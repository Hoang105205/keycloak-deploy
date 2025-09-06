FROM quay.io/keycloak/keycloak:24.0.5

# Tránh cluster/JGroups trên single node
ENV KC_CACHE=local

# Copy script khởi động (đọc env rồi gọi kc.sh)
COPY start-keycloak.sh /usr/local/bin/start-keycloak.sh
RUN chmod +x /usr/local/bin/start-keycloak.sh

# Dùng script làm entrypoint để cho phép shell expand biến (PORT, KC_HOSTNAME, ...)
ENTRYPOINT ["/usr/local/bin/start-keycloak.sh"]
