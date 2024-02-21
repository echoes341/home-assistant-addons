#!/usr/bin/with-contenv bashio

set -e
set -o pipefail

REMOTE_IP=$(bashio::config 'remote_ip')
REMOTE_PORT=$(bashio::config 'remote_port')
LOCAL_PORT=$(bashio::config 'local_port')
MONITORING_PORT=$(bashio::config 'monitoring_port')
TARGET=$(bashio::config 'target')
key_b64=$(bashio::config 'private_key_b64')
known_hosts_b64=$(bashio::config 'known_hosts_b64')

bashio::log.info "Writing keys..."
mkdir -p ~/.ssh
echo $key_b64 | base64 -d > ~/.ssh/key
chmod 0600 ~/.ssh/key

strict_host_key_checking=no
if [ -n "$known_hosts_b64" ]; then
  bashio::log.info "known_hosts set."
  echo $known_hosts_b64 | base64 -d > ~/.ssh/known_hosts
  chmod 644 ~/.ssh/known_hosts
  strict_host_key_checking=yes
fi

bashio::log.info "Starting tunnel"
autossh -M ${MONITORING_PORT} -i ~/.ssh/key -NT \
    -o ServerAliveInterval=60 \
    -o PasswordAuthentication=no \
    -o StrictHostKeyChecking=${strict_host_key_checking} \
    -o ExitOnForwardFailure=yes \
    -R ${REMOTE_IP}:${REMOTE_PORT}:localhost:${LOCAL_PORT} \
    ${TARGET}
