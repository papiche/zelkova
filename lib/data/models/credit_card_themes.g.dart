// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_themes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardTheme _$CreditCardThemeFromJson(Map<String, dynamic> json) =>
    CreditCardTheme(
      CreditCardTheme._colorFromJson((json['primary_color'] as num).toInt()),
      CreditCardTheme._colorFromJson((json['secondary_color'] as num).toInt()),
    );

Map<String, dynamic> _$CreditCardThemeToJson(CreditCardTheme instance) =>
    <String, dynamic>{
      'primary_color': CreditCardTheme._colorToJson(instance.primaryColor),
      'secondary_color': CreditCardTheme._colorToJson(instance.secondaryColor),
    };
