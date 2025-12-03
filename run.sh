#!/usr/bin/with-contenv bashio
set -e

while true; do
  # Load config values
  sunsynk_user="$(bashio::config 'sunsynk_user')"
  sunsynk_pass="$(bashio::config 'sunsynk_pass')"
  sunsynk_serial="$(bashio::config 'sunsynk_serial')"
  HA_LongLiveToken="$(bashio::config 'HA_LongLiveToken')"
  Home_Assistant_IP="$(bashio::config 'Home_Assistant_IP')"
  Home_Assistant_PORT="$(bashio::config 'Home_Assistant_PORT')"
  Refresh_rate="$(bashio::config 'Refresh_rate')"
  Enable_HTTPS="$(bashio::config 'Enable_HTTPS')"
  API_Server="$(bashio::config 'API_Server')"
  use_internal_api="$(bashio::config 'use_internal_api')"

  bashio::log.info "Starting SolarSynkV3 polling cycle..."
  bashio::log.info "Home Assistant: ${Home_Assistant_IP}:${Home_Assistant_PORT} HTTPS=${Enable_HTTPS}"
  bashio::log.info "API Server: ${API_Server} internal_api=${use_internal_api}"
  bashio::log.info "Serial set: $([[ -n "${sunsynk_serial}" ]] && echo yes || echo no)"
  bashio::log.info "User set: $([[ -n "${sunsynk_user}" ]] && echo yes || echo no)"
  bashio::log.info "Token set: $([[ -n "${HA_LongLiveToken}" ]] && echo yes || echo no)"
  bashio::log.info "Refresh rate: ${Refresh_rate}s"

  # Run the main script (if it exits non-zero, the add-on will error visibly)
  python3 /main.py

  bashio::log.info "Cycle complete. Sleeping for ${Refresh_rate} seconds..."
  sleep "${Refresh_rate}"
done
