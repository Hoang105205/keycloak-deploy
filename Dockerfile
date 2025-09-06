# Dockerfile — Keycloak for Render (Postgres)
# Pin version để tránh vỡ khi upstream đổi.
FROM quay.io/keycloak/keycloak:26.0

# Cấu hình cơ bản (không chứa secrets)
ENV KC_DB=postgres \
    KC_PROXY_HEADERS=xforwarded \
    KC_HEALTH_ENABLED=true

# Tạo entrypoint script để expand biến môi trường (đặc biệt là $PORT của Render)
RUN printf '#!/bin/sh\nset -e\nexec /opt/keycloak/bin/kc.sh start \\\n  --auto-build \\\n  --http-enabled=true \\\n  --http-port="${PORT}" \\\n  --hostname="${KC_HOSTNAME:-}" \\\n  --hostname-strict=false \\\n  --hostname-strict-https=false\n' \
    > /usr/local/bin/keycloak-render-entrypoint.sh \
 && chmod +x /usr/local/bin/keycloak-render-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/keycloak-render-entrypoint.sh"]
