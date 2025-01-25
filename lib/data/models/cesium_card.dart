import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credit_card_themes.dart';
import 'is_json_serializable.dart';

part 'cesium_card.g.dart';

@JsonSerializable()
@CopyWith()
class AccountCard implements IsJsonSerializable<AccountCard> {
  AccountCard(
      {required this.seed,
      required this.pubKey,
      required this.name,
      required this.theme});

  factory AccountCard.fromJson(Map<String, dynamic> json) =>
      _$AccountCardFromJson(json);

  final String pubKey;
  final String seed;
  final AccountCardTheme theme;
  final String name;

  @override
  Map<String, dynamic> toJson() => _$AccountCardToJson(this);

  @override
  AccountCard fromJson(Map<String, dynamic> json) {
    return AccountCard.fromJson(json);
  }
}
