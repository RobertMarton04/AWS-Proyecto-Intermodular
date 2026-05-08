#!/bin/bash
dnf update -y
dnf install -y docker
systemctl enable --now docker
mkdir -p /home/ec2-user/app && cd /home/ec2-user/app

# Crear config de Nginx
cat <<EOF > nginx.conf
events {}
http {
    server {
        listen 80;
        location /gitea/ { proxy_pass http://gitea:3000/; }
        location /vscode/ { proxy_pass http://vscode:8080/; }
        location /nextcloud/ { proxy_pass http://10.0.2.100/; } # IP fija de la privada
    }
}
EOF

# Docker Compose
cat <<EOF > docker-compose.yml
services:
  nginx:
    image: nginx:latest
    ports: ["80:80"]
    volumes: ["./nginx.conf:/etc/nginx/nginx.conf:ro"]
  gitea:
    image: gitea/gitea:latest
    ports: ["3000:3000"]
  vscode:
    image: codercom/code-server:latest
    environment: ["PASSWORD=demo123"]
EOF
docker compose up -d
