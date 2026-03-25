# Analyse de l'application Ginkgo (ginkgo/lib/main.dart)

## 1. Architecture générale

Ginkgo est un portefeuille (wallet) multi-devises pour les cryptomonnaies Ğ1 (Duniter) et ZEN, développé avec Flutter. L'application suit une architecture basée sur le pattern BLoC (Business Logic Component) avec les packages `flutter_bloc` et `hydrated_bloc` pour la gestion d'état persistante.

### Structure clé :
- **État global** : Géré par plusieurs Cubits (`AppCubit`, `NodeListCubit`, `MultiWalletTransactionCubit`, `PaymentCubit`, `ContactsCubit`, `ThemeCubit`, `BottomNavCubit`)
- **Persistance** : Utilise `HydratedBloc` pour la sérialisation automatique, `Hive` pour le stockage local, et `SharedPreferences` pour les préférences
- **Services** : `ServiceManager`, `NostrRelayService`, `ZenTagService`, `BackgroundWalletSyncService`
- **UI** : Widgets Flutter avec `ResponsiveFramework` pour l'adaptabilité multi-plateforme

## 2. Fonctionnalités principales

### 2.1 Gestion multi-wallets
- Support de plusieurs portefeuilles simultanés (multi-wallet)
- Synchronisation en arrière-plan via `WorkManager` (Android/iOS)
- Import/export de clés et mnémoniques
- Support des clés Duniter V1 (base58) et V2 (Substrate/Polkadot)

### 2.2 Connexion aux réseaux Ğ1
- **Mode V1** : Connexion aux nœuds Cesium+ (obsolète, maintenu pour compatibilité)
- **Mode V2** : Connexion aux endpoints Duniter V2 (Substrate) - **forcé par défaut** depuis la ligne 755 de `main.dart`
- Gestion des nœuds par type (`NodeType.cesiumPlus`, `NodeType.endpoint`, `NodeType.duniterIndexer`, `NodeType.datapod`)
- Système de rechargement périodique des nœuds (tâches `Once.runHourly`)

### 2.3 Fonctionnalités sociales et Web of Trust
- Gestion de contacts avec cache (`ContactsCache`)
- Intégration NOSTR pour les profils et listes de contacts (kind 0 et 3)
- Service de tags ZEN pour l'isolation des écosystèmes (`:ZEN:XXXXXXXX`)
- Calcul de distance dans le Web of Trust (`DistancePrecompute`)

### 2.4 Sécurité et authentification
- Authentification biométrique (`BiometricAuthService`)
- Verrouillage automatique après inactivité (`AppLifecycleReactor`)
- Stockage sécurisé via `flutter_secure_storage` pour V2
- Gestion des clés privées avec `bip32_ed25519` et `sr25519`

### 2.5 Internationalisation et accessibilité
- Support de 13 langues (espagnol, catalan, danois, allemand, anglais, espéranto, basque, français, galicien, italien, néerlandais, portugais)
- Localisation via `easy_localization`
- Thèmes clair/sombre avec `ThemeCubit`
- Interface responsive adaptée mobile/tablette/desktop

### 2.6 Tâches en arrière-plan
- Synchronisation périodique des transactions (`fetchWalletsTransactionsTask` toutes les 16 minutes)
- Nettoyage quotidien du cache et des erreurs
- Pré-calcul des distances horaire
- Notifications locales (`awesome_notifications`)

## 3. Technologies et dépendances clés

### 3.1 Gestion d'état et architecture
- `flutter_bloc` + `hydrated_bloc` : Gestion d'état avec persistance
- `provider` : Injection de dépendances
- `get_it` : Service locator pattern

### 3.2 Cryptographie et blockchain
- `polkadart` + `polkadart_keyring` : Interaction avec Substrate (Duniter V2)
- `bip32_ed25519`, `sr25519`, `bip340` : Signatures et dérivation de clés
- `duniter_datapod` (package local) : Client GraphQL pour Duniter
- `duniter_indexer` (package local) : Indexation des transactions

### 3.3 Stockage et persistance
- `hive_ce_flutter` : Base de données NoSQL locale
- `shared_preferences` : Préférences utilisateur
- `ferry` + `ferry_hive_ce_store` : Cache GraphQL

### 3.4 UI/UX
- `responsive_framework` : Layout adaptatif
- `introduction_screen` : Tutoriel d'introduction
- `filesystem_picker` : Sélection de fichiers
- `emoji_picker_flutter` : Sélection d'émojis pour les paiements
- `flutter_svg` : Support SVG

### 3.5 Communication réseau
- `http` : Requêtes HTTP standard
- `web_socket_channel` : Connexions WebSocket (NOSTR)
- `connectivity_wrapper` : Détection de connectivité

## 4. Possibilités inexploitées et améliorations potentielles

### 4.1 Intégration NOSTR sous-utilisée
- **État actuel** : Le service `NostrRelayService` est initialisé mais seulement si une clé NOSTR (`nsec`) existe dans `SharedPreferencesHelperV2`
- **Potentiel inexploité** :
  - Publication automatique des profils (kind 0)
  - Synchronisation des contacts via kind 3
  - Abonnements à des relays multiples
  - Support des événements de paiement (NIP-XX)
