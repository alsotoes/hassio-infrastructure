# smb1-proxy Add-on for Home Assistant

This Home Assistant add-on mounts an **old Apple Time Capsule (or any SMB1/NT1-only share)** and re-exports it over **modern SMB2/3** so other devices on your network can access it safely.
It can also expose the mounted data inside Home Assistant’s `/share` folder for use by other add-ons.

---

## Features

- Connects to legacy SMB1/NT1 servers (e.g. Apple Time Capsule).
- Uses **FUSE smbnetfs** for secure userspace mounting (requires SYS_ADMIN for mount registration).
- Re-exports the mounted path via **Samba SMB2/3** for modern clients.
- Optionally exposes the mounted share at `/share/<name>` for local add-ons.
- Supports legacy **NTLMv1 authentication** if required.
- Avahi + D-Bus included for mDNS/NetBIOS discovery.
- Configurable access controls (`hosts_allow`, `interfaces`).
- **Auto-recovery**: Automatically remounts on connection failures.
- **Health monitoring**: Built-in health checks for mount status.
- **Web UI**: Real-time status monitoring on port 8080.
- **Graceful shutdown**: Clean unmounting and process termination.
- **AppArmor security**: Enhanced container security profile.

---

## Installation

   - Go to **Settings → Add-ons → Add-on Store**.
   - Click **⋮ → Reload**.
   - Find **smb1-proxy**, click **Install**.
   - **Supports all architectures**: aarch64, amd64, armhf, armv7, i386

---

## Configuration

Example configuration:

```yaml
tc_host: "timecapsule.local"       # Hostname or IP of your Time Capsule
tc_share: "Data"                   # Share name (default on TC is "Data")
tc_username: "admin"
tc_password: "your-password"
tc_domain: ""                      # Leave empty unless your device requires it
mount_point: "/data/timecapsule"   # Where to mount inside the add-on
reexport_share_name: "timecapsule" # Name of the re-exported Samba share
allow_ntlmv1: true                 # Enable if authentication fails
allow_smb1: true                   # Force SMB1 client protocol
hosts_allow:
  - "192.168.0.0/16"
interfaces: []
expose_in_share: true              # Expose the mount inside HA's /share
share_link_name: "timecapsule"     # Path: /share/timecapsule
```

---

## Usage

- **Network access (SMB2/3):**
  - Windows: `\\<HA-IP>\timecapsule`
  - macOS/Linux: `smb://<HA-IP>/timecapsule`

- **Local access inside HA (if enabled):**
  - `/share/timecapsule`

- **Web UI monitoring:**
  - Status page: `http://<HA-IP>:8080`
  - JSON API: `http://<HA-IP>:8080/api/status`

---

## Troubleshooting

- If `smbnetfs` cannot locate your share:
  - Use the Time Capsule’s IP instead of hostname.
  - Try uppercase hostnames (NetBIOS).
- Enable `allow_ntlmv1: true` if you get authentication errors.
- Check logs for details — the mounter service logs mount errors and lists available shares if detection fails.

---

## Security Notes

- **SMB1 and NTLMv1 are insecure.** This add-on is a **gateway**:
  - It uses SMB1 internally to connect to the Time Capsule.
  - It re-exports the data via SMB2/3, so your LAN devices connect securely.
- Do not expose SMB1 directly to your network.

---

## License

GPL-3.0
