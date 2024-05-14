import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/g1_helper.dart';
import '../../ui/ui_helpers.dart';
import 'is_json_serializable.dart';
import 'model_utils.dart';

part 'contact.g.dart';

@JsonSerializable()
@CopyWith()
class Contact extends Equatable implements IsJsonSerializable<Contact> {
  const Contact({
    this.nick,
    required this.pubKey,
    this.avatar,
    this.notes,
    this.name,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Contact merge(Contact c) {
    return Contact(
      nick: c.nick ?? nick,
      pubKey: c.pubKey,
      avatar: c.avatar ?? avatar,
      notes: c.notes ?? notes,
      name: c.name ?? name,
    );
  }

  final String? nick;
  final String pubKey;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? avatar;
  final String? notes;
  final String? name;

  @override
  List<Object?> get props => <dynamic>[
        pubKey,
        nick,
        pubKey,
        avatar,
        notes,
        name,
      ];

  bool get hasAvatar => avatar != null;

  @override
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  Contact fromJson(Map<String, dynamic> json) => Contact.fromJson(json);

  @override
  String toString() {
    return 'Contact $pubKey, hasAvatar: ${avatar != null}, nick: $nick, name: $name';
  }

  String toStringSmall(String pubKey) {
    return humanizeContact(pubKey, this);
  }

  String get title => name != null && nick != null
      ? name != nick && name!.toLowerCase() != nick!.toLowerCase()
          ? '$name ($nick)'
          : name! // avoid "nick (nick)" users
      : nick ?? name ?? humanizePubKey(pubKey);

  String get titleWithoutNick => name ?? humanizePubKey(pubKey);

  String? get subtitle =>
      (nick != null || name != null) ? humanizePubKey(pubKey) : null;

  Contact cloneWithoutAvatar() {
    return Contact(
      nick: nick,
      pubKey: pubKey,
      // avatar: null,
      notes: notes,
      name: name,
    );
  }

  bool keyEqual(Contact other) =>
      extractPublicKey(pubKey) == extractPublicKey(other.pubKey);
}
