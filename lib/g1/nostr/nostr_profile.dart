import 'dart:convert';

/// Normalize an image URL by collapsing path double-slashes.
/// Some UPlanet IPFS gateways emit  https://host//ipfs/Qm…
/// which breaks NetworkImage. We keep the protocol "://" intact.
String? _normalizeUrl(String? url) {
  if (url == null || url.isEmpty) return url;
  // Replace //+ in path with a single /  (but not the "://" in protocol).
  return url.replaceAllMapped(
    RegExp(r'(?<!:)//+'),
    (_) => '/',
  );
}

/// NOSTR profile metadata (NIP-01 kind 0, NIP-24, NIP-39)
///
/// Maps to Cesium+ profile fields for migration:
///   C+ title      → name
///   C+ description → about
///   C+ city        → city (custom field in content)
///   C+ avatar      → picture (URL) or picture64 (base64 fallback)
///   C+ socials     → website, nip05, i-tags (NIP-39)
///   C+ geoPoint    → geo tag
///
/// UPlanet identity tags (NIP-39 "i" tags from nostr_setup_profile.py):
///   g1pub, email, zencard, ipfs_gw, ipns_vault, tw_feed,
///   github, twitter, mastodon, telegram,
///   umap_cid, usat_cid, umap_full_cid, usat_full_cid, umaproot, umap_updated
class NostrProfile {
  NostrProfile({
    required this.npub,
    required this.name,
    this.displayName,
    this.about,
    this.picture,
    this.banner,
    this.picture64,
    this.nip05,
    this.website,
    this.city,
    this.socials,
    // UPlanet identity (NIP-39 "i" tags)
    this.g1pub,
    this.g1v2,
    this.email,
    this.zencard,
    this.ipfsGw,
    this.ipnsVault,
    this.twFeed,
    this.github,
    this.twitter,
    this.mastodon,
    this.telegram,
    // UMAP image CIDs (NIP-39 "i" tags)
    this.umapCid,
    this.usatCid,
    this.umapFullCid,
    this.usatFullCid,
    this.umaproot,
    this.umapUpdated,
  });

  /// Parse from a kind 0 event's content JSON + tags
  factory NostrProfile.fromEventContent(
      String contentJson, String npub, List<List<String>>? tags) {
    final Map<String, dynamic> json =
        jsonDecode(contentJson) as Map<String, dynamic>;

    // Extract identity fields from NIP-39 "i" tags
    final Map<String, String> iTags = <String, String>{};
    if (tags != null) {
      for (final List<String> tag in tags) {
        if (tag.length >= 2 && tag[0] == 'i') {
          final String val = tag[1];
          final int colonIdx = val.indexOf(':');
          if (colonIdx > 0) {
            iTags[val.substring(0, colonIdx)] = val.substring(colonIdx + 1);
          }
        }
      }
    }

    // Parse socials from content if present
    List<Map<String, String>>? socials;
    if (json['socials'] != null) {
      socials = (json['socials'] as List<dynamic>)
          .map((dynamic s) =>
              Map<String, String>.from(s as Map<dynamic, dynamic>))
          .toList();
    }

    return NostrProfile(
      npub: npub,
      name: (json['name'] as String?) ?? '',
      displayName: json['display_name'] as String?,
      about: json['about'] as String?,
      // Normalize URLs: fix double-slashes in path introduced by some IPFS
      // gateways (e.g. https://ipfs.example.com//ipfs/Qm...).
      // Preserve the protocol prefix "://" unchanged.
      picture: _normalizeUrl(json['picture'] as String?),
      banner: _normalizeUrl(json['banner'] as String?),
      picture64: json['picture64'] as String?,
      nip05: json['nip05'] as String?,
      website: json['website'] as String?,
      city: json['city'] as String?,
      socials: socials,
      // NIP-39 identity tags (content field takes priority over i-tag)
      g1pub: json['g1pub'] as String? ?? iTags['g1pub'],
      g1v2: json['g1v2'] as String? ?? iTags['g1v2'],
      email: iTags['email'],
      zencard: iTags['zencard'],
      ipfsGw: iTags['ipfs_gw'],
      ipnsVault: iTags['ipns_vault'],
      twFeed: iTags['tw_feed'],
      github: iTags['github'],
      twitter: iTags['twitter'],
      mastodon: iTags['mastodon'],
      telegram: iTags['telegram'],
      // UMAP CIDs
      umapCid: iTags['umap_cid'],
      usatCid: iTags['usat_cid'],
      umapFullCid: iTags['umap_full_cid'],
      usatFullCid: iTags['usat_full_cid'],
      umaproot: iTags['umaproot'],
      umapUpdated: iTags['umap_updated'],
    );
  }

