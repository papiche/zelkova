import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/g1_helper.dart';
import '../../ui/logger.dart';
import 'contact.dart';

part 'payment_state.g.dart';

enum PaymentStatus { notSent, sending, isSent }

@CopyWith()
@JsonSerializable()
class PaymentState extends Equatable {
  const PaymentState({
    List<Contact>? contacts,
    this.comment = '',
    this.amount,
    this.status = PaymentStatus.notSent,
  }) : contacts = contacts ?? const <Contact>[];

  factory PaymentState.fromJson(Map<String, dynamic> json) =>
      _$PaymentStateFromJson(json);

  bool canBeSent() {
    if (status != PaymentStatus.notSent) {
      logger('Payment status is not "notSent"');
      return false;
    }
    if (contacts.isEmpty || !validateKeys(contacts)) {
      logger('Contacts are empty or keys are not valid');
      return false;
    }
    if (amount == null || amount! <= 0) {
      logger('Amount is null or less than or equal to 0');
      return false;
    }
    return true;
  }

  final List<Contact> contacts;
  final String comment;
  final double? amount;
  final PaymentStatus status;

  Map<String, dynamic> toJson() => _$PaymentStateToJson(this);

  static PaymentState emptyPayment = const PaymentState();

  @override
  String toString() {
    return 'contacts: $contacts amount: ${amount ?? ""} status: $status';
  }

  @override
  List<Object?> get props => <dynamic>[contacts, comment, amount, status];

  bool isMultiple() => contacts.length > 1;
}
