# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Ẑelkova is a Flutter cross-platform wallet for the **ẐEN MULTIPASS** (UPlanet ecosystem). It is a fork of Ginkgo, specialised for NOSTR identities and ẐEN payments on Duniter V2 (Substrate).

## Setup

```bash
cp dot.env.sample .env          # configure endpoints, UPassport URL, NOSTR relay
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs   # required: generates env.g.dart, *.g.dart, ferry GQL types
```

Code generation must be re-run after any change to `.env`, Hive model annotations, `@JsonSerializable` classes, or Ferry GraphQL schemas.

Two env files are used: `.env` (release/production) and `.env.dev` (debug/development). The `Env` class (`lib/env.dart`) reads them at build time via `envied`.

## Commands

```bash
flutter run                                          # default device
flutter run -d chrome                               # web PWA
flutter run -d linux                                # Linux desktop
flutter test                                        # all tests
flutter test test/g1_v2_helper_test.dart            # single test file

./build_apk.sh [debug|release] [development|production]   # APK build
./build_web_ipfs.sh [debug|release|profile] [development|production] [--clean]  # web for IPFS

# Landing server (feedback relay, landing page)
cd landing && pip install -r requirements.txt && python server.py
```

For the APK release build, `android/key.properties` and `android/upload-keystore.jks` are required. `build_apk.sh` auto-generates a dev keystore if missing.

## Architecture

### `lib/` structure

| Path | Role |
|------|------|
| `lib/main.dart` | App bootstrap: Hive init, GetIt DI registration, HydratedBloc storage, NOSTR relay connect, WorkManager setup |
| `lib/env.dart` | Typed env config via `envied` (endpoints, API URLs, genesis hash) |
| `lib/g1/` | All blockchain + NOSTR logic (see below) |
| `lib/data/models/` | Cubit/Bloc state classes + Hive models (many are code-generated `*.g.dart`) |
| `lib/data/repository/` | Data access layer |
| `lib/services/` | App-level services: `background_wallet_sync_service.dart`, `feedback_service.dart`, `upassport_api_service.dart`, etc. |
| `lib/ui/screens/` | 5 main screens (`first_screen` through `fifth_screen`) + wallet creation, APK share, feedback, node list |
| `lib/ui/widgets/` | Reusable widgets |

### `lib/g1/` — Blockchain + NOSTR core

- **`multipass_service.dart`** — Calls UPassport `/g1nostr` to create/fetch MULTIPASS (NOSTR identity). Returns `MultipassResponse` with `nsec`, `g1pub`, `npub`, `ssssPlayer`, etc.
- **`zen_tag_service.dart`** — Manages the `:ZEN:XXXXXXXX` address suffix that isolates Ẑelkova wallets within a constellation. Derived from `UPLANETNAME_G1` (cooperative central wallet pubkey). Must be stripped before payment via `extractPublicKey()`.
- **`service_manager.dart`** — `DuniterService` abstract interface with `DuniterServiceV2` implementation routing to `duniter_indexer_helper.dart` and `duniter_endpoint_helper.dart`.
- **`g1_v2_helper.dart`** / **`sign_and_send.dart`** — Duniter V2 (Substrate/polkadart) transaction signing and submission.
- **`nostr/`** — NOSTR relay connection (`nostr_relay_service.dart`), profile publish/fetch (`nostr_profile.dart`), key utilities (`nostr_keys.dart`, `nostr_utils.dart`), station economy events (`station_economy_event.dart`).
- **`crypto/`** — Low-level Ed25519/Schnorrkel cryptography, Cesium wallet, key derivation.

### State management

Strict Bloc/Cubit pattern throughout. Key cubits:
- `AppCubit` / `AppState` — global wallet state, account lifecycle
- `PaymentCubit` / `PaymentState` — payment flow
- `ContactCubit` / `ContactState` — WoT contacts
- `NodeListCubit` — Duniter node selection
- `TransactionsBloc` — transaction history

`HydratedCubit` persists state across restarts. GetIt (`lib/g1/service_manager.dart`, `main.dart`) manages singletons.

