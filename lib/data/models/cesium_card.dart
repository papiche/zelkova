import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credit_card_themes.dart';
import 'is_json_serializable.dart';

part 'cesium_card.g.dart';

@JsonSerializable()
@CopyWith()
class CesiumCard implements IsJsonSerializable<CesiumCard> {
  CesiumCard(
      {required this.seed,
      required this.pubKey,
      required this.name,
      required this.theme});

  factory CesiumCard.fromJson(Map<String, dynamic> json) =>
      _$CesiumCardFromJson(json);

  final String pubKey;
  final String seed;
  final CreditCardTheme theme;
  final String name;

  @override
  Map<String, dynamic> toJson() => _$CesiumCardToJson(this);

  @override
  CesiumCard fromJson(Map<String, dynamic> json) {
    return CesiumCard.fromJson(json);
  }
}
