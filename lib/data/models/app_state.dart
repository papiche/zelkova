import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/currency.dart';
import '../../g1/distance_precompute.dart';
import 'contact_wot_info.dart';
import 'is_json_serializable.dart';

part 'app_state.g.dart';

@JsonSerializable()
@CopyWith()
class AppState extends Equatable implements IsJsonSerializable<AppState> {
  AppState(
      {this.introViewed = false,
      this.warningViewed = false,
      this.warningBrowserViewed = false,
      this.expertMode = false,
      bool? walletCreatedViewed,
      this.v2mode = false,
      Currency? currency,
      double? currentUd,
      this.currentUdLastUpdate,
      Map<String, bool>? tutorials,
      bool? hasRecentExport,
      int? recentExportReminderInDays,
      this.distancePrecompute,
      this.wotInfo})
      : tutorials = tutorials ?? <String, bool>{},
        currency = currency ?? Currency.G1,
        walletCreatedViewed = walletCreatedViewed ?? introViewed,
        currentUd = currentUd ?? 11.06,
        hasRecentExport = hasRecentExport ?? false,
        recentExportReminderInDays = recentExportReminderInDays ?? 7;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  final bool introViewed;
  final bool hasRecentExport;
  final int recentExportReminderInDays;
  final bool walletCreatedViewed;
  final bool warningViewed;
  final bool warningBrowserViewed;
  final bool expertMode;
  final bool v2mode;
  final Currency currency;
  final double currentUd;
  @JsonKey(includeIfNull: false)
  final DateTime? currentUdLastUpdate;
  final Map<String, bool> tutorials;
  @JsonKey(includeIfNull: false)
  final DistancePrecompute? distancePrecompute;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final ContactWotInfo? wotInfo;

  @override
  AppState fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object?> get props => <Object?>[
        introViewed,
        warningViewed,
        expertMode,
        warningBrowserViewed,
        walletCreatedViewed,
        tutorials,
        currency,
        currentUd,
        currentUdLastUpdate,
        v2mode,
        distancePrecompute,
        recentExportReminderInDays,
        hasRecentExport,
        wotInfo
      ];
}
