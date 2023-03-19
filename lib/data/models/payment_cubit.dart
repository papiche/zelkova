import 'dart:typed_data';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'payment_state.dart';

class PaymentCubit extends HydratedCubit<PaymentState> {
  PaymentCubit() : super(PaymentState.emptyPayment);

  void updatePayment({
    String? description,
    double? amount,
    bool? isSent,
  }) {
    final PaymentState newState = state.copyWith(
      description: description,
      amount: amount,
      isSent: isSent,
    );
    emit(newState);
  }

  void selectUser(String publicKey, String? nick, Uint8List? avatar,
      [double? amount]) {
    final PaymentState newState = PaymentState(
        publicKey: publicKey, nick: nick, avatar: avatar, amount: amount);
    emit(newState);
  }

  void selectKeyAmount(String publicKey, double amount) {
    final PaymentState newState =
        PaymentState(publicKey: publicKey, amount: amount);
    emit(newState);
  }

  void selectKey(String publicKey) {
    final PaymentState newState = PaymentState(
        publicKey: publicKey, amount: state.amount, comment: state.comment);
    emit(newState);
  }

  @override
  PaymentState? fromJson(Map<String, dynamic> json) =>
      PaymentState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PaymentState state) => state.toJson();

  void clearRecipient() {
    emit(PaymentState.emptyPayment);
  }

  void selectAmount(double amount) {
    emit(state.copyWith(amount: amount));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }
}
