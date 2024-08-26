# Build arguments
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ENV ETCD__VER="v3.5.15" \
    DOWNLOAD_URL="https://storage.googleapis.com/etcd" \
    ARCH="aarch64"

VOLUME ["/var/lib/etcd"]
RUN useradd -ms /bin/bash -d /var/lib/etcd etcd && mkdir -p /var/lib/etcd/data /tmp/etcd-download && \
    apt-get update && apt-get install --no-install-recommends curl=7.74.0-1.3+deb11u12 -y && \
    curl -L ${DOWNLOAD_URL}/${ETCD__VER}/etcd-${ETCD__VER}-linux-${ARCH}.tar.gz -o /tmp/etcd.tar.gz && \
    tar xzvf /tmp/etcd.tar.gz -C /tmp/etcd-download --strip-components=1 --no-same-owner && \
    cp /tmp/etcd-download/etcd /tmp/etcd-download/etcdctl /tmp/etcd-download/etcdutl /usr/local/bin/ && \
    rm -f /tmp/etcd.tar.gz && rm -rf /tmp/etcd-download

COPY rootfs /
RUN chmod a+x /run.sh 

USER 1000
WORKDIR /var/lib/etcd
EXPOSE 2379/tcp 2380/tcp
HEALTHCHECK \
    --interval=5m \
    --timeout=3s \
    CMD curl -f http://127.0.0.1:2379/health || exit 1

CMD ["/run.sh"]

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Alvaro Soto <alsotoes@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Alvaro Soto" \
    org.opencontainers.image.authors="Alvaro Soto <alsotoes@gmail.com>" \
    org.opencontainers.image.licenses="GPL-3.0 license" \
    org.opencontainers.image.url="https://headup.ws" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
