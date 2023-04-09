import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState extends Equatable implements IsJsonSerializable<AppState> {
  const AppState({
    this.introViewed = false,
    this.warningViewed = false,
    this.warningBrowserViewed = false,
    this.expertMode = false,
  });

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  final bool introViewed;
  final bool warningViewed;
  final bool warningBrowserViewed;
  final bool expertMode;

  AppState copyWith({
    bool? introViewed,
    bool? warningViewed,
    bool? warningBrowserViewed,
    bool? expertMode,
    String? locale,
  }) {
    return AppState(
        introViewed: introViewed ?? this.introViewed,
        warningViewed: warningViewed ?? this.warningViewed,
        warningBrowserViewed: warningBrowserViewed ?? this.warningBrowserViewed,
        expertMode: expertMode ?? this.expertMode);
  }

  @override
  AppState fromJson(Map<String, dynamic> json) => AppState.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object?> get props =>
      <Object>[introViewed, warningViewed, expertMode, warningBrowserViewed];
}
