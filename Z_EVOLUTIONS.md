# Ginkgo Évolutions : Intégration Open Collective, UPassport et NIP-101

## 1. Introduction et Contexte

Ginkgo est actuellement un portefeuille Ğ1 fonctionnel avec architecture BLoC, support multi-plateforme et internationalisation étendue. Cependant, son potentiel est limité par un manque d'intégration avec l'écosystème Astroport en plein développement.

Ce document présente une refonte stratégique de Ginkgo pour en faire la **plateforme centrale de l'écosystème Astroport**, intégrant :
- **Open Collective** : Gestion des contributions et remboursements
- **UPassport API** : Identité souveraine et certifications
- **NIP-101** : Réseau social géolocalisé et système Oracle

## 2. État Actuel de Ginkgo

### 2.1 Points Forts
- Architecture BLoC propre avec persistance Hydrated
- Support multi-plateforme (mobile, web, desktop)
- Internationalisation (13 langues)
- Tâches en arrière-plan robustes (WorkManager)
- Intégration NOSTR basique (`NostrRelayService`)

### 2.2 Limitations Identifiées
1. **NOSTR sous-utilisé** : Connexion uniquement si clé `nsec` existe, pas d'exploitation des kinds NIP-101
2. **Pas d'intégration économique** : Aucun lien avec le modèle ZEN.ECONOMY.v2
3. **Pas de géolocalisation** : Impossible de découvrir les UMAP/SECTOR/REGION voisins
4. **Pas de certifications** : Aucun support du système Oracle NIP-101

### 2.3 Code Existant à Étendre
- `NostrRelayService` (452 lignes) : À étendre pour les kinds 30800, 30500-30503, 30312-30313
- `ZenTagService` : Gestion des tags `:ZEN:XXXXXXXX` déjà présente
- `SharedPreferencesHelperV2` : Stockage des clés NOSTR (`nsec`)
- `Env.resolvedNostrRelay` : Configuration du relay via UPassport URL

## 3. Analyse des Systèmes Existants

### 3.1 Open Collective (OC2UPlanet)
**Scripts principaux** :
- `oc2uplanet.sh` : Interroge l'API GraphQL Open Collective, émet des ẐEN via `UPLANET.official.sh`
- `oc_expense_monitor.sh` : Surveille les dépenses REJECTED et rembourse les ẐEN

**Flux économique** :
```
1€ donation → 1Ẑ crédité
Types de contributions :
- Satellite (128 Go) : 33/33/33/1 → MULTIPASS/RnD/ASSETS/Capitaine
- Constellation (GPU) : Même répartition
- Locataire : Recharge MULTIPASS directe
```

**API GraphQL** : Endpoints `https://api.opencollective.com/graphql/v2` (prod) ou staging
**Authentification** : Token `OCAPIKEY` stocké dans DID NOSTR coopératif (kind 30800)

### 3.2 UPassport API (54321.py)
**Routeurs pertinents pour Ginkgo** :
- `POST /oc_webhook` : Traitement des transactions Open Collective en temps réel
- `GET /check_balance` : Récupération solde Ğ1 et ẐEN
- `POST /zen_send` : Envoi de ẐEN
- `GET /api/permit/*` : Gestion des permis Oracle (NIP-101)
- `GET /api/umap/geolinks` : Géolocalisation UMAP

**Authentification** : NIP-42 (NOSTR) avec challenge-response
**Stockage** : Fichiers locaux `~/.zen/game/nostr/{email}/`

### 3.3 NIP-101 (UPlanet)
**Kinds à supporter** :
- `30800` : DID Documents (W3C Decentralized Identifiers)
- `30500-30503` : Système Oracle (définition, demande, attestation, credential)
- `30312-30313` : ORE Meeting Space & Verification
- Géokeys hiérarchiques : UMAP (0.01°), SECTOR (0.1°), REGION (1.0°)

**Concepts clés** :
- **DIDs** : `did:nostr:<hex_pubkey>` résolvable via NOSTR
- **Permis** : Certification par pairs (ex: PERMIT_ORE_V1)
- **ORE** : Obligations Réelles Environnementales attachées aux cellules géographiques

## 4. Architecture Proposée

### 4.1 Nouveaux Services Dart

