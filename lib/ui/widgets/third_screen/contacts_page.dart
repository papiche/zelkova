import 'dart:async';

import 'package:bip340/bip340.dart' as bip340;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/contact.dart';
import '../../../g1/g1_v2_helper.dart';
import '../../../g1/nostr/nostr_keys.dart';
import '../../../g1/nostr/nostr_profile.dart';
import '../../../g1/nostr/nostr_relay_service.dart';
import '../../../shared_prefs_helper_v2.dart';
import '../bottom_widget.dart';
import '../contacts_actions.dart';

enum _FollowFilter { out12p, in21p, p2p, n2 }

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();

  _FollowFilter _filter = _FollowFilter.out12p;
  bool _loading = false;
  String _error = '';

  String? _myHexPubkey;

  // Raw sets of hex pubkeys
  Set<String> _myFollows = <String>{};
  Set<String> _myFollowers = <String>{};
  Set<String> _n2Follows = <String>{};

  // Profiles keyed by hex pubkey
  Map<String, NostrProfile> _profiles = <String, NostrProfile>{};

  // Displayed list (after filter + search)
  List<_ContactEntry> _displayList = <_ContactEntry>[];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Data loading ─────────────────────────────────────────────────────────

  Future<void> _loadData() async {
    if (_loading) {
      return;
    }
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec == null || nsec.isEmpty) {
        if (mounted) {
          setState(() {
            _loading = false;
            _error = tr('contacts_no_identity');
          });
        }
        return; // ignore: always_put_control_body_on_new_line
      }

      final String myHex = bip340.getPublicKey(NostrKeys.nsecToHex(nsec));

      final NostrRelayService relay = NostrRelayService();
      if (!relay.isConnected) {
        if (mounted) {
          setState(() {
            _loading = false;
            _error = tr('contacts_relay_offline');
          });
        }
        return; // ignore: always_put_control_body_on_new_line
      }

      // Fetch follows + followers in parallel
      final List<List<String>> both = await Future.wait(<Future<List<String>>>[
        relay.fetchContacts(myHex),
        relay.fetchFollowers(myHex),
      ]);

      final Set<String> myFollows = Set<String>.from(both[0])
        ..remove(myHex);
      final Set<String> myFollowers = Set<String>.from(both[1])
        ..remove(myHex);

      // N2: follows-of-follows (cap at 30 to avoid relay flooding)
      final List<String> followsList = myFollows.toList();
      final int n2Cap =
          followsList.length > 30 ? 30 : followsList.length;
      final List<List<String>> n2Raw = await Future.wait(
        followsList
            .sublist(0, n2Cap)
            .map((String h) => relay.fetchContacts(h)),
      );
      final Set<String> n2Follows = <String>{};
      n2Raw.forEach(n2Follows.addAll);
      n2Follows
        ..removeAll(myFollows)
        ..removeAll(myFollowers)
        ..remove(myHex);

      // All pubkeys to resolve profiles for
      final List<String> allPubkeys = <String>{
        ...myFollows,
        ...myFollowers,
        ...n2Follows,
      }.toList();

      // Fetch profiles in batches of 15
      final Map<String, NostrProfile> profiles = <String, NostrProfile>{};
      for (int i = 0; i < allPubkeys.length; i += 15) {
        final int end = (i + 15 < allPubkeys.length)
            ? i + 15
            : allPubkeys.length;
        final List<NostrProfile?> batch = await Future.wait(
          allPubkeys
              .sublist(i, end)
              .map((String h) => relay.fetchProfile(h)),
        );
        for (int j = 0; j < batch.length; j++) {
          final NostrProfile? p = batch[j];
          if (p != null) {
            profiles[allPubkeys[i + j]] = p;
          }
        }
      }

      if (mounted) {
        setState(() {
          _myHexPubkey = myHex;
          _myFollows = myFollows;
          _myFollowers = myFollowers;
          _n2Follows = n2Follows;
          _profiles = profiles;
          _loading = false;
        });
        _applyFilter();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = e.toString();
        });
      }
    }
  }

  // ── Filtering ─────────────────────────────────────────────────────────────

  void _applyFilter() {
    Set<String> pubkeys;
    switch (_filter) {
      case _FollowFilter.p2p:
        pubkeys = _myFollows.intersection(_myFollowers);
        break;
      case _FollowFilter.out12p:
        pubkeys = Set<String>.from(_myFollows);
        break;
      case _FollowFilter.in21p:
        pubkeys = Set<String>.from(_myFollowers);
        break;
      case _FollowFilter.n2:
        pubkeys = Set<String>.from(_n2Follows);
        break;
    }

    final String q = _searchController.text.toLowerCase();

    final List<_ContactEntry> list = pubkeys
        .where((String h) => _profiles.containsKey(h))
        .map((String h) {
          final NostrProfile p = _profiles[h]!;
          final bool iFollow = _myFollows.contains(h);
          final bool followsMe = _myFollowers.contains(h);
          return _ContactEntry(
            hexPubkey: h,
            profile: p,
            iFollow: iFollow,
            followsMe: followsMe,
          );
        })
        .where((_ContactEntry e) {
          if (q.isEmpty) {
            return true;
          }
          final NostrProfile p = e.profile;
          return p.name.toLowerCase().contains(q) ||
              (p.city?.toLowerCase().contains(q) ?? false) ||
              (p.email?.toLowerCase().contains(q) ?? false) ||
              e.hexPubkey.contains(q);
        })
        .toList()
      ..sort((_ContactEntry a, _ContactEntry b) =>
          a.profile.name.toLowerCase().compareTo(b.profile.name.toLowerCase()));

    setState(() => _displayList = list);
  }

  // ── Widgets ───────────────────────────────────────────────────────────────

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: <Widget>[
          _chip(_FollowFilter.out12p, '→ 12P',
              tr('contacts_filter_12p'),
              Icons.person_add_outlined),
          const SizedBox(width: 8),
          _chip(_FollowFilter.in21p, '← P21',
              tr('contacts_filter_p21'),
              Icons.person_outlined),
          const SizedBox(width: 8),
          _chip(_FollowFilter.p2p, '↔ P2P',
              tr('contacts_filter_p2p'),
              Icons.people_outlined),
          const SizedBox(width: 8),
          _chip(_FollowFilter.n2, 'N2',
              tr('contacts_filter_n2'),
              Icons.hub_outlined),
        ],
      ),
    );
  }

  Widget _chip(_FollowFilter f, String label, String tooltip, IconData icon) {
    final bool selected = _filter == f;
    return Tooltip(
      message: tooltip,
      child: FilterChip(
        selected: selected,
        avatar: Icon(icon, size: 14),
        label: Text(label),
        onSelected: (_) {
          setState(() => _filter = f);
          _applyFilter();
        },
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _buildRelationBadge(_ContactEntry e) {
    final bool p2p = e.iFollow && e.followsMe;
    if (p2p) {
      return const Tooltip(
        message: 'P2P — mutuel',
        child: Icon(Icons.swap_horiz, size: 16, color: Colors.green),
      );
    }
    if (e.iFollow && !e.followsMe) {
      return const Tooltip(
        message: '12P — tu suis',
        child: Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
      );
    }
    if (!e.iFollow && e.followsMe) {
      return const Tooltip(
        message: 'P21 — te suit',
        child: Icon(Icons.arrow_back, size: 16, color: Colors.orange),
      );
    }
    // N2 only
    return const Tooltip(
      message: "N2 — ami d'ami",
      child: Icon(Icons.hub_outlined, size: 16, color: Colors.grey),
    );
  }

  Widget _buildProfileTile(_ContactEntry e) {
    final NostrProfile p = e.profile;
    final String g1pub = p.g1pub ?? '';
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: p.picture != null && p.picture!.isNotEmpty
            ? NetworkImage(p.picture!)
            : null,
        onBackgroundImageError: (_, __) {},
        child: (p.picture == null || p.picture!.isEmpty)
            ? Text(
                p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Text(p.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        <String>[
          if (p.city?.isNotEmpty ?? false) p.city!,
          if (p.email?.isNotEmpty ?? false) p.email!,
        ].join(' · '),
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildRelationBadge(e),
          if (g1pub.isNotEmpty || (p.g1v2?.isNotEmpty ?? false))
            const Icon(Icons.chevron_right, size: 18),
        ],
      ),
      onTap: (g1pub.isNotEmpty || (p.g1v2?.isNotEmpty ?? false))
          ? () {
              String? nostrHex;
              if (p.npub.isNotEmpty) {
                try {
                  nostrHex = NostrKeys.npubToHex(p.npub);
                } catch (_) {}
              }
              final String? g1v2 = p.g1v2;
              final Contact contact;
              if (g1v2 != null && g1v2.isNotEmpty) {
                contact = Contact.withAddress(
                  address: g1v2,
                  createdOn: DateTime.now().millisecondsSinceEpoch,
                ).copyWith(nostrHex: nostrHex);
              } else if (isValidV2Address(g1pub)) {
                contact = Contact.withAddress(
                  address: g1pub,
                  createdOn: DateTime.now().millisecondsSinceEpoch,
                ).copyWith(nostrHex: nostrHex);
              } else {
                contact = Contact(
                  pubKey: g1pub,
                  createdOn: DateTime.now().millisecondsSinceEpoch,
                ).copyWith(nostrHex: nostrHex);
              }
              showContactPage(context, contact);
            }
          : null,
    );
  }

  Widget _buildList() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(_error, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh),
                label: Text(tr('retry')),
              ),
            ],
          ),
        ),
      );
    }
    if (_myHexPubkey == null) {
      return Center(child: Text(tr('contacts_no_identity')));
    }
    if (_displayList.isEmpty) {
      return Center(child: Text(tr('not_found_contacts')));
    }
    return ListView.builder(
      itemCount: _displayList.length,
      itemBuilder: (BuildContext ctx, int i) =>
          _buildProfileTile(_displayList[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ── Filter chips ──────────────────────────────────────────────
        _buildFilterChips(),
        // ── Search bar ────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: tr('contacts_search_multipass'),
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _applyFilter();
                      },
                    )
                  : null,
              isDense: true,
            ),
            onChanged: (_) => _applyFilter(),
          ),
        ),
        // ── Stats line ────────────────────────────────────────────────
        if (!_loading && _myHexPubkey != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Text(
              '${_myFollows.length} → · ${_myFollowers.length} ← · '
              '${_myFollows.intersection(_myFollowers).length} ↔ · '
              '${_n2Follows.length} N2',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(140),
                  ),
            ),
          ),
        const SizedBox(height: 4),
        // ── List ──────────────────────────────────────────────────────
        Expanded(child: _buildList()),
        const BottomWidget(),
      ],
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────

class _ContactEntry {
  _ContactEntry({
    required this.hexPubkey,
    required this.profile,
    required this.iFollow,
    required this.followsMe,
  });

  final String hexPubkey;
  final NostrProfile profile;
  final bool iFollow;
  final bool followsMe;
}

class NoElements extends StatelessWidget {
  const NoElements({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: Text(tr(text))));
  }
}
