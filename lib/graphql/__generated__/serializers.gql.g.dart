// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(FetchPolicy.serializer)
      ..add(GAccountsByNameOrPkData.serializer)
      ..add(GAccountsByNameOrPkData_account.serializer)
      ..add(GAccountsByNameOrPkData_account_identity.serializer)
      ..add(GAccountsByNameOrPkData_account_identity_account.serializer)
      ..add(
          GAccountsByNameOrPkData_account_identity_account_identity.serializer)
      ..add(GAccountsByNameOrPkReq.serializer)
      ..add(GAccountsByNameOrPkVars.serializer)
      ..add(GAccountsByPkData.serializer)
      ..add(GAccountsByPkData_account_by_pk.serializer)
      ..add(GAccountsByPkData_account_by_pk_identity.serializer)
      ..add(GAccountsByPkReq.serializer)
      ..add(GAccountsByPkVars.serializer)
      ..add(GBoolean_comparison_exp.serializer)
      ..add(GFloat_comparison_exp.serializer)
      ..add(GInt_comparison_exp.serializer)
      ..add(GLastIndexedBlockNumberData.serializer)
      ..add(GLastIndexedBlockNumberData_parameters_by_pk.serializer)
      ..add(GLastIndexedBlockNumberReq.serializer)
      ..add(GLastIndexedBlockNumberVars.serializer)
      ..add(GSearchIdentityData.serializer)
      ..add(GSearchIdentityData_search_identity.serializer)
      ..add(GSearchIdentityReq.serializer)
      ..add(GSearchIdentityVars.serializer)
      ..add(GString_comparison_exp.serializer)
      ..add(Gaccount_bool_exp.serializer)
      ..add(Gaccount_order_by.serializer)
      ..add(Gaccount_select_column.serializer)
      ..add(Gaccount_stream_cursor_input.serializer)
      ..add(Gaccount_stream_cursor_value_input.serializer)
      ..add(Gblock_bool_exp.serializer)
      ..add(Gblock_order_by.serializer)
      ..add(Gblock_select_column.serializer)
      ..add(Gblock_stream_cursor_input.serializer)
      ..add(Gblock_stream_cursor_value_input.serializer)
      ..add(Gcertification_aggregate_bool_exp.serializer)
      ..add(Gcertification_aggregate_bool_exp_count.serializer)
      ..add(Gcertification_aggregate_order_by.serializer)
      ..add(Gcertification_avg_order_by.serializer)
      ..add(Gcertification_bool_exp.serializer)
      ..add(Gcertification_max_order_by.serializer)
      ..add(Gcertification_min_order_by.serializer)
      ..add(Gcertification_order_by.serializer)
      ..add(Gcertification_select_column.serializer)
      ..add(Gcertification_stddev_order_by.serializer)
      ..add(Gcertification_stddev_pop_order_by.serializer)
      ..add(Gcertification_stddev_samp_order_by.serializer)
      ..add(Gcertification_stream_cursor_input.serializer)
      ..add(Gcertification_stream_cursor_value_input.serializer)
      ..add(Gcertification_sum_order_by.serializer)
      ..add(Gcertification_var_pop_order_by.serializer)
      ..add(Gcertification_var_samp_order_by.serializer)
      ..add(Gcertification_variance_order_by.serializer)
      ..add(Gcursor_ordering.serializer)
      ..add(Gdate.serializer)
      ..add(Gidentity_bool_exp.serializer)
      ..add(Gidentity_order_by.serializer)
      ..add(Gidentity_select_column.serializer)
      ..add(Gidentity_stream_cursor_input.serializer)
      ..add(Gidentity_stream_cursor_value_input.serializer)
      ..add(Gjsonb.serializer)
      ..add(Gjsonb_cast_exp.serializer)
      ..add(Gjsonb_comparison_exp.serializer)
      ..add(Gorder_by.serializer)
      ..add(Gparameters_bool_exp.serializer)
      ..add(Gparameters_order_by.serializer)
      ..add(Gparameters_select_column.serializer)
      ..add(Gparameters_stream_cursor_input.serializer)
      ..add(Gparameters_stream_cursor_value_input.serializer)
      ..add(Gsearch_identity_args.serializer)
      ..add(Gsmith_bool_exp.serializer)
      ..add(Gsmith_cert_aggregate_bool_exp.serializer)
      ..add(Gsmith_cert_aggregate_bool_exp_count.serializer)
      ..add(Gsmith_cert_aggregate_order_by.serializer)
      ..add(Gsmith_cert_avg_order_by.serializer)
      ..add(Gsmith_cert_bool_exp.serializer)
      ..add(Gsmith_cert_max_order_by.serializer)
      ..add(Gsmith_cert_min_order_by.serializer)
      ..add(Gsmith_cert_order_by.serializer)
      ..add(Gsmith_cert_select_column.serializer)
      ..add(Gsmith_cert_stddev_order_by.serializer)
      ..add(Gsmith_cert_stddev_pop_order_by.serializer)
      ..add(Gsmith_cert_stddev_samp_order_by.serializer)
      ..add(Gsmith_cert_stream_cursor_input.serializer)
      ..add(Gsmith_cert_stream_cursor_value_input.serializer)
      ..add(Gsmith_cert_sum_order_by.serializer)
      ..add(Gsmith_cert_var_pop_order_by.serializer)
      ..add(Gsmith_cert_var_samp_order_by.serializer)
      ..add(Gsmith_cert_variance_order_by.serializer)
      ..add(Gsmith_order_by.serializer)
      ..add(Gsmith_select_column.serializer)
      ..add(Gsmith_stream_cursor_input.serializer)
      ..add(Gsmith_stream_cursor_value_input.serializer)
      ..add(Gtime_period.serializer)
      ..add(Gtimestamp.serializer)
      ..add(Gtimestamp_comparison_exp.serializer)
      ..add(Gtimestamptz.serializer)
      ..add(Gtimestamptz_comparison_exp.serializer)
      ..add(Gtransaction_aggregate_bool_exp.serializer)
      ..add(Gtransaction_aggregate_bool_exp_count.serializer)
      ..add(Gtransaction_aggregate_order_by.serializer)
      ..add(Gtransaction_avg_order_by.serializer)
      ..add(Gtransaction_bool_exp.serializer)
      ..add(Gtransaction_max_order_by.serializer)
      ..add(Gtransaction_min_order_by.serializer)
      ..add(Gtransaction_order_by.serializer)
      ..add(Gtransaction_select_column.serializer)
      ..add(Gtransaction_stddev_order_by.serializer)
      ..add(Gtransaction_stddev_pop_order_by.serializer)
      ..add(Gtransaction_stddev_samp_order_by.serializer)
      ..add(Gtransaction_stream_cursor_input.serializer)
      ..add(Gtransaction_stream_cursor_value_input.serializer)
      ..add(Gtransaction_sum_order_by.serializer)
      ..add(Gtransaction_timeserie_args.serializer)
      ..add(Gtransaction_timeserie_tmp_bool_exp.serializer)
      ..add(Gtransaction_timeserie_tmp_order_by.serializer)
      ..add(Gtransaction_timeserie_tmp_select_column.serializer)
      ..add(Gtransaction_timeserie_tmp_stream_cursor_input.serializer)
      ..add(Gtransaction_timeserie_tmp_stream_cursor_value_input.serializer)
      ..add(Gtransaction_var_pop_order_by.serializer)
      ..add(Gtransaction_var_samp_order_by.serializer)
      ..add(Gtransaction_variance_order_by.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountsByNameOrPkData_account)]),
          () => new ListBuilder<GAccountsByNameOrPkData_account>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GSearchIdentityData_search_identity)]),
          () => new ListBuilder<GSearchIdentityData_search_identity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gaccount_bool_exp)]),
          () => new ListBuilder<Gaccount_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gaccount_bool_exp)]),
          () => new ListBuilder<Gaccount_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gblock_bool_exp)]),
          () => new ListBuilder<Gblock_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gblock_bool_exp)]),
          () => new ListBuilder<Gblock_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gcertification_bool_exp)]),
          () => new ListBuilder<Gcertification_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gcertification_bool_exp)]),
          () => new ListBuilder<Gcertification_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gcertification_select_column)]),
          () => new ListBuilder<Gcertification_select_column>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gidentity_bool_exp)]),
          () => new ListBuilder<Gidentity_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gidentity_bool_exp)]),
          () => new ListBuilder<Gidentity_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gparameters_bool_exp)]),
          () => new ListBuilder<Gparameters_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gparameters_bool_exp)]),
          () => new ListBuilder<Gparameters_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gsmith_bool_exp)]),
          () => new ListBuilder<Gsmith_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gsmith_bool_exp)]),
          () => new ListBuilder<Gsmith_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gsmith_cert_bool_exp)]),
          () => new ListBuilder<Gsmith_cert_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gsmith_cert_bool_exp)]),
          () => new ListBuilder<Gsmith_cert_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gsmith_cert_select_column)]),
          () => new ListBuilder<Gsmith_cert_select_column>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gtimestamp)]),
          () => new ListBuilder<Gtimestamp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gtimestamp)]),
          () => new ListBuilder<Gtimestamp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gtimestamptz)]),
          () => new ListBuilder<Gtimestamptz>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gtimestamptz)]),
          () => new ListBuilder<Gtimestamptz>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gtransaction_bool_exp)]),
          () => new ListBuilder<Gtransaction_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gtransaction_bool_exp)]),
          () => new ListBuilder<Gtransaction_bool_exp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(Gtransaction_select_column)]),
          () => new ListBuilder<Gtransaction_select_column>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(Gtransaction_timeserie_tmp_bool_exp)]),
          () => new ListBuilder<Gtransaction_timeserie_tmp_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(Gtransaction_timeserie_tmp_bool_exp)]),
          () => new ListBuilder<Gtransaction_timeserie_tmp_bool_exp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gjsonb)]),
          () => new ListBuilder<Gjsonb>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gjsonb)]),
          () => new ListBuilder<Gjsonb>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(bool)]),
          () => new ListBuilder<bool>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(bool)]),
          () => new ListBuilder<bool>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(double)]),
          () => new ListBuilder<double>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(double)]),
          () => new ListBuilder<double>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
