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
                            hintText: tr('search_contacts'),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (String query) {
                            context.read<ContactsCubit>().filterContacts(query);
                            // Debounce network search
                            EasyDebounce.debounce(
                              'search-network',
                              const Duration(milliseconds: 500),
                              () => _searchNetwork(query),
                            );
                          })),
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
                  )
                ]))),
        const SizedBox(height: 20),
        Expanded(child: _buildContactsList(cubit)),
        const BottomWidget()
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
