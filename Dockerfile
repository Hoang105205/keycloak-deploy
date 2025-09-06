# Dockerfile (Keycloak on Render)
FROM quay.io/keycloak/keycloak:26.0

ENV KC_DB=postgres
ENV KC_PROXY_HEADERS=xforwarded
ENV KC_HEALTH_ENABLED=true
# KHÔNG set KEYCLOAK_ADMIN* trong Dockerfile

# Dùng shell để expand $PORT do Render inject
CMD ["/bin/sh","-lc","exec /opt/keycloak/bin/kc.sh start --auto-build --http-enabled=true --http-port=${PORT} --hostname=${KC_HOSTNAME:-} --hostname-strict=false --hostname-strict-https=false"]
