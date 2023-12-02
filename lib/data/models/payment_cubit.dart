import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../ui/ui_helpers.dart';
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

  void selectUser(Contact contact) {
    emit(state.copyWith(contacts: <Contact>[contact]));
  }

  void selectUsers(List<Contact> contacts) {
    emit(state.copyWith(contacts: contacts));
  }

  void selectKeyAmount(Contact contact, double? amount) {
    final PaymentState newState =
        PaymentState(contacts: <Contact>[contact], amount: amount);
    emit(newState);
  }

  void clearRecipient() {
    final PaymentState newState =
        PaymentState(comment: state.comment, amount: state.amount);
    emit(newState);
  }

  void pendingPayment() {
    emit(PaymentState.emptyPayment);
  }

  void sent() {
    emit(PaymentState.emptyPayment.copyWith(status: PaymentStatus.isSent));
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

  void selectKey(Contact contact) {
    final PaymentState newState = PaymentState(
        contacts: List<Contact>.from(state.contacts)..add(contact),
        amount: state.amount,
        comment: state.comment);
    emit(newState);
  }

  @override
  PaymentState? fromJson(Map<String, dynamic> json) =>
      PaymentState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PaymentState state) => state.toJson();

  void selectAmount(double? amount) {
    // As copyWith ignores null amounts
    final PaymentState newState = PaymentState(
        contacts: state.contacts, comment: state.comment, amount: amount);
    emit(newState);
  }

  void setComment(String comment) {
    // As copyWith ignores null amounts
    final PaymentState newState = PaymentState(
        contacts: state.contacts, amount: state.amount, comment: comment);
    emit(newState);
  }

  void reset() {
    if (inDevelopment) {
      emit(PaymentState.emptyPayment.copyWith(contacts: state.contacts));
    } else {
      emit(PaymentState.emptyPayment);
    }
  }
}
