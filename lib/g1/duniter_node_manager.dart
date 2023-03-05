import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../main.dart';

class DuniterNodeManager {
  DuniterNodeManager() {
    _loadNodes();
    _startResetErrorsTimer();
  }

  final String _peerListUrl = 'https://nodes.duniter.org/network/peers';
  List<String> _nodes = <String>[];
  int _currentNodeIndex = 0;
  final int _retryCount = 3;
  Map<String, int> _nodeErrors = <String, int>{};
  Timer? _resetErrorsTimer;
  String? _fastestNode;
  late Duration? _fastestLatency;

  Future<dynamic> makeRequest(String endpoint) async {
    Response response;
    for (int i = 0; i < _nodes.length; i++) {
      final String currentNode = _nodes[_currentNodeIndex];
      try {
        response = await http.get(Uri.parse('$currentNode$endpoint'));
        if (response.statusCode == 200) {
          _resetNodeErrors(currentNode);
          return jsonDecode(response.body);
        }
      } catch (e) {
        _incrementNodeErrors(currentNode);
        logger('Error: $e');
      }

      _rotateNodes();
    }

    throw Exception('No nodes available');
  }

  Future<void> _loadNodes() async {
    try {
      final Response response = await http.get(Uri.parse(_peerListUrl));
      if (response.statusCode == 200) {
        final List<dynamic> peerList =
            jsonDecode(response.body) as List<dynamic>;
        _nodes = peerList
            .where((dynamic peer) =>
                (peer as Map<String, dynamic>)['currency'] == 'g1')
            .map((dynamic peer) =>
                'http://${(peer as Map<String, dynamic>)['host']}:${peer['port']}/')
            .toList();
        _resetNodeErrors(null);
      }
    } catch (e) {
      logger('Error: $e');
    }
  }

  void _rotateNodes() {
    _currentNodeIndex = (_currentNodeIndex + 1) % _nodes.length;
  }

  void _incrementNodeErrors(String nodeUrl) {
    _nodeErrors[nodeUrl] = (_nodeErrors[nodeUrl] ?? 0) + 1;
  }

  void _resetNodeErrors(String? nodeUrl) {
    if (nodeUrl == null) {
      _nodeErrors = <String, int>{for (String v in _nodes) v[0]: 0};
    } else {
      _nodeErrors[nodeUrl] = 0;
    }
  }

  void _startResetErrorsTimer() {
    _resetErrorsTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _resetNodeErrors(null);
    });
  }

  void _cancelResetErrorsTimer() {
    _resetErrorsTimer?.cancel();
  }

  bool _hasNodeExceededRetryLimit(String nodeUrl) {
    return _nodeErrors[nodeUrl] != null && _nodeErrors[nodeUrl]! >= _retryCount;
  }

  Future<void> dispose() async {
    _cancelResetErrorsTimer();
  }

  Future<String?> getFastestNode() async {
    for (final String node in _nodes) {
      final Duration latency = await pingNode(node);

      if (_fastestNode == null || latency < _fastestLatency!) {
        _fastestNode = node;
        _fastestLatency = latency;
      }
    }
    return _fastestNode;
  }

  Future<Duration> pingNode(String node) async {
    try {
      final Stopwatch stopwatch = Stopwatch()..start();
      await http.get(Uri.parse('$node/network/peers/self/ping'));
      stopwatch.stop();
      return stopwatch.elapsed;
    } catch (e) {
      // Handle exception when node is unavailable
      return const Duration(days: 20);
    }
  }
}
