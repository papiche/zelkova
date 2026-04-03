# Ẑelkova

**Ẑelkova** est le portefeuille ẐEN de l'écosystème UPlanet — un fork indépendant de [Ẑinkgo/Ginkgo](https://git.duniter.org/vjrj/ginkgo) spécialisé pour le réseau MULTIPASS.

> 🌳 Le Zelkova est un arbre résistant natif d'Asie, de la même famille symbolique que le Ginkgo — avec le **Ẑ** naturel de ẐEN.

---

## Fonctionnalités clés

- 💳 **MULTIPASS** — Identité NOSTR sur le relay UPlanet (comptes ẐEN)
- ⚡ **Transferts ẐEN** — Uniquement entre MULTIPASS (pas vers/depuis les wallets Ğ1)
- 📩 **Message Cesium+** — Pour les portefeuilles Ğ1 non-MULTIPASS
- 🔗 **Follow NOSTR** — Suivre d'autres MULTIPASS (kind 3)
- 🐛 **Feedback intégré** — Via `POST {UPASSPORT_URL}/api/feedback` (pas de lien externe)
- 🌐 **Progressive Web App** — Tournant sur `astroport.one`

---

## Format des adresses

| Type | Format |
|------|--------|
| MULTIPASS (v2 SS58) | `g1Address:ZEN:CONSTELLATION_TAG` |
| MULTIPASS (v1 base58) | `pubkey:ZEN:CONSTELLATION_TAG` |
| Wallet Ğ1 (non-MULTIPASS) | `pubkey:XXX` (checksum v1, sans `:ZEN`) |

---

## Architecture

Basé sur Ginkgo (branche `zen`), avec :
- Mode **V2 uniquement** (Duniter V2 / Substrate forcé)
- **NOSTR relay** via NIP-101/NIP-39 (relay UPlanet)
- **ZenTagService** — isolation par constellation (`:ZEN:TAG`)
- **FeedbackService** — `POST {UPASSPORT_URL}/api/feedback`

---

## Package & identifiants

| Champ | Valeur |
|-------|--------|
| Package Android | `one.astroport.zelkova` |
| Bundle iOS | `one.astroport.zelkova` |
| Domaine | `astroport.one` |
| WorkManager | `one.astroport.zelkova.*` |

---

## Assets graphiques à remplacer

> 🎨 **Pour le graphiste** — voici les fichiers à créer pour Ẑelkova :

### Icônes et logo (répertoire `assets/img/`)

| Fichier | Usage | Format | Taille actuelle |
|---------|-------|--------|-----------------|
| `assets/img/favicon.png` | Icône principale de l'app (AppBar, onglets) | PNG | 256×256 |
| `assets/img/favicon-32x32.png` | Favicon web 32px | PNG | 32×32 |
| `assets/img/favicon-16x16.png` | Favicon web 16px | PNG | 16×16 |
| `assets/img/favicon.ico` | Favicon navigateur | ICO | multi-size |
| `assets/img/logo.png` | Logo avec texte "Ẑelkova" | PNG | variable |
| `assets/img/logo.svg` | Logo vectoriel avec texte | SVG | vector |
| `assets/img/logo-leaf.svg` | Feuille seule (symbole app) | SVG | vector |
| `assets/img/logo-leaf-512.png` | Icône Play Store / App Store | PNG | 512×512 |

### Icônes web (`web/icons/`)

| Fichier | Usage |
|---------|-------|
| `web/icons/Icon-maskable-192.png` | PWA maskable 192px |
| `web/icons/Icon-maskable-512.png` | PWA maskable 512px |
| `web/icons/Icon-192.png` | PWA 192px |
| `web/icons/Icon-512.png` | PWA 512px |
| `web/favicon.png` | Favicon web direct |

### Écrans d'introduction (`assets/img/undraw_intro_*.png`)

Les 5 illustrations d'accueil (style undraw.co) :
- `undraw_intro_1.png` → **Créer un MULTIPASS**
- `undraw_intro_2.png` → **Payer en ẐEN**
- `undraw_intro_3.png` → **Réseau NOSTR**
- `undraw_intro_4.png` → **Toile de confiance Ğ1**
- `undraw_intro_5.png` → **Souveraineté numérique**

### Symboles Ğ1 et ẐEN (à adapter)

| Fichier | Usage |
|---------|-------|
| `assets/img/gbrevedot.png` | Symbole Ğ1 (monnaie libre) |
| `assets/img/gbrevedot.svg` | Symbole Ğ1 vectoriel |
| `assets/img/gbrevedot_color.png` | Symbole Ğ1 coloré |

Pour Ẑelkova, ajouter l'icône **Ẑ** (Z accent circonflexe) comme symbole ẐEN.

### Charte graphique suggérée

- **Couleur principale** : Violet/mauve (`#7B5EA7`) — évoque la fleur de Zelkova
- **Couleur secondaire** : Vert émeraude (`#2E8B57`) — lien avec la nature
- **Accentuation** : Or (`#DAA520`) — valeur, usage coopératif
- **Fond clair** : `#F8F4FF` (légèrement violacé)
- Police : **Nunito** (déjà présente dans `assets/fonts/`)

---

## Variables d'environnement (`.env`)

Copier `.env.sample` → `.env` et configurer :

```env
UPASSPORT_URL=https://u.astroport.one
NOSTR_RELAY=wss://relay.astroport.one
CURRENCY=ẐEN
GENESIS_HASH=<duniter_v2_genesis_hash>
```

---

## Développement

```bash
cd zelkova
flutter pub get
flutter run -d chrome
```

---

## Licence

GPL-3.0 — Fork de [Ginkgo](https://git.duniter.org/vjrj/ginkgo) par l'équipe UPlanet / Astroport.ONE
