#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Exit on error
set -ex

# Exit on pipe fails (if possible)
( set -o pipefail 2> /dev/null ) || true

case $(uname -m) in
    "x86_64") 
        echo "OK: setting ARCH to '$(uname -m)'"
        BUILD_FROM=$(grep amd64 build.yaml | sed 's/amd64:/ /' | sed 's/^[[:space:]]*//g')
    ;;
    "aarch64") 
        echo "OK: setting ARCH to '$(uname -m)'"
        BUILD_FROM=$(grep aarch64 build.yaml | sed 's/aarch64:/ /' | sed 's/^[[:space:]]*//g')
    ;;
    *) echo "ERROR: ARCH '$(uname -m)' not supported" && exit
    ;;
esac

if command -v podman &> /dev/null ; then MANAGER=podman ; else MANAGER=docker ; fi
sed --expression "s/ARG BUILD_FROM/ARG BUILD_FROM=$(echo "${BUILD_FROM}" | sed 's/\//\\\//g')/" ./Dockerfile | tee ./.4978c5b7d4e4.Containerfile

${MANAGER} rmi 4978c5b7d4e4:latest || true
${MANAGER} build -t 4978c5b7d4e4:latest -f ./.4978c5b7d4e4.Containerfile
${MANAGER} image inspect 4978c5b7d4e4:latest

${MANAGER} run -d \
    -p 2379:2379 \
    -p 2380:2380 \
    --name etcd-cappy \
    -e NODE_NAME="cappy" \
    -e INITIAL_CLUSTER_STATE="new" \
    -e LOG_LEVEL="debug" \
    -e LOGGER="zap" \
    4978c5b7d4e4:latest

${MANAGER} exec etcd-cappy /usr/local/bin/etcd --version
${MANAGER} exec etcd-cappy /usr/local/bin/etcdctl version
${MANAGER} exec etcd-cappy /usr/local/bin/etcdutl version
${MANAGER} exec etcd-cappy /usr/local/bin/etcdctl endpoint health
${MANAGER} exec etcd-cappy /usr/local/bin/etcdctl put foo bar
${MANAGER} exec etcd-cappy /usr/local/bin/etcdctl get foo

${MANAGER} stop etcd-cappy
${MANAGER} rm etcd-cappy
