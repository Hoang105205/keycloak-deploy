# Dockerfile (Render)
FROM quay.io/keycloak/keycloak:26.0

# Cấu hình cơ bản (không chứa secrets)
ENV KC_DB=postgres
ENV KC_PROXY_HEADERS=xforwarded
ENV KC_HEALTH_ENABLED=true

# Dùng shell để expand $PORT do Render cấp
ENTRYPOINT ["/bin/sh","-lc"]
CMD ["exec /opt/keycloak/bin/kc.sh start --auto-build --http-enabled=true --http-port=${PORT} --hostname=${KC_HOSTNAME:-} --hostname-strict=false --hostname-strict-https=false"]
