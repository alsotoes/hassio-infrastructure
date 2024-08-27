# Changelog

## 0.0.6

- Change to home-assistant image.
- Share data forder instead using docker volumes.
- Run as root instead of etcd to use /data folder.
- /data and /backups mounted RW.
- Tests passed: put, get, delete.

## 0.0.5

- First version to see the light
- Too buggy to share

## 0.0.4

- Uses etcd **v3.5.15**
- Download url set to https://storage.googleapis.com/etcd
- **arm64/aarch64** is the only supported architecture
- Too buggy to share

## 0.0.3

- Using bitnami minideb image as base
- docker volume to store the database data
- Too buggy to share

## 0.0.2 

- addon can be installed but won't start
- Too buggy to share

## 0.0.1

- First version to see the light
- Using bitnami docker image as base
- Too buggy to share
