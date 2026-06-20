#!/bin/bash
## Build Flutter web for IPFS deployment with multiple modes and flavors
## Usage: ./build_web_ipfs.sh [debug|release|profile] [development|production] [--no-patch] [--clean] [--deploy] [--help]
set -e

cd "$(dirname "$0")"

BUILD_MODE="${1:-release}"
FLAVOR="${2:-production}"
PATCH_IPFS=true
CLEAN=false
DEPLOY=false
OVH_ZONE="${OVH_ZONE:-astroport.one}"
DNSLINK_SUB="${DNSLINK_SUB:-z}"
OVH_SH="$(dirname "$0")/../Astroport.ONE/admin/system/ovh.me.sh"

# Parse additional flags
for arg in "$@"; do
    case $arg in
        --no-patch)
            PATCH_IPFS=false
            shift
            ;;
        --clean)
            CLEAN=true
            shift
            ;;
        --deploy)
            DEPLOY=true
            shift
            ;;
        --help|-h)
            cat <<EOF
Usage: $0 [BUILD_MODE] [FLAVOR] [OPTIONS]

Build Ẑelkova web for IPFS deployment.

Arguments:
  BUILD_MODE          debug, release, or profile (default: release)
  FLAVOR              development or production (default: production)

Options:
  --no-patch          Skip IPFS relative‑path patching
  --clean             Run 'flutter clean' before building
  --deploy            ipfs add + mise à jour DNSLink via ovh.me.sh
                      (zone: OVH_ZONE=${OVH_ZONE}, sub: DNSLINK_SUB=${DNSLINK_SUB})
  --help, -h          Show this help

Examples:
  $0 debug development          # Debug build, development flavor
  $0 release production         # Release build, production flavor (default)
  $0 release production --deploy # Build + ipfs add + DNSLink z.astroport.one
  $0 profile production --clean # Clean & profile build with IPFS patch
  $0 --no-patch                 # Release build without IPFS patching

Flavors:
  development: enables sandbox, verbose logs, dev tools
  production:  disables sandbox, enables optimizations

IPFS patching:
  - Changes base href from "/" to "./"
  - Converts absolute /icons/ paths to relative
  - Required for proper IPFS gateway hosting

Deploy (--deploy):
  - ipfs add -r build/web/  →  récupère le CID racine
  - ovh.me.sh upsert \${DNSLINK_SUB} <CID> \${OVH_ZONE}
  - Met à jour _dnslink.\${DNSLINK_SUB}.\${OVH_ZONE} → dnslink=/ipfs/<CID>

EOF
            exit 0
            ;;
    esac
done

# Validate build mode
case $BUILD_MODE in
    debug|release|profile)
        ;;
    *)
        echo "ERROR: BUILD_MODE must be debug, release, or profile (got: $BUILD_MODE)"
        exit 1
        ;;
esac

# Validate flavor
case $FLAVOR in
    development|production)
        ;;
    *)
        echo "ERROR: FLAVOR must be development or production (got: $FLAVOR)"
        exit 1
        ;;
esac

echo "=== Ẑelkova Web Build ==="
echo "Mode:   $BUILD_MODE"
echo "Flavor: $FLAVOR"
echo "Patch:  $PATCH_IPFS"
echo "Clean:  $CLEAN"
echo ""

# Check flutter
if ! command -v flutter &>/dev/null; then
    if [ -x "$HOME/flutter/bin/flutter" ]; then
        export PATH="$HOME/flutter/bin:$PATH"
    else
        echo "ERROR: flutter not found in PATH"
        exit 1
    fi
fi

FLUTTER_VER=$(flutter --version 2>/dev/null)
echo "Flutter: ${FLUTTER_VER%%$'\n'*}"
echo ""

# Clean if requested
if [ "$CLEAN" = true ]; then
    echo "=== flutter clean ==="
    flutter clean
    echo ""
fi

# Get dependencies
echo "=== flutter pub get ==="
flutter pub get
echo ""

# Build web
echo "=== Building web ($BUILD_MODE, $FLAVOR) ==="

DART_DEFINES="FLUTTER_FLAVOR=$FLAVOR"
if [ "$FLAVOR" = "development" ]; then
    DART_DEFINES="$DART_DEFINES,DEVELOPMENT=true"
