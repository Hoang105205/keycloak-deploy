# Dockerfile
FROM quay.io/keycloak/keycloak:24.0.5

ENV KC_HTTP_ENABLED=true
ENV KC_HTTP_PORT=8080
ENV KC_PROXY=edge

ENV KC_HOSTNAME_STRICT=false

WORKDIR /opt/keycloak

EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--http-enabled=true", "--http-port=8080", "--proxy=edge", "--hostname-strict=false"]
