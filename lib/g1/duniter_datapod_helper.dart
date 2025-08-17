import 'dart:convert';
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:duniter_datapod/duniter_datapod_client.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-mutations.data.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-mutations.req.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-mutations.var.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.data.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.req.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.var.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod.schema.schema.gql.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry_hive_ce_store/ferry_hive_ce_store.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../data/models/contact.dart';
import '../data/models/lat_lng_parse.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../shared_prefs_helper.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'api.dart';
import 'duniter_indexer_helper.dart';
import 'g1_v2_helper.dart';

const Duration defDatapodTimeout = Duration(seconds: 20);

Future<T> executeOnDatapodNodes<T>(
    Future<T> Function(Node node, ferry.Client client) operation,
    {bool retry = true,
    Duration timeout = defDatapodTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.datapodEndpoint);
  nodes.shuffle();

  for (final Node node in nodes) {
    try {
      final ferry.Client client =
          await initDuniterDatapodClient(node.url, GetIt.instance<HiveStore>());

      final T result = await operation(node, client).timeout(timeout);
      return result; // If the operation is successful, return the result
    } catch (e, stacktrace) {
      NodeManager().increaseNodeErrors(NodeType.datapodEndpoint, node);
      loggerDev('Error in node ${node.url}', error: e, stackTrace: stacktrace);
      if (!retry) {
        rethrow;
      }
    }
  }
  throw Exception(
      'All nodes failed to execute the operation'); // If all nodes fail, throw an exception
}

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
  /* final Uint8List? avatar = await fetchAndResizeAvatar(
      (profile as dynamic).avatar as String?,
      resize: resizeAvatar); */

  List<Map<String, String>>? socials;

  final ListJsonObject? socialsJson =
      (profile as dynamic).socials as ListJsonObject?;
  if (socialsJson != null) {
    socials = socialsJson.asList
        .map((Object? item) => (item! as Map<dynamic, dynamic>).map(
              (dynamic key, dynamic value) =>
                  MapEntry<String, String>(key.toString(), value.toString()),
            ))
        .toList();
  }
  final Gtimestamp? timeRaw = (profile as dynamic).time as Gtimestamp?;
  final Gpoint? geoLocRaw = (profile as dynamic).geoloc as Gpoint?;
  return Contact.withAddress(
    name: (profile as dynamic).title as String,
    address: (profile as dynamic).pubkey as String,
    avatarCid: (profile as dynamic).avatar as String?,
    description: (profile as dynamic).description as String?,
    dataCid: (profile as dynamic).data_cid as String?,
    geoLoc: geoLocRaw != null ? LatLngParsing.parse(geoLocRaw.value) : null,
    indexRequestCid: (profile as dynamic).index_request_cid as String?,
    socials: socials,
    time: timeRaw != null ? DateTime.tryParse(timeRaw.value) : null,
    city: (profile as dynamic).city as String?,
  );
}

Future<GGetProfileByAddressData_profiles?> _searchProfileByPKV2(
    String pubkey) async {
  return executeOnDatapodNodes((Node node, ferry.Client client) async {
    loggerDev('Searching profile in node ${node.url} with address $pubkey');
    try {
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
        return null;
      }
      loggerDev('Profile found for pubkey $pubkey in node ${node.url}');
      return response.data?.profiles.first;
    } catch (e) {
      loggerDev(
          'Error fetching profile in node ${node.url} with address $pubkey',
          error: e);
    }
    return null;
  });
}

Future<Contact> getProfileV2(String pubKey,
    {bool onlyProfile = false,
    bool resize = true,
    bool complete = false}) async {
  loggerDev('Fetching profile v2 for pubkey $pubKey');
  final String address = addressFromV1PubkeyFaiSafe(pubKey);
  final GGetProfileByAddressData_profiles? profile =
      await _searchProfileByPKV2(address);
  Contact c;
  if (profile != null) {
    c = await createContactFromProfile(profile, resizeAvatar: resize);
  } else {
    c = Contact.withAddress(address: address);
  }
  if (!onlyProfile) {
    final Contact cWot = complete
        ? await getAccount(address: c.address)
        : await getAccountBasic(address: c.address);
    c = c.merge(cWot);
  }
  logger('Contact retrieved in getProfile $c (c+ only $onlyProfile)');
  ContactsCache().addContact(c);
  return c;
}

