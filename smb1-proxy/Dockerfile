ARG BUILD_FROM
FROM ${BUILD_FROM}
ENV DEBIAN_FRONTEND=noninteractive

# Install packages and clean up in single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        samba \
        smbclient \
        smbnetfs \
        fuse3 \
        avahi-daemon \
        dbus \
        jq \
        bash \
        ca-certificates \
        netcat-openbsd \
        python3 && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* && \
    rm -rf /var/cache/debconf/* /var/lib/dpkg/info/*

COPY rootfs /

RUN chmod 0755 \
    /etc/cont-init.d/10-configure \
    /etc/services.d/dbus/run \
    /etc/services.d/avahi/run \
    /etc/services.d/mounter/run \
    /etc/services.d/smbd/run \
    /etc/services.d/webui/run \
    /etc/services.d/mounter/finish \
    /etc/services.d/smbd/finish \
    /usr/local/bin/health-check \
    /usr/local/bin/status-server

EXPOSE 137/udp 138/udp 139/tcp 445/tcp 631/tcp 9876/tcp
