#!/bin/bash

# Read options
AFP_SERVER=$(jq --raw-output ".afp_server" /data/options.json)
AFP_USER=$(jq --raw-output ".afp_user" /data/options.json)
AFP_PASSWORD=$(jq --raw-output ".afp_password" /data/options.json)


# Create mount point
MOUNT_POINT="/mnt/afp"
mkdir -p "${MOUNT_POINT}"

mount_afp_share() {
    local server="$1"
    local mount_point="$2"
    local user="$3"
    local password="$4"

    if command -v afp_client >/dev/null 2>&1; then
        afp_client mount -u "${user}" -p "${password}" "${server}" "${mount_point}"
        return $?
    fi

    local server_without_scheme="${server#afp://}"
    local server_path
    if [ "${server_without_scheme}" = "${server}" ]; then
        server_path="${server}"
    else
        server_path="${server_without_scheme}"
    fi
    local url_with_credentials="afp://${user}:${password}@${server_path}"

    if command -v mount_afp >/dev/null 2>&1; then
        mount_afp "${url_with_credentials}" "${mount_point}"
        return $?
    fi

    if command -v afpfs-ng >/dev/null 2>&1; then
        afpfs-ng mount "${url_with_credentials}" "${mount_point}"
        return $?
    fi

    echo "No AFP mounting utility (afp_client, mount_afp, afpfs-ng) is available." >&2
    return 1
}

# Mount AFP share
if ! mount_afp_share "${AFP_SERVER}" "${MOUNT_POINT}" "${AFP_USER}" "${AFP_PASSWORD}"; then
    echo "Failed to mount AFP share" >&2
    exit 1
fi

# Verify mount succeeded before continuing
if ! mountpoint -q "${MOUNT_POINT}"; then
    echo "AFP mount validation failed" >&2
    exit 1
fi

TIMEMACHINE_MARKER="${MOUNT_POINT}/.com.apple.timemachine.supported"
if [ ! -f "${TIMEMACHINE_MARKER}" ]; then
    echo "AFP mount validation failed: Time Machine marker not found" >&2
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
