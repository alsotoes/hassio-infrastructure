#!/usr/bin/env bash
set -e

# Variables passed via add-on config (see config.json)
OLD_SERVER="${OLD_SERVER:-192.168.1.50}"
OLD_SHARE="${OLD_SHARE:-Share}"
OLD_USER="${OLD_USER:-guest}"
OLD_PASS="${OLD_PASS:-}"
MOUNTPOINT="/data/oldshare"

mkdir -p "$MOUNTPOINT"

# Mount legacy SMB1 share
mount -t cifs "//$OLD_SERVER/$OLD_SHARE" "$MOUNTPOINT" \
    -o username=$OLD_USER,password=$OLD_PASS,vers=1.0,sec=ntlm,nounix,noserverino

# Write Samba config
cat > /etc/samba/smb.conf <<EOF
[global]
   workgroup = WORKGROUP
   server string = SMB1 Proxy
   security = user
   map to guest = Bad User
   smb encrypt = required
   min protocol = SMB2
   max protocol = SMB3

[proxied]
   path = $MOUNTPOINT
   browseable = yes
   writable = yes
   guest ok = yes
   read only = no
EOF

# Launch Samba daemons
/usr/sbin/smbd --foreground --no-process-group
