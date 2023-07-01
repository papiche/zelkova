import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/g1_helper.dart';
import 'contact.dart';

part 'payment_state.g.dart';

enum PaymentStatus { notSent, sending, isSent }

@JsonSerializable()
class PaymentState extends Equatable {
  const PaymentState({
    this.contact,
    this.comment = '',
    this.amount,
    this.status = PaymentStatus.notSent,
  });

  factory PaymentState.fromJson(Map<String, dynamic> json) =>
      _$PaymentStateFromJson(json);

  bool canBeSent() =>
      status == PaymentStatus.notSent &&
      (contact != null && validateKey(contact!.pubKey)) &&
      amount != null &&
      amount! > 0;

  final Contact? contact;
  final String comment;
  final double? amount;
  final PaymentStatus status;

  Map<String, dynamic> toJson() => _$PaymentStateToJson(this);

  PaymentState copyWith({
    Contact? contact,
    String? comment,
    double? amount,
    PaymentStatus? status,
  }) {
    return PaymentState(
      contact: contact ?? this.contact,
      comment: comment ?? this.comment,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  static PaymentState emptyPayment = const PaymentState();

  @override
  String toString() {
    return 'pubKey: $contact.pubKey amount: ${amount ?? ""} status: $status';
  }

  @override
  List<Object?> get props => <dynamic>[contact, comment, amount, status];
}
