#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Exit on error
set -ex

# Exit on pipe fails (if possible)
( set -o pipefail 2> /dev/null ) || true

/usr/local/bin/etcd \
  --name "$(bashio::config 'NODE_NAME')" \
  --data-dir /data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --initial-advertise-peer-urls http://0.0.0.0:2380 \
  --initial-cluster "$(bashio::config 'NODE_NAME')"=http://0.0.0.0:2380 \
  --initial-cluster-state "$(bashio::config 'INITIAL_CLUSTER_STATE')" \
  --log-level "$(bashio::config 'LOG_LEVEL')" \
  --log-outputs stderr
