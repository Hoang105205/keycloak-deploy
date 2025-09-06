# Dockerfile
FROM quay.io/keycloak/keycloak:24.0.5

# Khai báo DB vendor (các thông số còn lại set qua ENV trên Render)
ENV KC_DB=postgres

# Chạy server ở HTTP (phù hợp reverse proxy của Render), nhận X-Forwarded-*,
# tắt hostname-strict để đỡ lỗi khi chạy sau proxy.
CMD /opt/keycloak/bin/kc.sh start \
  --http-enabled=true \
  --http-port=${PORT:-8080} \
  --proxy-headers=xforwarded \
  --hostname-strict=false
