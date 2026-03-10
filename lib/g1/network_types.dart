// AUTO-GENERATED FILE - DO NOT EDIT
// Generated for network: g1
// Generated at: 2026-03-10 16:22:08.349061
// Run: dart scripts/generate_network_wrapper.dart

import '../env.dart';
import '../generated/g1/g1.dart';

export '../generated/g1/g1.dart'
    show G1, Constants, Queries, Extrinsics, Registry, Rpc;
export '../generated/g1/pallets/certification.dart' hide Queries, Constants;
export '../generated/g1/types/frame_system/account_info.dart';
export '../generated/g1/types/frame_system/event_record.dart';
export '../generated/g1/types/frame_system/pallet/event.dart';
export '../generated/g1/types/frame_system/phase.dart';
export '../generated/g1/types/g1_runtime/runtime_call.dart';
export '../generated/g1/types/pallet_certification/types/idty_cert_meta.dart';
export '../generated/g1/types/pallet_identity/types/idty_value.dart';
export '../generated/g1/types/primitive_types/h256.dart';
export '../generated/g1/types/sp_membership/membership_data.dart';
export '../generated/g1/types/sp_runtime/dispatch_error.dart';
export '../generated/g1/types/sp_runtime/multi_signature.dart';
export '../generated/g1/types/sp_runtime/multiaddress/multi_address.dart';
export '../generated/g1/types/tuples.dart';

// Alias for backward compatibility (code uses Gtest but we provide the correct runtime)
typedef Gtest = G1;

// Genesis hash from .env
String get networkGenesisHash => Env.genesisHash;

// Currency/Network from .env
String get networkCurrency => Env.currency;

// Check if we're on G1 network
bool get isG1Network => Env.currency.toLowerCase() == 'g1';

// Check if we're on gtest network
bool get isGtestNetwork => !isG1Network;
