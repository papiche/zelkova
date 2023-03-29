#!/bin/bash

if [ -z "$(ls -A /etc/nginx)" ]; then
    cp -a /etc/nginx-default/* /etc/nginx/
fi

CONFIG_FILE="/usr/share/nginx/html/assets/assets/env.production.txt"

VARIABLES=(
  "SENTRY_DSN"
  "CARD_TEXT"
  "DUNITER_NODES"
  "CESIUM_PLUS_NODES"
  "GVA_NODES"
)

DUNITER_IP=$(getent hosts duniter | awk '{ print $1 }')

export GVA_NODES="http://$DUNITER_IP:30901 ${GVA_NODES}"

for VAR_NAME in "${VARIABLES[@]}"; do
  VAR_VALUE=${!VAR_NAME}
  if [ ! -z "$VAR_VALUE" ]; then
    ESCAPED_VAR_VALUE=$(echo "$VAR_VALUE" | sed -e 's/[\/&]/\\&/g')
    sed -i -e "s/^\($VAR_NAME=\).*\$/\1$ESCAPED_VAR_VALUE/" $CONFIG_FILE
  fi
done

# Tyr to mimic nginx entrypoint
# https://github.com/nginxinc/docker-nginx/blob/master/Dockerfile-debian.template
/docker-entrypoint.sh
exec nginx -g "daemon off;"
