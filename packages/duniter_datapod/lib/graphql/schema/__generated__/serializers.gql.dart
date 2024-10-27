// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/src/json_object_serializer.dart'
    show JsonObjectSerializer;
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.data.gql.dart'
    show
        GGetProfileByAddressData,
        GGetProfileByAddressData_profiles,
        GGetProfileCountData,
        GGetProfileCountData_profiles_aggregate,
        GGetProfileCountData_profiles_aggregate_aggregate;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.req.gql.dart'
    show GGetProfileByAddressReq, GGetProfileCountReq;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.var.gql.dart'
    show GGetProfileByAddressVars, GGetProfileCountVars;
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
  Gtimestamp_comparison_exp,
])
final Serializers serializers = _serializersBuilder.build();
