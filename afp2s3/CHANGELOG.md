# Changelog

## 0.1.1

- Add AFP mount validation to abort startup if the share cannot be mounted.
- Ensure the image includes `mountpoint` by installing `util-linux`.

## 0.1.0

- Initial release
- This add-on mounts a remote AFP (Apple Filing Protocol) share into the add-on's filesystem and exposes it as an S3-compatible object storage endpoint using Minio.
