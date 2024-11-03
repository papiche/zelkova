import 'dart:typed_data';

import 'package:duniter_datapod/duniter_datapod_client.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.data.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.req.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.var.gql.dart';
import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'g1_helper.dart';
import 'g1_v2_helper_multi.dart';

Future<Uint8List?> fetchAndResizeAvatar(String? avatarCid,
    {bool resize = true}) async {
  if (avatarCid == null) {
    return null;
  }
  final Uint8List? avatarBase64 = await _getAvatarFromIpfs(avatarCid);
  return checkAndResizeAvatar(avatarBase64, resize);
}

/*
{
  "data": {
    "profiles": [
      {
        "avatar": null,
        "pubkey": "5FiDA1i3Qk6GzQz4r67QygmuAD8LLKSuccXRnznN1yLvG5ns",
        "description": null,
        "title": "vjrj ❥",
        "city": null,
        "data_cid": "QmbzrrBCoVy5G8rz9Gw5i7MFzHhF6WmDncKwMsuC3za77k",
        "geoloc": null,
        "index_request_cid": "bafyreia3dnocpc3xf7r7dk32ogoy57hw5e3ua2vby2zahatyaqox6dorny",
        "socials": null,
        "time": "2023-09-30T16:58:58"
      },
      {
        "avatar": "QmdUEF24hzEF6SW198sRJ2C1hWd3XFADALKBBgciCooAfC",
        "pubkey": "5DpRqhjEof2WMFoAYTAqqoQzyBH9zRRmAbBZGQm9uZSzNeY6",
        "description": "Ğ1nkgo author",
        "title": "vjrj",
        "city": "Spain",
        "data_cid": "QmSXeSD9vsVKRrKAUabihsFZhhxsdAdeY2WgppkD1kYhu8",
        "geoloc": null,
        "index_request_cid": "bafyreiey2zeiuu2u5nhiohd6a4gkj6tvc3zlkgfp4nbqv4234wkdoehahm",
        "socials": [
          {
            "url": "https://twitter.com/vjrj",
            "type": "twitter"
          }
        ],
        "time": "2023-10-22T22:04:44"
      }
    ]
  }
}
 */
Future<Contact> createContactFromProfile(
  dynamic profile, {
  bool resizeAvatar = true,
}) async {
  final Uint8List? avatar = await fetchAndResizeAvatar(
      (profile as dynamic).avatar as String?,
      resize: resizeAvatar);

  return Contact.withAddress(
    name: (profile as dynamic).title as String,
    address: (profile as dynamic).pubkey as String,
    avatar: avatar,
  );
}

Future<List<Contact>> searchWotV2(String searchPatternRaw) async {
  final List<Contact> contacts = <Contact>[];
  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    loggerDev('Searching indexer v2 with pattern $searchPatternRaw');
    try {
      // if is a v1Key, search pubkey
      final String searchPattern = validateKey(searchPatternRaw)
          ? addressFromV1PubkeyMulti(searchPatternRaw)
          : searchPatternRaw;
      loggerDev("Searching indexer v2 with '$searchPattern'");

      if (searchPattern.length < 8) {
        loggerDev('Searching wot by name');
        final GAccountsByNameReq req = GAccountsByNameReq(
            (GAccountsByNameReqBuilder b) => b..vars.pattern = searchPattern);
        final ferry.Client client = await initDuniterIndexerClient(
            node.url, GetIt.instance<HiveStore>());

        final ferry.OperationResponse<GAccountsByNameData, GAccountsByNameVars>
            response = await client.request(req).first;
        if (response.hasErrors) {
          loggerDev('Error: ${response.linkException?.originalException}');
        } else {
          final GAccountsByNameData? accounts = response.data;
          for (final GAccountsByNameData_identity account
              in accounts!.identity) {
            final String? address = account.accountId;
            if (address == null) {
              loggerDev('ERROR: Pubkey is null');
            } else {
              contacts.add(
                  Contact.withAddress(nick: account.name, address: address));
            }
          }
        }
      } else {
        loggerDev('Searching wot by name or pk');
        final GAccountsByNameOrPkReq req = GAccountsByNameOrPkReq(
            (GAccountsByNameOrPkReqBuilder b) =>
                b..vars.pattern = searchPattern);
        final ferry.Client client = await initDuniterIndexerClient(
            node.url, GetIt.instance<HiveStore>());

        final ferry
            .OperationResponse<GAccountsByNameOrPkData, GAccountsByNameOrPkVars>
            response = await client.request(req).first;

        if (response.hasErrors) {
          loggerDev('Error: ${response.linkException?.originalException}');
        } else {
          final GAccountsByNameOrPkData? accounts = response.data;
          for (final GAccountsByNameOrPkData_identity account
              in accounts!.identity) {
            final String? address = account.accountId;
            if (address == null) {
              loggerDev('ERROR: Pubkey is null');
            } else {
              contacts.add(
                  Contact.withAddress(nick: account.name, address: address));
            }
          }
        }
      }
    } catch (e) {
      loggerDev('Error searching wot: $e');
    }
  }
  return contacts;
}

