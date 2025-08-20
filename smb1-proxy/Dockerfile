# Start from a minimal base
FROM debian:bullseye-slim

# Install Samba server and client tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        samba smbclient cifs-utils \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy entrypoint
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Create Samba config/data dirs
RUN mkdir -p /config /data /share

# Expose Samba ports
EXPOSE 139 445

# Run smbd in foreground (no capability set change)
CMD ["/run.sh"]
