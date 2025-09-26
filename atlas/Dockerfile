ARG BUILD_FROM
# Stage 1: Build Go binary and clone repo
FROM --platform=$BUILD_ARCH golang:1.22 AS builder

RUN apk add --no-cache git

RUN git clone https://github.com/karam-ajaj/atlas.git /atlas-repo
WORKDIR /atlas-repo
RUN git checkout 3.1.11

# Build the Go binary
WORKDIR /atlas-repo/config/atlas_go
RUN go mod init atlas || true
RUN go build -o /atlas .

# Stage 2: Runtime
FROM $BUILD_FROM

RUN apk add --no-cache \
    nginx iputils-ping traceroute nmap sqlite net-tools curl jq ca-certificates git \
    && pip install --no-cache-dir fastapi uvicorn

# Remove default Nginx config
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default || true

# Copy from builder stage
COPY --from=builder /atlas-repo/config/nginx/default.conf.template /config/nginx/default.conf.template
COPY --from=builder /atlas-repo/data/html/ /usr/share/nginx/html/
COPY --from=builder /atlas-repo/config/scripts /config/scripts
COPY --from=builder /atlas /config/bin/atlas

# Make all shell scripts executable
RUN chmod +x /config/scripts/*.sh

# Set default ports (can be overridden at runtime)
ENV ATLAS_UI_PORT=8888
ENV ATLAS_API_PORT=8889

# Entrypoint: initializes DB, runs scans, launches FastAPI and Nginx
EXPOSE 8888 8889
CMD ["/run.sh"]