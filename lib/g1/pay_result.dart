import '../data/models/node.dart';

class PayResult {
  PayResult({
    required this.message,
    this.node,
    this.progressStream,
  });

  final Node? node;
  final String message;
  final Stream<String>? progressStream;
}
