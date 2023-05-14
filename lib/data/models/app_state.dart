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
      Currency? currency,
      double? currentUd,
      Map<String, bool>? tutorials})
      : tutorials = tutorials ?? <String, bool>{},
        currency = currency ?? Currency.G1,
        currentUd = currentUd ?? 10.68; // as 14/05/2023

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  final bool introViewed;
  final bool warningViewed;
  final bool warningBrowserViewed;
  final bool expertMode;
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
      Map<String, bool>? tutorials}) {
    return AppState(
        introViewed: introViewed ?? this.introViewed,
        warningViewed: warningViewed ?? this.warningViewed,
        warningBrowserViewed: warningBrowserViewed ?? this.warningBrowserViewed,
        expertMode: expertMode ?? this.expertMode,
        currency: currency ?? this.currency,
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
        tutorials,
        currency,
        currentUd
      ];
}
