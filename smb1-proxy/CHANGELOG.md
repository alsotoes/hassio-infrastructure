# Changelog

## 1.3.1

- Fixed JSON parsing errors in configuration script with better error handling
- Resolved directory creation conflicts on container restarts
- Added proper PNG icon and logo files (512x512) with One Piece jigsaw puzzle theme
- Improved configuration script robustness with fallback values

## 1.3.0

- Disabled AppArmor to resolve s6-overlay init system compatibility issues
- Improved add-on description to highlight key features
- Replaced old PNG icons with new One Piece jigsaw puzzle themed SVG designs
- Prioritized functionality over security profile for better user experience

## 1.2.9

- Added multi-architecture support (aarch64, amd64, armhf, armv7, i386)
- Optimized container image size with aggressive cleanup and single-layer builds
- Enhanced AppArmor profile with additional system permissions
- Improved compatibility across all Home Assistant hardware platforms

## 1.2.8

- Added ingress support for seamless Home Assistant UI integration
- Fixed AppArmor profile to allow s6-overlay init system execution
- Enhanced web UI accessibility through Home Assistant interface

## 1.2.7

- Added web UI for status monitoring (accessible on port 8080)
- Implemented JSON API endpoint for programmatic status checks
- Added real-time service and mount health monitoring
- Enhanced user experience with visual status indicators

## 1.2.6

- Added health check monitoring for SMB mount status
- Implemented auto-remount on mount failures (30-second intervals)
- Added graceful shutdown handling for all services
- Fixed AppArmor profile to allow proper container initialization
- Enhanced reliability with automatic recovery from network issues

## 1.2.5

- Added AppArmor security profile for enhanced container security
- Improved directory creation logic to check existence before mkdir
- Enabled AppArmor protection by default

## 1.2.4

- Fixed JSON parsing error in configuration script
- Fixed directory creation conflicts on container restart
- Improved error handling for empty configuration arrays

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
