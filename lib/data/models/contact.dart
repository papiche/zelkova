import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../g1/g1_helper.dart';
import '../../g1/g1_v2_helper.dart';
import '../../ui/ui_helpers.dart';
import 'cert.dart';
import 'identity_status.dart';
import 'is_json_serializable.dart';
import 'model_utils.dart';

part 'contact.g.dart';

@JsonSerializable()
@CopyWith()
class Contact extends Equatable implements IsJsonSerializable<Contact> {
  Contact(
      {this.nick,
      required String pubKey,
      String? address,
      this.avatar,
      this.avatarCid,
      this.notes,
      this.name,
      this.description,
      this.city,
      this.dataCid,
      this.geoLoc,
      this.indexRequestCid,
      this.socials,
      this.time,
      this.certsIssued,
      this.certsReceived,
      this.status,
      this.isMember,
      this.createdOn,
      this.index,
      this.expireOn})
      :
        // ensure that Contact does not have v1 checksums
        pubKey = extractPublicKey(pubKey),
        address = address ?? addressFromV1Pubkey(extractPublicKey(pubKey));

  factory Contact.withIdentityFields({
    String? nick,
    required String pubKey,
    String? address,
    List<Cert>? certsReceived,
    List<Cert>? certsIssued,
    IdentityStatus? status,
    bool? isMember,
    int? createdOn,
    int? index,
    int? expireOn,
  }) {
    return Contact(
      nick: nick,
      pubKey: pubKey,
      address: address,
      certsReceived: certsReceived,
      certsIssued: certsIssued,
      status: status,
      isMember: isMember,
      createdOn: createdOn,
      expireOn: expireOn,
      index: index,
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  const Contact._(
      {this.nick,
      required this.pubKey,
      required this.address,
      this.avatar,
      this.avatarCid,
      this.notes,
      this.name,
      this.description,
      this.city,
      this.dataCid,
      this.geoLoc,
      this.indexRequestCid,
      this.socials,
      this.time,
      this.certsIssued,
      this.certsReceived,
      this.status,
      this.isMember,
      this.createdOn,
      this.index,
      this.expireOn});

  factory Contact.withPubKey(
      {String? nick,
      required String pubKey,
      Uint8List? avatar,
      String? avatarCid,
      String? notes,
      String? name,
      String? description,
      String? city,
      String? dataCid,
      LatLng? geoLoc,
      String? indexRequestCid,
      List<Map<String, String>>? socials,
      List<Cert>? certsReceived,
      List<Cert>? certsIssued,
      int? index,
      DateTime? time}) {
    return Contact._(
        nick: nick,
        pubKey: extractPublicKey(pubKey),
        address: addressFromV1Pubkey(extractPublicKey(pubKey)),
        avatar: avatar,
        avatarCid: avatarCid,
        notes: notes,
        name: name,
        description: description,
        city: city,
        dataCid: dataCid,
        geoLoc: geoLoc,
        indexRequestCid: indexRequestCid,
        socials: socials,
        time: time,
        certsReceived: certsReceived,
        certsIssued: certsIssued,
        index: index);
  }

  factory Contact.empty() {
    return const Contact._(
      name: '',
      pubKey: '',
      address: '',
    );
  }

  factory Contact.withAddress(
      {String? nick,
      required String address,
      Uint8List? avatar,
      String? avatarCid,
      String? notes,
      String? name,
      String? description,
      String? city,
      String? dataCid,
      LatLng? geoLoc,
      String? indexRequestCid,
      List<Map<String, String>>? socials,
      DateTime? time,
      List<Cert>? certsReceived,
      List<Cert>? certsIssued,
      IdentityStatus? status,
      bool? isMember,
      int? createdOn,
      int? expireOn,
      int? index}) {
    return Contact._(
        nick: nick,
        pubKey: v1pubkeyFromAddress(address),
        address: address,
        avatar: avatar,
        avatarCid: avatarCid,
        notes: notes,
        name: name,
        description: description,
        city: city,
        dataCid: dataCid,
        geoLoc: geoLoc,
        indexRequestCid: indexRequestCid,
        socials: socials,
        time: time,
        certsReceived: certsReceived,
        certsIssued: certsIssued,
        status: status,
        isMember: isMember,
        createdOn: createdOn,
        expireOn: expireOn,
        index: index);
  }

  final String? nick;
  final String pubKey;
  final String address;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? avatar;
  final String? notes;
  final String? name;
  final String? avatarCid;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? description;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? city;
  final String? dataCid;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final LatLng? geoLoc;
  final String? indexRequestCid;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<Map<String, String>>? socials;
  final DateTime? time;

  // identity fields
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<Cert>? certsReceived;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<Cert>? certsIssued;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final IdentityStatus? status;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final bool? isMember;
  final int? createdOn;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final int? expireOn;
  final int? index;

  Contact merge(Contact c) {
    return Contact(
      nick: c.nick ?? nick,
      pubKey: c.pubKey,
      avatar: c.avatar ?? avatar,
      notes: c.notes ?? notes,
      name: c.name ?? name,
      avatarCid: c.avatarCid ?? avatarCid,
      description: c.description ?? description,
      city: c.city ?? city,
      dataCid: c.dataCid ?? dataCid,
      geoLoc: c.geoLoc ?? geoLoc,
      indexRequestCid: c.indexRequestCid ?? indexRequestCid,
      socials: c.socials ?? socials,
      time: c.time ?? time,
      certsIssued: _mergeCertLists(c.certsIssued, certsIssued),
      certsReceived: _mergeCertLists(c.certsReceived, certsReceived),
      status: c.status ?? status,
      isMember: c.isMember ?? isMember,
      createdOn: c.createdOn ?? createdOn,
      expireOn: c.expireOn ?? expireOn,
      index: c.index ?? index,
    );
  }

  List<Cert>? _mergeCertLists(List<Cert>? listA, List<Cert>? listB) {
    if (listA == null && listB == null) {
      return null;
    }
    if (listA == null) {
      return listB;
    }
    if (listB == null) {
      return listA;
    }

    return listB;
  }

  @override
  List<Object?> get props => <dynamic>[
        pubKey,
        nick,
        avatar,
        avatarCid,
        notes,
        name,
        address,
        dataCid,
        indexRequestCid,
        time,
        createdOn,
        index
      ];

  // Only avatar binary
  bool get hasAvatar => avatar != null;

  @override
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  Contact fromJson(Map<String, dynamic> json) => Contact.fromJson(json);

  @override
  String toString() {
    return 'Contact $pubKey, hasAvatar: ${avatar != null}, hasAvatarCid: ${avatarCid != null}, nick: $nick, name: $name';
  }

  String toStringSmall(String pubKey) {
    return humanizeContact(pubKey, this);
  }

  String get title => name != null && nick != null
      ? name != nick && name!.toLowerCase() != nick!.toLowerCase()
          ? '$name ($nick)'
          : name! // avoid "nick (nick)" users
      : nick ?? name ?? humanizePubOrAddress; // at least show something

  String get titleWithoutAddressOrPubKey => name != null && nick != null
      ? name != nick && name!.toLowerCase() != nick!.toLowerCase()
          ? (name!.isNotEmpty ? '$name! ($nick!)' : nick!)
          : name!
      : nick ?? name ?? '';

  String get humanizePubOrAddress =>
      createdOnV2 ? humanizeAddress(address) : humanizePubKey(pubKey);

  bool get hasTitle =>
      (name != null && name!.isNotEmpty) || (nick != null && nick!.isNotEmpty);

  String? get subtitle =>
      (nick != null || name != null) ? humanizePubOrAddress : null;

  /*
  String? get subtitleV2NotUsed =>
      (nick != null || name != null) ? humanizeAddress(address) : null;

  String? get subtitleV1V2concatenated => (nick != null || name != null)
      ? '${humanizePubKey(pubKey)} ${humanizeAddress(address)}'
      : null;
   */

  Contact cloneWithoutAvatar() {
    return Contact(
        nick: nick,
        pubKey: pubKey,
        // avatar: null,
        notes: notes,
        name: name,
        avatarCid: avatarCid,
        description: description,
        city: city,
        dataCid: dataCid,
        geoLoc: geoLoc,
        indexRequestCid: indexRequestCid,
        socials: socials,
        time: time);
  }

  bool keyEqual(Contact other) =>
      extractPublicKey(pubKey) == extractPublicKey(other.pubKey);

  bool get createdOnV2 => createdOn != null && createdOn! > 0;
}
