#!/bin/bash
# -*- coding: utf-8 -*-

export ETCD_NAME="etcd"
export ETCD_INITIAL_CLUSTER_STATE="existing"
export ETCD_INITIAL_CLUSTER="etcd=http://0.0.0.0:2380"
export ETCD_LOG_LEVEL="info"

[ ! -d /data/members ] && export ETCD_INITIAL_CLUSTER_STATE="new"
/usr/local/bin/etcd \
    --data-dir /data \
    --listen-client-urls http://0.0.0.0:2379 \
    --advertise-client-urls http://0.0.0.0:2379 \
    --listen-peer-urls http://0.0.0.0:2380 \
    --initial-advertise-peer-urls http://0.0.0.0:2380 \
    --log-outputs stderr
