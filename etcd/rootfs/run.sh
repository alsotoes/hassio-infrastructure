#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Exit on error
set -ex

# Exit on pipe fails (if possible)
( set -o pipefail 2> /dev/null ) || true

/usr/local/bin/etcd \
  --name "${NODE_NAME:-etcd}" \
  --data-dir /var/lib/etcd/data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --initial-advertise-peer-urls http://0.0.0.0:2380 \
  --initial-cluster "${NODE_NAME:-etcd}"=http://0.0.0.0:2380 \
  --initial-cluster-state "${INITIAL_CLUSTER_STATE:-new}" \
  --log-level "${LOG_LEVEL:-info}" \
  --logger "${LOGGER:-capnslog}" \
  --log-outputs stderr
