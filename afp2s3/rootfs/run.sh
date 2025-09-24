#!/bin/bash

# Read options
AFP_SERVER=$(jq --raw-output ".afp_server" /data/options.json)
AFP_USER=$(jq --raw-output ".afp_user" /data/options.json)
AFP_PASSWORD=$(jq --raw-output ".afp_password" /data/options.json)


# Create mount point
MOUNT_POINT="/mnt/afp"
mkdir -p "${MOUNT_POINT}"

# Mount AFP share
if ! afp_client mount -u "${AFP_USER}" -p "${AFP_PASSWORD}" "${AFP_SERVER}" "${MOUNT_POINT}"; then
    echo "Failed to mount AFP share" >&2
    exit 1
fi

# Verify mount succeeded before continuing
if ! mountpoint -q "${MOUNT_POINT}"; then
    echo "AFP mount validation failed" >&2
    exit 1
fi

# Get architecture
ARCH=$(uname -m)
case "${ARCH}" in
    "x86_64")
        MINIO_ARCH="amd64"
        ;;
    "armv7l")
        MINIO_ARCH="arm"
        ;;
    "aarch64")
        MINIO_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

# Download Minio
MINIO_URL="https://dl.min.io/server/minio/release/linux-${MINIO_ARCH}/minio"
wget "${MINIO_URL}" -O /usr/local/bin/minio
chmod +x /usr/local/bin/minio

minio server "${MOUNT_POINT}" --console-address ":9001"