```dart
// lib/services/open_collective_service.dart
class OpenCollectiveService {
  Future<List<OCTransaction>> fetchTransactions();
  Future<OCMember> getMemberBySlug(String slug);
  Future<void> emitZen(String email, double amount, String tier);
  Future<void> submitExpense(ExpenseRequest request);
  Stream<ExpenseStatus> monitorExpense(String expenseId);
}

// lib/services/upassport_api_service.dart  
class UPassportApiService {
  Future<BalanceInfo> getBalance(String g1pub);
  Future<ZenCardInfo> getZenCard(String email);
  Future<List<PermitCredential>> getUserPermits(String npub);
  Future<UmapInfo> getNearbyUmaps(double lat, double lon, double radiusKm);
  Future<void> publishDidDocument(DIDDocument doc);
}

// lib/services/nip101_service.dart
class Nip101Service {
  Future<DIDDocument> resolveDid(String did);
  Future<List<PermitDefinition>> getPermitDefinitions();
  Future<PermitRequest> applyForPermit(String permitId, Map evidence);
  Future<void> attestPermit(String applicantPubKey, String permitId);
  Future<List<GeoEvent>> getLocalEvents(GeoQuery query);
}
```

### 4.2 Extension du NostrRelayService Existant

**Modifications dans `lib/g1/nostr/nostr_relay_service.dart`** :
```dart
// Ajouter ces méthodes à la classe existante
Future<List<NostrEvent>> queryEvents({
  List<int>? kinds,
  List<String>? authors,
  String? geohash,
  double? latitude,
  double? longitude,
  double? radiusKm,
  int? since,
  int? until,
  int? limit,
});

Future<DIDDocument?> fetchDidDocument(String pubKey);
Future<void> publishDidDocument(DIDDocument doc);
Future<void> publishPermitRequest(PermitRequest request);
Future<void> publishAttestation(String applicantPubKey, String permitId);
```

### 4.3 Nouveaux Cubits (Gestion d'État)

```dart
// lib/data/models/open_collective_cubit.dart
class OpenCollectiveCubit extends HydratedCubit<OpenCollectiveState> {
  Future<void> loadContributions();
  Future<void> requestConversion(double zenAmount, String iban);
  Future<void> trackExpenseStatus(String expenseId);
}

// lib/data/models/permit_cubit.dart
class PermitCubit extends HydratedCubit<PermitState> {
  Future<void> loadAvailablePermits();
  Future<void> applyForPermit(String permitId, Map evidence);
  Future<void> loadUserCredentials();
  Future<void> renewCredential(String credentialId);
}

// lib/data/models/geo_cubit.dart
class GeoCubit extends HydratedCubit<GeoState> {
  Future<void> detectCurrentLocation();
  Future<List<UmapInfo>> getNearbyUmaps();
  Future<void> joinUmapChat(String umapPubKey);
  Future<void> publishLocalEvent(String content, double lat, double lon);
}
```

### 4.4 Dépendances à Ajouter

**Dans `pubspec.yaml`** :
```yaml
dependencies:
  # Pour les cartes interactives
  flutter_map: ^6.0.0
  latlong2: ^0.9.1  # Déjà présent
  
  # Pour les PDF (factures)
  pdf: ^3.10.2
  printing: ^5.11.2
  
  # Pour les graphiques (dashboard économique)
  fl_chart: ^0.66.0
  
  # Pour les requêtes GraphQL (Open Collective)
  graphql_flutter: ^5.2.0
  
  # Pour la géolocalisation
  geolocator: ^13.0.2  # Déjà présent
  
  # Pour les signatures avancées
  ed25519_edwards: ^0.3.0
```

## 5. Fonctionnalités Détaillées

### 5.1 Portefeuille Économique Astroport

**Interface de conversion ẐEN → €** :
- Formulaire avec montant, IBAN, détails de facturation
- Génération automatique de facture PDF aux normes françaises
- Suivi du statut : `pending` → `submitted` → `approved` → `paid`/`rejected`
- Historique avec export CSV

**Gestion des portefeuilles collectifs** :
- Dashboard avec soldes : `CASH`, `RnD`, `ASSETS`, `IMPOT`
- Visualisation des flux (graphiques circulaires et chronologiques)
- Notifications des redistributions PAF (Paiement pour Autrui Fixe)
- Participation aux décisions via UPassport

### 5.2 Certifications Oracle NIP-101

**Catalogue des permis** :
- Liste des permis disponibles (PERMIT_ORE_V1, etc.)
- Description, exigences, récompenses
- Statut de l'utilisateur (éligible, en attente, certifié)

