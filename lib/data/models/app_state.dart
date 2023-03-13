import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'isJsonSerializable.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState extends Equatable implements IsJsonSerializable<AppState> {
  const AppState({
    this.introViewed = false,
    this.warningViewed = false,
  });

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  final bool introViewed;
  final bool warningViewed;

  AppState copyWith({
    bool? introViewed,
    bool? warningViewed,
    DateTime? lastFetchTime,
  }) {
    return AppState(
      introViewed: introViewed ?? this.introViewed,
      warningViewed: warningViewed ?? this.warningViewed,
    );
  }

  @override
  AppState fromJson(Map<String, dynamic> json) => AppState.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object?> get props => <Object>[introViewed, warningViewed];
}
