import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'contact.dart';
import 'payment_state.dart';

class PaymentCubit extends HydratedCubit<PaymentState> {
  PaymentCubit() : super(PaymentState.emptyPayment);

  @override
  String get storagePrefix => kIsWeb ? 'PaymentCubit' : super.storagePrefix;

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

  void selectUser(Contact contact, [double? amount]) {
    final PaymentState newState =
        PaymentState(contact: contact, amount: amount);
    emit(newState);
  }

  void selectKeyAmount(Contact contact, double amount) {
    final PaymentState newState =
        PaymentState(contact: contact, amount: amount);
    emit(newState);
  }

  void sent() {
    emit(state.copyWith(status: PaymentStatus.isSent));
  }

  void notSent() {
    emit(state.copyWith(status: PaymentStatus.notSent));
  }

  void sentFailed() {
    emit(state.copyWith(status: PaymentStatus.notSent));
  }

  void sending() {
    emit(state.copyWith(status: PaymentStatus.sending));
  }

  void selectKey(Contact? contact) {
    final PaymentState newState = PaymentState(
        contact: contact, amount: state.amount, comment: state.comment);
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
    // As copyWith ignores null amounts
    final PaymentState newState = PaymentState(
        contact: state.contact, comment: state.comment, amount: amount);
    emit(newState);
  }

  void setComment(String comment) {
    // As copyWith ignores null amounts
    final PaymentState newState = PaymentState(
        contact: state.contact, amount: state.amount, comment: comment);
    emit(newState);
  }
}
