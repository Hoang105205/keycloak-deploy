# --- build stage: tạo bản optimized ---
FROM quay.io/keycloak/keycloak:24.0.5 as builder
ENV KC_DB=postgres
WORKDIR /opt/keycloak
# build để không phải augmentation lúc runtime (Render sẽ nhận port nhanh)
RUN /opt/keycloak/bin/kc.sh build \
    --http-enabled=true \
    --http-port=8080 \
    --proxy-headers=xforwarded \
    --hostname-strict=false

# --- runtime stage ---
FROM quay.io/keycloak/keycloak:24.0.5
ENV KC_DB=postgres
ENV KC_HTTP_ENABLED=true
ENV KC_HTTP_PORT=8080
ENV KC_PROXY_HEADERS=xforwarded
ENV KC_HOSTNAME_STRICT=false
WORKDIR /opt/keycloak
EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
