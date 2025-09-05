FROM quay.io/keycloak/keycloak:25.0.6

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
