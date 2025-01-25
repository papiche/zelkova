import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';
import 'wallet_themes.dart';

part 'wallet.g.dart';

@JsonSerializable()
@CopyWith()
class Wallet implements IsJsonSerializable<Wallet> {
  Wallet(
      {required this.seed,
      required this.pubKey,
      required this.name,
      required this.theme});

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  final String pubKey;
  final String seed;
  final WalletTheme theme;
  final String name;

  @override
  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @override
  Wallet fromJson(Map<String, dynamic> json) {
    return Wallet.fromJson(json);
  }
}
