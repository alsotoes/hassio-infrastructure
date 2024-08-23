# Home Assistant Community Add-on: etcd

![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield]

[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

**IMPORTANT:** 

- **Only use this add-on if you are running home assistant on SSD drives** otherwise, the server will constantly fail because of low IO.
- INITIAL_CLUSTER_STATE is set to **existing** by default, so change this to **new** the first time you start the service to allow the node bootstrap and then change it back to **existing** to avoid failure.

## About this integration

* *Image*: I use minideb created by bitnami [here](https://hub.docker.com/r/bitnami/etcd/), [README.md](https://github.com/bitnami/minideb/blob/master/README.md)
* *app*: etcd repo can be found [here](https://github.com/etcd-io/etcd), [README.md](https://github.com/etcd-io/etcd/blob/main/README.md)

![etcd Logo](https://raw.githubusercontent.com/etcd-io/etcd/main/logos/etcd-horizontal-color.svg)

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being:

* *Simple*: well-defined, user-facing API (gRPC)
* *Secure*: automatic TLS with optional client cert authentication
* *Fast*: benchmarked 10,000 writes/sec
* *Reliable*: properly distributed using Raft

etcd is written in Go and uses the [Raft](https://github.com/etcd-io/raft) [README.md](https://github.com/etcd-io/raft/blob/main/README.md) consensus algorithm to manage a highly-available replicated log.

### Environment variables

### Customizable environment variables

| Name                          | Description                                                                                  | Default Value           |
|-------------------------------|----------------------------------------------------------------------------------------------|-------------------------|
| `LOG_LEVEL`                   | etcd log level.                                                                              | `info`                  |
| `INITIAL_CLUSTER_STATE`       | Initial cluster state. Allowed values: "new" or "existing".                                  | `existing`              |
| `NODE_NAME`                   | etcd member name.                                                                            | `nil`                   |

### Read-only environment variables

| Name                               | Description                                                                                  | Value                              |
|------------------------------------|----------------------------------------------------------------------------------------------|------------------------------------|
| `ETCDCTL_API`                      | etcdctl API version.                                                                         | `3`                                |
| `ETCD_DATA_DIR`                    | etcd data directory.                                                                         | `/var/lib/etcd`                    |
| `ETCD_LOG_OUTPUTS`                 | ‘stderr’ to skip journald logging even when running under systemd                            | `stderr`                           |
| `ETCD_LISTEN_CLIENT_URLS`          | List of URLs to listen on for client traffic.                                                | `http://0.0.0.0:2379`              |
| `ETCD_ADVERTISE_CLIENT_URLS`       | List of this member client URLs to advertise to the rest of the cluster.                     | `http://0.0.0.0:2379`              |
| `ETCD_LISTEN_PEER_URLS`            | List of URLs to listen on for peers traffic.                                                 | `http://0.0.0.0:2380`              |
| `ETCD_INITIAL_ADVERTISE_PEER_URLS` | List of this member peer URLs to advertise to the rest of the cluster while bootstrapping.   | `http://0.0.0.0:2380`              |
