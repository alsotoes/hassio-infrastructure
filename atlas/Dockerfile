# Stage 1: Build Go binary
FROM golang:1.22 AS builder
WORKDIR /app
COPY atlas-github/config/atlas_go /app
# If you have go.mod in config/atlas_go, this is enough; otherwise add module init
RUN if [ ! -f go.mod ]; then go mod init atlas || true; fi
RUN go build -o atlas .

# Stage 2: Runtime
FROM ghcr.io/home-assistant/amd64-base-python:3.9-alpine3.14

RUN apk add --no-cache \
    nginx iputils-ping traceroute nmap sqlite net-tools curl jq ca-certificates \
    && pip install --no-cache-dir fastapi uvicorn

# Remove default Nginx config
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default || true

# Copy template & static UI content
COPY atlas-github/config/nginx/default.conf.template /config/nginx/default.conf.template
COPY atlas-github/data/html/ /usr/share/nginx/html/

# Copy scripts and binary
COPY atlas-github/config/scripts /config/scripts
COPY --from=builder /app/atlas /config/bin/atlas

# Make all shell scripts executable
RUN chmod +x /config/scripts/*.sh

# Set default ports (can be overridden at runtime)
ENV ATLAS_UI_PORT=8888
ENV ATLAS_API_PORT=8889

# Entrypoint: initializes DB, runs scans, launches FastAPI and Nginx
EXPOSE 8888 8889
CMD ["/config/scripts/atlas_check.sh"]
