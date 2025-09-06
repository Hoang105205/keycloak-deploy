# Keycloak 24 ổn định, bạn có thể giữ 24.0.5 nếu muốn
FROM quay.io/keycloak/keycloak:24.0.5

# Không hardcode admin/password trong image. Để Render set ENV.
# Bật cache local để tránh cảnh báo cluster/JGroups trên single node
ENV KC_CACHE=local

# Dùng ENTRYPOINT mặc định của image: /opt/keycloak/bin/kc.sh
# Chỉ cần chỉ định CMD là "start" với các tham số run-time phù hợp Render
CMD ["start",
     "--http-enabled=true",
     "--http-port=${PORT}",
     "--hostname=${KC_HOSTNAME}",
     "--hostname-strict=false",
     "--proxy=edge"]
