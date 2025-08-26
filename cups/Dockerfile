ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian:bookworm
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        jq \
        sudo \
        locales \
        cups \
        avahi-daemon \
        libnss-mdns \
        dbus \
        colord \
        printer-driver-all \
        printer-driver-splix \
        printer-driver-gutenprint \
        openprinting-ppds \
        hpijs-ppds \
        hp-ppd  \
        hplip \
        printer-driver-foo2zjs \
        cups-pdf \
        gnupg2 \
        lsb-release \
        samba \
        procps \
        whois \
        wget \
        expect \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_2_all.deb \
    && echo "deb https://www.bchemnet.com/suldr/ debian extra" >> /etc/apt/sources.list \
    && dpkg -i suldr-keyring_2_all.deb && apt-get update \
    && apt-get install -y suld-driver2-1.00.39hp && apt-get clean -y \
    && rm -f suldr-keyring_2_all.deb && rm -rf /var/lib/apt/lists/*

# run hp-plugin via an expect script without heredoc
RUN set -eux; \
    printf '%s\n' \
      'spawn hp-plugin -i' \
      'expect "Enter option (d=download*, p=specify path, q=quit) ?"' \
      'send "d\r"' \
      'expect "Do you accept the license terms for the plug-in (y=yes*, n=no, q=quit) ?"' \
      'send "y\r"' \
      'expect eof' \
    > /tmp/hp-plugin.exp; \
    expect /tmp/hp-plugin.exp; \
    rm -f /tmp/hp-plugin.exp

COPY rootfs /
RUN chmod 0755 /etc/cont-init.d/10-avahi \
    /etc/cont-init.d/20-cups-service-name \
    /etc/cont-init.d/30-cups-web \
    /etc/services.d/dbus/run \
    /etc/services.d/avahi/run \
    /etc/services.d/cupsd/run

# Add user and disable sudo password checking
RUN useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/print \
  --shell=/bin/bash \
  --password=$(mkpasswd print) \
  print \
&& sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

EXPOSE 631

# Build arguments
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ARG BUILD_ARCH

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Alvaro Soto <alsotoes@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}, ${BUILD_DESCRIPTION}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Alvaro Soto" \
    org.opencontainers.image.authors="Alvaro Soto <alsotoes@gmail.com>" \
    org.opencontainers.image.licenses="GPL-3.0 license" \
    org.opencontainers.image.url="https://headup.ws" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_VERSION} \
    org.opencontainers.image.version=${BUILD_VERSION}
