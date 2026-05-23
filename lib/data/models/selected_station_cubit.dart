import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Persists the UPassport station selected by the user.
/// Stored as {url, name} — empty url means "use default from Env".
class SelectedStationCubit extends HydratedCubit<SelectedStationState> {
  SelectedStationCubit() : super(const SelectedStationState());

  @override
  String get storagePrefix => 'SelectedStationCubit';

  void select(String url, String name) {
    emit(SelectedStationState(url: url, name: name));
  }

  void clearSelection() {
    emit(const SelectedStationState());
  }

  @override
  SelectedStationState? fromJson(Map<String, dynamic> json) =>
      SelectedStationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SelectedStationState state) => state.toJson();
}

class SelectedStationState {
  const SelectedStationState({this.url, this.name});

  factory SelectedStationState.fromJson(Map<String, dynamic> json) =>
      SelectedStationState(
        url: json['url'] as String?,
        name: json['name'] as String?,
      );

  final String? url;
  final String? name;

  bool get hasSelection => url != null && url!.isNotEmpty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'name': name,
      };
}
