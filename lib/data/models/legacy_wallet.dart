import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';
import 'wallet_themes.dart';

part 'legacy_wallet.g.dart';

@JsonSerializable()
@CopyWith()
class LegacyWallet implements IsJsonSerializable<LegacyWallet> {
  LegacyWallet(
      {required this.seed,
      required this.pubKey,
      required this.name,
      required this.theme,
      this.lastUsed});

  factory LegacyWallet.fromJson(Map<String, dynamic> json) =>
      _$LegacyWalletFromJson(json);

  final String pubKey;
  final String seed;
  final WalletTheme theme;
  final String name;
  final int? lastUsed;

  @override
  Map<String, dynamic> toJson() => _$LegacyWalletToJson(this);

  @override
  LegacyWallet fromJson(Map<String, dynamic> json) {
    return LegacyWallet.fromJson(json);
  }
}
