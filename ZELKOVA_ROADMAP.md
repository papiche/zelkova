# Ẑelkova — Feuille de route & Synergies TrocZen

## Vision

**Ẑelkova** = Ginkgo (MULTIPASS + Duniter V2) **+** TrocZen (offline, P2P, ẐEN local)

Ẑelkova bénéficie de deux projets complémentaires :
- **Ginkgo/Ẑinkgo** → wallet Duniter V2, NOSTR relay, paiements en ligne
- **TrocZen** → échanges hors-ligne, Bons ẐEN, marchés locaux, P2P

---

## ✅ Déjà intégré (depuis Ginkgo branche zen)

| Fonctionnalité | Fichier |
|----------------|---------|
| Portefeuille Duniter V2 (Ğ1) | `lib/g1/` |
| MULTIPASS NOSTR (NIP-39 g1pub) | `lib/g1/nostr/` |
| Transferts ẐEN entre MULTIPASS | `lib/ui/pay_helper.dart` |
| Message Cesium+ vers wallets Ğ1 | `lib/g1/cesium_message_service.dart` |
| Follow NOSTR (kind 3) | `lib/ui/widgets/contact_page.dart` |
| Feedback vers `/api/feedback` | `lib/services/feedback_service.dart` |

---

## 🚀 À intégrer depuis TrocZen

### 1. Partage APK pair-à-pair ✅ PORTÉ
> `lib/services/apk_share_service.dart` (adapté de TrocZen)

Lance un serveur HTTP local sur `:8303`. L'utilisateur affiche un QR Code →
son voisin scanne → télécharge l'APK directement. **Zero Play Store.**

**TODO** :
- [ ] Créer `lib/ui/screens/apk_share_screen.dart` (QR + compteur downloads)
- [ ] Ajouter un bouton "Partager l'app" dans le drawer / écran Info
- [ ] Ajouter `assets/apk/zelkova.apk` en bundle (ou utiliser l'APK installé)
- [ ] Android: implémenter `MethodChannel` `getApkPath` dans `MainActivity.kt`

---

### 2. Journal d'audit local (SQLite) — PRIORITÉ HAUTE
> Source : `TrocZen/troczen/lib/services/audit_trail_service.dart`

Journal local des transferts ẐEN avec :
- Traçabilité conformité RGPD (anonymisation optionnelle)
- Bilan économique personnel (entrées/sorties par période)
- Indépendant du cache réseau (persiste après clear cache)
- Table SQL : `sender_npub, receiver_npub, amount, status, timestamp`

**TODO** :
- [ ] Porter `audit_trail_service.dart` → remplacer SQLite par Hive (déjà présent)
  ou ajouter dépendance `sqflite`
- [ ] Créer un écran "Mon bilan ẐEN" avec graphique mensuel
- [ ] Intégrer l'audit dans `pay_helper.dart` après chaque paiement réussi

---

### 3. Toile de confiance visuelle — PRIORITÉ HAUTE
> Source : `TrocZen/troczen/lib/screens/trust_web_screen.dart`

Visualise les connexions NOSTR de l'utilisateur :
- **N1** = mes contacts (kind 3 follow list)
- **Mutuels (P2P)** = ceux qui me suivent ET que je suis
- **Sortants (1→2P)** = je suis, ils ne me suivent pas → invitation ẐEN ?
- **Entrants (2P→1)** = ils me suivent, je ne les suis pas → follow retour ?

**TODO** :
- [ ] Porter `trust_web_screen.dart` → remplacer `NostrService` TrocZen
  par `NostrRelayService` de Zelkova
- [ ] Intégrer dans l'onglet Contacts (3ème onglet) avec un bouton "Réseau"
- [ ] Ajouter action "Suivre tous les mutuels" (kind 3 batch)

---

### 4. Calcul du Dividende Universel (DU) — PRIORITÉ MOYENNE
> Source : `TrocZen/troczen/lib/services/du_calculation_service.dart`

Calcul **hyperrelativiste** du DU basé sur le graphe social NOSTR local :
```
DuTotal = DuBase (de la Box) + DuSkill (compétences attestées)
c² = taux de croissance monétaire
alpha = ajustement selon graphe social N1/N2
```

**TODO** :
- [ ] Porter `DuCalculationService` → utiliser le relay Zelkova
- [ ] Afficher le DU estimé dans l'écran Solde (4ème onglet)
- [ ] Synchroniser avec les données de la station `UPASSPORT_URL`

---

### 5. Compétences WoTx (NOSTR kinds 30500-30503) — PRIORITÉ MOYENNE
> Source : `TrocZen/troczen/lib/services/nostr_wotx_service.dart`

Registre décentralisé de compétences sur NOSTR :
- Kind 30500: Définition de compétence (Skill Permit)
- Kind 30501: Demande d'attestation
- Kind 30502: Attestation par un pair
- Kind 30503: Révocation

**TODO** :
- [ ] Créer `lib/services/nip_wotx_service.dart` (adapter NostrWoTxService)
- [ ] Afficher les compétences dans la page de contact MULTIPASS
- [ ] Permettre d'attester les compétences d'un autre MULTIPASS

---

### 6. Circuit de Bons ẐEN (offline) — PRIORITÉ BASSE
> Source : `TrocZen/troczen/lib/services/burn_service.dart`

TrocZen utilise des "Bons" (unités d'échange locales) qui peuvent circuler
hors-ligne via QR codes signés cryptographiquement :

```
Bon émis (Kind 30303) → Transferts P2P (Kind 30302) → Révélation circuit (Kind 30304)
```

**TODO (long terme)** :
- [ ] Intégrer le modèle `Bon` de TrocZen dans Zelkova
- [ ] Créer un mode "marché local" pour les événements sans réseau
- [ ] Synchronisation relay NOSTR quand connecté

---

### 7. Partage P2P via QR amélioré — PRIORITÉ BASSE
> Source : `TrocZen/troczen/lib/models/qr_payload_v2.dart`

TrocZen a un format QR v2 enrichi avec signature cryptographique.
Complément au format `:ZEN:TAG` de Zelkova.

---

## Architecture cible Ẑelkova v2

```
zelkova/
├── lib/
│   ├── services/
│   │   ├── feedback_service.dart     ✅ Intégré
│   │   ├── apk_share_service.dart    ✅ Porté depuis TrocZen
│   │   ├── audit_trail_service.dart  📋 À porter (bilan ẐEN)
│   │   ├── du_calculation_service.dart 📋 À porter (DU offline)
│   │   └── nip_wotx_service.dart    📋 À créer (compétences)
│   ├── ui/
│   │   ├── screens/
│   │   │   ├── apk_share_screen.dart  📋 À créer
│   │   │   ├── trust_web_screen.dart  📋 À porter
│   │   │   └── feedback_screen.dart  ✅ Intégré
│   │   └── widgets/
│   │       └── zen_balance_widget.dart 📋 DU + balance ẐEN
```

---

## Dépendances à ajouter (pubspec.yaml)

```yaml
# Pour AuditTrailService (bilan local)
sqflite: ^2.3.0
path: ^1.9.0    # déjà présent

# Pour ApkShareService (déjà dans Flutter, pas de dep extra nécessaire)
# path_provider déjà présent
```

---

## Référence

- **TrocZen** : [`TrocZen/troczen/`](../TrocZen/troczen/) — marché local offline
- **Ginkgo** : [`ginkgo/`](../ginkgo/) — wallet Ğ1 en ligne  
- **Ẑelkova** : ce dépôt — fusion des deux approches
