ARG BUILD_FROM
ARG AFPFS_VERSION=0.8.1

FROM ${BUILD_FROM} AS afpfs_build

ARG AFPFS_VERSION

# Build afpfs-ng from source so the AFP tools are available on all architectures
RUN apk add --no-cache \
    autoconf \
    automake \
    bash \
    build-base \
    ca-certificates \
    fuse-dev \
    fuse3-dev \
    glib-dev \
    libgcrypt-dev \
    libgpg-error-dev \
    libtool \
    linux-headers \
    openssl-dev \
    pkgconfig \
    tar \
    wget

WORKDIR /tmp

RUN wget -O afpfs-ng.tar.gz https://github.com/afpfs-ng/afpfs-ng/releases/download/v${AFPFS_VERSION}/afpfs-ng-${AFPFS_VERSION}.tar.gz \
    && tar -xzf afpfs-ng.tar.gz \
    && cd afpfs-ng-${AFPFS_VERSION} \
    && if ! ./configure --prefix=/usr --sysconfdir=/etc --disable-python; then \
        ./configure --prefix=/usr --sysconfdir=/etc; \
    fi \
    && make -j"$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)" \
    && make install DESTDIR=/tmp/afpfs-install

FROM ${BUILD_FROM}

# Install runtime dependencies, including libraries required by afpfs-ng
RUN apk add --no-cache \
    ca-certificates \
    fuse \
    fuse3 \
    glib \
    libgcrypt \
    libgpg-error \
    openssl \
    util-linux \
    jq \
    wget

COPY --from=afpfs_build /tmp/afpfs-install/ /

# Copy data for add-on
COPY rootfs /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
