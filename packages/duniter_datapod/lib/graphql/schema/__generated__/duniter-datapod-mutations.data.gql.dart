// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-datapod-mutations.data.gql.g.dart';

abstract class GDeleteProfileData
    implements Built<GDeleteProfileData, GDeleteProfileDataBuilder> {
  GDeleteProfileData._();

  factory GDeleteProfileData(
          [void Function(GDeleteProfileDataBuilder b) updates]) =
      _$GDeleteProfileData;

  static void _initializeBuilder(GDeleteProfileDataBuilder b) =>
      b..G__typename = 'mutation_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteProfileData_deleteProfile? get deleteProfile;
  static Serializer<GDeleteProfileData> get serializer =>
      _$gDeleteProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteProfileData.serializer,
        json,
      );
}

abstract class GDeleteProfileData_deleteProfile
    implements
        Built<GDeleteProfileData_deleteProfile,
            GDeleteProfileData_deleteProfileBuilder> {
  GDeleteProfileData_deleteProfile._();

  factory GDeleteProfileData_deleteProfile(
          [void Function(GDeleteProfileData_deleteProfileBuilder b) updates]) =
      _$GDeleteProfileData_deleteProfile;

  static void _initializeBuilder(GDeleteProfileData_deleteProfileBuilder b) =>
      b..G__typename = 'DeleteProfileResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get success;
  String get message;
  static Serializer<GDeleteProfileData_deleteProfile> get serializer =>
      _$gDeleteProfileDataDeleteProfileSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteProfileData_deleteProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteProfileData_deleteProfile? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteProfileData_deleteProfile.serializer,
        json,
      );
}

abstract class GMigrateProfileData
    implements Built<GMigrateProfileData, GMigrateProfileDataBuilder> {
  GMigrateProfileData._();

  factory GMigrateProfileData(
          [void Function(GMigrateProfileDataBuilder b) updates]) =
      _$GMigrateProfileData;

  static void _initializeBuilder(GMigrateProfileDataBuilder b) =>
      b..G__typename = 'mutation_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMigrateProfileData_migrateProfile? get migrateProfile;
  static Serializer<GMigrateProfileData> get serializer =>
      _$gMigrateProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMigrateProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMigrateProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMigrateProfileData.serializer,
        json,
      );
}

abstract class GMigrateProfileData_migrateProfile
    implements
        Built<GMigrateProfileData_migrateProfile,
            GMigrateProfileData_migrateProfileBuilder> {
  GMigrateProfileData_migrateProfile._();

  factory GMigrateProfileData_migrateProfile(
      [void Function(GMigrateProfileData_migrateProfileBuilder b)
          updates]) = _$GMigrateProfileData_migrateProfile;

  static void _initializeBuilder(GMigrateProfileData_migrateProfileBuilder b) =>
      b..G__typename = 'MigrateProfileResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get success;
  String get message;
  static Serializer<GMigrateProfileData_migrateProfile> get serializer =>
      _$gMigrateProfileDataMigrateProfileSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMigrateProfileData_migrateProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMigrateProfileData_migrateProfile? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMigrateProfileData_migrateProfile.serializer,
        json,
      );
}

abstract class GUpdateProfileData
    implements Built<GUpdateProfileData, GUpdateProfileDataBuilder> {
  GUpdateProfileData._();

  factory GUpdateProfileData(
          [void Function(GUpdateProfileDataBuilder b) updates]) =
      _$GUpdateProfileData;

  static void _initializeBuilder(GUpdateProfileDataBuilder b) =>
      b..G__typename = 'mutation_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateProfileData_updateProfile? get updateProfile;
  static Serializer<GUpdateProfileData> get serializer =>
      _$gUpdateProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile
    implements
        Built<GUpdateProfileData_updateProfile,
            GUpdateProfileData_updateProfileBuilder> {
  GUpdateProfileData_updateProfile._();

  factory GUpdateProfileData_updateProfile(
          [void Function(GUpdateProfileData_updateProfileBuilder b) updates]) =
      _$GUpdateProfileData_updateProfile;

  static void _initializeBuilder(GUpdateProfileData_updateProfileBuilder b) =>
      b..G__typename = 'UpdateProfileResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get success;
  String get message;
  static Serializer<GUpdateProfileData_updateProfile> get serializer =>
      _$gUpdateProfileDataUpdateProfileSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile.serializer,
        json,
      );
}
