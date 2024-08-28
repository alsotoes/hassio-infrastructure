#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Exit on error
set -ex

# Exit on pipe fails (if possible)
( set -o pipefail 2> /dev/null ) || true

ETCD_NAME="$(bashio::config 'node_name')" \
ETCD_INITIAL_CLUSTER_STATE="$(bashio::config 'initial_cluster_state')" \
ETCD_INITIAL_CLUSTER="${ETCD_NAME}=http://0.0.0.0:2380" \
ETCD_LOG_LEVEL="$(bashio::config 'log_level')" \

/usr/local/bin/etcd \
  --data-dir /data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --initial-advertise-peer-urls http://0.0.0.0:2380 \
  --log-outputs stderr
