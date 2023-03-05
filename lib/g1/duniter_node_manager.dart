import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../main.dart';

class DuniterNodeManager {
  factory DuniterNodeManager() {
    return _instance;
  }

  DuniterNodeManager._internal() {
    _startResetErrorsTimer();
  }

  void init() {
    loadNodes();
  }

  String get fastestNode {
    return _fastestNode!;
  }

  static final DuniterNodeManager _instance = DuniterNodeManager._internal();

  final String _peerListUrl = 'https://g1.duniter.org/network/peers';
  final List<String> _nodes = <String>[];
  int _currentNodeIndex = 0;
  final int _retryCount = 3;
  Map<String, int> _nodeErrors = <String, int>{};
  Timer? _resetErrorsTimer;
  String _fastestNode = 'https://g1.duniter.org';
  late Duration _fastestLatency = const Duration(minutes: 1);

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

  Future<void> loadNodes() async {
    try {
      final Response response = await http.get(Uri.parse(_peerListUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> peerList =
            jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> peers = (peerList['peers'] as List<dynamic>)
            .where((dynamic peer) =>
                (peer as Map<String, dynamic>)['currency'] == 'g1')
            .where((dynamic peer) =>
                (peer as Map<String, dynamic>)['version'] == 10)
            .where((dynamic peer) =>
                (peer as Map<String, dynamic>)['status'] == 'UP')
            .toList();
        for (final dynamic peer in peers) {
          if (peer['endpoints'] != null) {
            final List<String> endpoints =
                List<String>.from(peer['endpoints'] as List<dynamic>);
            for (int j = 0; j < endpoints.length; j++) {
              if (endpoints[j].startsWith('BMAS')) {
                String endpoint = endpoints[j].replaceAll('BMAS ', '');
                if (endpoint.contains(' ')) {
                  endpoint = endpoint.substring(0, endpoint.indexOf(' '));
                }
                endpoint = 'https://${endpoint.replaceAll(':443', '')}';
                _nodes.add(endpoint);
                final Duration latency = await _pingNode(endpoint);
                if (_fastestNode == null || latency < _fastestLatency!) {
                  _fastestNode = endpoint;
                  _fastestLatency = latency;
                  if (!kReleaseMode) {
                    logger('Current faster node $_fastestNode');
                  }
                }
              }
            }
          }
        }
        _resetNodeErrors(null);
      }
      logger('Loaded ${_nodes.length} duniter nodes');
    } catch (e) {
      logger('Error: $e');
      rethrow;
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

  Future<Duration> _pingNode(String node) async {
    try {
      final Stopwatch stopwatch = Stopwatch()..start();
      await http.get(Uri.parse('$node/network/peers/self/ping'));
      stopwatch.stop();
      return stopwatch.elapsed;
    } catch (e) {
      // Handle exception when node is unavailable etc
      logger('Node $node does not respond to ping $e');
      _incrementNodeErrors(node);
      return const Duration(days: 20);
    }
  }
}
