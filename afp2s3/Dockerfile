ARG BUILD_FROM
ARG AFPFS_VERSION=0.8.1
ARG AFPFS_SOURCE=https://sourceforge.net/projects/afpfs-ng/files/afpfs-ng/${AFPFS_VERSION}/afpfs-ng-${AFPFS_VERSION}.tar.bz2/download

FROM ${BUILD_FROM} as afpfs_build

ARG AFPFS_VERSION
ARG AFPFS_SOURCE

RUN apk add --no-cache \
    build-base \
    libgcrypt-dev \
    fuse-dev \
    gmp-dev \
    readline-dev \
    ncurses-dev \
    wget \
    git

RUN wget -O afpfs-ng.tar.bz2 ${AFPFS_SOURCE} && \
    tar -xjf afpfs-ng.tar.bz2

WORKDIR /afpfs-ng-${AFPFS_VERSION}

RUN CFLAGS="-I/usr/local/include -L/usr/local/lib" ./configure && \
    make && \
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
