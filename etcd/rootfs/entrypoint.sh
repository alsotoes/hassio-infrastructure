#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Exit on error
set -ex

# Exit on pipe fails (if possible)
( set -o pipefail 2> /dev/null ) || true

ARCH="$(echo $ARCH)"
DOWNLOAD_URL="$(echo $DOWNLOAD_URL)"
ETCD__VER="$(echo $ETCD__VER)"

if [ -x "/usr/local/bin/etcd" ]
then
    # already installed, so do nothing 
    if [ "${ARCH}" = "aarch64" ]
    then 
        # it seems like google didn't get the memo about arm64==aarch64
        # both ok, but it'll be nice to have one alias with the other name
        ARCH="arm64"
    fi

    apt-get update && \
    apt-get install --no-install-recommends curl=7.74.0-1.3+deb11u12 ca-certificates=20210119 -y && \ 
    mkdir /tmp/etcd-download && \
    curl -L ${DOWNLOAD_URL}/${ETCD__VER}/etcd-${ETCD__VER}-linux-${ARCH}.tar.gz -o /tmp/etcd-${ETCD__VER}-linux-${ARCH}.tar.gz && \
    tar xzvf /tmp/etcd-${ETCD__VER}-linux-${ARCH}.tar.gz -C /tmp/etcd-download --strip-components=1 --no-same-owner && \
    cp /tmp/etcd-download/etcd /tmp/etcd-download/etcdctl /tmp/etcd-download/etcdutl /usr/local/bin/ && \
    rm -f /tmp/etcd-${ETCD__VER}-linux-${ARCH}.tar.gz && \
    rm -rf /tmp/etcd-download && \
    useradd -ms /bin/bash -d /var/lib/etcd etcd
fi