  // NIP-01 / NIP-24 metadata (stored in event content JSON)
  final String npub;
  final String name;
  final String? displayName;
  final String? about;
  final String? picture;
  final String? banner;
  final String? picture64;
  final String? nip05;
  final String? website;
  final String? city;
  final List<Map<String, String>>? socials;

  // UPlanet identity (NIP-39 "i" tags from nostr_setup_profile.py)
  final String? g1pub;
  final String? g1v2; // Duniter v2 SS58 address
  final String? email;
  final String? zencard;
  final String? ipfsGw;
  final String? ipnsVault;
  final String? twFeed;
  final String? github;
  final String? twitter;
  final String? mastodon;
  final String? telegram;

  // UMAP image CIDs
  final String? umapCid;
  final String? usatCid;
  final String? umapFullCid;
  final String? usatFullCid;
  final String? umaproot;
  final String? umapUpdated;

  /// Serialize to NIP-01 kind 0 content JSON
  Map<String, dynamic> toContentJson() {
    return <String, dynamic>{
      'name': name,
      if (displayName != null) 'display_name': displayName,
      if (about != null) 'about': about,
      if (picture != null) 'picture': picture,
      if (banner != null) 'banner': banner,
      // N'inclure picture64 (base64) QUE si pas d'URL IPFS disponible.
      // Les relays strfry rejettent les events > ~65KB ;
      // un avatar base64 peut dépasser 280KB.
      if (picture64 != null && (picture == null || picture!.isEmpty))
        'picture64': picture64,
      if (nip05 != null) 'nip05': nip05,
      if (website != null) 'website': website,
      if (g1pub != null) 'g1pub': g1pub,
      if (g1v2 != null) 'g1v2': g1v2,
      if (city != null) 'city': city,
      if (socials != null && socials!.isNotEmpty) 'socials': socials,
      'bot': false,
    };
  }

  /// Build all NIP-39 "i" identity tags for the event
  List<List<String>> toIdentityTags() {
    final List<List<String>> tags = <List<String>>[];
    void addTag(String key, String? value) {
      if (value != null && value.isNotEmpty) {
        tags.add(<String>['i', '$key:$value', '']);
      }
    }

    addTag('g1pub', g1pub);
    addTag('g1v2', g1v2);
    addTag('email', email);
    addTag('zencard', zencard);
    addTag('ipfs_gw', ipfsGw);
    addTag('ipns_vault', ipnsVault);
    addTag('tw_feed', twFeed);
    addTag('github', github);
    addTag('twitter', twitter);
    addTag('mastodon', mastodon);
    addTag('telegram', telegram);
    addTag('umap_cid', umapCid);
    addTag('usat_cid', usatCid);
    addTag('umap_full_cid', umapFullCid);
    addTag('usat_full_cid', usatFullCid);
    addTag('umaproot', umaproot);
    addTag('umap_updated', umapUpdated);
    return tags;
  }

  NostrProfile copyWith({
    String? name,
    String? displayName,
    String? about,
    String? picture,
    String? banner,
    String? picture64,
    String? nip05,
    String? website,
    String? g1pub,
    String? g1v2,
    String? city,
    List<Map<String, String>>? socials,
    String? email,
    String? zencard,
    String? ipfsGw,
    String? ipnsVault,
    String? twFeed,
    String? github,
    String? twitter,
    String? mastodon,
    String? telegram,
    String? umapCid,
    String? usatCid,
    String? umapFullCid,
    String? usatFullCid,
    String? umaproot,
    String? umapUpdated,
  }) {
    return NostrProfile(
      npub: npub,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      about: about ?? this.about,
      picture: picture ?? this.picture,
      banner: banner ?? this.banner,
      picture64: picture64 ?? this.picture64,
      nip05: nip05 ?? this.nip05,
      website: website ?? this.website,
      g1pub: g1pub ?? this.g1pub,
      g1v2: g1v2 ?? this.g1v2,
      city: city ?? this.city,
      socials: socials ?? this.socials,
      email: email ?? this.email,
      zencard: zencard ?? this.zencard,
      ipfsGw: ipfsGw ?? this.ipfsGw,
      ipnsVault: ipnsVault ?? this.ipnsVault,
      twFeed: twFeed ?? this.twFeed,
      github: github ?? this.github,
      twitter: twitter ?? this.twitter,
      mastodon: mastodon ?? this.mastodon,
      telegram: telegram ?? this.telegram,
      umapCid: umapCid ?? this.umapCid,
      usatCid: usatCid ?? this.usatCid,
      umapFullCid: umapFullCid ?? this.umapFullCid,
      usatFullCid: usatFullCid ?? this.usatFullCid,
      umaproot: umaproot ?? this.umaproot,
      umapUpdated: umapUpdated ?? this.umapUpdated,
    );
  }
}
