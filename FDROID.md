# Publication F-Droid — G1nkgo

## Prérequis accomplis

- [x] Licence AGPL-3.0 (compatible F-Droid)
- [x] Métadonnées fastlane (EN + FR) dans `fastlane/metadata/android/`
- [x] Pas de dépendance propriétaire Google Play Services
- [x] Code source public

## Structure fastlane en place

```
fastlane/metadata/android/
├── en-US/
│   ├── title.txt
│   ├── short_description.txt
│   ├── full_description.txt
│   └── images/phoneScreenshots/    ← à remplir
└── fr-FR/
    ├── title.txt
    ├── short_description.txt
    ├── full_description.txt
    └── images/phoneScreenshots/    ← à remplir
```

## Étapes pour publier sur F-Droid

### 1. Captures d'écran (obligatoire)

F-Droid exige au moins 1 capture d'écran. Placer des PNG/JPG dans :
```
fastlane/metadata/android/en-US/images/phoneScreenshots/1.png
fastlane/metadata/android/fr-FR/images/phoneScreenshots/1.png
```

Dimensions recommandées : 1080x1920 (portrait).

Optionnel mais recommandé :
```
fastlane/metadata/android/en-US/images/featureGraphic.png    # 1024x500
fastlane/metadata/android/en-US/images/icon.png              # 512x512
```

### 2. Vérifier la compatibilité F-Droid

F-Droid construit depuis les sources. Vérifier :

```bash
# Pas de binaires propriétaires embarqués
find . -name "*.jar" -o -name "*.aar" | grep -v build/

# Pas de Firebase/Google Play Services
grep -r "com.google.firebase\|com.google.android.gms" android/app/build.gradle pubspec.yaml

# Pas de tracking/analytics propriétaire (Sentry est OK si auto-hébergé)
grep -r "firebase_analytics\|google_analytics" pubspec.yaml
```

**Points d'attention pour G1nkgo :**
- `sentry_flutter` : Accepté si le DSN pointe vers une instance auto-hébergée (vérifier `.env`)
- `awesome_notifications` : OK (pas de FCM)
- `flutter_secure_storage` : OK
- `local_auth` : OK (biométrie native)

### 3. Créer le fichier de métadonnées F-Droid

Créer un fichier `metadata/org.comunes.g1nkgo.yml` dans le repo [fdroiddata](https://gitlab.com/fdroid/fdroiddata) :

```yaml
Categories:
  - Money
License: AGPL-3.0-only
AuthorName: SCIC CopyLaRadio
AuthorEmail: support@qo-op.com
AuthorWebSite: https://copylaradio.com
SourceCode: https://github.com/papiche/ginkgo
IssueTracker: https://github.com/papiche/ginkgo/issues

AutoName: G1nkgo
Description: |
  G1nkgo is a wallet for ẐEN, a layer-2 stablecoin built on the Ğ1 (June)
  libre currency blockchain (Duniter v2s).

  ẐEN is the operational unit of the UPlanet cooperative ecosystem. Each
  Astroport relay station runs a ZEN.ECONOMY engine that automates the
  cooperative's constitutional rules.

RepoType: git
Repo: https://github.com/papiche/ginkgo.git

Builds:
  - versionName: 2.0.4
    versionCode: 25
    commit: v2.0.4
    output: build/app/outputs/flutter-apk/app-production-release.apk
    srclibs:
      - flutter@stable
    rm:
      - ios
      - macos
      - windows
      - linux
    build:
      - $$flutter$$/bin/flutter config --no-analytics
      - $$flutter$$/bin/flutter pub get
      - $$flutter$$/bin/flutter build apk --flavor production --release

AutoUpdateMode: Version
UpdateCheckMode: Tags
CurrentVersion: 2.0.4
CurrentVersionCode: 25
```

### 4. Soumettre à F-Droid

#### Option A : Inclusion dans le dépôt officiel F-Droid

1. Forker [fdroiddata](https://gitlab.com/fdroid/fdroiddata) sur GitLab
2. Créer `metadata/org.comunes.g1nkgo.yml` (voir ci-dessus)
3. Tester localement :
   ```bash
   # Installer fdroidserver
   pip install fdroidserver

   # Valider les métadonnées
   fdroid readmeta
   fdroid lint org.comunes.g1nkgo
   ```
4. Soumettre une Merge Request sur fdroiddata
5. Processus de review (peut prendre quelques semaines)

#### Option B : Dépôt F-Droid personnel (plus rapide)

Créer son propre dépôt F-Droid pour distribution immédiate :

```bash
# Installer fdroidserver
pip install fdroidserver

# Initialiser le dépôt
mkdir fdroid-repo && cd fdroid-repo
fdroid init

# Copier l'APK signé
cp ../ginkgo-production-release.apk repo/

# Générer le dépôt
fdroid update --create-metadata

# Publier via IPFS
ipfs add -r repo/
```

Les utilisateurs ajoutent l'URL du dépôt dans F-Droid Client.

### 5. Tags de version (important)

F-Droid utilise les tags git pour détecter les nouvelles versions :

```bash
git tag -a v2.0.4 -m "G1nkgo 2.0.4 - ẐEN wallet"
git push origin v2.0.4
```

Chaque nouvelle version :
1. Incrémenter `version` dans `pubspec.yaml` (ex: `2.0.5+26`)
2. Créer le tag git correspondant
3. F-Droid détecte automatiquement via `AutoUpdateMode: Version`

### 6. Signature

Pour F-Droid officiel : F-Droid signe avec sa propre clé (les utilisateurs font confiance à F-Droid).

Pour un dépôt personnel : utiliser une clé stable et la conserver précieusement :

```bash
keytool -genkey -v \
    -keystore ginkgo-release.jks \
    -storetype JKS \
    -keyalg RSA -keysize 4096 -validity 10000 \
    -alias ginkgo \
    -dname "CN=G1nkgo, OU=UPlanet, O=SCIC CopyLaRadio, C=FR"
```

Ne jamais committer le keystore — le sauvegarder hors du dépôt.

## Checklist finale

- [ ] Screenshots dans `fastlane/metadata/android/*/images/phoneScreenshots/`
- [ ] Vérifier que Sentry DSN pointe vers instance auto-hébergée (ou le retirer)
- [ ] Créer un tag git `v2.0.4`
- [ ] Tester le build depuis un clone propre : `git clone && ./build_apk.sh release production`
- [ ] Soumettre la MR sur fdroiddata (ou publier son propre dépôt)
- [ ] Publier le dépôt F-Droid personnel via IPFS pour distribution décentralisée
