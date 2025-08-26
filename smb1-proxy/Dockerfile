# Multi-arch Home Assistant add-on base (Alpine + s6-overlay v3)
ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-alpine:3.19
FROM ${BUILD_FROM}

# hadolint ignore=DL3018
RUN set -eux;     apk add --no-cache samba-common-tools samba-server samba-client bash jq coreutils;     mkdir -p /run/samba /etc/samba /data

# Copy rootfs (s6 services & scripts)
COPY rootfs /

# Ensure executables
RUN chmod +x /etc/services.d/smbd/run /etc/cont-init.d/10-configure

# Expose (host_network is enabled, but keep for clarity)
EXPOSE 137/udp 138/udp 139/tcp 445/tcp
