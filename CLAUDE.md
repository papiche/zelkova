# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ğ1nkgo (Ginkgo) is a Flutter wallet app for the Ğ1 (Duniter v2) cryptocurrency. It targets Android, Linux desktop, and web. Licensed AGPL v3.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app (prompts for target platform)
flutter run

# Run all unit tests
flutter test

# Run a single test file
flutter test test/g1_test.dart

# Build for web
flutter build web --no-tree-shake-icons

# Build for Android (release)
flutter build appbundle --release

# Build Linux + Debian package
./build.sh linux

# Code generation (env vars, JSON serialization, Hive adapters, Ferry GraphQL)
dart run build_runner build --delete-conflicting-outputs

# Lint/analyze
dart analyze

# Integration tests (requires Patrol CLI)
patrol test
patrol test integration_test/app_smoke_test.dart
```

## Environment Setup

Copy `dot.env.sample` to `.env` (production) and `.env.dev` (development). After changing env files, run `build_runner` and possibly `flutter clean` to clear cached values. The `Env` class in `lib/env.dart` uses `envied` to generate `env.g.dart`.

## Architecture

### State Management: BLoC/Cubit with Hydrated Persistence

All state is managed via **BLoC/Cubit** pattern (`flutter_bloc` + `hydrated_bloc`). Cubits persist state automatically via Hive. Key cubits:

- `AppCubit` (`lib/data/models/app_cubit.dart`) - global app state (current wallet, accounts, settings)
- `ContactCubit` (`lib/data/models/contact_cubit.dart`) - contact list and search
- `PaymentCubit` (`lib/data/models/payment_cubit.dart`) - payment flow state
- `NodeListCubit` (`lib/data/models/node_list_cubit.dart`) - duniter node management
- `TransactionsBloc` (`lib/data/models/transactions_bloc.dart`) - transaction history
- `BottomNavCubit` (`lib/data/models/bottom_nav_cubit.dart`) - navigation tab state

States use `json_serializable` + `copy_with_extension` for serialization (`.g.dart` files).

### Screen Navigation

`SkeletonScreen` (`lib/ui/screens/skeleton_screen.dart`) hosts 5 tabs via `BottomNavBar`:
1. **FirstScreen** - wallet card, pay/receive actions
2. **SecondScreen** - POS terminal (QR generation)
3. **ThirdScreen** - contacts
4. **FourthScreen** - transaction history & balance chart
5. **FifthScreen** - settings, import/export, node list

### Network Layer (`lib/g1/`)

- `DuniterService` (`service_manager.dart`) - abstract interface for all network operations
- `g1_v2_helper.dart` - Duniter v2 substrate RPC interactions via `polkadart`
- `duniter_indexer_helper.dart` - GraphQL queries to Duniter indexer (via `ferry`)
- `duniter_datapod_helper.dart` - profile/avatar storage via datapod
- `duniter_endpoint_helper.dart` - node discovery and health checking
- `sign_and_send.dart` - transaction signing and submission
- `transactions_v2_parser.dart` - parsing transaction data from indexer

### Local Packages (`packages/`)

- `duniter_indexer` - Ferry GraphQL client for Duniter Squid indexer
- `duniter_datapod` - Ferry GraphQL client for datapod (profiles/avatars)

### Generated Code (`lib/generated/`)

- `lib/generated/g1/` and `lib/generated/gtest/` - Polkadart-generated substrate chain types (from `polkadart_cli`)
- Excluded from analysis in `analysis_options.yaml`

### Code Generation

Multiple generators run via `build_runner`:
- `json_serializable` → `*.g.dart` model serialization
- `copy_with_extension_gen` → copyWith methods
- `envied_generator` → `env.g.dart` from `.env` files
- `ferry_generator` → GraphQL types (in local packages)
- `hive_ce_generator` → Hive type adapters
- `polkadart_cli` → substrate chain types (configured in `pubspec.yaml` under `polkadart:`)

### Localization

Uses `easy_localization` with JSON files in `assets/translations/`. Translation keys are used throughout the UI. Translations managed via Weblate.

## Lint Configuration

Strict analysis with `strict-casts: true` and `strict-raw-types: true`. Always use `always_specify_types`. Prefer single quotes. `*.g.dart` files and `lib/generated/` are excluded from analysis. BLoC lint rules are included via `bloc_lint`.

## Key Conventions

- **Note the merge conflict** in `pubspec.yaml` (lines 41-56) - this needs resolution before builds will work
- Models use `@JsonSerializable()` + `@CopyWith()` annotations with generated `.g.dart` companions
- Platform-specific code uses conditional imports (e.g., `brave_detector.dart` → `_web.dart`/`_stub.dart`)
- Currency is configurable: `g1` (production) or `gtest` (testing network), set via `CURRENCY` env var
- Sentry is used for error reporting (configured in `pubspec.yaml` and `main.dart`)
- `GetIt` is used as service locator alongside BLoC
