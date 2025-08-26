# Home Assistant Add-on: SMB1 Proxy (No kernel mounts)

This add-on provides a **Samba server** that accepts **legacy SMB1/NT1** clients and
re-exports a local directory from your Home Assistant host. It **does not** attempt to
mount remote CIFS/SMB shares from inside the container, so it avoids the
“Unable to apply new capability set.” error caused by missing kernel capabilities.

## What this add-on does
- Serves a **single** share to your LAN using Samba (SMB/CIFS).
- Can **allow SMB1/NT1** and weaker NTLMv1 auth for very old clients (Windows XP, old TVs, embedded NAS). Controlled via options.
- Stores files in a host-mapped directory (default: `/share/smb1-proxy`) so data persists and is visible to other add-ons/host.

## What this add-on does NOT do
- It **does not mount** a remote SMB share from inside the container.
  If you need to proxy a remote share, mount it on the *host* (or another box) and
  point the `export_path` to that mount via the `/share` mapping.

## Requirements
- Home Assistant **OS** + **Supervisor** (you have this).
- Architecture: works on all HA arches (`aarch64`, `amd64`, `armv7`, `armhf`, `i386`).
- Uses **host networking** to bind SMB ports (137/138/139/445).

## Installation
1. Copy this folder into your local add-ons repo on the host, e.g.:
   `/usr/share/hassio/addons/local/ha-addon-smb1-proxy`
2. In Home Assistant: *Settings → Add-ons → Add-on Store* → refresh → open **SMB1 Proxy** → **Install**.
3. Configure options (username/password, share name, `export_path`, and SMB1 toggles).
4. Start the add-on; check the **Logs**.
5. From a client, connect to `\<HA-IP>\<share_name>` (Windows) or `smb://<HA-IP>/<share_name>` (macOS/Linux).

## Options (with sensible defaults)
```yaml
workgroup: "WORKGROUP"
share_name: "smb1"
export_path: "/share/smb1-proxy"
username: "smb1"
password: "changeme"
read_only: false
allow_smb1: true
allow_ntlmv1: true
guest_ok: false
hosts_allow: ["192.168.0.0/16", "10.0.0.0/8", "172.16.0.0/12"]
interfaces: []  # e.g. ["eth0"]
```

- **allow_smb1**: If `true`, sets `server min protocol = NT1` to allow SMB1. If `false`, min protocol is SMB2.
- **allow_ntlmv1**: If `true`, enables `ntlm auth = yes` for very old clients. Leaving it `false` is more secure.
- **guest_ok**: If `true`, allows guest access for the share (no password). Not recommended.
- **hosts_allow**: Restrict LANs that may connect.
- **interfaces**: Force Samba to bind only to specific interfaces (optional).

## Security
SMB1 and NTLMv1 are insecure and should be used **only** on trusted LANs for legacy devices.
Use `hosts_allow` to restrict access and consider placing legacy devices on an isolated VLAN.

## Changelog
- 0.2.0: Re-architected to avoid kernel CIFS mounts; no special capabilities needed; compatible with HA Core 2025.8.x.
