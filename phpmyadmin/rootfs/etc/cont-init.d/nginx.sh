#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: phpMyAdmin
# Configures nginx
# ==============================================================================
declare upload_limit

upload_limit="64M"

if bashio::config.has_value 'upload_limit'; then
    upload_limit=$(bashio::config "upload_limit")M
fi

sed -i "s/%%upload_limit%%/${upload_limit}/g" \
    /etc/nginx/includes/server_params.conf
