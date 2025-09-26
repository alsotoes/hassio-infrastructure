# Changelog

## 0.1.7

- Refactor Dockerfile to fix build issues on arm64.
- Use multi-stage build to compile afpfs-ng from source.
- Use alpine-based image for the build stage.
- Remove patch for afpfs-ng, as it is no longer needed.
- Split RUN command in build stage into multiple commands.
- Add DESTDIR to make install command.

## 0.1.6

- Change the builder layer to arm64v8/ubuntu:jammy

## 0.1.5

- Build `afpfs-ng` from source to guarantee AFP mount tools are shipped with the image.
- Patch upstream `afpfs-ng` to fix a compile-time error when closing Desktop database handles.

## 0.1.4

- Validate AFP mounts by requiring the `.com.apple.timemachine.supported` marker file from the remote share.

## 0.1.3

- Fix AFP mounting on systems where the `afp_client` binary is unavailable by adding fallbacks to other AFP utilities.

## 0.1.2

- Disable the AppArmor profile to increase compatibility with environments that lack AppArmor support.

## 0.1.1

- Add AFP mount validation to abort startup if the share cannot be mounted.
- Ensure the image includes `mountpoint` by installing `util-linux`.

## 0.1.0

- Initial release
- This add-on mounts a remote AFP (Apple Filing Protocol) share into the add-on's filesystem and exposes it as an S3-compatible object storage endpoint using Minio.
