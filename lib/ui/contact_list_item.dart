import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data/models/contact.dart';
import '../g1/nostr/nostr_profile.dart';
import '../g1/nostr/nostr_relay_service.dart';
import 'contacts_cache.dart';
import 'ui_helpers.dart';
import 'widgets/connectivity_widget_wrapper_wrapper.dart';
import 'widgets/contacts_actions.dart';

/// Session-level cache: G1 pubKey → NostrProfile (nullable = "fetched, not found")
final Map<String, NostrProfile?> _nostrProfileCache = <String, NostrProfile?>{};

class ContactListItem extends StatefulWidget {
  const ContactListItem(
      {super.key,
      required this.contact,
      required this.index,
      required this.onTap,
      this.onLongPress,
      required this.trailing,
      required this.isV2,
      this.subtitleExtra});

  final Contact contact;
  final int index;
  final String? subtitleExtra;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;
  final bool isV2;

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  Contact? _enrichedContact;
  NostrProfile? _nostrProfile;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    // 1. Enrich from Cesium+/cache first
    final Contact cached =
        await ContactsCache().getContact(widget.contact.pubKey);
    Contact enriched = cached;
    if (widget.contact.createdOn != null && cached.createdOn == null) {
      enriched = cached.copyWith(createdOn: widget.contact.createdOn);
    }

    // 2. Enrich with NOSTR kind 0 profile (if relay connected)
    NostrProfile? nostrProfile;
    final String pubKey = widget.contact.pubKey;

    if (_nostrProfileCache.containsKey(pubKey)) {
      // Already fetched this session — use cache (may be null = not found)
      nostrProfile = _nostrProfileCache[pubKey];
    } else {
      final NostrRelayService relay = NostrRelayService();
      if (relay.isConnected) {
        try {
          final String? nostrHex = await relay.findNostrHexByG1Pub(pubKey);
          if (nostrHex != null) {
            nostrProfile = await relay.fetchProfile(nostrHex);
          }
        } catch (_) {}
      }
      // Cache the result (even null = not found) to avoid re-fetching
      _nostrProfileCache[pubKey] = nostrProfile;
    }

    if (mounted) {
      setState(() {
        _enrichedContact = enriched;
        _nostrProfile = nostrProfile;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      // Show shimmer while loading
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: _buildListTile(
          widget.contact,
          context,
          false,
          avatar(
            widget.contact,
            bgColor: tileColor(widget.index, context),
            color: tileColor(widget.index, context, true),
          ),
          null,
        ),
      );
    }

    final Contact displayContact = _enrichedContact ?? widget.contact;
    final Widget avatarWidget = _buildAvatar(displayContact, context);

    return ConnectivityWidgetWrapperWrapper(
      offlineWidget:
          _buildListTile(widget.contact, context, false, avatarWidget, null),
      child:
          _buildListTile(displayContact, context, true, avatarWidget, _nostrProfile),
    );
  }

  Widget _buildAvatar(Contact contact, BuildContext context) {
    // Priority: NOSTR picture URL → Cesium+ binary avatar → default
    if (_nostrProfile?.picture != null &&
        _nostrProfile!.picture!.isNotEmpty) {
      return CircleAvatar(
        radius: defAvatarUiSize,
        backgroundColor:
            tileColor(widget.index, context).withOpacity(0.2),
        backgroundImage: NetworkImage(_nostrProfile!.picture!),
        onBackgroundImageError: (_, __) {},
        child: null,
      );
    }
    return avatar(
      contact,
      bgColor: tileColor(widget.index, context),
      color: tileColor(widget.index, context, true),
    );
  }

  ListTile _buildListTile(Contact contact, BuildContext context,
      bool hasProfile, Widget avatarWidget, NostrProfile? nostrProfile) {
    // NOSTR displayName overrides Cesium+ name if available
    final String title = nostrProfile?.displayName?.isNotEmpty == true
        ? nostrProfile!.displayName!
        : (nostrProfile?.name?.isNotEmpty == true
            ? nostrProfile!.name!
            : contact.title);

    // Subtitle: city / about  from NOSTR, or Cesium+ subtitle
    String? subtitleText;
    if (nostrProfile != null && hasProfile) {
      if (nostrProfile.city?.isNotEmpty == true) {
        subtitleText = nostrProfile.city;
      } else if (nostrProfile.about?.isNotEmpty == true) {
        final String about = nostrProfile.about!;
        subtitleText =
            about.length > 50 ? '${about.substring(0, 50)}…' : about;
      }
    }
    subtitleText ??= contact.subtitle;

    final Widget? subtitleWidget =
        subtitleText != null && hasProfile ? Text(subtitleText) : null;

    // Trailing: payment button or caller-provided widget
    Widget? trailingWidget = widget.trailing != null
        ? SizedBox(width: 56.0, child: widget.trailing)
        : null;

    // If no trailing provided, show ⚡ payment button (works for any contact)
    if (widget.trailing == null && hasProfile) {
      trailingWidget = Tooltip(
        message: 'Envoyer ẐEN',
        child: IconButton(
          icon: const Icon(Icons.electric_bolt,
              size: 20, color: Color(0xFFBF5AFF)),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => onSentContact(context, contact),
        ),
      );
    }

    return ListTile(
      title: Text(title),
      subtitle: subtitleWidget ??
          (widget.subtitleExtra != null && hasProfile
              ? Text(widget.subtitleExtra!)
              : Container()),
      tileColor: tileColor(widget.index, context),
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      leading: avatarWidget,
      trailing: trailingWidget,
    );
  }
}
