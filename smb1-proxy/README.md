# Home Assistant Community Add-on: SMB1 Proxy

![Supports amd64 Architecture][amd64-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports arm64 Architecture][arm64-shield]

[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

![smb1-proxy Logo](https://raw.githubusercontent.com/alsotoes/hassio-infrastructure/main/smb1-proxy/logo.svg)

Some legacy devices (old NAS, printers, Windows XP machines, etc.) only support the **SMB1 (CIFS/NT1)** protocol, which modern Linux kernels and Home Assistant no longer support for security reasons.  

This add-on acts as a **proxy**:
- Connects to the legacy SMB1 share.
- Re-exports it as a modern **SMB2/SMB3 share** that Home Assistant and other devices can mount safely.

⚠️ **Important:** SMB1 is insecure. Only use this add-on on trusted networks, and consider migrating data off legacy devices whenever possible.

---

## 🚀 Installation

1. Copy this add-on into your Home Assistant `addons/` folder: /config/addons/smb1-proxy/

The folder should contain:
- `Dockerfile`
- `config.json`
- `run.sh`
- `README.md` (this file)

2. Go to **Home Assistant → Settings → Add-ons → Add-on Store**.
3. Click the **⋮ menu → Repositories → Local add-ons**.
4. Find and install **SMB1 Proxy**.

---

## ⚙️ Configuration

The add-on uses environment variables to define the old SMB1 server details.

Example configuration in Home Assistant:

```yaml
OLD_SERVER: "192.168.1.50"
OLD_SHARE: "LegacyShare"
OLD_USER: "guest"
OLD_PASS: ""
```

| Option       | Description                           | Default  |
| ------------ | ------------------------------------- | -------- |
| `OLD_SERVER` | IP or hostname of the old SMB1 server | required |
| `OLD_SHARE`  | Share name on the old server          | required |
| `OLD_USER`   | Username for the old server           | `guest`  |
| `OLD_PASS`   | Password for the old server           | empty    |


📂 Accessing the Proxied Share

Once the add-on is running:

The legacy share is mounted inside the container.

The container runs a Samba server that re-exports it as SMB3.

You can access it from other devices (including Home Assistant host) at:

\\<home-assistant-host>\proxied


Example from Linux:
```bash
sudo mount -t cifs //homeassistant.local/proxied /mnt/proxied \
  -o username=guest,password=,vers=3.0
```

🔒 Security Notes

SMB1 is deprecated and insecure (exploited by malware like WannaCry).

Keep the add-on and device on a trusted local network only.

Consider migrating data away from SMB1 devices as a long-term solution.

🛠️ Troubleshooting

If the share does not mount, check logs with:

```bash
docker logs addon_smb1_proxy
```

Add sec=ntlm or sec=lanman in run.sh if your device requires older authentication.

If you can’t connect to the proxy share, verify firewall rules and ensure ports 139 and 445 are open.

---

👉 Do you also want me to add **examples for mounting the proxied share inside Home Assistant OS** (so HA can directly use it as `/media` or `/backup`)? That would make it really convenient.

---

📜 License
This add-on is provided as-is, with no warranty. Use at your own risk.
