import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import './node.dart';
import '../main.dart';
import 'api.dart';
import 'g1_helper.dart';

class NodeBloc extends HydratedBloc<NodeEvent, NodeState> {
  factory NodeBloc() {
    return _singleton;
  }

  NodeBloc._internal()
      : super(NodeState(
            nodes: defaultDuniterNodes,
            cPlusNodes: defaultCesiumPlusNodes,
            status: NodeStatus.loading)) {
    // Init NodeBloc here
    on<LoadNodes>((LoadNodes event, Emitter<NodeState> emit) async {
      final List<Node> nodes = await fetchNodesFromApi();
      emit(NodeState(
          nodes: nodes,
          cPlusNodes: defaultCesiumPlusNodes,
          status: NodeStatus.loaded));
    });
    on<AddNode>((AddNode event, Emitter<NodeState> emit) async {});
    on<InsertNode>((InsertNode event, Emitter<NodeState> emit) async {});
    on<SetNodes>((SetNodes event, Emitter<NodeState> emit) async {});
    on<AddCPlusNode>((AddCPlusNode event, Emitter<NodeState> emit) async {});
    on<AddCPlusNodes>((AddCPlusNodes event, Emitter<NodeState> emit) async {});
  }

  static final NodeBloc _singleton = NodeBloc._internal();

  List<Node> get nodeList => state.nodes;

  List<Node> get cPlusNodeList => state.cPlusNodes;

  Stream<NodeState> mapEventToState(NodeEvent event) async* {
    if (event is LoadNodes) {
      final List<Node> nodes = List<Node>.of(state.nodes)..addAll(event.nodes);
      yield state.copyWith(nodes: nodes);
    } else if (event is SetNodes) {
      // final List<Node> nodes = List<Node>.of(state.nodes)..addAll(event.nodes);
      yield state.copyWith(nodes: event.nodes);
    } else if (event is AddNode) {
      final List<Node> nodes = List<Node>.of(state.nodes)..add(event.node);
      yield state.copyWith(nodes: nodes);
    } else if (event is InsertNode) {
      final List<Node> nodes = List<Node>.of(state.nodes)
        ..insert(0, event.node);
      yield state.copyWith(nodes: nodes);
    } else if (event is AddCPlusNodes) {
      final List<Node> nodes = List<Node>.of(state.cPlusNodes)
        ..addAll(event.nodes);
      yield state.copyWith(cPlusNodes: nodes);
    } else if (event is AddCPlusNode) {
      final List<Node> nodes = List<Node>.of(state.cPlusNodes)..add(event.node);
      yield state.copyWith(cPlusNodes: nodes);
    }
  }

  @override
  NodeState? fromJson(Map<String, dynamic> json) {
    final List<Node> nodes = (json['nodes'] as List<Node>)
        .map((dynamic nodeJson) =>
            Node.fromJson(nodeJson as Map<String, dynamic>))
        .toList();
    final List<Node> cPlusNodes = (json['cPlusNodes'] as List<Node>)
        .map((dynamic nodeJson) =>
            Node.fromJson(nodeJson as Map<String, dynamic>))
        .toList();
    logger(
        'Loaded with ${nodes.length} duniter nodes and ${cPlusNodes.length} c+ nodes');
    return NodeState(
        nodes: nodes, cPlusNodes: cPlusNodes, status: NodeStatus.loaded);
  }

  @override
  Map<String, dynamic>? toJson(NodeState state) {
    return <String, dynamic>{
      'nodes': state.nodes.map((Node node) => node.toJson()).toList(),
    };
  }

  Future<void> loadNodes() async {
    final List<Node> nodes = await fetchNodesFromApi();
    add(SetNodes(nodes));
  }

  Future<List<Node>> fetchNodesFromApi() async {
    final List<Node> nodes = <Node>[];
    // To compare with somthing...
    String fastestNode = 'https://g1.duniter.org';
    late Duration fastestLatency = const Duration(minutes: 1);
    try {
      final Response response = await getPeers();
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
        for (final dynamic peerR in peers) {
          final Map<String, dynamic> peer = peerR as Map<String, dynamic>;
          if (peer['endpoints'] != null) {
            final List<String> endpoints =
                List<String>.from(peer['endpoints'] as List<dynamic>);
            for (int j = 0; j < endpoints.length; j++) {
              if (endpoints[j].startsWith('BMAS')) {
                final String endpointUnParsed = endpoints[j];
                final String endpoint = parseHost(endpointUnParsed);
                final Duration latency = await _pingNode(endpoint);
                if (fastestNode == null || latency < fastestLatency) {
                  fastestNode = endpoint;
                  fastestLatency = latency;
                  if (!kReleaseMode) {
                    logger('Node bloc: Current faster node $fastestNode');
                  }
                }
                final Node node =
                    Node(url: endpoint, latency: latency.inSeconds);
                add(InsertNode(node: node));
                nodes.insert(0, node);
              }
            }
          }
        }
      }
      logger('Node bloc: Loaded ${nodes.length} duniter nodes');
    } catch (e) {
      logger('Error: $e');
      rethrow;
    }
    nodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
    logger('First node in list ${nodes.first.url}');
    return nodes;
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
      return const Duration(days: 20);
    }
  }

  Future<http.Response> requestWithRetry(String path) async {
    return _requestWithRetry(nodeList, path);
  }

  Future<http.Response> requestCPlusWithRetry(String path) async {
    return _requestWithRetry(cPlusNodeList, path);
  }

  Future<http.Response> _requestWithRetry(List<Node> nodes, String path) async {
    for (int i = 0; i < nodes.length; i++) {
      final Node node = nodes[i];
      if (node.errors >= 3) {
        // Too much errors skip
        continue;
      }
      final Uri url = Uri.parse('${node.url}$path');
      logger('Trying $url');
      try {
        final int startTime = DateTime.now().millisecondsSinceEpoch;
        final Response response = await http.get(url);
        final int endTime = DateTime.now().millisecondsSinceEpoch;
        final int newLatency = endTime - startTime;
        if (response.statusCode == 200) {
          final Node newNode = node.copyWith(latency: newLatency, errors: 0);
          nodes[i] = newNode;
          return response;
        }
      } catch (e) {
        final int newErrors = node.errors + 1;
        final Node newNode = node.copyWith(errors: newErrors);
        nodes[i] = newNode;
        continue;
      }
    }
    throw Exception(
        'Cannot make the request to any of the ${nodes.length} nodes');
  }
}
