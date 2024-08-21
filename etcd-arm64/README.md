# Home Assistant Community Add-on: etcd

**Only use this add-on if you are running home assistant on SSD drives**

![etcd Logo](https://raw.githubusercontent.com/etcd-io/etcd/main/logos/etcd-horizontal-color.svg)

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being:

* *Simple*: well-defined, user-facing API (gRPC)
* *Secure*: automatic TLS with optional client cert authentication
* *Fast*: benchmarked 10,000 writes/sec
* *Reliable*: properly distributed using Raft

etcd is written in Go and uses the [Raft][] consensus algorithm to manage a highly-available replicated log.

## Configuration

You can find a sample configuration file on this [link](https://github.com/coreos/etcd/blob/master/etcd.conf.yml.sample)

### Environment variables

Apart from providing your custom configuration file, you can also modify the server behavior via configuration as environment variables.

#### Customizable environment variables

| Name                               | Description                                                                                  | Default Value           |
|------------------------------------|----------------------------------------------------------------------------------------------|-------------------------|
| `ETCD_SNAPSHOTS_DIR`               | etcd snaphots directory (used on "disaster recovery" feature).                               | `/snapshots`            |
| `ETCD_SNAPSHOT_HISTORY_LIMIT`      | etcd snaphots history limit.                                                                 | `1`                     |
| `ETCD_INIT_SNAPSHOTS_DIR`          | etcd init snaphots directory (used on "init from snapshot" feature).                         | `/init-snapshot`        |
| `ALLOW_NONE_AUTHENTICATION`        | Allow accessing etcd without any password.                                                   | `no`                    |
| `ETCD_ROOT_PASSWORD`               | Password for the etcd root user.                                                             | `nil`                   |
| `ETCD_CLUSTER_DOMAIN`              | Domain to use to discover other etcd members.                                                | `nil`                   |
| `ETCD_START_FROM_SNAPSHOT`         | Whether etcd should start from an existing snapshot or not.                                  | `no`                    |
| `ETCD_DISASTER_RECOVERY`           | Whether etcd should try or not to recover from snapshots when the cluste disastrously fails. | `no`                    |
| `ETCD_ON_K8S`                      | Whether etcd is running on a K8s environment or not.                                         | `no`                    |
| `ETCD_INIT_SNAPSHOT_FILENAME`      | Existing snapshot filename to start the etcd cluster from.                                   | `nil`                   |
| `ETCDCTL_API`                      | etcdctl API version.                                                                         | `3`                     |
| `ETCD_DISABLE_STORE_MEMBER_ID`     | Disable writing the member id in a file.                                                     | `no`                    |
| `ETCD_DISABLE_PRESTOP`             | Disable running the pre-stop hook.                                                           | `no`                    |
| `ETCD_NAME`                        | etcd member name.                                                                            | `nil`                   |
| `ETCD_LOG_LEVEL`                   | etcd log level.                                                                              | `info`                  |
| `ETCD_LISTEN_CLIENT_URLS`          | List of URLs to listen on for client traffic.                                                | `http://0.0.0.0:2379`   |
| `ETCD_ADVERTISE_CLIENT_URLS`       | List of this member client URLs to advertise to the rest of the cluster.                     | `http://127.0.0.1:2379` |
| `ETCD_INITIAL_CLUSTER`             | Initial list of members to bootstrap a cluster.                                              | `nil`                   |
| `ETCD_INITIAL_CLUSTER_STATE`       | Initial cluster state. Allowed values: "new" or "existing".                                  | `nil`                   |
| `ETCD_LISTEN_PEER_URLS`            | List of URLs to listen on for peers traffic.                                                 | `nil`                   |
| `ETCD_INITIAL_ADVERTISE_PEER_URLS` | List of this member peer URLs to advertise to the rest of the cluster while bootstrapping.   | `nil`                   |
| `ETCD_INITIAL_CLUSTER_TOKEN`       | Unique initial cluster token used for bootstrapping.                                         | `nil`                   |
| `ETCD_AUTO_TLS`                    | Use generated certificates for TLS communications with clients.                              | `false`                 |
| `ETCD_CERT_FILE`                   | Path to the client server TLS cert file.                                                     | `nil`                   |
| `ETCD_KEY_FILE`                    | Path to the client server TLS key file.                                                      | `nil`                   |
| `ETCD_TRUSTED_CA_FILE`             | Path to the client server TLS trusted CA cert file.                                          | `nil`                   |
| `ETCD_CLIENT_CERT_AUTH`            | Enable client cert authentication                                                            | `false`                 |
| `ETCD_PEER_AUTO_TLS`               | Use generated certificates for TLS communications with peers.                                | `false`                 |

#### Read-only environment variables

| Name                        | Description                                                          | Value                              |
|-----------------------------|----------------------------------------------------------------------|------------------------------------|
| `ETCD_BASE_DIR`             | etcd installation directory.                                         | `/opt/bitnami/etcd`                |
| `ETCD_VOLUME_DIR`           | Persistence base directory.                                          | `/bitnami/etcd`                    |
| `ETCD_BIN_DIR`              | etcd executables directory.                                          | `${ETCD_BASE_DIR}/bin`             |
| `ETCD_DATA_DIR`             | etcd data directory.                                                 | `${ETCD_VOLUME_DIR}/data`          |
| `ETCD_CONF_DIR`             | etcd configuration directory.                                        | `${ETCD_BASE_DIR}/conf`            |
| `ETCD_DEFAULT_CONF_DIR`     | etcd default configuration directory.                                | `${ETCD_BASE_DIR}/conf.default`    |
| `ETCD_TMP_DIR`              | Directory where ETCD temporary files are stored.                     | `${ETCD_BASE_DIR}/tmp`             |
| `ETCD_CONF_FILE`            | Airflow configuration file.                                          | `${ETCD_CONF_DIR}/etcd.yaml`       |
| `ETCD_NEW_MEMBERS_ENV_FILE` | File containining the etcd environment to use after adding a member. | `${ETCD_DATA_DIR}/new_member_envs` |
| `ETCD_DAEMON_USER`          | etcd system user name.                                               | `etcd`                             |
| `ETCD_DAEMON_GROUP`         | etcd system user group.                                              | `etcd`                             |

Additionally, you can configure etcd using the upstream env variables [here](https://etcd.io/docs/v3.4/op-guide/configuration/)
