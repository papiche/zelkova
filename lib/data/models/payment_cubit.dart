import 'dart:typed_data';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'payment_state.dart';

class PaymentCubit extends HydratedCubit<PaymentState> {
  PaymentCubit() : super(PaymentState.emptyPayment);

  void updatePayment({
    String? description,
    double? amount,
    PaymentStatus? status,
  }) {
    final PaymentState newState = state.copyWith(
      comment: description,
      amount: amount,
      status: status,
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

  void sent() {
    emit(state.copyWith(status: PaymentStatus.isSent));
  }

  void sentFailed() {
    emit(state.copyWith(status: PaymentStatus.notSent));
  }

  void sending() {
    emit(state.copyWith(status: PaymentStatus.sending));
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

  void selectAmount(double? amount) {
    // As ignores null amounts
    final PaymentState newState = PaymentState(
        publicKey: state.publicKey,
        nick: state.nick,
        avatar: state.avatar,
        amount: amount);
    emit(newState);
  }

  void setComment(String comment) {
    emit(state.copyWith(comment: comment));
  }
}