else
    DART_DEFINES="$DART_DEFINES,DEVELOPMENT=false"
fi

# Use appropriate Flutter command
case $BUILD_MODE in
    debug)
        flutter build web --debug --no-wasm-dry-run --dart-define="$DART_DEFINES" -t lib/main.dart
        ;;
    release)
        flutter build web --release --no-wasm-dry-run --dart-define="$DART_DEFINES" -t lib/main.dart
        ;;
    profile)
        flutter build web --profile --no-wasm-dry-run --dart-define="$DART_DEFINES" -t lib/main.dart
        ;;
esac

echo "Build completed: build/web/"
echo ""

# IPFS patching
if [ "$PATCH_IPFS" = true ]; then
    echo "=== Patching for IPFS (relative paths) ==="

    WEB_DIR="build/web"

    # Ensure index.html exists
    if [ ! -f "$WEB_DIR/index.html" ]; then
        echo "ERROR: $WEB_DIR/index.html not found"
        exit 1
    fi

    # base href: "/" -> "./"
    sed -i 's|<base href="/">|<base href="./">|' "$WEB_DIR/index.html"

    # Remove absolute /icons/ paths in index.html
    sed -i 's|href="/icons/|href="icons/|g' "$WEB_DIR/index.html"
    sed -i 's|src="/icons/|src="icons/|g' "$WEB_DIR/index.html"

    # Remove absolute /icons/ paths in manifest.json
    if [ -f "$WEB_DIR/manifest.json" ]; then
        sed -i 's|"src": "/icons/|"src": "icons/|g' "$WEB_DIR/manifest.json"
    fi

    # Also patch service worker.js if it references absolute paths
    if [ -f "$WEB_DIR/flutter_service_worker.js" ]; then
        sed -i "s|'/icons/'|'icons/'|g" "$WEB_DIR/flutter_service_worker.js"
    fi

    # Strip sourceMappingURL from flutter.js to suppress DevTools 404 warnings
    if [ -f "$WEB_DIR/flutter.js" ]; then
        sed -i 's|//# sourceMappingURL=.*||' "$WEB_DIR/flutter.js"
    fi

    echo "IPFS patching done."
    echo ""
fi

# Deploy: ipfs add + DNSLink OVH
if [ "$DEPLOY" = true ]; then
    echo "=== IPFS add ==="
    if ! command -v ipfs &>/dev/null; then
        echo "ERROR: ipfs non trouvé dans PATH"
        exit 1
    fi

    CID=$(ipfs add -r -q --pin build/web/ | tail -1)
    if [ -z "$CID" ]; then
        echo "ERROR: ipfs add n'a retourné aucun CID"
        exit 1
    fi
    echo "CID racine: $CID"
    echo ""

    echo "=== DNSLink: _dnslink.${DNSLINK_SUB}.${OVH_ZONE} → /ipfs/${CID} ==="
    if [ ! -x "$OVH_SH" ]; then
        echo "ERROR: ovh.me.sh introuvable ou non exécutable: $OVH_SH"
        echo "Mise à jour manuelle: ovh.me.sh upsert ${DNSLINK_SUB} ${CID} ${OVH_ZONE}"
        exit 1
    fi
    "$OVH_SH" upsert "$DNSLINK_SUB" "$CID" "$OVH_ZONE"
    echo ""
    echo "Accessible via:"
    echo "  https://${DNSLINK_SUB}.${OVH_ZONE}"
    echo ""
fi

# Summary
echo "=== Build Summary ==="
echo "Output directory: $(pwd)/build/web"
echo "Build mode:       $BUILD_MODE"
echo "Flavor:           $FLAVOR"
echo "IPFS patch:       $PATCH_IPFS"
echo "Deploy:           $DEPLOY"
echo ""
if [ "$DEPLOY" = false ]; then
    echo "Pour déployer sur IPFS:"
    echo "  $0 $BUILD_MODE $FLAVOR --deploy"
    echo "  # ou manuellement:"
    echo "  ipfs add -r build/web/ && ovh.me.sh upsert ${DNSLINK_SUB} <CID> ${OVH_ZONE}"
    echo ""
fi
echo "Pour servir localement:"
echo "  python3 -m http.server --directory build/web 8080"
echo "  # puis ouvrir http://localhost:8080"
echo ""
