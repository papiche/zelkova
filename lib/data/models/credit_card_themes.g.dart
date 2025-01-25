// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_themes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCardTheme _$AccountCardThemeFromJson(Map<String, dynamic> json) =>
    AccountCardTheme(
      AccountCardTheme._colorFromJson((json['primary_color'] as num).toInt()),
      AccountCardTheme._colorFromJson((json['secondary_color'] as num).toInt()),
    );

Map<String, dynamic> _$AccountCardThemeToJson(AccountCardTheme instance) =>
    <String, dynamic>{
      'primary_color': AccountCardTheme._colorToJson(instance.primaryColor),
      'secondary_color': AccountCardTheme._colorToJson(instance.secondaryColor),
    };
