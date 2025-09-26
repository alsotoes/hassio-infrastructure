ARG BUILD_FROM
ARG AFPFS_VERSION=0.8.1
ARG AFPFS_SOURCE=https://sourceforge.net/projects/afpfs-ng/files/afpfs-ng/${AFPFS_VERSION}/afpfs-ng-${AFPFS_VERSION}.tar.bz2/download

FROM ${BUILD_FROM} AS afpfs_build

ARG AFPFS_VERSION
ARG AFPFS_SOURCE

# Build afpfs-ng from source so the AFP tools are available on all architectures
RUN apk add --no-cache \
    autoconf \
    automake \
    bash \
    build-base \
    ca-certificates \
    bzip2 \
    fuse-dev \
    fuse3-dev \
    glib-dev \
    libgcrypt-dev \
    libgpg-error-dev \
    libtool \
    linux-headers \
    openssl-dev \
    pkgconfig \
    patch \
    python3 \
    tar \
    wget \
    git

WORKDIR /tmp

RUN git clone https://github.com/simonvetter/afpfs-ng.git && \
    wget https://gist.githubusercontent.com/alsotoes/d64cb088cbbc210fdafba090fab0ebd4/raw/1c1800ef50402095fbde78d2e45e4170a63be1bd/afpfs-ng_headup-patch00.diff && \
    patch -p0 < afpfs-ng_headup-patch00.diff && cd afpfs-ng && \
    CFLAGS="-I/usr/local/include -L/usr/local/lib" ./configure --prefix=/usr --sysconfdir=/etc --build=arm-unknown-linux-gnu && \
    make -j"$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)" && \
    make install DESTDIR=/tmp/afpfs-install

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
