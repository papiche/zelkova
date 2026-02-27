#!/bin/sh

# Inject environment variables into the Flutter web app config
CONFIG_FILE="/usr/share/nginx/html/assets/assets/env.production.txt"

# Ensure the config directory exists (Flutter web build quirk)
mkdir -p /usr/share/nginx/html/assets/assets/

# If config file doesn't exist yet, copy from assets
if [ ! -f "$CONFIG_FILE" ]; then
  cp /usr/share/nginx/html/assets/env.production.txt "$CONFIG_FILE" 2>/dev/null || true
fi

# Replace env variables in config file (POSIX sh compatible)
for VAR_NAME in CURRENCY SENTRY_DSN CARD_COLOR_LEFT CARD_COLOR_RIGHT CARD_TEXT DUNITER_NODES CESIUM_PLUS_NODES GVA_NODES; do
  VAR_VALUE=$(eval echo \"\$$VAR_NAME\")
  if [ -n "$VAR_VALUE" ]; then
    ESCAPED_VAR_VALUE=$(printf '%s' "$VAR_VALUE" | sed -e 's/[\/&]/\\&/g')
    sed -i "s/^\(${VAR_NAME}=\).*$/\1${ESCAPED_VAR_VALUE}/" "$CONFIG_FILE"
  fi
done

# Start nginx
exec nginx -g "daemon off;"
