# 🌳 Ẑelkova

**Ẑelkova** est le portefeuille **ẐEN MULTIPASS** de l'écosystème UPlanet — fork indépendant de [Ginkgo](https://git.duniter.org/vjrj/ginkgo) (branche `zen`), spécialisé pour les identités NOSTR et les paiements ẐEN.

> Le *Zelkova* est un arbre résistant natif d'Asie, de la même famille symbolique que le Ginkgo,  
> avec le **Ẑ** naturel de ẐEN.

📱 **Dépôt** : https://github.com/papiche/zelkova  
🌐 **Serveur dev** : https://u.copylaradio.com (UPlanet ORIGIN)

---

## ✨ Fonctionnalités

| Fonctionnalité | Description |
|---------------|-------------|
| 💳 **MULTIPASS** | Identité NOSTR sur le relay UPlanet — compte ẐEN |
| ⚡ **Transferts ẐEN** | Uniquement entre MULTIPASS (pas vers wallets Ğ1) |
| 📩 **Message Cesium+** | Vers les portefeuilles Ğ1 non-MULTIPASS |
| 🔗 **Follow NOSTR** | Suivre d'autres MULTIPASS (kind 3) |
| 📱 **Partage APK P2P** | Distribuer l'app sans Play Store (Wi-Fi local) |
| 🐛 **Feedback intégré** | Issues GitHub via `/api/feedback` (sans lien externe) |
| 🌐 **PWA** | Fonctionne dans tout navigateur moderne |

### Format des adresses ẐEN

| Type | Format QR / Clipboard |
|------|-----------------------|
| MULTIPASS v2 (SS58) | `g1Address:ZEN:CONSTELLATION_TAG` |
| MULTIPASS v1 (base58) | `pubkey:ZEN:CONSTELLATION_TAG` |
| Wallet Ğ1 pur | `pubkey:XXX` (checksum v1, sans `:ZEN`) |

---

## 🚀 Démarrage rapide

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install/linux) ≥ 3.19
- Android Studio / Xcode (pour Android/iOS)

```bash
# Vérifier l'installation Flutter
flutter doctor
```

### 1 — Cloner et configurer

```bash
git clone https://github.com/papiche/zelkova.git
cd zelkova

# Configurer l'environnement
cp dot.env.sample .env
nano .env   # Renseigner UPASSPORT_URL et NOSTR_RELAY
```

`.env` minimal pour commencer :

```env
UPASSPORT_URL=https://u.copylaradio.com   # serveur dev UPlanet ORIGIN
NOSTR_RELAY=wss://relay.copylaradio.com
CURRENCY=ẐEN

# Hash genesis du réseau Ğ1 production (Duniter V2)
GENESIS_HASH=0xfeb770bbb0344dabc8366b0d1f889a8e4e6ca09b914006655fe795920deb6d56

# Nœuds RPC (WebSocket) — plusieurs = fallback automatique
ENDPOINTS=wss://rpc.duniter.org wss://g1.axiom-team.fr/ws/ wss://g1.p2p.legal/ws wss://g1.gyroi.de wss://g1.coinduf.eu

# Indexers Squid (GraphQL) — plusieurs = fallback automatique
DUNITER_INDEXER_NODES=https://indexer.duniter.org/v1/graphql https://g1-squid.axiom-team.fr/v1/graphql https://squid.g1.gyroi.de/v1/graphql

CESIUM_PLUS_NODES=https://g1.data.e-is.pro https://g1.data.le-sou.org
IPFS_GATEWAYS=https://ipfs.copylaradio.com

GITHUB_REPO=papiche/zelkova               # pour le feedback
# GITHUB_TOKEN=ghp_xxx                    # token pour créer les issues
```

### 2 — Lancer en développement

```bash
flutter pub get
flutter run                  # sur appareil connecté (Android/iOS)
flutter run -d chrome        # PWA dans Chrome
flutter run -d linux         # App desktop Linux
```

---

## 📦 Builds

### Android APK

```bash
flutter build apk --debug           # APK debug
flutter build apk --release         # APK release (nécessite android/key.properties)
```

APK généré : `build/app/outputs/flutter-apk/app-debug.apk`

> **Signature release** : créer `android/key.properties` et un keystore `.jks`.  
> Voir : https://docs.flutter.dev/deployment/android

### PWA Web

```bash
flutter build web --release
# Résultat : build/web/
```

