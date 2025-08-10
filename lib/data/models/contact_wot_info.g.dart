// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_wot_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactWotInfoCWProxy {
  ContactWotInfo me(Contact me);

  ContactWotInfo you(Contact you);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ContactWotInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ContactWotInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  ContactWotInfo call({
    Contact me,
    Contact you,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfContactWotInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfContactWotInfo.copyWith.fieldName(...)`
class _$ContactWotInfoCWProxyImpl implements _$ContactWotInfoCWProxy {
  const _$ContactWotInfoCWProxyImpl(this._value);

  final ContactWotInfo _value;

  @override
  ContactWotInfo me(Contact me) => this(me: me);

  @override
  ContactWotInfo you(Contact you) => this(you: you);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ContactWotInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ContactWotInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  ContactWotInfo call({
    Object? me = const $CopyWithPlaceholder(),
    Object? you = const $CopyWithPlaceholder(),
  }) {
    return ContactWotInfo(
      me: me == const $CopyWithPlaceholder()
          ? _value.me
          // ignore: cast_nullable_to_non_nullable
          : me as Contact,
      you: you == const $CopyWithPlaceholder()
          ? _value.you
          // ignore: cast_nullable_to_non_nullable
          : you as Contact,
    );
  }
}

extension $ContactWotInfoCopyWith on ContactWotInfo {
  /// Returns a callable class that can be used as follows: `instanceOfContactWotInfo.copyWith(...)` or like so:`instanceOfContactWotInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactWotInfoCWProxy get copyWith => _$ContactWotInfoCWProxyImpl(this);
}