- **Amélioration** : Intégration complète du social graph NOSTR pour découvrir des contacts et partager des informations de profil

### 4.2 Mode V2 forcé sans sélection réseau
- **État actuel** : Le mode V2 est forcé en permanence (ligne 755 : `_forceV2Mode()`), désactivant la détection automatique de G1
- **Potentiel inexploité** : L'ancien système de détection automatique G1/gtest (commenté lignes 651-739) pourrait être réactivé pour permettre le basculement entre réseaux de test et production
- **Amélioration** : Interface utilisateur pour sélectionner manuellement le réseau (G1 production vs gtest)

### 4.3 IPFS et stockage décentralisé
- **État actuel** : Configuration des gateways IPFS dans `Env.ipfsGateways` mais utilisation limitée
- **Potentiel inexploité** :
  - Stockage décentralisé d'avatars et métadonnées de profil
  - Partage de documents via IPFS
  - Intégration avec IPNS pour des profils actualisables
- **Amélioration** : Service IPFS natif pour upload/téléchargement de médias

### 4.4 Fonctionnalités PWA avancées
- **État actuel** : `PWAInstall` configuré mais utilisation basique
- **Potentiel inexploité** :
  - Installation progressive (PWA) avec cache offline
  - Synchronisation en arrière-plan via Service Workers
  - Notifications push cross-platform
- **Amélioration** : Optimisation pour une expérience web app-like complète

### 4.5 Analytics et monitoring
- **État actuel** : Sentry configuré mais désactivé (`enableSentry = false` ligne 379)
- **Potentiel inexploité** :
  - Télémétrie anonyme des performances
  - Suivi des erreurs en production
  - Analytics d'utilisation pour améliorer l'UX
- **Amélioration** : Activer Sentry en production avec consentement utilisateur

### 4.6 Intégration UPassport
- **État actuel** : URL UPassport configurée dans `Env.upassportUrl` mais utilisation limitée
- **Potentiel inexploité** :
  - Authentification décentralisée via UPassport
  - Portefeuille d'identités vérifiables
  - Signature de documents avec clés Duniter
- **Amélioration** : Intégration complète du protocole UPassport pour l'identité numérique

### 4.7 Multidevice et synchronisation
- **État actuel** : Synchronisation locale uniquement, pas de sync cross-device
- **Potentiel inexploité** :
  - Synchronisation chiffrée via NOSTR ou IPFS
  - Backup cloud sécurisé
  - Récupération multi-appareil
- **Amélioration** : Système de synchronisation E2E chiffrée utilisant NOSTR comme transport

### 4.8 Fonctionnalités DeFi et smart contracts
- **État actuel** : Portefeuille basique de transactions
- **Potentiel inexploité** :
  - Interaction avec smart contracts Substrate
  - Staking et gouvernance
  - Échanges décentralisés (DEX)
  - Prêts et emprunts
- **Amélioration** : Module DeFi intégré pour l'écosystème Ğ1

### 4.9 Code mort et fonctionnalités commentées
- **Détection automatique G1** : Code commenté lignes 651-739 (ancien système de polling)
- **Feedback UI** : Commenté lignes 1083-1100 (problème de thème)
- **Sentry** : Désactivé en production
- **PDF generation** : Dépendance `pdf` commentée (incompatible WASM)

## 5. Points techniques à améliorer

### 5.1 Gestion des erreurs réseau
- Les reconnections WebSocket NOSTR sont implémentées mais pourraient être plus robustes
- Pas de stratégie de fallback pour les nœuds hors service

### 5.2 Performance
- Chargement initial lourd avec initialisation multiple de services
- Cache Hive pourrait être optimisé (voir `_clearCacheIfNeeded`)

### 5.3 Sécurité
- Stockage des clés : V2 utilise `flutter_secure_storage` mais V1 utilise `SharedPreferences`
- Authentification biométrique : dépend de `local_auth` avec limitations cross-platform

### 5.4 Tests et qualité
- Présence de tests d'intégration (`integration_test/`) et unitaires
- Mais couverture limitée des services complexes (NOSTR, synchronisation)

## 6. Conclusion

Ginkgo est une application Flutter mature et bien architecturée qui sert de portefeuille complet pour l'écosystème Ğ1. Son codebase montre une évolution vers Duniter V2 (Substrate) avec abandon progressif du legacy V1.

**Points forts** :
- Architecture BLoC propre avec persistance Hydrated
- Support multi-plateforme (mobile, web, desktop)
- Internationalisation étendue
- Tâches en arrière-plan robustes
- Intégration avec l'écosystème Ğ1 (NOSTR, UPassport, ZEN)

**Opportunités d'amélioration** :
1. Exploiter pleinement l'intégration NOSTR pour un réseau social décentralisé
2. Réactiver la sélection réseau (test/production) avec UI adaptée
3. Développer les fonctionnalités IPFS pour le stockage décentralisé
4. Implémenter la synchronisation multi-appareils
5. Activer les analytics Sentry pour le monitoring production

L'application a une base solide pour évoluer vers un "super-app" de l'écosystème Ğ1, intégrant portefeuille, identité, social et DeFi dans une interface unifiée.