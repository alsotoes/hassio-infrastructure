#!/usr/bin/with-contenv bashio

# Wait for Avahi to be ready
until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Starting CUPS server..."

cupsd -f
