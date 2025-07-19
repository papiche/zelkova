import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../ui/ui_helpers.dart';
import 'is_json_serializable.dart';

part 'wallet_themes.g.dart';

mixin WalletThemes {
  @Deprecated('Use WalletThemes.randomExcluding instead')
  static WalletTheme get random {
    final int index = Random().nextInt(themes.length);
    return themes[index];
  }

  static WalletTheme randomExcluding(List<WalletTheme> exclusions) {
    final List<WalletTheme> filteredThemes = themes
        .where((WalletTheme theme) => !exclusions.contains(theme))
        .toList();

    if (filteredThemes.isEmpty) {
      return themes[Random().nextInt(themes.length)];
    }

    final int index = Random().nextInt(filteredThemes.length);
    return filteredThemes[index];
  }

  static const WalletTheme theme1 =
      WalletTheme(Color(0xFF05112B), Color(0xFF085476));
  static const WalletTheme theme2 = WalletTheme(
    Colors.blueGrey,
    Colors.pink,
  );
  static const WalletTheme theme3 = WalletTheme(
    Color(0xFF00A9E0),
    Color(0xFF0077B5),
  );
  static const WalletTheme theme4 = WalletTheme(
    Color(0xFFFDB813),
    Color(0xFF8C1D40),
  );
  static const WalletTheme theme5 = WalletTheme(
    Colors.blueGrey,
    Colors.deepPurple,
  );
  static const WalletTheme theme6 = WalletTheme(Colors.blue, Colors.green);
  static const WalletTheme theme7 = WalletTheme(
    Colors.black54,
    Colors.black,
  );
  static const WalletTheme theme8 = WalletTheme(
    Colors.blueGrey,
    Color(0xFF004678),
  );
  static const WalletTheme theme9 = WalletTheme(
    Color(0xFFCE002D),
    Color(0xFF673F1E),
  );
  static const WalletTheme theme10 =
      WalletTheme(Color(0xFF598040), Color(0xFF225500));

  static const List<WalletTheme> themes = <WalletTheme>[
    WalletThemes.theme1,
    WalletThemes.theme2,
    WalletThemes.theme3,
    WalletThemes.theme4,
    WalletThemes.theme5,
    WalletThemes.theme6,
    WalletThemes.theme7,
    WalletThemes.theme8,
    WalletThemes.theme9,
    WalletThemes.theme10,
  ];
}

@JsonSerializable()
class WalletTheme implements IsJsonSerializable<WalletTheme> {
  const WalletTheme(
    this.primaryColor,
    this.secondaryColor,
  );

  factory WalletTheme.fromJson(Map<String, dynamic> json) =>
      _$WalletThemeFromJson(json);

  @JsonKey(
      name: 'primary_color', toJson: _colorToJson, fromJson: _colorFromJson)
  final Color primaryColor;

  @JsonKey(
      name: 'secondary_color', toJson: _colorToJson, fromJson: _colorFromJson)
  final Color secondaryColor;

  static int _colorToJson(Color color) => colorToValue(color);

  static Color _colorFromJson(int value) => Color(value);

  @override
  Map<String, dynamic> toJson() => _$WalletThemeToJson(this);

  @override
  WalletTheme fromJson(Map<String, dynamic> json) {
    return WalletTheme.fromJson(json);
  }
}
