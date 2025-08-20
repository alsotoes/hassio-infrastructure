# Start from a minimal base
FROM debian:bullseye-slim

# Install Samba server and client tools
RUN apt-get update && \
    apt-get install -y samba smbclient cifs-utils && \
    rm -rf /var/lib/apt/lists/*

# Copy add-on configuration & entrypoint
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Create Samba config directory
RUN mkdir -p /config /data /share

# Expose Samba ports
EXPOSE 139 445

CMD ["/run.sh"]
