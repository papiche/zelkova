enum TransactionType { sending, received, receiving, sent, pending }

bool isProcessing(TransactionType type) {
  return type == TransactionType.sending ||
      type == TransactionType.receiving ||
      type == TransactionType.pending;
}
