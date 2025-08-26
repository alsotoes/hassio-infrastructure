ARG BUILD_FROM
FROM ${BUILD_FROM}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update  && apt-get install -y --no-install-recommends       samba smbclient cifs-utils smbnetfs fuse3 avahi-daemon dbus jq bash ca-certificates  && rm -rf /var/lib/apt/lists/*

COPY rootfs /

RUN chmod 0755   /etc/cont-init.d/10-configure   /etc/services.d/dbus/run   /etc/services.d/avahi/run   /etc/services.d/mounter/run   /etc/services.d/smbd/run

EXPOSE 137/udp 138/udp 139/tcp 445/tcp 631/tcp