**Processus de certification** :
1. Consultation des exigences et preuves nécessaires
2. Soumission de demande avec preuves (IPFS, liens)
3. Attestation par pairs existants (notification push)
4. Réception du credential W3C (kind 30503)
5. Affichage du badge NIP-58 dans le profil

**Renouvellement** :
- Notifications 30 jours avant expiration
- Processus simplifié pour les titulaires actuels
- Historique des certifications

### 5.3 Réseau Social Géolocalisé

**Carte interactive** :
- Couches UMAP (1.2 km²), SECTOR (100 km²), REGION (10,000 km²)
- Points d'intérêt : Astroports, jardins partagés, événements
- Filtres par type d'activité

**Chat local** :
- Messagerie NOSTR limitée à la zone géographique
- Support texte, images, voix (NIP-94)
- Modération communautaire
- Historique persistant

**Découverte de voisins** :
- Profils publics avec intérêts communs
- Système de réputation basé sur le Web of Trust
- Événements locaux (réunions, ateliers)

### 5.4 Intégration MULTIPASS Complète

**Scan QR amélioré** :
- Support MULTIPASS, UPassport, DIDs
- Vérification cryptographique
- Ajout automatique aux contacts

**Gestion des identités** :
- Synchronisation avec NOSTR kind 0 (profil) et kind 3 (contacts)
- Support multi-identités (personnelle, professionnelle, associative)
- Export/import via SSSS (Shamir Secret Sharing)

## 6. Roadmap d'Implémentation Détaillée

### Phase 1 : Fondations (Semaines 1-6)

**Semaine 1-2** : Services de base
- [ ] Créer `OpenCollectiveService` avec appel API GraphQL
- [ ] Implémenter `UPassportApiService` avec auth NIP-42
- [ ] Étendre `NostrRelayService` pour les kinds NIP-101
- [ ] Ajouter dépendances `pubspec.yaml`

**Semaine 3-4** : Cubits et état
- [ ] Implémenter `OpenCollectiveCubit`, `PermitCubit`, `GeoCubit`
- [ ] Créer les états correspondants avec persistance Hydrated
- [ ] Connecter aux services existants
- [ ] Tests unitaires (80%+ coverage)

**Semaine 5-6** : UI basique
- [ ] Écrans de test pour chaque service
- [ ] Intégration dans la navigation existante (nouvel onglet "Astroport")
- [ ] Composants réutilisables (cards, lists, forms)

### Phase 2 : Économie ZEN (Semaines 7-12)

**Semaine 7-8** : Conversion ẐEN→€
- [ ] Interface utilisateur complète (formulaire, validation)
- [ ] Génération de factures PDF (package `pdf`)
- [ ] Intégration avec UPassport `/zen_send`
- [ ] Suivi du statut (polling/WebSocket)

**Semaine 9-10** : Portefeuilles collectifs
- [ ] Dashboard économique avec `fl_chart`
- [ ] Historique des transactions collectives
- [ ] Notifications des redistributions PAF
- [ ] Export des données (CSV, PDF)

**Semaine 11-12** : Gestion des dépenses
- [ ] Soumission de dépenses (hébergement, maintenance)
- [ ] Suivi du statut (pending, approved, paid, rejected)
- [ ] Remboursement automatique si REJECTED
- [ ] Intégration avec `oc_expense_monitor.sh`

### Phase 3 : Certifications et Social (Semaines 13-20)

**Semaine 13-15** : Système Oracle
- [ ] Interface catalogue des permis
- [ ] Processus de demande complet (formulaire, preuves)
- [ ] Attestation par pairs (interface simplifiée)
- [ ] Affichage des badges dans le profil utilisateur

**Semaine 16-18** : Géolocalisation
- [ ] Carte interactive avec `flutter_map`
- [ ] Chat UMAP avec WebSocket NOSTR
- [ ] Détection automatique de la localisation
- [ ] Privacy controls (granularité configurable)

**Semaine 19-20** : Intégration MULTIPASS
- [ ] Scan QR amélioré (support multiple formats)
- [ ] Gestion des contacts avancée
- [ ] Synchronisation avec NOSTR kind 3
- [ ] Système de réputation et confiance

### Phase 4 : Optimisation et Déploiement (Semaines 21-26)

**Semaine 21-22** : Performance et sécurité
- [ ] Cache intelligent des données (Hive)
- [ ] Chiffrement des données sensibles (`flutter_secure_storage`)
- [ ] Audit de sécurité (dépendances, code)
- [ ] Rate limiting et protection DDoS

