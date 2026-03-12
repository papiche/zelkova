#!/bin/bash
## Build Flutter web and patch for IPFS-compatible relative paths
set -e

cd "$(dirname "$0")"

echo "=== Flutter build web ==="
flutter build web

echo "=== Patching for IPFS (relative paths) ==="

# base href: "/" -> "./"
sed -i 's|<base href="/">|<base href="./">|' build/web/index.html

# Remove absolute /icons/ paths in index.html
sed -i 's|href="/icons/|href="icons/|g' build/web/index.html

# Remove absolute /icons/ paths in manifest.json
sed -i 's|"src": "/icons/|"src": "icons/|g' build/web/manifest.json

echo "=== Done ==="
echo "Deploy: ipfs add -r build/web/"
