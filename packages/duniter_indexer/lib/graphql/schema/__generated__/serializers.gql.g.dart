// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(FetchPolicy.serializer)
      ..add(GAccountAggregateBoolExp.serializer)
      ..add(GAccountAggregateOrderBy.serializer)
      ..add(GAccountAvgOrderBy.serializer)
      ..add(GAccountBasicByPkData.serializer)
      ..add(GAccountBasicByPkData_accountByPk.serializer)
      ..add(GAccountBasicByPkData_accountByPk_identity.serializer)
      ..add(GAccountBasicByPkReq.serializer)
      ..add(GAccountBasicByPkVars.serializer)
      ..add(GAccountBasicFieldsData.serializer)
      ..add(GAccountBasicFieldsData_identity.serializer)
      ..add(GAccountBasicFieldsReq.serializer)
      ..add(GAccountBasicFieldsVars.serializer)
      ..add(GAccountBoolExp.serializer)
      ..add(GAccountByPkData.serializer)
      ..add(GAccountByPkData_accountByPk.serializer)
      ..add(GAccountByPkData_accountByPk_commentsIssued.serializer)
      ..add(GAccountByPkData_accountByPk_commentsIssuedAggregate.serializer)
      ..add(GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate
          .serializer)
      ..add(GAccountByPkData_accountByPk_identity.serializer)
      ..add(GAccountByPkData_accountByPk_identity_certIssued.serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_certIssuedAggregate.serializer)
      ..add(GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate
          .serializer)
      ..add(GAccountByPkData_accountByPk_identity_certIssued_issuer.serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_certIssued_receiver.serializer)
      ..add(GAccountByPkData_accountByPk_identity_certReceived.serializer)
      ..add(GAccountByPkData_accountByPk_identity_certReceivedAggregate
          .serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate
              .serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_certReceived_issuer.serializer)
      ..add(GAccountByPkData_accountByPk_identity_certReceived_receiver
          .serializer)
      ..add(GAccountByPkData_accountByPk_identity_linkedAccount.serializer)
      ..add(GAccountByPkData_accountByPk_identity_linkedAccountAggregate
          .serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate
              .serializer)
      ..add(GAccountByPkData_accountByPk_identity_membershipHistory.serializer)
      ..add(GAccountByPkData_accountByPk_identity_membershipHistoryAggregate
          .serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate
              .serializer)
      ..add(GAccountByPkData_accountByPk_identity_ownerKeyChange.serializer)
      ..add(GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate
          .serializer)
      ..add(
          GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate
              .serializer)
      ..add(GAccountByPkData_accountByPk_identity_smith.serializer)
      ..add(GAccountByPkData_accountByPk_identity_smith_smithCertIssued
          .serializer)
      ..add(GAccountByPkData_accountByPk_identity_smith_smithCertReceived
          .serializer)
      ..add(GAccountByPkData_accountByPk_identity_udHistory.serializer)
      ..add(GAccountByPkData_accountByPk_linkedIdentity.serializer)
      ..add(GAccountByPkData_accountByPk_removedIdentities.serializer)
      ..add(GAccountByPkData_accountByPk_removedIdentitiesAggregate.serializer)
      ..add(GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate
          .serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssued.serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssuedAggregate.serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate
          .serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum
          .serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssued_comment.serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssued_from.serializer)
      ..add(GAccountByPkData_accountByPk_transfersIssued_to.serializer)
      ..add(GAccountByPkData_accountByPk_transfersReceived.serializer)
      ..add(GAccountByPkData_accountByPk_transfersReceivedAggregate.serializer)
      ..add(GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate
          .serializer)
      ..add(
          GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum
              .serializer)
      ..add(GAccountByPkData_accountByPk_transfersReceived_comment.serializer)
      ..add(GAccountByPkData_accountByPk_transfersReceived_from.serializer)
      ..add(GAccountByPkData_accountByPk_transfersReceived_to.serializer)
      ..add(GAccountByPkData_accountByPk_wasIdentity.serializer)
      ..add(GAccountByPkData_accountByPk_wasIdentityAggregate.serializer)
      ..add(GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate
          .serializer)
      ..add(GAccountByPkReq.serializer)
      ..add(GAccountByPkVars.serializer)
      ..add(GAccountFieldsData.serializer)
      ..add(GAccountFieldsData_commentsIssued.serializer)
      ..add(GAccountFieldsData_commentsIssuedAggregate.serializer)
      ..add(GAccountFieldsData_commentsIssuedAggregate_aggregate.serializer)
      ..add(GAccountFieldsData_identity.serializer)
      ..add(GAccountFieldsData_identity_certIssued.serializer)
      ..add(GAccountFieldsData_identity_certIssuedAggregate.serializer)
      ..add(
          GAccountFieldsData_identity_certIssuedAggregate_aggregate.serializer)
      ..add(GAccountFieldsData_identity_certIssued_issuer.serializer)
      ..add(GAccountFieldsData_identity_certIssued_receiver.serializer)
      ..add(GAccountFieldsData_identity_certReceived.serializer)
      ..add(GAccountFieldsData_identity_certReceivedAggregate.serializer)
      ..add(GAccountFieldsData_identity_certReceivedAggregate_aggregate
          .serializer)
      ..add(GAccountFieldsData_identity_certReceived_issuer.serializer)
      ..add(GAccountFieldsData_identity_certReceived_receiver.serializer)
      ..add(GAccountFieldsData_identity_linkedAccount.serializer)
      ..add(GAccountFieldsData_identity_linkedAccountAggregate.serializer)
      ..add(GAccountFieldsData_identity_linkedAccountAggregate_aggregate
          .serializer)
      ..add(GAccountFieldsData_identity_membershipHistory.serializer)
      ..add(GAccountFieldsData_identity_membershipHistoryAggregate.serializer)
      ..add(GAccountFieldsData_identity_membershipHistoryAggregate_aggregate
          .serializer)
      ..add(GAccountFieldsData_identity_ownerKeyChange.serializer)
      ..add(GAccountFieldsData_identity_ownerKeyChangeAggregate.serializer)
      ..add(GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate
          .serializer)
      ..add(GAccountFieldsData_identity_smith.serializer)
      ..add(GAccountFieldsData_identity_smith_smithCertIssued.serializer)
      ..add(GAccountFieldsData_identity_smith_smithCertReceived.serializer)
      ..add(GAccountFieldsData_identity_udHistory.serializer)
      ..add(GAccountFieldsData_linkedIdentity.serializer)
      ..add(GAccountFieldsData_removedIdentities.serializer)
      ..add(GAccountFieldsData_removedIdentitiesAggregate.serializer)
      ..add(GAccountFieldsData_removedIdentitiesAggregate_aggregate.serializer)
      ..add(GAccountFieldsData_transfersIssued.serializer)
      ..add(GAccountFieldsData_transfersIssuedAggregate.serializer)
      ..add(GAccountFieldsData_transfersIssuedAggregate_aggregate.serializer)
      ..add(
          GAccountFieldsData_transfersIssuedAggregate_aggregate_sum.serializer)
      ..add(GAccountFieldsData_transfersIssued_comment.serializer)
      ..add(GAccountFieldsData_transfersIssued_from.serializer)
      ..add(GAccountFieldsData_transfersIssued_to.serializer)
      ..add(GAccountFieldsData_transfersReceived.serializer)
      ..add(GAccountFieldsData_transfersReceivedAggregate.serializer)
      ..add(GAccountFieldsData_transfersReceivedAggregate_aggregate.serializer)
      ..add(GAccountFieldsData_transfersReceivedAggregate_aggregate_sum
          .serializer)
      ..add(GAccountFieldsData_transfersReceived_comment.serializer)
      ..add(GAccountFieldsData_transfersReceived_from.serializer)
      ..add(GAccountFieldsData_transfersReceived_to.serializer)
      ..add(GAccountFieldsData_wasIdentity.serializer)
      ..add(GAccountFieldsData_wasIdentityAggregate.serializer)
      ..add(GAccountFieldsData_wasIdentityAggregate_aggregate.serializer)
      ..add(GAccountFieldsReq.serializer)
      ..add(GAccountFieldsVars.serializer)
      ..add(GAccountMaxOrderBy.serializer)
      ..add(GAccountMinOrderBy.serializer)
      ..add(GAccountOrderBy.serializer)
      ..add(GAccountSelectColumn.serializer)
      ..add(GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns
          .serializer)
      ..add(GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns
          .serializer)
      ..add(GAccountStddevOrderBy.serializer)
      ..add(GAccountStddevPopOrderBy.serializer)
      ..add(GAccountStddevSampOrderBy.serializer)
      ..add(GAccountStreamCursorInput.serializer)
      ..add(GAccountStreamCursorValueInput.serializer)
      ..add(GAccountSumOrderBy.serializer)
      ..add(GAccountVarPopOrderBy.serializer)
      ..add(GAccountVarSampOrderBy.serializer)
      ..add(GAccountVarianceOrderBy.serializer)
      ..add(GAccountsByPkData.serializer)
      ..add(GAccountsByPkData_account.serializer)
      ..add(GAccountsByPkData_account_commentsIssued.serializer)
      ..add(GAccountsByPkData_account_commentsIssuedAggregate.serializer)
      ..add(GAccountsByPkData_account_commentsIssuedAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_identity.serializer)
      ..add(GAccountsByPkData_account_identity_certIssued.serializer)
      ..add(GAccountsByPkData_account_identity_certIssuedAggregate.serializer)
      ..add(GAccountsByPkData_account_identity_certIssuedAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_identity_certIssued_issuer.serializer)
      ..add(GAccountsByPkData_account_identity_certIssued_receiver.serializer)
      ..add(GAccountsByPkData_account_identity_certReceived.serializer)
      ..add(GAccountsByPkData_account_identity_certReceivedAggregate.serializer)
      ..add(GAccountsByPkData_account_identity_certReceivedAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_identity_certReceived_issuer.serializer)
      ..add(GAccountsByPkData_account_identity_certReceived_receiver.serializer)
      ..add(GAccountsByPkData_account_identity_linkedAccount.serializer)
      ..add(
          GAccountsByPkData_account_identity_linkedAccountAggregate.serializer)
      ..add(GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_identity_membershipHistory.serializer)
      ..add(GAccountsByPkData_account_identity_membershipHistoryAggregate
          .serializer)
      ..add(
          GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate
              .serializer)
      ..add(GAccountsByPkData_account_identity_ownerKeyChange.serializer)
      ..add(
          GAccountsByPkData_account_identity_ownerKeyChangeAggregate.serializer)
      ..add(GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_identity_smith.serializer)
      ..add(GAccountsByPkData_account_identity_smith_smithCertIssued.serializer)
      ..add(
          GAccountsByPkData_account_identity_smith_smithCertReceived.serializer)
      ..add(GAccountsByPkData_account_identity_udHistory.serializer)
      ..add(GAccountsByPkData_account_linkedIdentity.serializer)
      ..add(GAccountsByPkData_account_removedIdentities.serializer)
      ..add(GAccountsByPkData_account_removedIdentitiesAggregate.serializer)
      ..add(GAccountsByPkData_account_removedIdentitiesAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_transfersIssued.serializer)
      ..add(GAccountsByPkData_account_transfersIssuedAggregate.serializer)
      ..add(GAccountsByPkData_account_transfersIssuedAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum
          .serializer)
      ..add(GAccountsByPkData_account_transfersIssued_comment.serializer)
      ..add(GAccountsByPkData_account_transfersIssued_from.serializer)
      ..add(GAccountsByPkData_account_transfersIssued_to.serializer)
      ..add(GAccountsByPkData_account_transfersReceived.serializer)
      ..add(GAccountsByPkData_account_transfersReceivedAggregate.serializer)
      ..add(GAccountsByPkData_account_transfersReceivedAggregate_aggregate
          .serializer)
      ..add(GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum
          .serializer)
      ..add(GAccountsByPkData_account_transfersReceived_comment.serializer)
      ..add(GAccountsByPkData_account_transfersReceived_from.serializer)
      ..add(GAccountsByPkData_account_transfersReceived_to.serializer)
      ..add(GAccountsByPkData_account_wasIdentity.serializer)
      ..add(GAccountsByPkData_account_wasIdentityAggregate.serializer)
      ..add(GAccountsByPkData_account_wasIdentityAggregate_aggregate.serializer)
      ..add(GAccountsByPkReq.serializer)
      ..add(GAccountsByPkVars.serializer)
      ..add(GBlockBoolExp.serializer)
      ..add(GBlockOrderBy.serializer)
      ..add(GBlockSelectColumn.serializer)
      ..add(GBlockStreamCursorInput.serializer)
      ..add(GBlockStreamCursorValueInput.serializer)
      ..add(GBooleanComparisonExp.serializer)
      ..add(GByteaComparisonExp.serializer)
      ..add(GCallAggregateBoolExp.serializer)
      ..add(GCallAggregateOrderBy.serializer)
      ..add(GCallBoolExp.serializer)
      ..add(GCallMaxOrderBy.serializer)
      ..add(GCallMinOrderBy.serializer)
      ..add(GCallOrderBy.serializer)
      ..add(GCallSelectColumn.serializer)
      ..add(GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns
          .serializer)
      ..add(GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns
          .serializer)
      ..add(GCallStreamCursorInput.serializer)
      ..add(GCallStreamCursorValueInput.serializer)
      ..add(GCertAggregateBoolExp.serializer)
      ..add(GCertAggregateOrderBy.serializer)
      ..add(GCertAvgOrderBy.serializer)
      ..add(GCertBoolExp.serializer)
      ..add(GCertEventAggregateBoolExp.serializer)
      ..add(GCertEventAggregateOrderBy.serializer)
      ..add(GCertEventAvgOrderBy.serializer)
      ..add(GCertEventBoolExp.serializer)
      ..add(GCertEventMaxOrderBy.serializer)
      ..add(GCertEventMinOrderBy.serializer)
      ..add(GCertEventOrderBy.serializer)
      ..add(GCertEventSelectColumn.serializer)
      ..add(GCertEventStddevOrderBy.serializer)
      ..add(GCertEventStddevPopOrderBy.serializer)
      ..add(GCertEventStddevSampOrderBy.serializer)
      ..add(GCertEventStreamCursorInput.serializer)
      ..add(GCertEventStreamCursorValueInput.serializer)
      ..add(GCertEventSumOrderBy.serializer)
      ..add(GCertEventVarPopOrderBy.serializer)
      ..add(GCertEventVarSampOrderBy.serializer)
      ..add(GCertEventVarianceOrderBy.serializer)
      ..add(GCertFieldsData.serializer)
      ..add(GCertFieldsData_issuer.serializer)
      ..add(GCertFieldsData_receiver.serializer)
      ..add(GCertFieldsReq.serializer)
      ..add(GCertFieldsVars.serializer)
      ..add(GCertMaxOrderBy.serializer)
      ..add(GCertMinOrderBy.serializer)
      ..add(GCertOrderBy.serializer)
      ..add(GCertSelectColumn.serializer)
      ..add(GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns
          .serializer)
      ..add(GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns
          .serializer)
      ..add(GCertStddevOrderBy.serializer)
      ..add(GCertStddevPopOrderBy.serializer)
      ..add(GCertStddevSampOrderBy.serializer)
      ..add(GCertStreamCursorInput.serializer)
      ..add(GCertStreamCursorValueInput.serializer)
      ..add(GCertSumOrderBy.serializer)
      ..add(GCertVarPopOrderBy.serializer)
      ..add(GCertVarSampOrderBy.serializer)
      ..add(GCertVarianceOrderBy.serializer)
      ..add(GChangeOwnerKeyAggregateBoolExp.serializer)
      ..add(GChangeOwnerKeyAggregateOrderBy.serializer)
      ..add(GChangeOwnerKeyAvgOrderBy.serializer)
      ..add(GChangeOwnerKeyBoolExp.serializer)
      ..add(GChangeOwnerKeyMaxOrderBy.serializer)
      ..add(GChangeOwnerKeyMinOrderBy.serializer)
      ..add(GChangeOwnerKeyOrderBy.serializer)
      ..add(GChangeOwnerKeySelectColumn.serializer)
      ..add(GChangeOwnerKeyStddevOrderBy.serializer)
      ..add(GChangeOwnerKeyStddevPopOrderBy.serializer)
      ..add(GChangeOwnerKeyStddevSampOrderBy.serializer)
      ..add(GChangeOwnerKeyStreamCursorInput.serializer)
      ..add(GChangeOwnerKeyStreamCursorValueInput.serializer)
      ..add(GChangeOwnerKeySumOrderBy.serializer)
      ..add(GChangeOwnerKeyVarPopOrderBy.serializer)
      ..add(GChangeOwnerKeyVarSampOrderBy.serializer)
      ..add(GChangeOwnerKeyVarianceOrderBy.serializer)
      ..add(GCommentTypeEnum.serializer)
      ..add(GCommentTypeEnumComparisonExp.serializer)
      ..add(GCommentsIssuedData.serializer)
      ..add(GCommentsIssuedReq.serializer)
      ..add(GCommentsIssuedVars.serializer)
      ..add(GCounterLevelEnum.serializer)
      ..add(GCounterLevelEnumComparisonExp.serializer)
      ..add(GCursorOrdering.serializer)
      ..add(GEventAggregateBoolExp.serializer)
      ..add(GEventAggregateOrderBy.serializer)
      ..add(GEventAvgOrderBy.serializer)
      ..add(GEventBoolExp.serializer)
      ..add(GEventMaxOrderBy.serializer)
      ..add(GEventMinOrderBy.serializer)
      ..add(GEventOrderBy.serializer)
      ..add(GEventSelectColumn.serializer)
      ..add(GEventStddevOrderBy.serializer)
      ..add(GEventStddevPopOrderBy.serializer)
      ..add(GEventStddevSampOrderBy.serializer)
      ..add(GEventStreamCursorInput.serializer)
      ..add(GEventStreamCursorValueInput.serializer)
      ..add(GEventSumOrderBy.serializer)
      ..add(GEventTypeEnum.serializer)
      ..add(GEventTypeEnumComparisonExp.serializer)
      ..add(GEventVarPopOrderBy.serializer)
      ..add(GEventVarSampOrderBy.serializer)
      ..add(GEventVarianceOrderBy.serializer)
      ..add(GExtrinsicAggregateBoolExp.serializer)
      ..add(GExtrinsicAggregateOrderBy.serializer)
      ..add(GExtrinsicAvgOrderBy.serializer)
      ..add(GExtrinsicBoolExp.serializer)
      ..add(GExtrinsicMaxOrderBy.serializer)
      ..add(GExtrinsicMinOrderBy.serializer)
      ..add(GExtrinsicOrderBy.serializer)
      ..add(GExtrinsicSelectColumn.serializer)
      ..add(
          GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns
              .serializer)
      ..add(
          GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns
              .serializer)
      ..add(GExtrinsicStddevOrderBy.serializer)
      ..add(GExtrinsicStddevPopOrderBy.serializer)
      ..add(GExtrinsicStddevSampOrderBy.serializer)
      ..add(GExtrinsicStreamCursorInput.serializer)
      ..add(GExtrinsicStreamCursorValueInput.serializer)
      ..add(GExtrinsicSumOrderBy.serializer)
      ..add(GExtrinsicVarPopOrderBy.serializer)
      ..add(GExtrinsicVarSampOrderBy.serializer)
      ..add(GExtrinsicVarianceOrderBy.serializer)
      ..add(GGetHistoryAndBalanceData.serializer)
      ..add(GGetHistoryAndBalanceData_account.serializer)
      ..add(GGetHistoryAndBalanceData_account_commentsIssued.serializer)
      ..add(
          GGetHistoryAndBalanceData_account_commentsIssuedAggregate.serializer)
      ..add(GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity.serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certIssued.serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certIssuedAggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate
              .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certIssued_issuer
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certIssued_receiver
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certReceived.serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certReceivedAggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate
              .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certReceived_issuer
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_certReceived_receiver
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_linkedAccount.serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate
              .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_membershipHistory
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate
              .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate
              .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_ownerKeyChange.serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate
              .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_smith.serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_identity_udHistory.serializer)
      ..add(GGetHistoryAndBalanceData_account_linkedIdentity.serializer)
      ..add(GGetHistoryAndBalanceData_account_removedIdentities.serializer)
      ..add(GGetHistoryAndBalanceData_account_removedIdentitiesAggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate
              .serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersIssued.serializer)
      ..add(
          GGetHistoryAndBalanceData_account_transfersIssuedAggregate.serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum
              .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_transfersIssued_comment.serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersIssued_from.serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersIssued_to.serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersReceived.serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersReceivedAggregate
          .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate
              .serializer)
      ..add(
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum
              .serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersReceived_comment
          .serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersReceived_from.serializer)
      ..add(GGetHistoryAndBalanceData_account_transfersReceived_to.serializer)
      ..add(GGetHistoryAndBalanceData_account_wasIdentity.serializer)
      ..add(GGetHistoryAndBalanceData_account_wasIdentityAggregate.serializer)
      ..add(GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate
          .serializer)
      ..add(GGetHistoryAndBalanceReq.serializer)
      ..add(GGetHistoryAndBalanceVars.serializer)
      ..add(GIdentitiesByNameData.serializer)
      ..add(GIdentitiesByNameData_identity.serializer)
      ..add(GIdentitiesByNameData_identity_certIssued.serializer)
      ..add(GIdentitiesByNameData_identity_certIssuedAggregate.serializer)
      ..add(GIdentitiesByNameData_identity_certIssuedAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameData_identity_certIssued_issuer.serializer)
      ..add(GIdentitiesByNameData_identity_certIssued_receiver.serializer)
      ..add(GIdentitiesByNameData_identity_certReceived.serializer)
      ..add(GIdentitiesByNameData_identity_certReceivedAggregate.serializer)
      ..add(GIdentitiesByNameData_identity_certReceivedAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameData_identity_certReceived_issuer.serializer)
      ..add(GIdentitiesByNameData_identity_certReceived_receiver.serializer)
      ..add(GIdentitiesByNameData_identity_linkedAccount.serializer)
      ..add(GIdentitiesByNameData_identity_linkedAccountAggregate.serializer)
      ..add(GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameData_identity_membershipHistory.serializer)
      ..add(
          GIdentitiesByNameData_identity_membershipHistoryAggregate.serializer)
      ..add(GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameData_identity_ownerKeyChange.serializer)
      ..add(GIdentitiesByNameData_identity_ownerKeyChangeAggregate.serializer)
      ..add(GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameData_identity_smith.serializer)
      ..add(GIdentitiesByNameData_identity_smith_smithCertIssued.serializer)
      ..add(GIdentitiesByNameData_identity_smith_smithCertReceived.serializer)
      ..add(GIdentitiesByNameData_identity_udHistory.serializer)
      ..add(GIdentitiesByNameOrPkData.serializer)
      ..add(GIdentitiesByNameOrPkData_identity.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certIssued.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certIssuedAggregate.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certIssued_issuer.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certIssued_receiver.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certReceived.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certReceivedAggregate.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certReceived_issuer.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_certReceived_receiver.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_linkedAccount.serializer)
      ..add(
          GIdentitiesByNameOrPkData_identity_linkedAccountAggregate.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameOrPkData_identity_membershipHistory.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate
          .serializer)
      ..add(
          GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate
              .serializer)
      ..add(GIdentitiesByNameOrPkData_identity_ownerKeyChange.serializer)
      ..add(
          GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByNameOrPkData_identity_smith.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_smith_smithCertIssued.serializer)
      ..add(
          GIdentitiesByNameOrPkData_identity_smith_smithCertReceived.serializer)
      ..add(GIdentitiesByNameOrPkData_identity_udHistory.serializer)
      ..add(GIdentitiesByNameOrPkReq.serializer)
      ..add(GIdentitiesByNameOrPkVars.serializer)
      ..add(GIdentitiesByNameReq.serializer)
      ..add(GIdentitiesByNameVars.serializer)
      ..add(GIdentitiesByPkData.serializer)
      ..add(GIdentitiesByPkData_identity.serializer)
      ..add(GIdentitiesByPkData_identity_certIssued.serializer)
      ..add(GIdentitiesByPkData_identity_certIssuedAggregate.serializer)
      ..add(
          GIdentitiesByPkData_identity_certIssuedAggregate_aggregate.serializer)
      ..add(GIdentitiesByPkData_identity_certIssued_issuer.serializer)
      ..add(GIdentitiesByPkData_identity_certIssued_receiver.serializer)
      ..add(GIdentitiesByPkData_identity_certReceived.serializer)
      ..add(GIdentitiesByPkData_identity_certReceivedAggregate.serializer)
      ..add(GIdentitiesByPkData_identity_certReceivedAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByPkData_identity_certReceived_issuer.serializer)
      ..add(GIdentitiesByPkData_identity_certReceived_receiver.serializer)
      ..add(GIdentitiesByPkData_identity_linkedAccount.serializer)
      ..add(GIdentitiesByPkData_identity_linkedAccountAggregate.serializer)
      ..add(GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByPkData_identity_membershipHistory.serializer)
      ..add(GIdentitiesByPkData_identity_membershipHistoryAggregate.serializer)
      ..add(GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByPkData_identity_ownerKeyChange.serializer)
      ..add(GIdentitiesByPkData_identity_ownerKeyChangeAggregate.serializer)
      ..add(GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate
          .serializer)
      ..add(GIdentitiesByPkData_identity_smith.serializer)
      ..add(GIdentitiesByPkData_identity_smith_smithCertIssued.serializer)
      ..add(GIdentitiesByPkData_identity_smith_smithCertReceived.serializer)
      ..add(GIdentitiesByPkData_identity_udHistory.serializer)
      ..add(GIdentitiesByPkReq.serializer)
      ..add(GIdentitiesByPkVars.serializer)
      ..add(GIdentityAggregateBoolExp.serializer)
      ..add(GIdentityAggregateOrderBy.serializer)
      ..add(GIdentityAvgOrderBy.serializer)
      ..add(GIdentityBasicFieldsData.serializer)
      ..add(GIdentityBasicFieldsReq.serializer)
      ..add(GIdentityBasicFieldsVars.serializer)
      ..add(GIdentityBoolExp.serializer)
      ..add(GIdentityFieldsData.serializer)
      ..add(GIdentityFieldsData_certIssued.serializer)
      ..add(GIdentityFieldsData_certIssuedAggregate.serializer)
      ..add(GIdentityFieldsData_certIssuedAggregate_aggregate.serializer)
      ..add(GIdentityFieldsData_certIssued_issuer.serializer)
      ..add(GIdentityFieldsData_certIssued_receiver.serializer)
      ..add(GIdentityFieldsData_certReceived.serializer)
      ..add(GIdentityFieldsData_certReceivedAggregate.serializer)
      ..add(GIdentityFieldsData_certReceivedAggregate_aggregate.serializer)
      ..add(GIdentityFieldsData_certReceived_issuer.serializer)
      ..add(GIdentityFieldsData_certReceived_receiver.serializer)
      ..add(GIdentityFieldsData_linkedAccount.serializer)
      ..add(GIdentityFieldsData_linkedAccountAggregate.serializer)
      ..add(GIdentityFieldsData_linkedAccountAggregate_aggregate.serializer)
      ..add(GIdentityFieldsData_membershipHistory.serializer)
      ..add(GIdentityFieldsData_membershipHistoryAggregate.serializer)
      ..add(GIdentityFieldsData_membershipHistoryAggregate_aggregate.serializer)
      ..add(GIdentityFieldsData_ownerKeyChange.serializer)
      ..add(GIdentityFieldsData_ownerKeyChangeAggregate.serializer)
      ..add(GIdentityFieldsData_ownerKeyChangeAggregate_aggregate.serializer)
      ..add(GIdentityFieldsData_smith.serializer)
      ..add(GIdentityFieldsData_smith_smithCertIssued.serializer)
      ..add(GIdentityFieldsData_smith_smithCertReceived.serializer)
      ..add(GIdentityFieldsData_udHistory.serializer)
      ..add(GIdentityFieldsReq.serializer)
      ..add(GIdentityFieldsVars.serializer)
      ..add(GIdentityMaxOrderBy.serializer)
      ..add(GIdentityMinOrderBy.serializer)
      ..add(GIdentityOrderBy.serializer)
      ..add(GIdentitySelectColumn.serializer)
      ..add(
          GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns
              .serializer)
      ..add(GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns
          .serializer)
      ..add(GIdentityStatusEnum.serializer)
      ..add(GIdentityStatusEnumComparisonExp.serializer)
      ..add(GIdentityStddevOrderBy.serializer)
      ..add(GIdentityStddevPopOrderBy.serializer)
      ..add(GIdentityStddevSampOrderBy.serializer)
      ..add(GIdentityStreamCursorInput.serializer)
      ..add(GIdentityStreamCursorValueInput.serializer)
      ..add(GIdentitySumOrderBy.serializer)
      ..add(GIdentityVarPopOrderBy.serializer)
      ..add(GIdentityVarSampOrderBy.serializer)
      ..add(GIdentityVarianceOrderBy.serializer)
      ..add(GIntArrayComparisonExp.serializer)
      ..add(GIntComparisonExp.serializer)
      ..add(GItemTypeEnum.serializer)
      ..add(GItemTypeEnumComparisonExp.serializer)
      ..add(GItemsCounterBoolExp.serializer)
      ..add(GItemsCounterOrderBy.serializer)
      ..add(GItemsCounterSelectColumn.serializer)
      ..add(GItemsCounterStreamCursorInput.serializer)
      ..add(GItemsCounterStreamCursorValueInput.serializer)
      ..add(GJsonbCastExp.serializer)
      ..add(GJsonbComparisonExp.serializer)
      ..add(GLastBlockData.serializer)
      ..add(GLastBlockData_block.serializer)
      ..add(GLastBlockReq.serializer)
      ..add(GLastBlockVars.serializer)
      ..add(GMembershipEventAggregateBoolExp.serializer)
      ..add(GMembershipEventAggregateOrderBy.serializer)
      ..add(GMembershipEventAvgOrderBy.serializer)
      ..add(GMembershipEventBoolExp.serializer)
      ..add(GMembershipEventMaxOrderBy.serializer)
      ..add(GMembershipEventMinOrderBy.serializer)
      ..add(GMembershipEventOrderBy.serializer)
      ..add(GMembershipEventSelectColumn.serializer)
      ..add(GMembershipEventStddevOrderBy.serializer)
      ..add(GMembershipEventStddevPopOrderBy.serializer)
      ..add(GMembershipEventStddevSampOrderBy.serializer)
      ..add(GMembershipEventStreamCursorInput.serializer)
      ..add(GMembershipEventStreamCursorValueInput.serializer)
      ..add(GMembershipEventSumOrderBy.serializer)
      ..add(GMembershipEventVarPopOrderBy.serializer)
      ..add(GMembershipEventVarSampOrderBy.serializer)
      ..add(GMembershipEventVarianceOrderBy.serializer)
      ..add(GNumericComparisonExp.serializer)
      ..add(GOrderBy.serializer)
      ..add(GOwnerKeyChangeFieldsData.serializer)
      ..add(GOwnerKeyChangeFieldsReq.serializer)
      ..add(GOwnerKeyChangeFieldsVars.serializer)
      ..add(GPopulationHistoryBoolExp.serializer)
      ..add(GPopulationHistoryOrderBy.serializer)
      ..add(GPopulationHistorySelectColumn.serializer)
      ..add(GPopulationHistoryStreamCursorInput.serializer)
      ..add(GPopulationHistoryStreamCursorValueInput.serializer)
      ..add(GSmithBoolExp.serializer)
      ..add(GSmithCertAggregateBoolExp.serializer)
      ..add(GSmithCertAggregateOrderBy.serializer)
      ..add(GSmithCertAvgOrderBy.serializer)
      ..add(GSmithCertBoolExp.serializer)
      ..add(GSmithCertFieldsData.serializer)
      ..add(GSmithCertFieldsReq.serializer)
      ..add(GSmithCertFieldsVars.serializer)
      ..add(GSmithCertMaxOrderBy.serializer)
      ..add(GSmithCertMinOrderBy.serializer)
      ..add(GSmithCertOrderBy.serializer)
      ..add(GSmithCertSelectColumn.serializer)
      ..add(GSmithCertStddevOrderBy.serializer)
      ..add(GSmithCertStddevPopOrderBy.serializer)
      ..add(GSmithCertStddevSampOrderBy.serializer)
      ..add(GSmithCertStreamCursorInput.serializer)
      ..add(GSmithCertStreamCursorValueInput.serializer)
      ..add(GSmithCertSumOrderBy.serializer)
      ..add(GSmithCertVarPopOrderBy.serializer)
      ..add(GSmithCertVarSampOrderBy.serializer)
      ..add(GSmithCertVarianceOrderBy.serializer)
      ..add(GSmithEventAggregateBoolExp.serializer)
      ..add(GSmithEventAggregateOrderBy.serializer)
      ..add(GSmithEventAvgOrderBy.serializer)
      ..add(GSmithEventBoolExp.serializer)
      ..add(GSmithEventMaxOrderBy.serializer)
      ..add(GSmithEventMinOrderBy.serializer)
      ..add(GSmithEventOrderBy.serializer)
      ..add(GSmithEventSelectColumn.serializer)
      ..add(GSmithEventStddevOrderBy.serializer)
      ..add(GSmithEventStddevPopOrderBy.serializer)
      ..add(GSmithEventStddevSampOrderBy.serializer)
      ..add(GSmithEventStreamCursorInput.serializer)
      ..add(GSmithEventStreamCursorValueInput.serializer)
      ..add(GSmithEventSumOrderBy.serializer)
      ..add(GSmithEventTypeEnum.serializer)
      ..add(GSmithEventTypeEnumComparisonExp.serializer)
      ..add(GSmithEventVarPopOrderBy.serializer)
      ..add(GSmithEventVarSampOrderBy.serializer)
      ..add(GSmithEventVarianceOrderBy.serializer)
      ..add(GSmithFieldsData.serializer)
      ..add(GSmithFieldsData_smithCertIssued.serializer)
      ..add(GSmithFieldsData_smithCertReceived.serializer)
      ..add(GSmithFieldsReq.serializer)
      ..add(GSmithFieldsVars.serializer)
      ..add(GSmithOrderBy.serializer)
      ..add(GSmithSelectColumn.serializer)
      ..add(GSmithStatusEnum.serializer)
      ..add(GSmithStatusEnumComparisonExp.serializer)
      ..add(GSmithStreamCursorInput.serializer)
      ..add(GSmithStreamCursorValueInput.serializer)
      ..add(GStringArrayComparisonExp.serializer)
      ..add(GStringComparisonExp.serializer)
      ..add(GTimestamptzComparisonExp.serializer)
      ..add(GTransferAggregateBoolExp.serializer)
      ..add(GTransferAggregateOrderBy.serializer)
      ..add(GTransferAvgOrderBy.serializer)
      ..add(GTransferBoolExp.serializer)
      ..add(GTransferFieldsData.serializer)
      ..add(GTransferFieldsData_comment.serializer)
      ..add(GTransferFieldsData_from.serializer)
      ..add(GTransferFieldsData_to.serializer)
      ..add(GTransferFieldsReq.serializer)
      ..add(GTransferFieldsVars.serializer)
      ..add(GTransferMaxOrderBy.serializer)
      ..add(GTransferMinOrderBy.serializer)
      ..add(GTransferOrderBy.serializer)
      ..add(GTransferSelectColumn.serializer)
      ..add(GTransferStddevOrderBy.serializer)
      ..add(GTransferStddevPopOrderBy.serializer)
      ..add(GTransferStddevSampOrderBy.serializer)
      ..add(GTransferStreamCursorInput.serializer)
      ..add(GTransferStreamCursorValueInput.serializer)
      ..add(GTransferSumOrderBy.serializer)
      ..add(GTransferVarPopOrderBy.serializer)
      ..add(GTransferVarSampOrderBy.serializer)
      ..add(GTransferVarianceOrderBy.serializer)
      ..add(GTxCommentAggregateBoolExp.serializer)
      ..add(GTxCommentAggregateOrderBy.serializer)
      ..add(GTxCommentAvgOrderBy.serializer)
      ..add(GTxCommentBoolExp.serializer)
      ..add(GTxCommentMaxOrderBy.serializer)
      ..add(GTxCommentMinOrderBy.serializer)
      ..add(GTxCommentOrderBy.serializer)
      ..add(GTxCommentSelectColumn.serializer)
      ..add(GTxCommentStddevOrderBy.serializer)
      ..add(GTxCommentStddevPopOrderBy.serializer)
      ..add(GTxCommentStddevSampOrderBy.serializer)
      ..add(GTxCommentStreamCursorInput.serializer)
      ..add(GTxCommentStreamCursorValueInput.serializer)
      ..add(GTxCommentSumOrderBy.serializer)
      ..add(GTxCommentVarPopOrderBy.serializer)
      ..add(GTxCommentVarSampOrderBy.serializer)
      ..add(GTxCommentVarianceOrderBy.serializer)
      ..add(GUdHistoryAggregateOrderBy.serializer)
      ..add(GUdHistoryAvgOrderBy.serializer)
      ..add(GUdHistoryBoolExp.serializer)
      ..add(GUdHistoryMaxOrderBy.serializer)
      ..add(GUdHistoryMinOrderBy.serializer)
      ..add(GUdHistoryOrderBy.serializer)
      ..add(GUdHistorySelectColumn.serializer)
      ..add(GUdHistoryStddevOrderBy.serializer)
      ..add(GUdHistoryStddevPopOrderBy.serializer)
      ..add(GUdHistoryStddevSampOrderBy.serializer)
      ..add(GUdHistoryStreamCursorInput.serializer)
      ..add(GUdHistoryStreamCursorValueInput.serializer)
      ..add(GUdHistorySumOrderBy.serializer)
      ..add(GUdHistoryVarPopOrderBy.serializer)
      ..add(GUdHistoryVarSampOrderBy.serializer)
      ..add(GUdHistoryVarianceOrderBy.serializer)
      ..add(GUdReevalBoolExp.serializer)
      ..add(GUdReevalOrderBy.serializer)
      ..add(GUdReevalSelectColumn.serializer)
      ..add(GUdReevalStreamCursorInput.serializer)
      ..add(GUdReevalStreamCursorValueInput.serializer)
      ..add(GUniversalDividendBoolExp.serializer)
      ..add(GUniversalDividendOrderBy.serializer)
      ..add(GUniversalDividendSelectColumn.serializer)
      ..add(GUniversalDividendStreamCursorInput.serializer)
      ..add(GUniversalDividendStreamCursorValueInput.serializer)
      ..add(GValidatorBoolExp.serializer)
      ..add(GValidatorOrderBy.serializer)
      ..add(GValidatorSelectColumn.serializer)
      ..add(GValidatorStreamCursorInput.serializer)
      ..add(GValidatorStreamCursorValueInput.serializer)
      ..add(GaccountAggregateBoolExpBool_and.serializer)
      ..add(GaccountAggregateBoolExpBool_or.serializer)
      ..add(GaccountAggregateBoolExpCount.serializer)
      ..add(Gbytea.serializer)
      ..add(GcallAggregateBoolExpBool_and.serializer)
      ..add(GcallAggregateBoolExpBool_or.serializer)
      ..add(GcallAggregateBoolExpCount.serializer)
      ..add(GcertAggregateBoolExpBool_and.serializer)
      ..add(GcertAggregateBoolExpBool_or.serializer)
      ..add(GcertAggregateBoolExpCount.serializer)
      ..add(GcertEventAggregateBoolExpCount.serializer)
      ..add(GchangeOwnerKeyAggregateBoolExpCount.serializer)
      ..add(GeventAggregateBoolExpCount.serializer)
      ..add(GextrinsicAggregateBoolExpBool_and.serializer)
      ..add(GextrinsicAggregateBoolExpBool_or.serializer)
      ..add(GextrinsicAggregateBoolExpCount.serializer)
      ..add(GgetUdHistoryArgs.serializer)
      ..add(GidentityAggregateBoolExpBool_and.serializer)
      ..add(GidentityAggregateBoolExpBool_or.serializer)
      ..add(GidentityAggregateBoolExpCount.serializer)
      ..add(Gidentity_scalar.serializer)
      ..add(GmembershipEventAggregateBoolExpCount.serializer)
      ..add(GsmithCertAggregateBoolExpCount.serializer)
      ..add(GsmithEventAggregateBoolExpCount.serializer)
      ..add(Gtimestamptz.serializer)
      ..add(GtransferAggregateBoolExpCount.serializer)
      ..add(GtxCommentAggregateBoolExpCount.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GAccountBoolExp)]),
          () => new ListBuilder<GAccountBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GAccountBoolExp)]),
          () => new ListBuilder<GAccountBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_commentsIssued)
          ]),
          () => new ListBuilder<GAccountByPkData_accountByPk_commentsIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_removedIdentities)
          ]),
          () =>
              new ListBuilder<GAccountByPkData_accountByPk_removedIdentities>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_transfersIssued)
          ]),
          () => new ListBuilder<GAccountByPkData_accountByPk_transfersIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_transfersReceived)
          ]),
          () =>
              new ListBuilder<GAccountByPkData_accountByPk_transfersReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountByPkData_accountByPk_wasIdentity)]),
          () => new ListBuilder<GAccountByPkData_accountByPk_wasIdentity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_identity_certIssued)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_identity_certReceived)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_identity_linkedAccount)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GAccountByPkData_accountByPk_identity_membershipHistory)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_identity_ownerKeyChange)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountByPkData_accountByPk_identity_udHistory)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GAccountByPkData_accountByPk_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GAccountByPkData_accountByPk_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GAccountByPkData_accountByPk_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_commentsIssued)]),
          () => new ListBuilder<GAccountFieldsData_commentsIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_removedIdentities)]),
          () => new ListBuilder<GAccountFieldsData_removedIdentities>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_transfersIssued)]),
          () => new ListBuilder<GAccountFieldsData_transfersIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_transfersReceived)]),
          () => new ListBuilder<GAccountFieldsData_transfersReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_wasIdentity)]),
          () => new ListBuilder<GAccountFieldsData_wasIdentity>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_identity_certIssued)]),
          () => new ListBuilder<GAccountFieldsData_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_identity_certReceived)]),
          () => new ListBuilder<GAccountFieldsData_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountFieldsData_identity_linkedAccount)
          ]),
          () => new ListBuilder<GAccountFieldsData_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountFieldsData_identity_membershipHistory)
          ]),
          () =>
              new ListBuilder<GAccountFieldsData_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountFieldsData_identity_ownerKeyChange)
          ]),
          () => new ListBuilder<GAccountFieldsData_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountFieldsData_identity_udHistory)]),
          () => new ListBuilder<GAccountFieldsData_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountFieldsData_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GAccountFieldsData_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountFieldsData_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GAccountFieldsData_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GAccountSelectColumn)]),
          () => new ListBuilder<GAccountSelectColumn>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GAccountsByPkData_account)]),
          () => new ListBuilder<GAccountsByPkData_account>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountsByPkData_account_commentsIssued)]),
          () => new ListBuilder<GAccountsByPkData_account_commentsIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_removedIdentities)
          ]),
          () => new ListBuilder<GAccountsByPkData_account_removedIdentities>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_transfersIssued)
          ]),
          () => new ListBuilder<GAccountsByPkData_account_transfersIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_transfersReceived)
          ]),
          () => new ListBuilder<GAccountsByPkData_account_transfersReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GAccountsByPkData_account_wasIdentity)]),
          () => new ListBuilder<GAccountsByPkData_account_wasIdentity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_identity_certIssued)
          ]),
          () =>
              new ListBuilder<GAccountsByPkData_account_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_identity_certReceived)
          ]),
          () => new ListBuilder<
              GAccountsByPkData_account_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_identity_linkedAccount)
          ]),
          () => new ListBuilder<
              GAccountsByPkData_account_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_identity_membershipHistory)
          ]),
          () => new ListBuilder<
              GAccountsByPkData_account_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_identity_ownerKeyChange)
          ]),
          () => new ListBuilder<
              GAccountsByPkData_account_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GAccountsByPkData_account_identity_udHistory)
          ]),
          () => new ListBuilder<GAccountsByPkData_account_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GAccountsByPkData_account_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GAccountsByPkData_account_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GAccountsByPkData_account_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GAccountsByPkData_account_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GBlockBoolExp)]),
          () => new ListBuilder<GBlockBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GBlockBoolExp)]),
          () => new ListBuilder<GBlockBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCallBoolExp)]),
          () => new ListBuilder<GCallBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCallBoolExp)]),
          () => new ListBuilder<GCallBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCallSelectColumn)]),
          () => new ListBuilder<GCallSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCertBoolExp)]),
          () => new ListBuilder<GCertBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCertBoolExp)]),
          () => new ListBuilder<GCertBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCertEventBoolExp)]),
          () => new ListBuilder<GCertEventBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCertEventBoolExp)]),
          () => new ListBuilder<GCertEventBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GCertEventSelectColumn)]),
          () => new ListBuilder<GCertEventSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCertSelectColumn)]),
          () => new ListBuilder<GCertSelectColumn>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GChangeOwnerKeyBoolExp)]),
          () => new ListBuilder<GChangeOwnerKeyBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GChangeOwnerKeyBoolExp)]),
          () => new ListBuilder<GChangeOwnerKeyBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GChangeOwnerKeySelectColumn)]),
          () => new ListBuilder<GChangeOwnerKeySelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCommentTypeEnum)]),
          () => new ListBuilder<GCommentTypeEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCommentTypeEnum)]),
          () => new ListBuilder<GCommentTypeEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCounterLevelEnum)]),
          () => new ListBuilder<GCounterLevelEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GCounterLevelEnum)]),
          () => new ListBuilder<GCounterLevelEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GEventBoolExp)]),
          () => new ListBuilder<GEventBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GEventBoolExp)]),
          () => new ListBuilder<GEventBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GEventSelectColumn)]),
          () => new ListBuilder<GEventSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GEventTypeEnum)]),
          () => new ListBuilder<GEventTypeEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GEventTypeEnum)]),
          () => new ListBuilder<GEventTypeEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GExtrinsicBoolExp)]),
          () => new ListBuilder<GExtrinsicBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GExtrinsicBoolExp)]),
          () => new ListBuilder<GExtrinsicBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GExtrinsicSelectColumn)]),
          () => new ListBuilder<GExtrinsicSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GGetHistoryAndBalanceData_account)]),
          () => new ListBuilder<GGetHistoryAndBalanceData_account>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_commentsIssued)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_commentsIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_removedIdentities)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_removedIdentities>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_transfersIssued)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_transfersIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_transfersReceived)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_transfersReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_wasIdentity)
          ]),
          () =>
              new ListBuilder<GGetHistoryAndBalanceData_account_wasIdentity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_certIssued)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_certReceived)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_linkedAccount)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_membershipHistory)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_ownerKeyChange)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_identity_udHistory)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentitiesByNameData_identity)]),
          () => new ListBuilder<GIdentitiesByNameData_identity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameData_identity_certIssued)
          ]),
          () => new ListBuilder<GIdentitiesByNameData_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameData_identity_certReceived)
          ]),
          () => new ListBuilder<GIdentitiesByNameData_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameData_identity_linkedAccount)
          ]),
          () => new ListBuilder<GIdentitiesByNameData_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameData_identity_membershipHistory)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameData_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameData_identity_ownerKeyChange)
          ]),
          () =>
              new ListBuilder<GIdentitiesByNameData_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentitiesByNameData_identity_udHistory)]),
          () => new ListBuilder<GIdentitiesByNameData_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameData_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameData_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GIdentitiesByNameData_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameData_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentitiesByNameOrPkData_identity)]),
          () => new ListBuilder<GIdentitiesByNameOrPkData_identity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameOrPkData_identity_certIssued)
          ]),
          () =>
              new ListBuilder<GIdentitiesByNameOrPkData_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameOrPkData_identity_certReceived)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameOrPkData_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameOrPkData_identity_linkedAccount)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameOrPkData_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameOrPkData_identity_membershipHistory)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameOrPkData_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameOrPkData_identity_ownerKeyChange)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameOrPkData_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByNameOrPkData_identity_udHistory)
          ]),
          () => new ListBuilder<GIdentitiesByNameOrPkData_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GIdentitiesByNameOrPkData_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameOrPkData_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                GIdentitiesByNameOrPkData_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GIdentitiesByNameOrPkData_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GIdentitiesByPkData_identity)]),
          () => new ListBuilder<GIdentitiesByPkData_identity>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentitiesByPkData_identity_certIssued)]),
          () => new ListBuilder<GIdentitiesByPkData_identity_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByPkData_identity_certReceived)
          ]),
          () => new ListBuilder<GIdentitiesByPkData_identity_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByPkData_identity_linkedAccount)
          ]),
          () => new ListBuilder<GIdentitiesByPkData_identity_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByPkData_identity_membershipHistory)
          ]),
          () =>
              new ListBuilder<GIdentitiesByPkData_identity_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByPkData_identity_ownerKeyChange)
          ]),
          () => new ListBuilder<GIdentitiesByPkData_identity_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentitiesByPkData_identity_udHistory)]),
          () => new ListBuilder<GIdentitiesByPkData_identity_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByPkData_identity_smith_smithCertIssued)
          ]),
          () => new ListBuilder<
              GIdentitiesByPkData_identity_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentitiesByPkData_identity_smith_smithCertReceived)
          ]),
          () => new ListBuilder<
              GIdentitiesByPkData_identity_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GIdentityBoolExp)]),
          () => new ListBuilder<GIdentityBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GIdentityBoolExp)]),
          () => new ListBuilder<GIdentityBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentityFieldsData_certIssued)]),
          () => new ListBuilder<GIdentityFieldsData_certIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentityFieldsData_certReceived)]),
          () => new ListBuilder<GIdentityFieldsData_certReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentityFieldsData_linkedAccount)]),
          () => new ListBuilder<GIdentityFieldsData_linkedAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentityFieldsData_membershipHistory)]),
          () => new ListBuilder<GIdentityFieldsData_membershipHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GIdentityFieldsData_ownerKeyChange)]),
          () => new ListBuilder<GIdentityFieldsData_ownerKeyChange>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GIdentityFieldsData_udHistory)]),
          () => new ListBuilder<GIdentityFieldsData_udHistory>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentityFieldsData_smith_smithCertIssued)
          ]),
          () => new ListBuilder<GIdentityFieldsData_smith_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GIdentityFieldsData_smith_smithCertReceived)
          ]),
          () => new ListBuilder<GIdentityFieldsData_smith_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GIdentitySelectColumn)]),
          () => new ListBuilder<GIdentitySelectColumn>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GIdentityStatusEnum)]),
          () => new ListBuilder<GIdentityStatusEnum>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GIdentityStatusEnum)]),
          () => new ListBuilder<GIdentityStatusEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GItemTypeEnum)]),
          () => new ListBuilder<GItemTypeEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GItemTypeEnum)]),
          () => new ListBuilder<GItemTypeEnum>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GItemsCounterBoolExp)]),
          () => new ListBuilder<GItemsCounterBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GItemsCounterBoolExp)]),
          () => new ListBuilder<GItemsCounterBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GLastBlockData_block)]),
          () => new ListBuilder<GLastBlockData_block>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GMembershipEventBoolExp)]),
          () => new ListBuilder<GMembershipEventBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GMembershipEventBoolExp)]),
          () => new ListBuilder<GMembershipEventBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GMembershipEventSelectColumn)]),
          () => new ListBuilder<GMembershipEventSelectColumn>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GPopulationHistoryBoolExp)]),
          () => new ListBuilder<GPopulationHistoryBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GPopulationHistoryBoolExp)]),
          () => new ListBuilder<GPopulationHistoryBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithBoolExp)]),
          () => new ListBuilder<GSmithBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithBoolExp)]),
          () => new ListBuilder<GSmithBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithCertBoolExp)]),
          () => new ListBuilder<GSmithCertBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithCertBoolExp)]),
          () => new ListBuilder<GSmithCertBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GSmithCertSelectColumn)]),
          () => new ListBuilder<GSmithCertSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithEventBoolExp)]),
          () => new ListBuilder<GSmithEventBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithEventBoolExp)]),
          () => new ListBuilder<GSmithEventBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GSmithEventSelectColumn)]),
          () => new ListBuilder<GSmithEventSelectColumn>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GSmithEventTypeEnum)]),
          () => new ListBuilder<GSmithEventTypeEnum>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GSmithEventTypeEnum)]),
          () => new ListBuilder<GSmithEventTypeEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GSmithFieldsData_smithCertIssued)]),
          () => new ListBuilder<GSmithFieldsData_smithCertIssued>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GSmithFieldsData_smithCertReceived)]),
          () => new ListBuilder<GSmithFieldsData_smithCertReceived>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithStatusEnum)]),
          () => new ListBuilder<GSmithStatusEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GSmithStatusEnum)]),
          () => new ListBuilder<GSmithStatusEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GTransferBoolExp)]),
          () => new ListBuilder<GTransferBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GTransferBoolExp)]),
          () => new ListBuilder<GTransferBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GTransferSelectColumn)]),
          () => new ListBuilder<GTransferSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GTxCommentBoolExp)]),
          () => new ListBuilder<GTxCommentBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GTxCommentBoolExp)]),
          () => new ListBuilder<GTxCommentBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GTxCommentSelectColumn)]),
          () => new ListBuilder<GTxCommentSelectColumn>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GUdHistoryBoolExp)]),
          () => new ListBuilder<GUdHistoryBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GUdHistoryBoolExp)]),
          () => new ListBuilder<GUdHistoryBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GUdReevalBoolExp)]),
          () => new ListBuilder<GUdReevalBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GUdReevalBoolExp)]),
          () => new ListBuilder<GUdReevalBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GUniversalDividendBoolExp)]),
          () => new ListBuilder<GUniversalDividendBoolExp>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GUniversalDividendBoolExp)]),
          () => new ListBuilder<GUniversalDividendBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GValidatorBoolExp)]),
          () => new ListBuilder<GValidatorBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GValidatorBoolExp)]),
          () => new ListBuilder<GValidatorBoolExp>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gbytea)]),
          () => new ListBuilder<Gbytea>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gbytea)]),
          () => new ListBuilder<Gbytea>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gtimestamptz)]),
          () => new ListBuilder<Gtimestamptz>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Gtimestamptz)]),
          () => new ListBuilder<Gtimestamptz>())
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
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(JsonObject)]),
          () => new ListBuilder<JsonObject>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(JsonObject)]),
          () => new ListBuilder<JsonObject>())
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
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(String)])
          ]),
          () => new ListBuilder<BuiltList<String>>())
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
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(String)])
          ]),
          () => new ListBuilder<BuiltList<String>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(bool)]),
          () => new ListBuilder<bool>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(bool)]),
          () => new ListBuilder<bool>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(int)])
          ]),
          () => new ListBuilder<BuiltList<int>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(int)])
          ]),
          () => new ListBuilder<BuiltList<int>>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