### Local packages

- `packages/duniter_indexer/` — Ferry GraphQL client for Squid indexer (history, WoT, profiles). Has its own `build.yaml` for Ferry codegen.
- `packages/duniter_datapod/` — Ferry GraphQL client for DataPod (advanced certifications).

### Messagerie NIP-44 (DM chiffrés)

La messagerie privée n'utilise **pas** de Bloc/Cubit — les écrans appellent directement le singleton `NostrRelayService`.

| Fichier | Rôle |
|---------|------|
| `lib/g1/nostr/nip44.dart` | Chiffrement NIP-44 v2 : ECDH secp256k1 → HKDF-SHA256 → ChaCha20 + HMAC-SHA256 + padding |
| `lib/g1/nostr/nostr_relay_service.dart` | Singleton WebSocket — `subscribeToDms`, `fetchNip44Messages`, `sendNip44Message`, broadcast constellation |
| `lib/data/models/nostr_message.dart` | `NostrMessage` (id, sender, recipient, content, createdAt, pending) + `NostrConversation` |
| `lib/ui/screens/messages_screen.dart` | Liste des conversations, chargement parallèle via `Future.wait` |
| `lib/ui/screens/chat_screen.dart` | Chat 1:1, optimistic UI (`pending: true`), images chiffrées, emoji picker |
| `lib/ui/screens/bro_screen.dart` | Chat IA daemon station via NIP-44 (commandes `#mem`, `#rec`, `#reset`…) |
| `lib/ui/screens/love_screen.dart` | Canal matchmaking via NIP-44 (payload JSON `{channel, action}`) |
| `lib/ui/widgets/encrypted_image_bubble.dart` | Bulle image UENC — cache mémoire par CID, miniature async, plein écran |
| `lib/services/encrypted_file_service.dart` | Format UENC v1 (AES-256-GCM) — upload via UPassport `/api/fileupload/encrypted`, download IPFS |

**Flux NIP-44 :**
1. `subscribeToDms` filtre `kind=4, #p=[myPub], since=now` — live uniquement
2. `fetchNip44Messages` fait deux queries parallèles (envoyés + reçus), déchiffre, trie par `createdAt`
3. Les images chiffrées sont encapsulées dans le contenu NIP-44 comme JSON `{"_uenc_img": {cid, enc_key, enc_type, iv, filename, title, caption}}`
4. Le broadcast constellation (relays issus de kind-30850) est fire-and-forget après publication sur le relay principal

**Points critiques :**
- `NostrRelayService.sendNip44Message` signe avec `_signEvent` qui utilise `Random.secure()` pour l'auxRand BIP-340
- `_disconnectInternal()` préserve `_reconnectAttempts` (backoff 2→4→8→16→32s) ; `forceDisconnect()` le remet à 0
- Déduplication live dans `_subscribeLive` : vérifier `m.id == msg.id` (pas le content) pour les optimistes
- `fetchNip44Messages(limit: N)` divise par 2 chaque query — toujours passer `limit ≥ 2`

### `landing/` — Python FastAPI server

Serves the landing page and relays feedback to GitHub Issues via `GITHUB_TOKEN`. Separate from the main Flutter app.

## Key conventions

- **Strict typing**: `always_specify_types` is enforced — always declare explicit types including return types.
- **Bloc lint**: `bloc_lint/recommended.yaml` is active — no Flutter imports in Blocs, no business logic in widgets.
- **ZEN tag**: Never display or store a bare G1 pubkey when a `:ZEN:` suffix is expected. Always call `ZenTagService.extractPublicKey()` before payment.
- **MULTIPASS fields**: `ssss_player` is stored under the key `ssss` in the API response for backwards compat — `MultipassResponse.fromJson` accepts both.
- **Flavors**: `development` enables sandbox + verbose logs; `production` disables them. Pass via `--dart-define=FLUTTER_FLAVOR=production`.
- **Generated files**: `lib/data/models/*.g.dart` and `lib/generated/**` are excluded from linting. Do not edit them manually.
- **No Co-Authored-By** in commits (per workspace CLAUDE.md).
