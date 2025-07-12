import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void registerMockSecureStorage() {
  final Map<String, String?> secureStore = <String, String?>{};
  const MethodChannel channel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall call) async {
    final Map<String, dynamic> args =
        (call.arguments as Map<dynamic, dynamic>?)?.cast<String, dynamic>() ??
            <String, dynamic>{};
    switch (call.method) {
      case 'read':
        return secureStore[args['key']];
      case 'write':
        secureStore[args['key'] as String] = args['value'] as String?;
        return true;
      case 'delete':
        secureStore.remove(args['key']);
        return true;
      case 'readAll':
        return secureStore;
      case 'deleteAll':
        secureStore.clear();
        return true;
      default:
        return null;
    }
  });
}
