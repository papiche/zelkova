/// A "raccourci love" — a shortcut to a peer's LOVE identity (HEX_LOVE),
/// exchanged by QR code, used to send Ğ1-N² "love ♥" via kind 7 and to
/// publish a reciprocal kind-3 follow signed by the LOVE key (see
/// [LoveContactsService.publishLoveFollowList] in
/// `lib/services/love_contacts_service.dart`).
///
/// Not JSON-serializable via code generation (no build_runner step) — plain
/// manual toJson/fromJson to keep this feature self-contained.
class LoveContact {
  const LoveContact({
    required this.hexLove,
    required this.nickname,
    required this.addedAt,
    this.photoCid,
    this.photoEncKeyHex,
  });

  /// HEX_LOVE of the peer — the ATOM4LOVE-derived identity, never the
  /// peer's main MULTIPASS hex.
  final String hexLove;
  final String nickname;
  final int addedAt;

  /// Encrypted (UENC) photo on IPFS, taken at contact-add time — both null
  /// if no photo was captured.
  final String? photoCid;
  final String? photoEncKeyHex;

  bool get hasPhoto => photoCid != null && photoEncKeyHex != null;

  LoveContact copyWith({
    String? nickname,
    String? photoCid,
    String? photoEncKeyHex,
  }) {
    return LoveContact(
      hexLove: hexLove,
      nickname: nickname ?? this.nickname,
      addedAt: addedAt,
      photoCid: photoCid ?? this.photoCid,
      photoEncKeyHex: photoEncKeyHex ?? this.photoEncKeyHex,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'hex_love': hexLove,
        'nickname': nickname,
        'added_at': addedAt,
        if (photoCid != null) 'photo_cid': photoCid,
        if (photoEncKeyHex != null) 'photo_enc_key': photoEncKeyHex,
      };

  static LoveContact? fromJson(Map<String, dynamic> json) {
    final String? hex = json['hex_love'] as String?;
    if (hex == null || hex.length != 64) {
      return null;
    }
    return LoveContact(
      hexLove: hex,
      nickname: (json['nickname'] as String?) ?? hex.substring(0, 8),
      addedAt: (json['added_at'] as num?)?.toInt() ??
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
      photoCid: json['photo_cid'] as String?,
      photoEncKeyHex: json['photo_enc_key'] as String?,
    );
  }
}
