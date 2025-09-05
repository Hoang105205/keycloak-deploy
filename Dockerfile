FROM quay.io/keycloak/keycloak:24.0.5

ENV KC_DB=postgres
WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
