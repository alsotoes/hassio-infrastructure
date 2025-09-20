# Changelog

## 0.1.1

- Fix: bashio permission denied error by switching to standard bash
- Update: AppArmor profile cleaned up (removed bashio reference)

## 0.1.0

- Fix: Container initialization permission error (/init)
- Fix: AppArmor profile with proper library and device access
- Improve: Changed CMD to ENTRYPOINT for reliable startup
- Security: Enhanced AppArmor profile with additional protections

## 0.0.9

- Add: AppArmor security profile for enhanced container security
- Update: etcd to v3.6.0
- Security: Implement mandatory access controls with AppArmor

## 0.0.8

- Fix: issues/3
- Update to etcd v3.5.0
- Check for ETCD_INITIAL_CLUSTER_STATE now in run.sh
- Update hassio image to latest
- Adding support for amd64

## 0.0.7

- Fix: errors getting enviromental variables
- Disable port changing

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