Déployer `build/web/` sur nginx ou via le [landing server](#landing-server).

### Linux Desktop

```bash
flutter build linux --release
# Résultat : build/linux/x64/release/bundle/zelkova
```

---

## 🌐 Landing Server (déploiement léger)

`zelkova/landing/` contient un serveur Python FastAPI minimaliste qui sert :

| Route | Description |
|-------|-------------|
| `GET /` | Page de présentation (`landing/index.html`) |
| `GET /app` | Redirige vers la PWA Flutter |
| `POST /api/feedback` | Crée une issue GitHub / relai UPassport |
| `GET /health` | Statut du serveur |

### Déployer le landing

```bash
# Installer les dépendances Python
cd zelkova/landing
pip install -r requirements.txt

# Configurer .env (à la racine zelkova/)
# Ajouter GITHUB_TOKEN et PORT

# Lancer
python server.py          # port 8080 par défaut
# ou :
uvicorn server:app --host 0.0.0.0 --port 8080
```

### Obtenir un GitHub Token (pour /api/feedback)

1. Aller sur https://github.com/settings/tokens
2. **Fine-grained token** → Scopes : **Issues (Read & Write)**
3. Ajouter dans `.env` :
   ```env
   GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx
   GITHUB_REPO=papiche/zelkova
   ```

> Sans `GITHUB_TOKEN`, le feedback est relayé vers `{UPASSPORT_URL}/api/feedback`.

### Service systemd (production)

```bash
# /etc/systemd/system/zelkova-landing.service
[Unit]
Description=Ẑelkova Landing Server
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/zelkova/landing
ExecStart=/usr/bin/python3 server.py
Restart=always
EnvironmentFile=/opt/zelkova/.env

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable --now zelkova-landing
```

---

## 🛠️ Configuration complète (`.env`)

```env
# ─── Réseau Duniter V2 ────────────────────────────────────────
CURRENCY=ẐEN
GENESIS_HASH=                              # laisser vide en dev

# Nœuds Duniter V2 (Substrate)
ENDPOINTS=https://gw1.duniter.fr
DUNITER_INDEXER_NODES=https://indexer.duniter.fr
DATAPOD_ENDPOINTS=
IPFS_GATEWAYS=https://ipfs.copylaradio.com

# Nœuds Cesium+ (Ğ1 V1 — messages Cesium+)
CESIUM_PLUS_NODES=https://g1.data.le-sou.org

# ─── UPassport / NOSTR ───────────────────────────────────────
# Dev (UPlanet ORIGIN) :
UPASSPORT_URL=https://u.copylaradio.com
# Prod (astroport.one, quand déployé) :
# UPASSPORT_URL=https://u.astroport.one

# Relay NOSTR (dérivé de UPASSPORT_URL si vide)
NOSTR_RELAY=wss://relay.copylaradio.com

# ─── Feedback (landing server) ───────────────────────────────
GITHUB_TOKEN=ghp_xxx        # token GitHub (Issues Read+Write)
GITHUB_REPO=papiche/zelkova
PORT=8080
```

---

## 📁 Structure du projet

```
zelkova/
├── lib/                      ← Code Dart / Flutter
│   ├── services/
│   │   ├── feedback_service.dart    ← POST /api/feedback
│   │   └── apk_share_service.dart   ← Partage P2P (TrocZen)
│   ├── ui/screens/
│   │   ├── feedback_screen.dart     ← Formulaire de bug report
│   │   └── apk_share_screen.dart    ← QR Code distribution
│   └── ...
├── landing/                  ← Serveur landing (Python)
│   ├── index.html            ← Page de présentation
│   ├── server.py             ← FastAPI léger (/api/feedback)
│   └── requirements.txt
├── assets/
│   ├── img/                  ← Icônes et images (SVG + PNG)
│   └── translations/         ← Traductions (fr, en, de, es…)
├── android/                  ← Config Android
├── ios/                      ← Config iOS
├── linux/                    ← Config Linux desktop
├── web/                      ← Config PWA (icons, manifest)
├── dot.env.sample            ← Template d'environnement
├── ZELKOVA_ROADMAP.md        ← Synergies TrocZen à intégrer
└── README.md                 ← Ce fichier
```

---

## 🎨 Assets graphiques

Tous les SVG sources sont dans `assets/img/`. Les PNG ont été générés par Inkscape.

| Fichier | Usage | Statut |
|---------|-------|--------|
| `assets/img/leaf.svg` | Feuille de Zelkova + symbole Ẑ | ✅ Généré |
| `assets/img/logo.svg` | Logo horizontal feuille + texte | ✅ Généré |
| `assets/img/favicon.png` | Icône principale (256px) | ✅ Généré |
| `assets/img/logo-leaf-512.png` | Play Store / App Store | ✅ Généré |
| `assets/img/undraw_intro_*.png` | 5 écrans de bienvenue | ✅ Générés |
| `web/icons/Icon-*.png` | Icônes PWA (192, 512px) | ✅ Générés |

**Charte graphique** :
- 🟣 Violet `#7B5EA7` — identité MULTIPASS
- 🟢 Vert `#2E8B57` — nature, Ğ1
- 🥇 Or `#DAA520` — nervures, valeur ẐEN
- Fond `#F8F4FF` (légèrement violacé)
- Police **Nunito** (incluse dans `assets/fonts/`)

> Pour remplacer les assets par des créations originales Zelkova,  
> modifier les `.svg` puis regénérer les PNG avec Inkscape :  
> `inkscape --export-type=png --export-width=256 leaf.svg`

---

## 🏗️ Identifiants techniques

| Champ | Valeur |
|-------|--------|
| Package Android | `one.astroport.zelkova` |
| Namespace Android | `one.astroport.zelkova` |
| APPLICATION_ID Linux | `one.astroport.zelkova` |
| Binaire Linux | `zelkova` |
| WorkManager tasks | `one.astroport.zelkova.*` |
| Architecture Web3 | http://astroport.one |
| Serveur dev | `u.copylaradio.com` (UPlanet ORIGIN) |

---

## 🗺️ Feuille de route

- [ ] Test et Debug : Profil / connexion SSSS / export "nsec" / 
- [ ] Journal d'audit SQLite (bilan ẐEN / conformité RGPD)
- [ ] Visualisation toile de confiance N1/N2 (NOSTR)

---

## 🔗 Liens utiles

| Ressource | URL |
|-----------|-----|
| GitHub Zelkova | https://github.com/papiche/zelkova |
| Astroport.ONE | https://github.com/papiche/Astroport.ONE |
| UPassport | https://github.com/papiche/UPassport |
| TrocZen | https://github.com/papiche/troczen |
| Ginkgo (source) | https://git.duniter.org/vjrj/ginkgo |
| Documentation Flutter | https://docs.flutter.dev |
| Installer Astroport.ONE | `bash <(curl -sL https://astroport.com/install.sh)` |

---

## 📄 Licence

**GPL-3.0** — Fork de [Ginkgo](https://git.duniter.org/vjrj/ginkgo)  
Copyright UPlanet / Astroport.ONE — support@qo-op.com
