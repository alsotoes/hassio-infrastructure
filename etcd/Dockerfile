ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ARG BUILD_ARCH=aarch64
ENV ETCD_VER="v3.6.0" \
    DOWNLOAD_URL="https://storage.googleapis.com/etcd" \
    ARCH=${BUILD_ARCH}

RUN if [ "${ARCH}" == "aarch64" ]; then export ARCH="arm64"; fi && mkdir -p /tmp/etcd-download && \
    curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-${ARCH}.tar.gz -o /tmp/etcd.tar.gz && \
    tar xzvf /tmp/etcd.tar.gz -C /tmp/etcd-download --strip-components=1 --no-same-owner && \
    cp /tmp/etcd-download/etcd /tmp/etcd-download/etcdctl /tmp/etcd-download/etcdutl /usr/local/bin/ && \
    chmod +x /usr/local/bin/etcd /usr/local/bin/etcdctl /usr/local/bin/etcdutl && \
    rm -rf /tmp/*

COPY rootfs /
RUN chmod +x /run.sh

WORKDIR /
EXPOSE 2379/tcp 2380/tcp
HEALTHCHECK \
    --interval=5m \
    --timeout=3s \
    CMD curl -f http://127.0.0.1:2379/health || exit 1

ENTRYPOINT ["/run.sh"]

# Build arguments
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="etcd" \
    io.hass.description="A distributed, reliable key-value store for the most critical data of a distributed system" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Alvaro Soto <alsotoes@gmail.com>" \
    org.opencontainers.image.title="etcd" \
    org.opencontainers.image.description="A distributed, reliable key-value store for the most critical data of a distributed system" \
    org.opencontainers.image.vendor="Alvaro Soto" \
    org.opencontainers.image.authors="Alvaro Soto <alsotoes@gmail.com>" \
    org.opencontainers.image.licenses="GPL-3.0 license" \
    org.opencontainers.image.url="https://headup.ws" \
    org.opencontainers.image.version="${BUILD_VERSION}"
