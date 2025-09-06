# ---- build (persist build-time options: DB, proxy...) ----
FROM quay.io/keycloak/keycloak:24.0.5 AS builder
ENV KC_DB=postgres
WORKDIR /opt/keycloak
# build để persist DB vendor và tối ưu image
RUN /opt/keycloak/bin/kc.sh build \
    --http-enabled=true \
    --http-port=8080 \
    --proxy-headers=xforwarded \
    --hostname-strict=false

# ---- runtime ----
FROM quay.io/keycloak/keycloak:24.0.5
# optional (không bắt buộc vì đã persist lúc build, nhưng để rõ ràng)
ENV KC_DB=postgres
ENV KC_HTTP_ENABLED=true
ENV KC_HTTP_PORT=8080
ENV KC_PROXY_HEADERS=xforwarded
ENV KC_HOSTNAME_STRICT=false
WORKDIR /opt/keycloak

# *** QUAN TRỌNG: copy kết quả build ***
COPY --from=builder /opt/keycloak/ /opt/keycloak/

EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
