import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  final String? nick;
  final String pubKey;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? avatar;
  final String? notes;
  final String? name;

  @override
  List<Object?> get props => <dynamic>[nick, pubKey, avatar, notes, name];

  @override
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  Contact fromJson(Map<String, dynamic> json) => Contact.fromJson(json);

  @override
  String toString() {
    return 'Contact $pubKey, hasAvatar: ${avatar != null}, nick: $nick, name: $name';
  }
}
