import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';

part 'credit_card_themes.g.dart';

class CreditCardThemes {
  static const CreditCardTheme theme1 = CreditCardTheme(
    Color(0xFF1A237E),
    Color(0xFFFFBA00),
  );
  static const CreditCardTheme theme2 = CreditCardTheme(
    Color(0xFFEC1C24),
    Color(0xFFFF5F00),
  );
  static const CreditCardTheme theme3 = CreditCardTheme(
    Color(0xFF0077B5),
    Color(0xFF00A9E0),
  );
  static const CreditCardTheme theme4 = CreditCardTheme(
    Color(0xFF8C1D40),
    Color(0xFFFDB813),
  );
  static const CreditCardTheme theme5 = CreditCardTheme(
    Color(0xFF117AC9),
    Color(0xFFEE7203),
  );
  static const CreditCardTheme theme6 = CreditCardTheme(
    Color(0xFF00529B),
    Color(0xFF00AEEF),
  );
  static const CreditCardTheme theme7 = CreditCardTheme(
    Color(0xFFE41422),
    Color(0xFF1C5D8D),
  );
  static const CreditCardTheme theme8 = CreditCardTheme(
    Color(0xFF004678),
    Color(0xFFB5C8E5),
  );
  static const CreditCardTheme theme9 = CreditCardTheme(
    Color(0xFFCE002D),
    Color(0xFF673F1E),
  );
  static const CreditCardTheme theme10 = CreditCardTheme(
    Color(0xFFDD5600),
    Color(0xFFC6A700),
  );
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
