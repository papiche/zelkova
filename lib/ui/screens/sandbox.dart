import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/open_collective_service.dart';
import '../../services/upassport_api_service.dart';
import '../../services/nip101_service.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../ui/logger.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  final double expandedHeight = 500;
  String _log = '';
  bool _loading = false;

  void _addLog(String message) {
    setState(() {
      _log = '${DateTime.now().toIso8601String()}: $message\n$_log';
    });
  }

  Future<void> _testOpenCollective() async {
    setState(() => _loading = true);
    try {
      final OpenCollectiveService service = GetIt.instance<OpenCollectiveService>();
      _addLog('OpenCollectiveService isConfigured: ${service.isConfigured}');
      if (!service.isConfigured) {
        _addLog('Service not configured (needs API URL, key, slug).');
      } else {
        final List<OCTransaction> transactions = await service.fetchTransactions(limit: 5);
        _addLog('Fetched ${transactions.length} transactions');
        for (final OCTransaction tx in transactions.take(3)) {
          _addLog('  - ${tx.description}: ${tx.amount} ${tx.currency}');
        }
      }
    } catch (e) {
      _addLog('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _testUPassport() async {
    setState(() => _loading = true);
    try {
      final UPassportApiService service = GetIt.instance<UPassportApiService>();
      final BalanceInfo balance = await service.getBalance('testpubkey');
      _addLog('Balance: ${balance.balance}');
      final ZenCardInfo zenCard = await service.getZenCard('test@example.com');
      _addLog('ZenCard email: ${zenCard.email}');
    } catch (e) {
      _addLog('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _testNip101() async {
    setState(() => _loading = true);
    try {
      final Nip101Service service = GetIt.instance<Nip101Service>();
      final List<PermitDefinition> permits = await service.getPermitDefinitions(limit: 2);
      _addLog('Fetched ${permits.length} permit definitions');
      for (final PermitDefinition permit in permits) {
        _addLog('  - ${permit.name} (${permit.id})');
      }
      // Try to fetch a DID document (requires a valid DID)
      // final didDoc = await service.getDidDocument('did:nostr:test');
      // _addLog('DID Document: ${didDoc?.id ?? 'none'}');
    } catch (e) {
      _addLog('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _testNostrRelay() async {
    setState(() => _loading = true);
    try {
      final NostrRelayService relay = GetIt.instance<NostrRelayService>();
      _addLog('NostrRelayService connected: ${relay.isConnected}');
      if (!relay.isConnected) {
        _addLog('Connecting...');
        await relay.connect('wss://relay.damus.io');
      }
      final List<Map<String, dynamic>> events = await relay.queryEvents(kinds: <int>[0, 3], limit: 2);
      _addLog('Queried ${events.length} events');
      for (final Map<String, dynamic> event in events.take(2)) {
        _addLog('  - kind ${event['kind']} from ${event['pubkey']?.substring(0, 8)}');
      }
    } catch (e) {
      _addLog('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox - NIP-101 Integration'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => setState(() => _log = ''),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      "Test des nouveaux services d'intégration Astroport",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _loading ? null : _testOpenCollective,
                          child: const Text('Open Collective'),
                        ),
                        ElevatedButton(
                          onPressed: _loading ? null : _testUPassport,
                          child: const Text('UPassport API'),
                        ),
                        ElevatedButton(
                          onPressed: _loading ? null : _testNip101,
                          child: const Text('NIP-101'),
                        ),
                        ElevatedButton(
                          onPressed: _loading ? null : _testNostrRelay,
                          child: const Text('NOSTR Relay'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_loading) const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    const Text(
                      'Logs:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: SingleChildScrollView(
                        reverse: true,
                        child: SelectableText(
                          _log.isEmpty ? 'No logs yet.' : _log,
                          style: const TextStyle(fontFamily: 'Monospace', fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Explication:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Ces boutons testent l'intégration des nouveaux services Dart créés pour NIP-101, Open Collective, UPassport et NOSTR. Les services sont enregistrés dans GetIt et peuvent être utilisés dans toute l'application.",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
