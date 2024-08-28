#!/usr/bin/env bashio
# -*- coding: utf-8 -*-

declare etcd_name
declare etcd_initial_cluster_state
declare etcd_initial_cluster
declare etcd_log_level

etcd_name="$(bashio::config 'node_name')"
etcd_initial_cluster_state="$(bashio::config 'initial_cluster_state')"
etcd_initial_cluster="$(bashio::config 'node_name')=http://0.0.0.0:2380"
etcd_log_level="$(bashio::config 'log_level')"

if [ bashio::config.has_value 'node_name' ] ; then
    export ETCD_NAME=${etcd_name}
    export ETCD_INITIAL_CLUSTER_STATE=${etcd_initial_cluster_state}
    export ETCD_INITIAL_CLUSTER="${etcd_initial_cluster}"
    export ETCD_LOG_LEVEL="${etcd_log_level}"
else
    export ETCD_NAME="etcd"
    export ETCD_INITIAL_CLUSTER_STATE="new"
    export ETCD_INITIAL_CLUSTER="etcd=http://0.0.0.0:2380"
    export ETCD_LOG_LEVEL="info"
fi

/usr/local/bin/etcd \
    --data-dir /data \
    --listen-client-urls http://0.0.0.0:2379 \
    --advertise-client-urls http://0.0.0.0:2379 \
    --listen-peer-urls http://0.0.0.0:2380 \
    --initial-advertise-peer-urls http://0.0.0.0:2380 \
    --log-outputs stderr