Future<List<Contact>> getProfilesV2({required List<String> pubKeys}) async {
  loggerDev('Fetching profiles v2 for pubkeys $pubKeys');
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
    loggerDev('Contacts retrieved in getProfiles ${contacts.length}');
    return contacts;
  }
  loggerDev('Contacts not found in getProfiles');
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
    loggerDev("Searching profiles in node ${node.url} with term '$searchTerm'");
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
      loggerDev('Error fetching profiles in node ${node.url}', error: e);
    }
    loggerDev('Contacts found in searchProfiles ${contacts.length}');
    return contacts;
  }
  loggerDev('Contacts not found in searchProfilesV2');
  return contacts;
}

Future<bool> createOrUpdateProfileV2(String name) async {
  final KeyPair kp = await SharedPreferencesHelper().getKeyPair();
  final Map<String, dynamic> message = <String, dynamic>{
    'address': kp.address,
    'title': name
  };
  final String hash = calculateHash(jsonEncode(message));
  final String signature =
      encodeHex(kp.sign(Uint8List.fromList(hash.codeUnits)));
  return updateProfileV2(
      address: kp.address, hash: hash, signature: signature, title: name);
}

Future<bool> updateProfileV2(
    {required String address,
    String? avatarBase64,
    String? city,
    String? description,
    GGeolocInputBuilder? geoloc,
    ListBuilder<GSocialInput>? socials,
    required String hash,
    required String signature,
    String? title}) async {
  for (final Node node
      in NodeManager().getBestNodes(NodeType.datapodEndpoint)) {
    loggerDev('Updating profile in node ${node.url}');
    try {
      final ferry.Client client =
          await initDuniterDatapodClient(node.url, GetIt.instance<HiveStore>());
      final GUpdateProfileReq request =
          GUpdateProfileReq((GUpdateProfileReqBuilder b) => b
            ..vars.address = address
            ..vars.avatarBase64 = avatarBase64
            ..vars.city = city
            ..vars.description = description
            ..vars.geoloc = geoloc
            ..vars.hash = hash
            ..vars.signature = signature
            ..vars.socials = socials
            ..vars.title = title);

      final ferry.OperationResponse<GUpdateProfileData, GUpdateProfileVars>
          response = await client.request(request).first;

      if (response.hasErrors) {
        if (response.graphqlErrors != null) {
          log.e('Error updating profile', error: response.graphqlErrors);
        }
        if (response.linkException != null) {
          log.e('Error updating profile', error: response.linkException);
        }
        continue;
      } else {
        loggerDev('Profile updated successfully: ${response.data}');
        return true;
      }
    } catch (e) {
      log.e('Error updating profile in node ${node.url}', error: e);
    }
  }
  return false;
}

Future<bool> deleteProfileV2() async {
  final KeyPair kp = await SharedPreferencesHelper().getKeyPair();
  final Map<String, dynamic> message = <String, dynamic>{'address': kp.address};
  final String hash = calculateHash(jsonEncode(message));
  final String signature =
      encodeHex(kp.sign(Uint8List.fromList(hash.codeUnits)));
  for (final Node node
      in NodeManager().getBestNodes(NodeType.datapodEndpoint)) {
    loggerDev('Updating profile in node ${node.url}');
    try {
      final GDeleteProfileReq request =
          GDeleteProfileReq((GDeleteProfileReqBuilder b) => b
            ..vars.address = kp.address
            ..vars.hash = hash
            ..vars.signature = signature);
      final ferry.Client client =
          await initDuniterDatapodClient(node.url, GetIt.instance<HiveStore>());
      final ferry.OperationResponse<GDeleteProfileData, GDeleteProfileVars>
          response = await client.request(request).first;

      if (response.hasErrors) {
        log.e('Error deleting profile', error: response.graphqlErrors);
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log.e('Error updating profile in node ${node.url}', error: e);
    }
  }
  return false;
}
