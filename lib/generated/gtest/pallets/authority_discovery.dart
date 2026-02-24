// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/sp_authority_discovery/app/public.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<_i3.Public>> _keys =
      const _i2.StorageValue<List<_i3.Public>>(
    prefix: 'AuthorityDiscovery',
    storage: 'Keys',
    valueCodec: _i4.SequenceCodec<_i3.Public>(_i3.PublicCodec()),
  );

  final _i2.StorageValue<List<_i3.Public>> _nextKeys =
      const _i2.StorageValue<List<_i3.Public>>(
    prefix: 'AuthorityDiscovery',
    storage: 'NextKeys',
    valueCodec: _i4.SequenceCodec<_i3.Public>(_i3.PublicCodec()),
  );

  /// Keys of the current authority set.
  _i5.Future<List<_i3.Public>> keys({_i1.BlockHash? at}) async {
    final hashedKey = _keys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _keys.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Keys of the next authority set.
  _i5.Future<List<_i3.Public>> nextKeys({_i1.BlockHash? at}) async {
    final hashedKey = _nextKeys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextKeys.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `keys`.
  _i6.Uint8List keysKey() {
    final hashedKey = _keys.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextKeys`.
  _i6.Uint8List nextKeysKey() {
    final hashedKey = _nextKeys.hashedKey();
    return hashedKey;
  }
}
