# Ğ1nkgo — branche `zen`

![Ğ1nkgo logo](./assets/img/logo.png 'Ğ1nkgo logo')

> **Fork de la branche zen** : [git.duniter.org/zicmama/ginkgo/-/tree/zen](https://git.duniter.org/zicmama/ginkgo/-/tree/zen)
>
> Ğ1nkgo est un portefeuille ẐEN/Ğ1 (Duniter v2) écrit en Flutter, orienté **simplicité** et **intégration UPlanet**.
> Cette branche `zen` étend le portefeuille de base avec le système d'identité MULTIPASS UPlanet / NOSTR.

---

## ✨ Fonctionnalités nouvelles (branche `zen`)

### 🪪 MULTIPASS UPlanet

- **Création de compte MULTIPASS** lors de l'onboarding : email + géolocalisation → appel à l'API UPassport `/g1nostr` → dérivation de clé G1 + identité NOSTR
- **Sélecteur de station SWARM** au moment de l'inscription : liste les relais UPlanet disponibles avec capacités MP, ZenCard, PAF, bilan hebdo ; **tri automatique par distance GPS** après géolocalisation ; fiche de détail cliquable par station (URLs, espaces disque, économie)
- **Clé SSSS** correctement stockée et utilisée pour le déménagement

### 🏠 Déménagement MULTIPASS

Bouton **"Vous voulez déménager ?"** dans le drawer (visible uniquement pour les comptes MULTIPASS) :

1. Le dialog charge le `ssss_player` stocké localement
2. Envoie `POST {uspot}/upassport` avec `parametre=<ssss>` + `imageData=0000`
3. Le serveur déclenche `nostr_DESTROY_TW.sh` qui :
   - Exporte tous les events NOSTR vers IPFS (backup chiffré)
   - Retourne le solde Ğ1 au compte primordial (cash-back)
   - Génère un `.next.disco` pour la restauration sur le nouveau relai
   - Publie le CID du backup dans le profil NOSTR désactivé (source de vérité)
4. Sur le nouveau relai, l'utilisateur saisit son email → restauration automatique via `nostr_RESTORE_TW.sh`

Si la clé SSSS n'est pas disponible localement (compte ancien), affiche les instructions pour le terminal `/scan` manuel.

### 👥 Contacts — sources séparées

L'onglet Contacts propose désormais un **toggle `Cesium+` / `⚡ MULTIPASS`** :

| Mode | Source | Comportement |
|---|---|---|
| Cesium+ | API Cesium+ + WoT Duniter | Recherche textuelle réseau |
| MULTIPASS | Relai NOSTR local (kind 0) | Affichage immédiat, filtre local |

- La **page Payer** affiche directement les MULTIPASS du relai local (sans Cesium+)
- Tap sur un MULTIPASS → profil avec **picture**, **banner** et **bio NOSTR**

### 🧑‍🤝‍🧑 Profil NOSTR enrichi

- `picture` et `banner` affichées pour les profils des autres MULTIPASS (via `nostrHex` transmis depuis la liste, lookup par adresse V2 en fallback)
- Bouton **Suivre / Ne plus suivre** dans le SpeedDial quand on visite le profil d'un autre MULTIPASS → publie le kind 3 (follow list NOSTR)
- Édition du profil pré-remplie avec les valeurs actuelles du kind 0 (name, about, city, picture)
- Aperçu de la picture actuelle dans le sélecteur d'avatar

### 🌐 Liste des nœuds — stations Astroport

En mode Expert, la page Nœuds affiche le widget **AstroSwarmWidget** :

- Charge le JSON SWARM depuis `{Env.upassportUrl}`
- Liste toutes les stations de la constellation avec : hostname, ville, URLs (UPassport cliquable, IPFS, Relay), capacités (MP/ZenCard libres, espace disque), bilan hebdo coloré (vert/rouge)
- **Test de connectivité** asynchrone par station : `GET {uspot}/health` avec timeout 6s → dot 🟢 joignable / 🔴 inaccessible (DNS cassé, nginx mal configuré) / spinner en cours

---

## Features (branche master conservées)

- Introduction pour les débutants
- Génération de portefeuille MULTIPASS
- Terminal point de vente (QR code avec montant)
- Envoi de transactions ẐEN (UPLANETNAME.Ğ1 est seul habilité à envoyer ou recevoir des Ğ1 sur UPlanet ẐEN)
- Historique des transactions et graphique de solde
- Gestion de contacts avec cache
- Internationalisation (13 langues... need corrections...)
- Lecteur QR code
- Déménagement du portefeuille
- Découverte et sélection automatique des nœuds
- Tutoriels en ligne
- Pagination des transactions

---

## Architecture

```
lib/
├── g1/
│   ├── multipass_service.dart      — création MULTIPASS via /g1nostr
│   └── nostr/
│       ├── nostr_relay_service.dart — WebSocket NOSTR (kind 0/3/30850)
│       │     • fetchAllMultipassProfiles()  ← NOUVEAU
│       │     • fetchRecentProfiles()         ← NOUVEAU
│       ├── nostr_profile.dart       — parser kind 0 (_normalizeUrl)
│       └── nostr_keys.dart          — nsec/npub ↔ hex
├── services/
│   └── multipass_service.dart      — création ancienne méthode
└── ui/
    ├── screens/
    │   ├── wallet_creation_screen.dart  — onboarding + SWARM selector
    │   └── node_list_page.dart          — nœuds + AstroSwarmWidget
    └── widgets/
        ├── card_drawer.dart             — bouton "Déménager ?"
        ├── contact_page.dart            — profil NOSTR + Follow/Unfollow
        ├── multipass_relocation_dialog.dart  — dialog déménagement
        ├── node_list/
        │   └── astro_swarm_widget.dart  — stations Astroport NOUVEAU
        └── third_screen/
            └── contacts_page.dart       — toggle NOSTR/Cesium+
```

---

## Sources de données et workflows

### 1. Astroport — `{UPASSPORT_URL}` (GET `/`)

Endpoint principal de chaque station UPlanet. Retourne la description complète de la constellation.

```
GET https://u.copylaradio.com/
```

| Champ JSON | Données extraites | Usage dans Ginkgo |
|---|---|---|
| `uSPOT` | URL UPassport de la station principale | Sélecteur de station, déménagement |
| `myIPFS` | Gateway IPFS (`https://ipfs.copylaradio.com`) | URLs Coracle, liens backup |
| `myRELAY` | Relay NOSTR WSS | Connexion NostrRelayService |
| `NCARD` / `ZCARD` | Nb MULTIPASS / ZenCard actifs | Badge dans le sélecteur |
| `PAF` | Prélèvement hebdomadaire (Ẑ) | Affichage économie station |
| `BILAN` | Bilan comptable hebdo | Couleur vert/rouge |
| `SWARM[]` | Tableau des stations de la constellation | `_loadSwarmStations()` → liste de choix |
| `PLAYERs[]` | MULTIPASS enregistrés sur ce relai | (réservé) |
| `UMAPs[]` | Cellules géographiques actives | (réservé) |

**Champs par station SWARM :**

| Champ | Données |
|---|---|
| `hostname`, `IPCity` | Nom/ville de la station (label du sélecteur) |
| `uSPOT` | URL UPassport de cette station |
| `myIPFS` | Gateway IPFS de cette station |
| `myRELAY` | Relay NOSTR de cette station |
| `STATION_LAT`, `STATION_LON` | GPS → tri par distance Haversine |
| `capacities.nostr_slots` | Slots MULTIPASS libres (badge MP) |
| `capacities.zencard_slots` | Slots ZenCard libres |
| `capacities.storage_details.root.available_gb` | Espace disque |
| `services.upassport.active` | UPassport en ligne ? (🟢/🔴) |
| `economy.captain_remuneration` | PAF hebdo capitaine |
| `economy.multipass_count` | MULTIPASS actifs |

---

### 2. Astroport — `POST {UPASSPORT_URL}/g1nostr` (Création MULTIPASS)

Crée l'identité MULTIPASS : dérive les clés G1 + NOSTR, stocke le profil kind 0.

```
POST https://u.copylaradio.com/g1nostr
Content-Type: application/x-www-form-urlencoded

email=&lang=fr&lat=48.85&lon=2.35&format=json
```

**Réponse JSON `.multipass.json`** :

| Champ | Données |
|---|---|
| `g1pub` | Adresse G1 SS58 du portefeuille MULTIPASS |
| `nsec` | Clé privée NOSTR (bech32) — stockée dans SecureStorage |
| `npub` | Clé publique NOSTR (bech32) |
| `ssss` | Part SSSS du joueur (format `M-xxx:k51qzi...`) — utilisée pour le **déménagement** |
| `nostrns` | IPNS CID du vault NOSTR |
| `salt`, `pepper` | Credentials ZenCard |

TODO: Ajouter UPLANETNAME_G1 (Ğ1/Ẑ) et UPLANETG1PUB (historique ẑen) et UPLANETNAME_SOCIETY (historique ẐEN)

---

### 3. Astroport — `POST {UPASSPORT_URL}/upassport` (Scan QR / Terminal)

Route générique du terminal de scan. Comportement selon le PIN :

| `imageData` (PIN) | Comportement serveur |
|---|---|
| *(omis)* | Affichage du profil NOSTR correspondant |
| `0000` | **Déménagement** : déclenche `nostr_DESTROY_TW.sh` → backup IPFS chiffré + cash-back Ğ1 |
| `9999` | Terminal paiement MULTIPASS |
| `1111` | Interface BRO/Blog NOSTRTube |
| `8888` | Enregistreur vocal NOSTR |

```
POST https://u.copylaradio.com/upassport
parametre=<ssss_player>&imageData=0000&zlat=0.00&zlon=0.00
```

---

### 4. Duniter Substrate — WebSocket (polkadart)

Endpoints `wss://...` — protocole Substrate RPC via `polkadart`.

| Requête RPC | Données | Usage |
|---|---|---|
| `System.account(address)` | Solde libre, solde total | Affichage balance |
| `Smiths.membershipOf(pubKey)` | Statut membre WoT | Actions WoT (certifier, renouveler) |
| `Certification.certsOf(pubKey)` | Liste des certifications | Boutons certifier |
| `UniversalDividend.currentUd()` | Valeur du DU actuel (en centimes) | Conversion Ğ1 ↔ DU |

---

### 5. Duniter Indexer — Squid GraphQL

Endpoints `https://*.../v1/graphql` — indexeur Squid pour l'historique.

| Query GraphQL | Données extraites | Usage |
|---|---|---|
| `account(id: $id)` | Solde, dernier bloc | Balance screen |
| `transfersConnection` | Historique transactions (envoi/réception, montant, commentaire, date) | 4ème onglet |
| `identitiesConnection` | Recherche par nom (WoT search) | Recherche contacts |
| `certifications` | Certifications émises/reçues | Profil contact |
| `accountByAddress` | Conversion adresse → pubKey | Navigation profil V2 |

**Sélection de nœud :** Ginkgo choisit le nœud Squid avec le bloc le plus récent et la version la plus haute (`Filtering indexer nodes by highest version`).

---

### 6. NOSTR Relay Local — WebSocket (strfry)

Relay local (`wss://relay.copylaradio.com` ou `ws://127.0.0.1:7777`), protocole NIP-01.

| Kind | Nom | Données | Usage dans Ginkgo |
|---|---|---|---|
| `0` | Profil | `name, picture, banner, about, city, g1pub (NIP-39)` | Avatar, bannière, bio contact |
| `3` | Follow list | `["p", hexPubKey]` tags | Bouton Follow/Unfollow, routing paiements kind 7 |
| `30850` | Économie station (custom) | `capacity_multipass, capacity_zencard, cost_paf, revenue_total, bilan` | `SwarmEconomyWidget` (onglet Nœuds) |

**Filtres NOSTR utilisés :**

```json
// Toutes les profils MULTIPASS (avec tag g1pub)
{"kinds": [0], "limit": 200}
// → filtré côté client : tags.any(t => t[0]=="i" && t[1].startsWith("g1pub:"))

// Profil par hex pubkey
{"kinds": [0], "authors": ["<hexPubkey>"]}

// Recherche par tag NIP-39 g1pub
{"kinds": [0], "#i": ["g1pub:<duniterAddress>"], "limit": 1}

// Économie station (kind 30850, 30 derniers jours)
{"kinds": [30850], "since": <epoch-30j>}
```

---

## Configuration

Copier `dot.env.sample` vers `.env` et `.env.dev`. Le champ `UPASSPORT_URL` pointe vers le relai UPlanet de votre station.

```bash
UPASSPORT_URL=https://u.copylaradio.com
```

Après modification, régénérer les sources :

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Build

```bash
# Web
./build_web_ipfs.sh debug development

# Android
./build_apk.sh debug production

# Linux + .deb
# (voir CLAUDE.md)
```

---

## Liens

- **Branche zen** : [git.duniter.org/zicmama/ginkgo/-/tree/zen](https://git.duniter.org/zicmama/ginkgo/-/tree/zen)
- **Branche master (origine)** : [git.duniter.org/vjrj/ginkgo](https://git.duniter.org/vjrj/ginkgo)
- **UPassport API** : [u.copylaradio.com](https://u.copylaradio.com)
- **NIP-101 / UPlanet** : [github.com/papiche/NIP-101](https://github.com/papiche/NIP-101)
- **Traductions (Weblate)** : [weblate.duniter.org/projects/g1nkgo/g1nkgo/](https://weblate.duniter.org/projects/g1nkgo/g1nkgo/)

---

## Licence

GNU AGPL v3 (voir [LICENSE](./LICENSE))
