import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../ui/ui_helpers.dart';
import 'is_json_serializable.dart';

part 'credit_card_themes.g.dart';

class CreditCardThemes {
  static const AccountCardTheme theme1 =
      AccountCardTheme(Color(0xFF05112B), Color(0xFF085476));
  static const AccountCardTheme theme2 = AccountCardTheme(
    Colors.blueGrey,
    Colors.pink,
  );
  static const AccountCardTheme theme3 = AccountCardTheme(
    Color(0xFF00A9E0),
    Color(0xFF0077B5),
  );
  static const AccountCardTheme theme4 = AccountCardTheme(
    Color(0xFFFDB813),
    Color(0xFF8C1D40),
  );
  static const AccountCardTheme theme5 = AccountCardTheme(
    Colors.blueGrey,
    Colors.deepPurple,
  );
  static const AccountCardTheme theme6 =
      AccountCardTheme(Colors.blue, Colors.green);
  static const AccountCardTheme theme7 = AccountCardTheme(
    Colors.black54,
    Colors.black,
  );
  static const AccountCardTheme theme8 = AccountCardTheme(
    Colors.blueGrey,
    Color(0xFF004678),
  );
  static const AccountCardTheme theme9 = AccountCardTheme(
    Color(0xFFCE002D),
    Color(0xFF673F1E),
  );
  static const AccountCardTheme theme10 =
      AccountCardTheme(Color(0xFF598040), Color(0xFF225500));

  static const List<AccountCardTheme> themes = <AccountCardTheme>[
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
class AccountCardTheme implements IsJsonSerializable<AccountCardTheme> {
  const AccountCardTheme(
    this.primaryColor,
    this.secondaryColor,
  );

  factory AccountCardTheme.fromJson(Map<String, dynamic> json) =>
      _$AccountCardThemeFromJson(json);

  @JsonKey(
      name: 'primary_color', toJson: _colorToJson, fromJson: _colorFromJson)
  final Color primaryColor;

  @JsonKey(
      name: 'secondary_color', toJson: _colorToJson, fromJson: _colorFromJson)
  final Color secondaryColor;

  static int _colorToJson(Color color) => colorToValue(color);

  static Color _colorFromJson(int value) => Color(value);

  @override
  Map<String, dynamic> toJson() => _$AccountCardThemeToJson(this);

  @override
  AccountCardTheme fromJson(Map<String, dynamic> json) {
    return AccountCardTheme.fromJson(json);
  }
}
