#!/bin/bash
## Build Ẑelkova APK (debug or release)
## Usage: ./build_apk.sh [debug|release] [development|production]
set -e

cd "$(dirname "$0")"

BUILD_TYPE="${1:-debug}"
FLAVOR="${2:-production}"

echo "=== Ẑelkova APK Build ==="
echo "Type: $BUILD_TYPE | Flavor: $FLAVOR"

## Check flutter
if ! command -v flutter &>/dev/null; then
    if [ -x "$HOME/flutter/bin/flutter" ]; then
        export PATH="$HOME/flutter/bin:$PATH"
    else
        echo "ERROR: flutter not found"; exit 1
    fi
fi

echo "Flutter: $(flutter --version | head -1)"

## For release builds, ensure signing is configured
if [ "$BUILD_TYPE" = "release" ]; then
    KP="android/key.properties"
    KS="android/upload-keystore.jks"
    if [ ! -f "$KP" ]; then
        echo ""
        echo "No key.properties found — generating dev signing key..."
        if [ ! -f "$KS" ]; then
            keytool -genkey -v \
                -keystore "$KS" \
                -storetype JKS \
                -keyalg RSA -keysize 2048 -validity 10000 \
                -alias upload \
                -dname "CN=Ẑelkova Dev, OU=Dev, O=Comunes, L=Unknown, ST=Unknown, C=XX" \
                -storepass zelkova123 -keypass zelkova123
            echo "Generated dev keystore: $KS"
        fi
        cat > "$KP" <<EOF
storePassword=zelkova123
keyPassword=zelkova123
keyAlias=upload
storeFile=../upload-keystore.jks
EOF
        echo "Generated $KP (dev signing — NOT for store publication)"
        echo "For production, replace with your own keystore."
        echo ""
    fi
fi

## Get dependencies
echo "=== flutter pub get ==="
flutter pub get

## Build APK
FLAVOR_CAP="$(echo "${FLAVOR:0:1}" | tr '[:lower:]' '[:upper:]')${FLAVOR:1}"

if [ "$BUILD_TYPE" = "release" ]; then
    echo "=== Building RELEASE APK (flavor: $FLAVOR) ==="
    flutter build apk --flavor "$FLAVOR" --release \
        -t lib/main.dart
else
    echo "=== Building DEBUG APK (flavor: $FLAVOR) ==="
    flutter build apk --flavor "$FLAVOR" --debug \
        -t lib/main.dart
fi

## Find output APK
APK_DIR="build/app/outputs/flutter-apk"
APK=$(find "$APK_DIR" -name "*.apk" -newer pubspec.yaml 2>/dev/null | head -1)

if [ -n "$APK" ]; then
    SIZE=$(du -h "$APK" | cut -f1)
    echo ""
    echo "=== BUILD SUCCESS ==="
    echo "APK: $APK ($SIZE)"
    echo ""
    ## Copy to a convenient location
    cp "$APK" "zelkova-${FLAVOR}-${BUILD_TYPE}.apk"
    echo "Copied to: zelkova-${FLAVOR}-${BUILD_TYPE}.apk"
else
    echo ""
    echo "APK built. Check $APK_DIR/"
    ls -la "$APK_DIR/"*.apk 2>/dev/null
fi
