// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_themes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTheme _$WalletThemeFromJson(Map<String, dynamic> json) => WalletTheme(
  WalletTheme._colorFromJson((json['primary_color'] as num).toInt()),
  WalletTheme._colorFromJson((json['secondary_color'] as num).toInt()),
);

Map<String, dynamic> _$WalletThemeToJson(WalletTheme instance) =>
    <String, dynamic>{
      'primary_color': WalletTheme._colorToJson(instance.primaryColor),
      'secondary_color': WalletTheme._colorToJson(instance.secondaryColor),
    };