Future<GGetProfileByAddressData_profiles?> _searchProfileByPKV2(
    String pubkey) async {
  for (final Node node
      in NodeManager().getBestNodes(NodeType.datapodEndpoint)) {
    loggerDev('Searching profile in node ${node.url} with address $pubkey');
    try {
      final ferry.Client client =
          await initDuniterDatapodClient(node.url, GetIt.instance<HiveStore>());

      final GGetProfileByAddressReq request = GGetProfileByAddressReq(
          (GGetProfileByAddressReqBuilder b) => b..vars.pubkey = pubkey);
      final ferry
          .OperationResponse<GGetProfileByAddressData, GGetProfileByAddressVars>
          response = await client.request(request).first;
      if (response.hasErrors) {
        throw Exception(
            'Error fetching profile by address: ${response.graphqlErrors}');
      }
      if (response.data!.profiles.isEmpty) {
        loggerDev('No profile found for pubkey $pubkey in node ${node.url}');
        continue;
      }
      return response.data?.profiles.first;
    } catch (e) {
      logger(
          'Error fetching profile in node ${node.url} with address $pubkey ($e)');
    }
  }
  return null;
}

Future<Contact> getProfileV2(String pubKey,
    {bool onlyCPlusProfile = false, bool resize = true}) async {
  loggerDev('Fetching profile v2 for pubkey $pubKey');
  final String address = addressFromV1PubkeyMulti(pubKey);
  final GGetProfileByAddressData_profiles? profile =
      await _searchProfileByPKV2(address);
  Contact c;
  if (profile != null) {
    c = await createContactFromProfile(profile, resizeAvatar: resize);
  } else {
    c = Contact.withAddress(address: address);
  }
  if (!onlyCPlusProfile) {
    final List<Contact> wotList = await searchWotV2(pubKey);
    if (wotList.isNotEmpty) {
      final Contact cWot = wotList[0];
      c = c.merge(cWot);
    }
  }
  logger('Contact retrieved in getProfile $c (c+ only $onlyCPlusProfile)');
  ContactsCache().addContact(c);
  return c;
}

Future<List<Contact>> getProfilesV2({required List<String> pubKeys}) async {
  final List<Contact> contacts = <Contact>[];
  if (pubKeys.isEmpty) {
    return contacts;
  }

  for (final Node node
      in NodeManager().getBestNodes(NodeType.datapodEndpoint)) {
    try {
      final ferry.Client client =
          await initDuniterDatapodClient(node.url, GetIt.instance<HiveStore>());
      final GGetProfilesByAddressReq request = GGetProfilesByAddressReq(
        (GGetProfilesByAddressReqBuilder b) => b..vars.pubkeys.addAll(pubKeys),
      );

      final ferry.OperationResponse<GGetProfilesByAddressData,
              GGetProfilesByAddressVars> response =
          await client.request(request).first;

      if (response.hasErrors) {
        throw Exception('GraphQL Error: ${response.graphqlErrors}');
      }

      final Iterable<GGetProfilesByAddressData_profiles> profiles =
          response.data?.profiles ?? <GGetProfilesByAddressData_profiles>[];
      for (final GGetProfilesByAddressData_profiles profile in profiles) {
        final Contact contact = await createContactFromProfile(profile);
        contacts.add(contact);
      }
    } catch (e) {
      logger('Error fetching profiles in node ${node.url}: $e');
    }
  }

  return contacts;
}

Future<Uint8List?> _getAvatarFromIpfs(String? avatar) async {
  if (avatar == null) {
    return null;
  }
  final List<Node> nodes = NodeManager().nodesWorkingList(NodeType.ipfsGateway);
  for (final Node node in nodes) {
    // type https://gyroi.de/ipfs/Qmd...AfC
    final String ipfsUrl = '${node.url}/ipfs/$avatar';

    try {
      final http.Response response = await http.get(Uri.parse(ipfsUrl));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        return response.bodyBytes;
      }
    } catch (e) {
      loggerDev('Error fetching avatar from $ipfsUrl: $e');
      continue;
    }
  }

  return null;
}

Future<List<Contact>> searchProfilesV2({
  required String searchTermLower,
  required String searchTerm,
  required String searchTermCapitalized,
}) async {
  final List<Contact> contacts = <Contact>[];

  for (final Node node
      in NodeManager().getBestNodes(NodeType.datapodEndpoint)) {
    loggerDev('Searching profiles in node ${node.url} with term $searchTerm');
    try {
      final ferry.Client client =
          await initDuniterDatapodClient(node.url, GetIt.instance<HiveStore>());
      final GSearchProfilesReq request =
          GSearchProfilesReq((GSearchProfilesReqBuilder b) => b
            ..vars.searchTermLower = searchTermLower
            ..vars.searchTerm = searchTerm
            ..vars.searchTermCapitalized = searchTermCapitalized);

      final ferry.OperationResponse<GSearchProfilesData, GSearchProfilesVars>
          response = await client.request(request).first;

      if (response.hasErrors) {
        throw Exception('GraphQL Error: ${response.graphqlErrors}');
      }
      final Iterable<GSearchProfilesData_profiles> profiles =
          response.data?.profiles ?? <GSearchProfilesData_profiles>[];
      for (final GSearchProfilesData_profiles profile in profiles) {
        contacts.add(await createContactFromProfile(profile));
      }
    } catch (e) {
      logger('Error fetching profiles in node ${node.url}: $e');
    }
  }
  return contacts;
}
