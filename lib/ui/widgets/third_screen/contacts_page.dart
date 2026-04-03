import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_sort_type.dart';
import '../../../g1/api.dart';
import '../../../g1/g1_v2_helper.dart';
import '../../../g1/nostr/nostr_keys.dart';
import '../../../g1/nostr/nostr_profile.dart';
import '../../../g1/nostr/nostr_relay_service.dart';
import '../../ui_helpers.dart';
import '../bottom_widget.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import '../contact_menu.dart';
import '../contacts_actions.dart';
import '../slidable_contact_tile.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Contact> _networkResults = <Contact>[];
  bool _isSearchingNetwork = false;
  final int minSearchLength = 3;

  // ── MULTIPASS / NOSTR mode ──────────────────────────────────────────────
  bool _nostrMode = false;
  List<NostrProfile> _allNostrProfiles = <NostrProfile>[];
  List<NostrProfile> _filteredNostrProfiles = <NostrProfile>[];
  bool _nostrLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<ContactsCubit>().resetFilter();
  }

  @override
  void dispose() {
    _searchController.dispose();
    EasyDebounce.cancel('search-network');
    super.dispose();
  }

  Future<void> _searchNetwork(String query) async {
    if (query.length < minSearchLength) {
      setState(() {
        _networkResults = <Contact>[];
        _isSearchingNetwork = false;
      });
      return;
    }

    setState(() {
      _isSearchingNetwork = true;
    });

    try {
      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      if (!isConnected) {
        setState(() {
          _networkResults = <Contact>[];
          _isSearchingNetwork = false;
        });
        return;
      }

      final List<Contact> results = <Contact>[];

      // Search profiles
      final List<Contact> profileResults = await searchProfiles(query);
      results.addAll(profileResults);

      // Search WoT
      if (query.length >= minSearchLength) {
        final List<Contact> wotResults = await searchWot(query);
        for (final Contact c in wotResults) {
          if (!results.any((Contact r) => r.pubKey == c.pubKey)) {
            results.add(c);
          }
        }
      }

      if (mounted) {
        setState(() {
          _networkResults = results;
          _isSearchingNetwork = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _networkResults = <Contact>[];
          _isSearchingNetwork = false;
        });
      }
    }
  }

  // ── NOSTR / MULTIPASS methods ───────────────────────────────────────────

  Future<void> _loadNostrProfiles() async {
    if (_nostrLoading) return;
    setState(() => _nostrLoading = true);
    try {
      final NostrRelayService relay = NostrRelayService();
      if (!relay.isConnected) {
        if (mounted) setState(() => _nostrLoading = false);
        return;
      }
      final List<NostrProfile> profiles =
          await relay.fetchAllMultipassProfiles();
      if (mounted) {
        setState(() {
          _allNostrProfiles = profiles;
          _filteredNostrProfiles = _applyNostrFilter(_searchController.text);
          _nostrLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _nostrLoading = false);
    }
  }

  List<NostrProfile> _applyNostrFilter(String query) {
    if (query.isEmpty) return List<NostrProfile>.from(_allNostrProfiles);
    final String q = query.toLowerCase();
    return _allNostrProfiles.where((NostrProfile p) {
      return (p.name.toLowerCase().contains(q)) ||
          (p.city?.toLowerCase().contains(q) ?? false) ||
          (p.email?.toLowerCase().contains(q) ?? false) ||
          (p.g1pub?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  Widget _buildNostrProfilesList() {
    if (_nostrLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_allNostrProfiles.isEmpty) {
      return Center(child: Text(tr('contacts_nostr_empty')));
    }
    if (_filteredNostrProfiles.isEmpty) {
      return Center(child: Text(tr('not_found_contacts')));
    }
    return ListView.builder(
      itemCount: _filteredNostrProfiles.length,
      itemBuilder: (BuildContext ctx, int i) {
        final NostrProfile p = _filteredNostrProfiles[i];
        final String g1pub = p.g1pub ?? '';
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: p.picture != null && p.picture!.isNotEmpty
                ? NetworkImage(p.picture!)
                : null,
            onBackgroundImageError: (_, __) {},
            child: p.picture == null || p.picture!.isEmpty
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
          trailing: (g1pub.isNotEmpty || (p.g1v2?.isNotEmpty ?? false))
              ? const Icon(Icons.chevron_right, size: 18)
              : null,
          onTap: (g1pub.isNotEmpty || (p.g1v2?.isNotEmpty ?? false))
              ? () {
                  // Dériver nostrHex depuis npub pour éviter une requête réseau.
                  String? nostrHex;
                  if (p.npub.isNotEmpty) {
                    try {
                      nostrHex = NostrKeys.npubToHex(p.npub);
                    } catch (_) {}
                  }
                  // Priorité: g1v2 (SS58) > g1pub validé SS58 > g1pub v1 base58.
                  // Contact.withAddress() exige un SS58 valide (lève une erreur
                  // sinon) — utilisé seulement après validation isValidV2Address.
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
                    // g1pub est une pubkey v1 base58 (anciens profils)
                    contact = Contact(
                      pubKey: g1pub,
                      createdOn: DateTime.now().millisecondsSinceEpoch,
                    ).copyWith(nostrHex: nostrHex);
                  }
                  showContactPage(ctx, contact);
                }
              : null,
        );
      },
    );
  }

  Widget _buildContactsList(ContactsCubit cubit) {
    final List<Contact> localContacts = cubit.state.filteredContacts;
    final List<Contact> networkContactsFiltered = _networkResults
        .where((Contact nc) =>
            !localContacts.any((Contact lc) => lc.pubKey == nc.pubKey))
        .toList();

    final bool hasLocalContacts = localContacts.isNotEmpty;
    final bool hasNetworkContacts = networkContactsFiltered.isNotEmpty;
    final bool isSearching = _searchController.text.isNotEmpty;
    final bool hasSearched =
        isSearching && _searchController.text.length >= minSearchLength;
    final bool showNetworkSection = hasSearched && !_isSearchingNetwork;

    // Show empty state only when no search has been performed
    if (!hasLocalContacts &&
        !hasNetworkContacts &&
        !_isSearchingNetwork &&
        !hasSearched) {
      return Center(
        child: Text(
          cubit.state.contacts.isEmpty
              ? tr('no_contacts')
              : tr('not_found_contacts'),
        ),
      );
    }

    // Show "no results anywhere" when search completed but found nothing
    if (!hasLocalContacts &&
        !hasNetworkContacts &&
        !_isSearchingNetwork &&
        hasSearched) {
      return Center(
        child: Text(tr('no_network_results')),
      );
    }

    // Calculate item count properly
    int itemCount = localContacts.length;

    if (_isSearchingNetwork && isSearching) {
      // Add separator + loading indicator
      itemCount += 1;
    } else if (showNetworkSection) {
      // Add separator
      itemCount += 1;
      if (hasNetworkContacts) {
        // Add network contacts
        itemCount += networkContactsFiltered.length;
      } else if (hasLocalContacts) {
        // Add "no more results" message only if there are local contacts
        itemCount += 1;
      }
    }

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        // Local contacts
        if (index < localContacts.length) {
          return _buildContactTile(context, localContacts[index], index, false);
        }

        final int relativeIndex = index - localContacts.length;

        // Network section separator + content
        if (_isSearchingNetwork && isSearching) {
          // Show separator and loading indicator
          return Column(
            children: <Widget>[
              ListTile(
                tileColor: Theme.of(context).colorScheme.primaryContainer,
                title: Text(
                  tr('network_results'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
            ],
          );
        } else if (showNetworkSection) {
          // First item after local contacts is the separator
          if (relativeIndex == 0) {
            return ListTile(
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(
                tr('network_results'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            );
          }

          // Items after separator
          if (hasNetworkContacts) {
            // Network contacts (relativeIndex - 1 because separator is at 0)
            final int networkIndex = relativeIndex - 1;
            if (networkIndex >= 0 &&
                networkIndex < networkContactsFiltered.length) {
              return _buildContactTile(context,
                  networkContactsFiltered[networkIndex], networkIndex, true);
            }
          } else if (hasLocalContacts) {
            // No more results message (only when there are local contacts)
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  tr('no_more_network_results'),
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha((255.0 * 0.6).round()),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContactTile(
      BuildContext context, Contact contact, int index, bool isNetworkResult) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey<String>('${isNetworkResult ? 'net' : 'local'}_$index'),
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children: <SlidableAction>[
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (BuildContext c) {
                onDeleteContact(context, contact);
              },
              backgroundColor: deleteColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: tr('delete_contact'),
            ),
            if (showShare())
              SlidableAction(
                onPressed: (BuildContext c) =>
                    SharePlus.instance.share(ShareParams(text: contact.pubKey)),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                foregroundColor: Theme.of(context).primaryColor,
                icon: Icons.share,
                label: tr('share_this_key'),
              ),
          ],
        ),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          /* dismissible: DismissiblePane(onDismissed: () {
                          onSent(context, contact);
                        }), */
          children: <SlidableAction>[
            SlidableAction(
              onPressed: (BuildContext c) {
                onShowContactQr(context, contact);
              },
              backgroundColor: Theme.of(context).primaryColorDark,
              foregroundColor: Colors.white,
              icon: Icons.copy,
              label: tr('copy_contact_key'),
            ),
            SlidableAction(
              onPressed: (BuildContext c) {
                onSentContact(c, contact);
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.send,
              label: tr('send_g1'),
            ),
          ],
        ),
        child: SlidableContactTile(contact,
            index: index,
            context: context,
            onLongPress: () => onEditContact(context, contact),
            onTap: () {
              showContactPage(context, contact);
            },
            trailing: ContactMenu(
                contact: contact,
                onEdit: () => onEditContact(context, contact),
                onSent: () => onSentContact(context, contact),
                onCopy: () => onShowContactQr(context, contact),
                onDelete: () => onDeleteContact(context, contact))));
  }

  @override
  Widget build(BuildContext context) {
    final ContactsCubit cubit = context.watch<ContactsCubit>();
    context.read<ContactsCubit>().sortContactsAsStored();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ── Source toggle: Cesium+ vs MULTIPASS ────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: SegmentedButton<bool>(
            style: SegmentedButton.styleFrom(
              visualDensity: VisualDensity.compact,
            ),
            segments: <ButtonSegment<bool>>[
              ButtonSegment<bool>(
                value: false,
                label: Text(tr('contacts_source_cesium')),
                icon: const Icon(Icons.person_search, size: 16),
              ),
              ButtonSegment<bool>(
                value: true,
                label: Text(tr('contacts_source_multipass')),
                icon: const Icon(Icons.electric_bolt, size: 16),
              ),
            ],
            selected: <bool>{_nostrMode},
            onSelectionChanged: (Set<bool> s) {
              setState(() {
                _nostrMode = s.first;
                if (_nostrMode) {
                  _loadNostrProfiles();
                }
              });
            },
          ),
        ),
        // ── Search bar ─────────────────────────────────────────────────
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.surface),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: _nostrMode
                                ? tr('contacts_search_multipass')
                                : tr('search_contacts'),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (String query) {
                            if (_nostrMode) {
                              setState(() {
                                _filteredNostrProfiles =
                                    _applyNostrFilter(query);
                              });
                            } else {
                              context
                                  .read<ContactsCubit>()
                                  .filterContacts(query);
                              EasyDebounce.debounce(
                                'search-network',
                                const Duration(milliseconds: 500),
                                () => _searchNetwork(query),
                              );
                            }
                          })),
                  if (!_nostrMode)
                    PopupMenuButton<ContactsSortType>(
                    icon: const Icon(Icons.sort),
                    onSelected: (ContactsSortType result) {
                      context.read<ContactsCubit>().sortContacts(result);
                    },
                    itemBuilder: (BuildContext context) {
                      final ContactsSortType currentOrder =
                          context.read<ContactsCubit>().state.order;

                      return <PopupMenuEntry<ContactsSortType>>[
                        PopupMenuItem<ContactsSortType>(
                          value: ContactsSortType.date,
                          child: ListTile(
                            leading: Icon(
                              Icons.date_range,
                              color: currentOrder == ContactsSortType.date
                                  ? Colors.blue
                                  : null,
                            ),
                            title: Text(tr('contacts_sort_by_date')),
                            trailing: currentOrder == ContactsSortType.date
                                ? const Icon(Icons.check)
                                : null,
                          ),
                        ),
                        PopupMenuItem<ContactsSortType>(
                          value: ContactsSortType.alpha,
                          child: ListTile(
                            leading: Icon(
                              Icons.sort_by_alpha,
                              color: currentOrder == ContactsSortType.alpha
                                  ? Colors.blue
                                  : null,
                            ),
                            title: Text(tr('contacts_sort_by_name')),
                            trailing: currentOrder == ContactsSortType.alpha
                                ? const Icon(Icons.check)
                                : null,
                          ),
                        ),
                      ];
                    },
                  ),
                ])),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _nostrMode
              ? _buildNostrProfilesList()
              : _buildContactsList(cubit),
        ),
        const BottomWidget(),
      ],
    );
  }
}

class NoElements extends StatelessWidget {
  const NoElements({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: Text(tr(text))));
  }
}
