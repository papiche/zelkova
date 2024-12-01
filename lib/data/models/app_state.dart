import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/currency.dart';
import 'is_json_serializable.dart';

part 'app_state.g.dart';

@JsonSerializable()
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
      Map<String, bool>? tutorials})
      : tutorials = tutorials ?? <String, bool>{},
        currency = currency ?? Currency.G1,
        walletCreatedViewed = walletCreatedViewed ?? introViewed,
        currentUd = currentUd ?? 11.06; // as 01/12/2024

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  final bool introViewed;
  final bool walletCreatedViewed;
  final bool warningViewed;
  final bool warningBrowserViewed;
  final bool expertMode;
  final bool v2mode;
  final Currency currency;
  final double currentUd;
  final Map<String, bool> tutorials;

  AppState copyWith(
      {bool? introViewed,
      bool? warningViewed,
      bool? warningBrowserViewed,
      bool? expertMode,
      Currency? currency,
      double? currentUd,
      bool? walletCreatedViewed,
      bool? v2mode,
      Map<String, bool>? tutorials}) {
    return AppState(
        introViewed: introViewed ?? this.introViewed,
        warningViewed: warningViewed ?? this.warningViewed,
        warningBrowserViewed: warningBrowserViewed ?? this.warningBrowserViewed,
        expertMode: expertMode ?? this.expertMode,
        currency: currency ?? this.currency,
        walletCreatedViewed: walletCreatedViewed ?? this.walletCreatedViewed,
        v2mode: v2mode ?? this.v2mode,
        currentUd: currentUd ?? this.currentUd,
        tutorials: tutorials ?? this.tutorials);
  }

  @override
  AppState fromJson(Map<String, dynamic> json) => AppState.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object?> get props => <Object>[
        introViewed,
        warningViewed,
        expertMode,
        warningBrowserViewed,
        walletCreatedViewed,
        tutorials,
        currency,
        currentUd,
        v2mode
      ];
}
