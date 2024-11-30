// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/src/json_object_serializer.dart'
    show JsonObjectSerializer;
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-mutations.data.gql.dart'
    show
        GDeleteProfileData,
        GDeleteProfileData_deleteProfile,
        GMigrateProfileData,
        GMigrateProfileData_migrateProfile,
        GUpdateProfileData,
        GUpdateProfileData_updateProfile;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-mutations.req.gql.dart'
    show GDeleteProfileReq, GMigrateProfileReq, GUpdateProfileReq;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-mutations.var.gql.dart'
    show GDeleteProfileVars, GMigrateProfileVars, GUpdateProfileVars;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.data.gql.dart'
    show
        GGetProfileByAddressData,
        GGetProfileByAddressData_profiles,
        GGetProfileCountData,
        GGetProfileCountData_profiles_aggregate,
        GGetProfileCountData_profiles_aggregate_aggregate,
        GGetProfilesByAddressData,
        GGetProfilesByAddressData_profiles,
        GSearchProfileByTermData,
        GSearchProfileByTermData_profiles,
        GSearchProfilesData,
        GSearchProfilesData_profiles;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.req.gql.dart'
    show
        GGetProfileByAddressReq,
        GGetProfileCountReq,
        GGetProfilesByAddressReq,
        GSearchProfileByTermReq,
        GSearchProfilesReq;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.var.gql.dart'
    show
        GGetProfileByAddressVars,
        GGetProfileCountVars,
        GGetProfilesByAddressVars,
        GSearchProfileByTermVars,
        GSearchProfilesVars;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod.schema.schema.gql.dart'
    show
        GGeolocInput,
        GSocialInput,
        GString_comparison_exp,
        Gcursor_ordering,
        Gjsonb_cast_exp,
        Gjsonb_comparison_exp,
        Gorder_by,
        Gpoint,
        Gpoint_comparison_exp,
        Gprofiles_bool_exp,
        Gprofiles_order_by,
        Gprofiles_select_column,
        Gprofiles_stream_cursor_input,
        Gprofiles_stream_cursor_value_input,
        Gtimestamp,
        Gtimestamp_comparison_exp;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(JsonObjectSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GDeleteProfileData,
  GDeleteProfileData_deleteProfile,
  GDeleteProfileReq,
  GDeleteProfileVars,
  GGeolocInput,
  GGetProfileByAddressData,
  GGetProfileByAddressData_profiles,
  GGetProfileByAddressReq,
  GGetProfileByAddressVars,
  GGetProfileCountData,
  GGetProfileCountData_profiles_aggregate,
  GGetProfileCountData_profiles_aggregate_aggregate,
  GGetProfileCountReq,
  GGetProfileCountVars,
  GGetProfilesByAddressData,
  GGetProfilesByAddressData_profiles,
  GGetProfilesByAddressReq,
  GGetProfilesByAddressVars,
  GMigrateProfileData,
  GMigrateProfileData_migrateProfile,
  GMigrateProfileReq,
  GMigrateProfileVars,
  GSearchProfileByTermData,
  GSearchProfileByTermData_profiles,
  GSearchProfileByTermReq,
  GSearchProfileByTermVars,
  GSearchProfilesData,
  GSearchProfilesData_profiles,
  GSearchProfilesReq,
  GSearchProfilesVars,
  GSocialInput,
  GString_comparison_exp,
  GUpdateProfileData,
  GUpdateProfileData_updateProfile,
  GUpdateProfileReq,
  GUpdateProfileVars,
  Gcursor_ordering,
  Gjsonb_cast_exp,
  Gjsonb_comparison_exp,
  Gorder_by,
  Gpoint,
  Gpoint_comparison_exp,
  Gprofiles_bool_exp,
  Gprofiles_order_by,
  Gprofiles_select_column,
  Gprofiles_stream_cursor_input,
  Gprofiles_stream_cursor_value_input,
  Gtimestamp,
  Gtimestamp_comparison_exp,
])
final Serializers serializers = _serializersBuilder.build();
