#!/usr/bin/env bash
set -euo pipefail

# Mặc định hợp với Render
: "${KC_HTTP_ENABLED:=true}"
: "${KC_PROXY:=edge}"

# Render đặt PORT động; nếu chưa có thì 8080
HTTP_PORT="${KC_HTTP_PORT:-${PORT:-8080}}"

# Cần KC_HOSTNAME là domain Render (không có https://)
if [ -z "${KC_HOSTNAME:-}" ]; then
  echo "ERROR: KC_HOSTNAME is not set (e.g. keycloak-deploy-xxxx.onrender.com)" >&2
  exit 1
fi

# DB bắt buộc
: "${KC_DB:=postgres}"
if [ -z "${KC_DB_URL:-}" ] || [ -z "${KC_DB_USERNAME:-}" ] || [ -z "${KC_DB_PASSWORD:-}" ]; then
  echo "ERROR: KC_DB_URL / KC_DB_USERNAME / KC_DB_PASSWORD must be set" >&2
  exit 1
fi

exec /opt/keycloak/bin/kc.sh start \
  --http-enabled="${KC_HTTP_ENABLED}" \
  --http-port="${HTTP_PORT}" \
  --hostname="${KC_HOSTNAME}" \
  --hostname-strict=false \
  --proxy="${KC_PROXY}" \
  --optimized
