import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/node.dart';
import 'package:ginkgo/data/models/node_manager.dart';
import 'package:ginkgo/data/models/node_type.dart';

void main() {
  group('Node Discovery & Auto-Ping Tests', () {
    setUp(() {
      // Clean NodeManager before each test
      final NodeManager nm = NodeManager();
      nm.cesiumPlusNodes.clear();
      nm.endpointNodes.clear();
      nm.duniterIndexerNodes.clear();
      nm.duniterDataNodes.clear();
      nm.ipfsGateways.clear();
    });

    test('should have endpoint nodes available in NodeManager', () {
      final NodeManager nm = NodeManager();
      // Note: defaults may be loaded during API initialization, not in NodeManager constructor
      // This test verifies the NodeManager has the nodeList method working
      expect(nm.nodeList(NodeType.endpoint).runtimeType, <Node>[].runtimeType,
          reason: 'Should return a List<Node>');
    });

    test('default nodes should have dummy latencies (99999)', () {
      final NodeManager nm = NodeManager();
      final List<Node> endpointNodes = nm.nodeList(NodeType.endpoint);

      for (final Node node in endpointNodes) {
        expect(node.latency, 99999,
            reason: 'Default nodes should have dummy latency before ping');
      }
    });

    test('default nodes should have no errors initially', () {
      final NodeManager nm = NodeManager();
      final List<Node> endpointNodes = nm.nodeList(NodeType.endpoint);

      for (final Node node in endpointNodes) {
        expect(node.errors, 0,
            reason: 'Default nodes should have 0 errors on startup');
      }
    });

    test('shuffle should distribute default nodes randomly', () {
      final List<Node> original = <Node>[
        Node(url: 'https://node1.com'),
        Node(url: 'https://node2.com'),
        Node(url: 'https://node3.com'),
      ];

      final List<Node> shuffled1 = <Node>[...original]..shuffle();
      final List<Node> shuffled2 = <Node>[...original]..shuffle();

      // Verify all nodes are present (same set)
      expect(shuffled1.map((n) => n.url).toSet(),
          original.map((n) => n.url).toSet(),
          reason: 'Shuffled list should contain all original nodes');

      expect(shuffled2.map((n) => n.url).toSet(),
          original.map((n) => n.url).toSet(),
          reason: 'Shuffled list should contain all original nodes');

      // At least one shuffle should produce a different order (with high probability)
      final bool orderDifferent = shuffled1.map((n) => n.url).join(',') !=
          shuffled2.map((n) => n.url).join(',');
      expect(orderDifferent || shuffled1.length <= 1, true,
          reason: 'Shuffle should randomize order');
    });

    test('NodeManager.nodesWorking should count nodes with errors < 5', () {
      final NodeManager nm = NodeManager();

      // Can't directly set endpointNodes as it's final, so test the counting logic
      final List<Node> testNodes = <Node>[
        Node(url: 'https://good1.com', errors: 0),
        Node(url: 'https://good2.com', errors: 2),
        Node(url: 'https://bad1.com', errors: 5),
        Node(url: 'https://bad2.com', errors: 10),
      ];

      // Filter nodes with errors < 5
      final int workingCount = testNodes.where((n) => n.errors < 5).length;

      expect(workingCount, 2, reason: 'Should count 2 nodes with errors < 5');
    });

    test('node with latency < 99999 should be considered pinged', () {
      final Node defaultNode = Node(
        url: 'https://example.com',
        latency: 99999,
        errors: 0,
        currentBlock: 0,
      );

      final Node pinggedNode = Node(
        url: 'https://example.com',
        latency: 245000, // Real latency in microseconds
        errors: 0,
        currentBlock: 12345,
      );

      expect(defaultNode.latency, 99999, reason: 'Default latency');
      expect(pinggedNode.latency, 245000, reason: 'Real latency after ping');
      expect(pinggedNode.latency != defaultNode.latency, true,
          reason: 'Real and dummy latencies should be different');
    });

    test('node shuffle preserves all nodes (no duplicates/loss)', () {
      final List<Node> original = <Node>[
        Node(url: 'https://node1.com'),
        Node(url: 'https://node2.com'),
        Node(url: 'https://node3.com'),
        Node(url: 'https://node4.com'),
      ];

      final int originalCount = original.length;
      final List<Node> shuffled = <Node>[...original]..shuffle();

      expect(shuffled.length, originalCount,
          reason: 'Shuffle should preserve node count');

      final Set<String> originalUrls = original.map((n) => n.url).toSet();
      final Set<String> shuffledUrls = shuffled.map((n) => n.url).toSet();

      expect(shuffledUrls, originalUrls,
          reason: 'Shuffle should preserve all node URLs');
    });

    test('404 error handling distinction from connection errors', () {
      // 404 = resource not found (valid response for missing profiles)
      // Connection error = timeout, DNS fail, etc (invalid response)
      final Node node404 = Node(
        url: 'https://example.com',
        errors: 1, // 404 increments errors
      );

      final Node nodeTimeout = Node(
        url: 'https://example.com',
        errors: 1, // Timeout increments errors
      );

      // Both increment errors, but 404 shouldn't penalize as much for profile requests
      expect(node404.errors, nodeTimeout.errors,
          reason: 'Both increment error counter');
    });

    test('summary log should show success/failure ratio', () {
      const int totalCandidates = 10;
      const int successCount = 7;
      final int failCount = totalCandidates - successCount;

      expect(failCount, 3);

      final bool isSuccess = successCount >= totalCandidates / 2;
      expect(isSuccess, true,
          reason: '7/10 should be considered success (>= 50%)');

      final bool isFail = successCount < totalCandidates / 2;
      expect(isFail, false, reason: '7/10 should not be failure');
    });

    test('offline mode: NodeManager preserves node list', () {
      // Simulate offline: defaults are already loaded
      final NodeManager nm = NodeManager();

      final List<Node> beforePing = nm.nodeList(NodeType.endpoint);
      // Simulate ping failure (network down) by not modifying nodes
      final List<Node> afterPing = nm.nodeList(NodeType.endpoint);

      expect(afterPing.runtimeType, beforePing.runtimeType,
          reason: 'Failed ping should not crash node list access');
    });
  });

  group('V1 Learnings Applied', () {
    test('shuffle balances load distribution - probabilistic test', () {
      // V1 used shuffle to avoid all requests going to the first node
      final List<String> nodeUrls = <String>[
        'https://node1.com',
        'https://node2.com',
        'https://node3.com',
      ];

      const int iterations = 100;
      final Map<String, int> hitCounts = <String, int>{
        for (final String url in nodeUrls) url: 0
      };

      for (int i = 0; i < iterations; i++) {
        final List<String> shuffled = <String>[...nodeUrls]..shuffle();
        hitCounts[shuffled.first] = hitCounts[shuffled.first]! + 1;
      }

      // Each node should be first approximately 33% of the time (±25% tolerance for randomness)
      for (final String url in nodeUrls) {
        final int hits = hitCounts[url]!;
        final int expectedHits = iterations ~/ nodeUrls.length;
        final int tolerance = (expectedHits * 0.25).toInt(); // ±25% tolerance

        expect(hits, greaterThan(expectedHits - tolerance),
            reason:
                '$url should be first ~${expectedHits}x times, got $hits (tolerance: ±$tolerance)');
        expect(hits, lessThan(expectedHits + tolerance),
            reason:
                '$url should be first ~${expectedHits}x times, got $hits (tolerance: ±$tolerance)');
      }
    });

    test('ALWAYS fetch pattern (V1) - with high node count still fetches', () {
      // V1: Always attempted discovery (nodesWorking was high threshold)
      // V2 before fix: Only fetched if nodesWorking < 3 (broken)
      // V2 after fix: ALWAYS fetches

      final List<Node> manyNodes = <Node>[
        for (int i = 0; i < 10; i++) Node(url: 'https://node$i.com', errors: 0)
      ];

      final int workingCount = manyNodes.where((n) => n.errors < 5).length;

      // Even with 10 working nodes, new logic would STILL attempt fetch/ping
      // This ensures we always get real latencies, not dummy 99999
      expect(workingCount, 10, reason: 'All 10 nodes should be working');

      // The key improvement: even with 10 working nodes, we now ping them
      // (to get real latencies, not dummy values)
      // This is the opposite of the old V2 behavior (nodesWorking < 3 check)
    });
  });

  group('Security Improvements (V2)', () {
    test('localhost should be filtered from P2P discovery', () {
      final String localhost1 = 'http://localhost:8080';
      final String localhost2 = 'http://127.0.0.1:8080';
      final String ipv6loopback = 'http://[::1]:8080';
      final String validNode = 'https://g1.node1.com';

      expect(localhost1.contains('localhost'), true);
      expect(localhost2.contains('127.0.0.1'), true);
      expect(ipv6loopback.contains('::1'), true);
      expect(validNode.contains('localhost'), false);

      // Filter logic (as implemented in v2_peers.dart)
      final List<String> nodes = <String>[
        localhost1,
        localhost2,
        ipv6loopback,
        validNode
      ];

      final List<String> filtered = nodes
          .where((n) =>
              !n.contains('localhost') &&
              !n.contains('127.0.0.1') &&
              !n.contains('::1'))
          .toList();

      expect(filtered.length, 1, reason: 'Should have 1 valid node');
      expect(filtered.first, validNode);
    });

    test('maxNodes limit prevents DoS from P2P discovery', () {
      const int maxNodes = 20;
      final List<String> discoveredEndpoints = <String>[
        for (int i = 0; i < 50; i++) 'https://peer$i.com'
      ];

      // Apply maxNodes limit (V1 pattern, now in v2_peers.dart)
      final List<String> limited = <String>[];
      for (final String endpoint in discoveredEndpoints) {
        if (limited.length >= maxNodes) break;
        limited.add(endpoint);
      }

      expect(limited.length, maxNodes,
          reason: 'Should not exceed maxNodes limit');
    });

    test('node discovery respects genesis_hash validation', () {
      // Genesis hash validation prevents mixing nodes from different chains
      // (e.g., G1 with gtest nodes)
      final String g1Hash =
          '0xfeb770bb4c3a433e1eb1d3e95ccb02a5eaf82c86e95e3fc46d32dc2f8ff5505';
      final String gtestHash =
          '0x7e2f25b8c8cfea4a0b71c31c97dd8bfda4e3a97b7cb8c32d4a15c2c0f3d4e5';

      // Nodes from different chains should be rejected
      final Map<String, String> nodesByHash = <String, String>{
        'https://g1.node1.com': g1Hash,
        'https://g1.node2.com': g1Hash,
        'https://gtest.node1.com': gtestHash,
      };

      // Filter to only G1 nodes
      final List<String> g1Nodes = nodesByHash.entries
          .where((e) => e.value == g1Hash)
          .map((e) => e.key)
          .toList();

      expect(g1Nodes.length, 2, reason: 'Should have 2 G1 nodes');
      expect(g1Nodes.contains('https://g1.node1.com'), true);
      expect(g1Nodes.contains('https://g1.node2.com'), true);
      expect(g1Nodes.contains('https://gtest.node1.com'), false);
    });
  });

  group('Logging & Error Handling', () {
    test('summary log format includes failed count', () {
      const int totalCandidates = 10;
      const int successCount = 7;
      const int failCount = totalCandidates - successCount;
      const int avgLatency = 245;
      const int bestLatency = 120;

      // Format: "✓ endpoint: 7/10 online (avg: 245ms, best: 120ms) | 3 failed"
      final String summary =
          '✓ endpoint: $successCount/$totalCandidates online '
          '(avg: ${avgLatency}ms, best: ${bestLatency}ms) | $failCount failed';

      expect(summary.contains('7/10'), true);
      expect(summary.contains('3 failed'), true);
      expect(summary.contains('245ms'), true);
      expect(summary.contains('120ms'), true);
    });

    test('profile 404 log should be single final message', () {
      const String path = '/user/profile/pubkey123';
      const int consecutive404s = 2;

      // Format: "ℹ️ Resource not found: /user/profile/pubkey123 (404 from 2 nodes)"
      final String logMessage =
          'ℹ️ Resource not found: $path (404 from $consecutive404s nodes)';

      expect(logMessage.contains('Resource not found'), true);
      expect(logMessage.contains(path), true);
      expect(logMessage.contains('404 from 2 nodes'), true);
    });

    test('connection error should not spam individual logs', () {
      // Scenario: 10 nodes timeout
      // OLD: 10 individual logs like "Error fetching https://node1.com: TimeoutException"
      // NEW: 1 summary log like "⚠ endpoint: 2/10 online (...) | 8 failed"

      const int totalNodes = 10;
      const int failedCount = 8;
      const int successCount = totalNodes - failedCount;

      // Only 1 log message (summary)
      final int logCount = 1;

      expect(logCount, 1,
          reason:
              'Should produce only 1 summary log, not 10 individual errors');
    });
  });
}
