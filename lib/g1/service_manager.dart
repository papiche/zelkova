import 'package:flutter/foundation.dart';

import '../data/models/contact.dart';
import 'api.dart';
import 'datapod_api.dart';

abstract class ProfileService {
  Future<Contact> getProfile(String pubKey,
      {bool onlyCPlusProfile = false, bool resize = true});

  Future<List<Contact>> getProfiles(List<String> pubKeys);

  Future<List<Contact>> searchWot(String searchPatternRaw);

  Future<List<Contact>> searchProfiles(
      {required String searchTermLower,
      required String searchTerm,
      required String searchTermCapitalized});
}

class ProfileServiceV1 implements ProfileService {
  @override
  Future<Contact> getProfile(String pubKey,
      {bool onlyCPlusProfile = false, bool resize = true}) {
    return getProfileV1(pubKey,
        onlyCPlusProfile: onlyCPlusProfile, resize: resize);
  }

  @override
  Future<List<Contact>> searchWot(String searchPatternRaw) {
    return searchWotV1(searchPatternRaw);
  }

  @override
  Future<List<Contact>> searchProfiles(
      {required String searchTermLower,
      required String searchTerm,
      required String searchTermCapitalized}) {
    return searchProfilesV1(
        searchTermLower: searchTermLower,
        searchTerm: searchTerm,
        searchTermCapitalized: searchTermCapitalized);
  }

  @override
  Future<List<Contact>> getProfiles(List<String> pubKeys) {
    throw UnimplementedError();
  }
}

class ProfileServiceV2 implements ProfileService {
  @override
  Future<Contact> getProfile(String pubKey,
      {bool onlyCPlusProfile = false, bool resize = true}) {
    return getProfileV2(pubKey, onlyCPlusProfile: onlyCPlusProfile);
  }

  @override
  Future<List<Contact>> getProfiles(List<String> pubKeys) {
    return getProfilesV2(pubKeys: pubKeys);
  }

  @override
  Future<List<Contact>> searchWot(String searchPattern) {
    return searchWotV2('.*$searchPattern.*');
  }

  @override
  Future<List<Contact>> searchProfiles(
      {required String searchTermLower,
      required String searchTerm,
      required String searchTermCapitalized}) {
    return searchProfilesV2(
        searchTermLower: searchTermLower,
        searchTerm: searchTerm,
        searchTermCapitalized: searchTermCapitalized);
  }
}

class ServiceManager with ChangeNotifier {
  ServiceManager({required bool initialIsV2})
      : _currentService = initialIsV2 ? ProfileServiceV2() : ProfileServiceV1();
  ProfileService _currentService;
  final ProfileService _v1Service = ProfileServiceV1();
  final ProfileService _v2Service = ProfileServiceV2();

  ProfileService get profileService => _currentService;

  void updateService(bool useV2) {
    _currentService = useV2 ? _v2Service : _v1Service;
    notifyListeners();
  }
}
