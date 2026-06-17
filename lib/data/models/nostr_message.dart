import 'package:flutter/material.dart';

/// Represents a decrypted NIP-44 encrypted direct message (kind 4).
@immutable
class NostrMessage {
  const NostrMessage({
    required this.id,
    required this.senderHex,
    required this.recipientHex,
    required this.content,
    required this.createdAt,
    this.pending = false,
  });

  final String id;
  final String senderHex;
  final String recipientHex;
  final String content;
  final int createdAt; // unix timestamp (seconds)
  final bool pending;  // optimistic UI: sent but not yet confirmed by relay

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);

  bool isFromMe(String myHexPubkey) => senderHex == myHexPubkey;

  /// Returns the OTHER party's hexPubkey relative to [myHex].
  String peerHex(String myHex) =>
      senderHex == myHex ? recipientHex : senderHex;

  NostrMessage copyWith({bool? pending}) => NostrMessage(
        id: id,
        senderHex: senderHex,
        recipientHex: recipientHex,
        content: content,
        createdAt: createdAt,
        pending: pending ?? this.pending,
      );

  @override
  bool operator ==(Object other) =>
      other is NostrMessage && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Represents a single conversation with a peer.
@immutable
class NostrConversation {
  const NostrConversation({
    required this.peerHex,
    required this.lastMessage,
    this.peerName,
    this.peerPicture,
    this.unreadCount = 0,
  });

  final String peerHex;
  final NostrMessage lastMessage;
  final String? peerName;
  final String? peerPicture;
  final int unreadCount;

  NostrConversation copyWith({
    String? peerName,
    String? peerPicture,
    int? unreadCount,
    NostrMessage? lastMessage,
  }) {
    return NostrConversation(
      peerHex: peerHex,
      lastMessage: lastMessage ?? this.lastMessage,
      peerName: peerName ?? this.peerName,
      peerPicture: peerPicture ?? this.peerPicture,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
