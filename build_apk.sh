#!/bin/bash
## Build Ẑelkova APK et publication release
## Usage:
##   ./build_apk.sh                            → debug, production flavor
##   ./build_apk.sh release production         → release build
##   ./build_apk.sh release production --push  → release + git tag + GitHub release
set -e

cd "$(dirname "$0")"

## Aide
for arg in "$@"; do
  if [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
    cat <<'EOF'
Usage: ./build_apk.sh [BUILD_TYPE] [FLAVOR] [--push]

  BUILD_TYPE   debug (défaut) | release
  FLAVOR       production (défaut) | development
  --push       Bumpe la version, crée le tag git et publie sur GitHub Releases
               (uniquement avec BUILD_TYPE=release)

Exemples:
  ./build_apk.sh                              # debug rapide pour tester
  ./build_apk.sh release production           # release signée, sans publier
  ./build_apk.sh release production --push    # release + bump + tag + GitHub

Comportement de --push:
  1. Bumpe automatiquement le patch et le build code dans pubspec.yaml
       ex: 2.0.4+25 → 2.0.5+26
  2. Commit les fichiers modifiés (*.apk exclus)
  3. Crée/déplace le tag git vX.Y.Z et pousse sur origin
  4. Crée la GitHub Release ou met à jour l'APK si elle existe déjà
  5. 20h12.process.sh détectera la nouvelle version le soir même

Pour un bump mineur ou majeur (ex: 2.1.0), édite pubspec.yaml manuellement
avant de lancer --push : le script incrémentera seulement le patch à partir de là.

Keystore de production:
  Détecté automatiquement si ~/.zen/keystores/zelkova-prod.jks existe.
  Mot de passe dérivé de ~/.ipfs/swarm.key (sha256 | head -c 24).
  Sans ce fichier, un keystore dev temporaire est généré (ne pas publier).
EOF
    exit 0
  fi
done

BUILD_TYPE="${1:-debug}"
FLAVOR="${2:-production}"
PUSH=false
for arg in "$@"; do [[ "$arg" == "--push" ]] && PUSH=true; done

## Lire version depuis pubspec.yaml
VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')
VERSION_NAME="${VERSION%%+*}"   # ex: 2.0.4
VERSION_CODE="${VERSION##*+}"   # ex: 25

echo "=== Ẑelkova APK Build ==="
echo "Type: $BUILD_TYPE | Flavor: $FLAVOR | Version actuelle: $VERSION_NAME+$VERSION_CODE"

## Auto-bump patch + build number pour --push release
if [ "$BUILD_TYPE" = "release" ] && $PUSH; then
    IFS='.' read -r V_MAJOR V_MINOR V_PATCH <<< "$VERSION_NAME"
    VERSION_NAME="$V_MAJOR.$V_MINOR.$((V_PATCH + 1))"
    VERSION_CODE=$((VERSION_CODE + 1))
    sed -i "s/^version: .*/version: ${VERSION_NAME}+${VERSION_CODE}/" pubspec.yaml
    echo "📦 Version bumpée  : $VERSION_NAME+$VERSION_CODE"
fi

## Vérifier flutter
if ! command -v flutter &>/dev/null; then
    if [ -x "$HOME/flutter/bin/flutter" ]; then
        export PATH="$HOME/flutter/bin:$PATH"
    else
        echo "ERROR: flutter introuvable"; exit 1
    fi
fi
echo "Flutter: $(flutter --version 2>/dev/null | head -1)"

## Signing configuration pour release
if [ "$BUILD_TYPE" = "release" ]; then
    KP="android/key.properties"
    if [ ! -f "$KP" ]; then
        PROD_JKS="$HOME/.zen/keystores/zelkova-prod.jks"
        if [ -f "$HOME/.ipfs/swarm.key" ] && [ -f "$PROD_JKS" ]; then
            echo "⚙️  Keystore production détecté — configuration automatique..."
            KEYSTORE_PWD=$(cat ~/.ipfs/swarm.key | sha256sum | awk '{print $1}' | head -c 24)
            cat > "$KP" <<EOF
storePassword=$KEYSTORE_PWD
keyPassword=$KEYSTORE_PWD
keyAlias=upload
storeFile=$PROD_JKS
EOF
            echo "✅ key.properties configuré (keystore production)"
        else
            echo "⚠️  Keystore production absent — génération clé dev..."
            KS="android/upload-keystore.jks"
            if [ ! -f "$KS" ]; then
                keytool -genkey -v \
                    -keystore "$KS" \
                    -storetype JKS \
                    -keyalg RSA -keysize 2048 -validity 10000 \
                    -alias upload \
                    -dname "CN=Zelkova Dev, OU=Dev, O=G1FabLab, L=Unknown, ST=Unknown, C=XX" \
                    -storepass zelkova123 -keypass zelkova123
                echo "Clé dev générée : $KS"
            fi
            cat > "$KP" <<EOF
storePassword=zelkova123
keyPassword=zelkova123
keyAlias=upload
storeFile=../upload-keystore.jks
EOF
            echo "ℹ️  key.properties dev créé (ne pas publier sur store)"
        fi
    fi
fi

## Dépendances
echo "=== flutter pub get ==="
flutter pub get

## Build
if [ "$BUILD_TYPE" = "release" ]; then
    echo "=== Build RELEASE APK (flavor: $FLAVOR) ==="
    flutter build apk --release \
        --dart-define=FLUTTER_FLAVOR="$FLAVOR" \
        -t lib/main.dart
else
    echo "=== Build DEBUG APK (flavor: $FLAVOR) ==="
    flutter build apk --debug \
        --dart-define=FLUTTER_FLAVOR="$FLAVOR" \
        -t lib/main.dart
fi

## Résultat
APK_DIR="build/app/outputs/flutter-apk"
APK=$(find "$APK_DIR" -name "*.apk" -newer pubspec.yaml 2>/dev/null | head -1)
OUTPUT_APK="zelkova-${FLAVOR}-${BUILD_TYPE}.apk"

if [ -z "$APK" ]; then
    echo "APK introuvable dans $APK_DIR"
    ls -la "$APK_DIR/"*.apk 2>/dev/null || true
    exit 1
fi

SIZE=$(du -h "$APK" | cut -f1)
cp "$APK" "$OUTPUT_APK"
echo ""
echo "=== BUILD SUCCESS ==="
echo "APK : $OUTPUT_APK ($SIZE)"

## Vérifier la signature
if command -v apksigner &>/dev/null; then
    apksigner verify --print-certs "$OUTPUT_APK" 2>/dev/null | grep "certificate DN" || true
fi

## Publication release (--push)
if [ "$BUILD_TYPE" = "release" ] && $PUSH; then
    TAG="v$VERSION_NAME"
    echo ""
    echo "=== Publication $TAG ==="

    ## Committer les changements hors APK si nécessaire
    if ! git diff --quiet -- ':!*.apk' || ! git diff --cached --quiet -- ':!*.apk'; then
        git add -A -- ':!*.apk'
        git commit -m "chore: release $TAG (build $VERSION_CODE)"
    fi

    ## Tag (force pour écraser un éventuel tag local obsolète)
    git tag -f "$TAG"
    git push origin HEAD
    git push origin "$TAG" --force

    ## GitHub Release : créer ou mettre à jour l'APK
    if gh release view "$TAG" &>/dev/null 2>&1; then
        echo "Release $TAG existante — mise à jour de l'APK..."
        gh release upload "$TAG" "$OUTPUT_APK" --clobber
    else
        gh release create "$TAG" "$OUTPUT_APK" \
            --title "Ẑelkova $VERSION_NAME" \
            --notes "Release $VERSION_NAME (build $VERSION_CODE) — wallet ẐEN MULTIPASS"
    fi

    echo "✅ Release $TAG → https://github.com/papiche/zelkova/releases/tag/$TAG"
fi
