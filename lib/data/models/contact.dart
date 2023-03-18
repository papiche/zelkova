import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';

part 'contact.g.dart';

@JsonSerializable()
@CopyWith()
class Contact extends Equatable implements IsJsonSerializable<Contact> {
  const Contact({
    this.nick,
    required this.pubkey,
    this.avatar,
    this.notes,
    this.name,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  final String? nick;
  final String pubkey;
  @JsonKey(fromJson: _fromList, toJson: _toList)
  final Uint8List? avatar;
  final String? notes;
  final String? name;

  @override
  List<Object?> get props => <dynamic>[nick, pubkey, avatar, notes, name];

  @override
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  Contact fromJson(Map<String, dynamic> json) => Contact.fromJson(json);

  static Uint8List _fromList(List<int> list) => Uint8List.fromList(list);

  static List<int> _toList(Uint8List? uint8List) =>
      uint8List != null ? uint8List.toList() : <int>[];

  @override
  String toString() {
    return 'Contact $pubkey, hasAvatar: ${avatar != null}, nick: $nick, name: $name';
  }
}