**Semaine 23-24** : Internationalisation
- [ ] Traduction des nouvelles fonctionnalités
- [ ] Adaptation aux 13 langues supportées
- [ ] Tests de localisation
- [ ] Documentation utilisateur multilingue

**Semaine 25-26** : Tests et déploiement
- [ ] Tests end-to-end avec Patrol
- [ ] Déploiement progressif (beta, production)
- [ ] Monitoring (Sentry, analytics)
- [ ] Documentation développeur

## 7. Défis Techniques et Solutions

### 7.1 Synchronisation des Données
**Problème** : Données dispersées (Open Collective, NOSTR, blockchain Ğ1, IPFS)
**Solution** :
- Cache local avec stratégie TTL différenciée
- NOSTR : Subscription WebSocket en temps réel
- Open Collective : Polling toutes les 15 minutes + webhook
- Blockchain : Événements via WebSocket Substrate
- IPFS : Gateway local avec cache LRU

### 7.2 Confidentialité Géographique
**Problème** : Partage de localisation précise sensible
**Solution** :
- Niveaux de granularité configurables par l'utilisateur
- UMAP (1.2 km²) : Opt-in explicite
- SECTOR (100 km²) : Par défaut pour les nouveaux utilisateurs
- REGION (10,000 km²) : Mode "privé"
- Chiffrement des coordonnées exactes

### 7.3 Conformité Fiscale
**Problème** : Conversion ẐEN→€ avec facturation légale
**Solution** :
- Génération automatique de factures aux normes françaises
- Export comptable (FEC) compatible
- Interface avec Open Collective pour le suivi des dépenses
- Documentation fiscale intégrée

### 7.4 Expérience Utilisateur
**Problème** : Complexité des concepts (DIDs, permis, UMAPs, ẐEN)
**Solution** :
- Tutoriels interactifs avec progression
- Explications contextuelles (tooltips, overlays)
- Mode "simple" (fonctions de base) vs "expert" (toutes fonctions)
- Assistant pas-à-pas pour les premières utilisations

## 8. Métriques de Succès

### 8.1 Techniques
- **Performance** : Temps de chargement < 2s pour chaque écran
- **Fiabilité** : 99.9% de disponibilité des services intégrés
- **Sécurité** : Aucune vulnérabilité critique (score Snyk > 90)
- **Compatibilité** : Support Android 8+, iOS 13+, Web moderne

### 8.2 Utilisateurs
- **Adoption** : 30% des utilisateurs Ginkgo utilisent les nouvelles fonctionnalités
- **Rétention** : Taux de rétention > 60% après 30 jours
- **Satisfaction** : Score NPS > 40 (mesuré via in-app survey)
- **Engagement** : > 3 sessions par semaine par utilisateur actif

### 8.3 Économiques
- **Volume** : > 1000 conversions ẐEN→€ par mois
- **Participation** : > 50% des utilisateurs avec au moins un permis
- **Communauté** : > 100 UMAPs actifs avec chat local
- **Contributions** : > 10k€ collectés mensuellement via Open Collective

## 9. Conclusion

Ginkgo a une opportunité unique de devenir la **plateforme de référence pour l'écosystème Astroport**, bien au-delà d'un simple portefeuille Ğ1. Cette évolution stratégique positionne Ginkgo à l'intersection de trois tendances majeures :

1. **Économie circulaire** : Via l'intégration Open Collective et le modèle ZEN
2. **Identité souveraine** : Via les DIDs W3C et le système Oracle NIP-101
3. **Réseaux locaux résilients** : Via la géolocalisation NOSTR et les UMAPs

**Pour les développeurs** : Cette roadmap fournit un plan d'exécution clair avec des livrables hebdomadaires. L'architecture modulaire permet un développement incrémental avec des retours utilisateurs réguliers.

**Pour la communauté Astroport** : Ginkgo devient l'interface unifiée pour participer à l'économie circulaire, obtenir des certifications reconnues, et construire des communautés locales résilientes.

**Prochaines actions immédiates** :
1. Réviser l'architecture technique avec l'équipe
2. Prioriser les fonctionnalités Phase 1
3. Estimer les ressources nécessaires
4. Planifier le premier sprint de développement

---

*Document révisé le 22 mars 2026 - Version 2.0 pour les développeurs Ginkgo*