# Dockerfile (Keycloak cho Render)
FROM quay.io/keycloak/keycloak:26.0

ENV KC_DB=postgres
ENV KC_PROXY_HEADERS=xforwarded
ENV KC_HEALTH_ENABLED=true

CMD ["/opt/keycloak/bin/kc.sh","start","--auto-build","--http-enabled=true","--http-port=${PORT}","--hostname-strict=false","--hostname-strict-https=false"]
