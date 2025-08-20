#!/usr/bin/env bash
set -e

# Mount SMB1 share
mkdir -p /data/oldshare

mount -t cifs "//$OLD_SERVER/$OLD_SHARE" /data/oldshare \
  -o username=$OLD_USER,password=$OLD_PASS,vers=1.0,sec=ntlm,nounix,noserverino

# Generate Samba config
cat > /etc/samba/smb.conf <<EOF
[global]
   workgroup = WORKGROUP
   server string = SMB1 Proxy
   security = user
   map to guest = Bad User
   smb encrypt = required
   min protocol = SMB2
   max protocol = SMB3
   disable netbios = yes
   load printers = no
   printing = bsd
   printcap name = /dev/null
   disable spoolss = yes

[proxied]
   path = /data/oldshare
   browseable = yes
   writable = yes
   guest ok = yes
   read only = no
EOF

# Run Samba without capability issues
exec /usr/sbin/smbd --foreground --no-process-group --debug-stdout
