import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../ui/logger.dart';

class PolkaDotProvider {
  PolkaDotProvider(this.url, {this.timeout = const Duration(seconds: 10)});

  final Uri url;
  final Duration timeout;

  WebSocketChannel? channel;
  int _sequence = 0;

  final Map<int, Completer<Map<String, dynamic>>> _queries =
      <int, Completer<Map<String, dynamic>>>{};
  final Map<String, StreamController<Map<String, dynamic>>> _subscriptions =
      <String, StreamController<Map<String, dynamic>>>{};

  Future<void> connect() async {
    if (channel != null) {
      throw Exception('Already connected');
    }

    try {
      loggerDev('Connecting to $url');
      channel = WebSocketChannel.connect(url);

      await Future.any(<Future<void>>[
        channel!.ready,
        Future<void>.delayed(timeout, () {
          throw TimeoutException(
              'Connection timed out after ${timeout.inSeconds} seconds');
        })
      ]);

      loggerDev('Connected to stream $url');
      channel!.stream.timeout(timeout).listen(_onMessage, onDone: disconnect);
      loggerDev('End of connect $url');
    } catch (ex) {
      loggerDev('WS connection failed to $url: $ex');

      // await disconnect();
      throw Exception('Failed to connect to $url');
    }
  }

  Future<void> disconnect() async {
    if (channel == null) {
      throw Exception('Already disconnected');
    }
    await channel!.sink.close(status.normalClosure);
    channel = null;
    _queries.clear();
    for (final StreamController<Map<String, dynamic>> controller
        in _subscriptions.values) {
      await controller.close();
    }
    _subscriptions.clear();
  }

  Future<Map<String, dynamic>> send(String method, String params) async {
    if (channel == null) {
      throw Exception('WebSocket is not connected');
    }
    final int id = ++_sequence;
    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
    _queries[id] = completer;

    channel!.sink.add(jsonEncode(<String, Object>{
      'id': id,
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
    }));

    return completer.future;
  }

  Future<Stream<Map<String, dynamic>>> subscribe(
      String method, String params) async {
    final Map<String, dynamic> response = await send(method, params);
    final String subscriptionId = response['result'] as String;

    final StreamController<Map<String, dynamic>> controller =
        StreamController<Map<String, dynamic>>.broadcast();
    _subscriptions[subscriptionId] = controller;

    return controller.stream;
  }

  void _onMessage(dynamic message) {
    final Map<String, dynamic> jsonMessage =
        jsonDecode(message as String) as Map<String, dynamic>;
    if (jsonMessage.containsKey('id')) {
      final int id = jsonMessage['id'] as int;
      _queries.remove(id)?.complete(jsonMessage);
    } else if (jsonMessage.containsKey('params')) {
      final Map<String, dynamic> params =
          jsonMessage['params'] as Map<String, dynamic>;
      final String subscriptionId = params['subscription'] as String;
      _subscriptions[subscriptionId]?.add(params);
    }
  }
}
