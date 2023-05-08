enum TransactionType { sending, received, receiving, sent, pending, missing }

bool isProcessing(TransactionType type) =>
    type == TransactionType.sending ||
    type == TransactionType.receiving ||
    type == TransactionType.pending;

bool isPending(TransactionType type) =>
    type == TransactionType.pending || type == TransactionType.missing;
