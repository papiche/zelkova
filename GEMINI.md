# 🌳 Ẑelkova (ẐEN MULTIPASS Wallet)

Ẑelkova is a cross-platform, non-custodial wallet specialized for the **ẐEN MULTIPASS** (UPlanet ecosystem). It is an independent fork of Ginkgo, optimized for NOSTR identities and ẐEN payments on the Duniter V2 (Substrate) network.

## 🚀 Project Overview

- **Purpose**: Manage ZEN MULTIPASS identities (NOSTR kind 0/3) and perform ZEN transfers.
- **Ecosystem**: UPlanet / Astroport.ONE.
- **Platforms**: Android (APK), iOS, Web (PWA), and Linux Desktop.
- **Key Features**:
  - NOSTR-based identity and social following.
  - Duniter V2 (Substrate) integration for ZEN transfers.
  - P2P APK sharing (Wi-Fi local).
  - Integrated feedback system via GitHub API.
  - Offline-first capabilities with local database (Hive).

## 🛠 Technical Stack

- **Framework**: Flutter 3.19+ (Dart SDK ^3.8.0).
- **State Management**: `flutter_bloc` with `hydrated_bloc` for persistence.
- **Dependency Injection**: `get_it` for singleton management.
- **Data Persistence**: `hive_ce` (Hive Community Edition) and `shared_preferences`.
- **Blockchain**: `polkadart` (Duniter V2 / Substrate) and `ferry` (GraphQL for Indexer).
- **Identity & Social**: `web_socket_channel` for NOSTR relay integration.
- **Localization**: `easy_localization` (supports FR, EN, DE, ES, EO, etc.).
- **Error Tracking**: `sentry_flutter`.
- **Environment**: `envied` for secure `.env` management.

## 🏗 Building and Running

### Prerequisites
- Flutter SDK installed and configured.
- A `.env` file (copied from `dot.env.sample`).

### Development Commands
- **Install dependencies**:
  ```bash
  flutter pub get
  ```
- **Code Generation** (Required for JSON serialization, Envied, and Bloc):
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- **Run the app**:
  ```bash
  flutter run                  # Default device
  flutter run -d chrome        # Web/PWA
  flutter run -d linux         # Linux Desktop
  ```
- **Run tests**:
  ```bash
  flutter test
  ```

### Build Commands
- **Android APK**:
  ```bash
  flutter build apk --release
  ```
- **Web (PWA)**:
  ```bash
  flutter build web --release
  ```
- **Linux**:
  ```bash
  flutter build linux --release
  ```

## 📏 Development Conventions

- **State Management**: Use **Cubit/Bloc** for all business logic. UI should be reactive to state changes.
- **Typing**: The project enforces strict typing (`always_specify_types`). Always declare return types and parameter types.
- **Dependency Injection**: Register and retrieve services/blocs via `GetIt.instance`.
- **Localization**: Use `tr('key')` from `easy_localization`. Add new keys to `assets/translations/*.json`.
- **Asynchronous Code**: Prefer `unawaited` for fire-and-forget tasks and proper `try-catch` blocks for critical I/O.
- **Styling**: Adhere to the defined theme (Violet/Green/Gold) using `Theme.of(context).colorScheme`.
- **Persistence**: Use `HydratedCubit` for state that needs to survive app restarts.

## 📁 Key Directories
- `lib/data/models`: Data structures and Cubit states (mostly generated).
- `lib/g1`: Duniter/ZEN specific logic and NOSTR services.
- `lib/ui`: UI components, screens, and widgets.
- `landing`: Python FastAPI server for feedback relay and landing page.
- `packages/`: Local packages for Duniter Indexer and Datapod.
