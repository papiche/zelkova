// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_wot_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactWotInfoCWProxy {
  ContactWotInfo me(Contact me);

  ContactWotInfo you(Contact you);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactWotInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactWotInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactWotInfo call({Contact me, Contact you});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactWotInfo.copyWith(...)` or call `instanceOfContactWotInfo.copyWith.fieldName(value)` for a single field.
class _$ContactWotInfoCWProxyImpl implements _$ContactWotInfoCWProxy {
  const _$ContactWotInfoCWProxyImpl(this._value);

  final ContactWotInfo _value;

  @override
  ContactWotInfo me(Contact me) => call(me: me);

  @override
  ContactWotInfo you(Contact you) => call(you: you);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactWotInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactWotInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactWotInfo call({
    Object? me = const $CopyWithPlaceholder(),
    Object? you = const $CopyWithPlaceholder(),
  }) {
    return ContactWotInfo(
      me: me == const $CopyWithPlaceholder() || me == null
          ? _value.me
          // ignore: cast_nullable_to_non_nullable
          : me as Contact,
      you: you == const $CopyWithPlaceholder() || you == null
          ? _value.you
          // ignore: cast_nullable_to_non_nullable
          : you as Contact,
    );
  }
}

extension $ContactWotInfoCopyWith on ContactWotInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactWotInfo.copyWith(...)` or `instanceOfContactWotInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactWotInfoCWProxy get copyWith => _$ContactWotInfoCWProxyImpl(this);
}
