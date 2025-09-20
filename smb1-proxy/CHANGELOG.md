# Changelog

## 1.2.3

- Restored SYS_ADMIN privilege requirement for FUSE mounting
- Fixed "Operation not permitted" error with smbnetfs

## 1.2.2

- Removed kernel CIFS support completely, now FUSE-only
- Removed SYS_ADMIN privilege requirement
- Removed cifs-utils package dependency
- Simplified mounting logic to use smbnetfs exclusively

## 1.2.1

- Moving to fuse to avoid kernel changes

## 1.2.0

- Changing the entire structure for a more modern hassio add-on looklike
- Re-architected to avoid kernel CIFS mounts; no special capabilities needed; compatible with HA Core 2025.8.x

## 1.0.2

- Changes with outdated DAC capability

## 1.0.1

- Fix CAP issues for error "Unable to apply new capability set"
