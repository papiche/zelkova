import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contact.dart';

part 'cert.g.dart';

@CopyWith()
@JsonSerializable()
class Cert {
  Cert({
    required this.id,
    required this.issuerId,
    required this.receiverId,
    required this.createdOn,
    required this.expireOn,
    required this.isActive,
    required this.updatedOn,
  });

  factory Cert.fromJson(Map<String, dynamic> json) => _$CertFromJson(json);

  final String id;

  final Contact issuerId;
  final Contact receiverId;
  final int createdOn;
  final int expireOn;
  final bool isActive;
  final int updatedOn;

  Map<String, dynamic> toJson() => _$CertToJson(this);
}
