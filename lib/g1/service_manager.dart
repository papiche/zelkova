import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/transaction_state.dart';
import 'api.dart';
import 'duniter_endpoint_helper.dart';
import 'duniter_indexer_helper.dart' as duniter_indexer;
import 'pay_result.dart';
import 'transactions_v2_parser.dart';

abstract class DuniterService {
  Future<Contact> getProfile(String pubKey,
      {bool onlyProfile = false,
      bool resize = true,
      bool complete = false,
      Contact? baseContact});

  Future<List<Contact>> getProfiles(List<String> pubKeys);

  Future<List<Contact>> searchWot(String searchPatternRaw);

  Future<List<Contact>> searchProfiles(
      {required String searchTermLower,
      required String searchTerm,
      required String searchTermCapitalized,
      bool quickMode = false});

  Future<Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalance(
      String pubKeyRaw,
      {int? pageSize = 10,
      int? from,
      int? to,
      String? cursor,
      required bool isConnected});

  Future<TransactionState> transactionsParser(
      Map<String, dynamic> txData, TransactionState state, String myPubKeyRaw,
      {String? cursor, double? cachedUd});

  Future<PayResult> pay(
      {required List<String> to, required double amount, String? comment});

  Future<String?> getProfileUserName(String pubKey);

  Future<bool> createOrUpdateProfile(String name);

  Future<bool> deleteProfile();
}

class DuniterServiceV2 implements DuniterService {
  @override
  Future<Contact> getProfile(String pubKey,
      {bool onlyProfile = false,
      bool resize = true,
      bool complete = false,
      Contact? baseContact}) {
    return duniter_indexer.getProfileV2(pubKey,
        onlyProfile: onlyProfile,
        resize: resize,
        complete: complete,
        baseContact: baseContact);
  }

  @override
  Future<List<Contact>> getProfiles(List<String> pubKeys) {
    return duniter_indexer.getProfilesV2(pubKeys: pubKeys);
  }

  @override
  Future<List<Contact>> searchWot(String searchPattern) {
    return duniter_indexer.searchWotV2(searchPattern);
  }

  @override
  Future<List<Contact>> searchProfiles(
      {required String searchTermLower,
      required String searchTerm,
      required String searchTermCapitalized,
      bool quickMode = false}) {
    return searchProfilesV1(
        searchTermLower: searchTermLower,
        searchTerm: searchTerm,
        searchTermCapitalized: searchTermCapitalized,
        quickMode: quickMode);
  }

  @override
  Future<Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalance(
      String pubKeyRaw,
      {int? pageSize = 10,
      int? from,
      int? to,
      String? cursor,
      required bool isConnected}) {
    return duniter_indexer.getHistoryAndBalanceV2(pubKeyRaw,
        pageSize: pageSize,
        from: from,
        to: to,
        cursor: cursor,
        isConnected: isConnected);
  }

  @override
  Future<TransactionState> transactionsParser(
      Map<String, dynamic> txData, TransactionState state, String myPubKeyRaw,
      {String? cursor, double? cachedUd}) {
    return transactionsV2Parser(txData, state, myPubKeyRaw,
        cursor: cursor, cachedUd: cachedUd);
  }

  @override
  Future<PayResult> pay(
      {required List<String> to, required double amount, String? comment}) {
    return payV2(to: to, amount: amount, comment: comment);
  }

  @override
  Future<bool> createOrUpdateProfile(String name) {
    return createOrUpdateProfileV2cPlus(name);
  }

  @override
  Future<bool> deleteProfile() {
    return deleteProfileV2cPlus();
  }

  @override
  Future<String?> getProfileUserName(String pubKey) async {
    final Contact c =
        await duniter_indexer.getProfileV2(pubKey, onlyProfile: true);
    return c.name;
  }
}

class ServiceManager with ChangeNotifier {
  ServiceManager() : _currentService = DuniterServiceV2();
  DuniterService _currentService;
  final DuniterService _v2Service = DuniterServiceV2();

  DuniterService get current => _currentService;

  void updateService(bool useV2) {
    _currentService = _v2Service;
    notifyListeners();
  }
}
