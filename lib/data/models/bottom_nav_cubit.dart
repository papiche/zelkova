import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BottomNavCubit extends HydratedCubit<int> {
  BottomNavCubit() : super(0);

  @override
  String get storagePrefix => kIsWeb ? 'BottomNavCubit' : super.storagePrefix;

  void updateIndex(int index) => emit(index);

  int get currentIndex => state;

  void getFirstScreen() => emit(0);

  void getSecondScreen() => emit(1);

  void getTrdScreen() => emit(2);

  void getFrdScreen() => emit(3);

  void getFifthScreen() => emit(4);

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['pageIndex'] as int?;
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return <String, int>{'pageIndex': state};
  }
}
