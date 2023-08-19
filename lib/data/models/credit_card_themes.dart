import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';

part 'credit_card_themes.g.dart';

class CreditCardThemes {
  static const CreditCardTheme theme1 =
      CreditCardTheme(Color(0xFF05112B), Color(0xFF085476));
  static const CreditCardTheme theme2 = CreditCardTheme(
    Colors.blueGrey,
    Colors.pink,
  );
  static const CreditCardTheme theme3 = CreditCardTheme(
    Color(0xFF00A9E0),
    Color(0xFF0077B5),
  );
  static const CreditCardTheme theme4 = CreditCardTheme(
    Color(0xFFFDB813),
    Color(0xFF8C1D40),
  );
  static const CreditCardTheme theme5 = CreditCardTheme(
    Colors.blueGrey,
    Colors.deepPurple,
  );
  static const CreditCardTheme theme6 =
      CreditCardTheme(Colors.blue, Colors.green);
  static const CreditCardTheme theme7 = CreditCardTheme(
    Colors.black54,
    Colors.black,
  );
  static const CreditCardTheme theme8 = CreditCardTheme(
    Colors.blueGrey,
    Color(0xFF004678),
  );
  static const CreditCardTheme theme9 = CreditCardTheme(
    Color(0xFFCE002D),
    Color(0xFF673F1E),
  );
  static const CreditCardTheme theme10 =
      CreditCardTheme(Color(0xFF598040), Color(0xFF225500));

  static const List<CreditCardTheme> themes = <CreditCardTheme>[
    CreditCardThemes.theme1,
    CreditCardThemes.theme2,
    CreditCardThemes.theme3,
    CreditCardThemes.theme4,
    CreditCardThemes.theme5,
    CreditCardThemes.theme6,
    CreditCardThemes.theme7,
    CreditCardThemes.theme8,
    CreditCardThemes.theme9,
    CreditCardThemes.theme10,
  ];
}

@JsonSerializable()
class CreditCardTheme implements IsJsonSerializable<CreditCardTheme> {
  const CreditCardTheme(
    this.primaryColor,
    this.secondaryColor,
  );

  factory CreditCardTheme.fromJson(Map<String, dynamic> json) =>
      _$CreditCardThemeFromJson(json);

  @JsonKey(
      name: 'primary_color', toJson: _colorToJson, fromJson: _colorFromJson)
  final Color primaryColor;

  @JsonKey(
      name: 'secondary_color', toJson: _colorToJson, fromJson: _colorFromJson)
  final Color secondaryColor;

  static int _colorToJson(Color color) => color.value;

  static Color _colorFromJson(int value) => Color(value);

  @override
  Map<String, dynamic> toJson() => _$CreditCardThemeToJson(this);

  @override
  CreditCardTheme fromJson(Map<String, dynamic> json) {
    return CreditCardTheme.fromJson(json);
  }
}
