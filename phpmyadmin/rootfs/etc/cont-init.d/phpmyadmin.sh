#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: phpMyAdmin
# Configures phpMyAdmin
# ==============================================================================
declare host
declare password
declare port
declare username
declare database

if ! bashio::fs.file_exists "/data/config.secret.inc.php"; then
    cat > /data/config.secret.inc.php <<EOT
<?php
\$cfg['blowfish_secret'] = '$(tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)';
EOT
fi
chmod 644 /data/config.secret.inc.php

host=$(bashio::services "mysql" "host")
password=$(bashio::services "mysql" "password")
port=$(bashio::services "mysql" "port")
username=$(bashio::services "mysql" "username")

database=$(\
    mysql \
        -u "${username}" -p"${password}" \
        -h "${host}" -P "${port}" \
        --skip-column-names \
        -e "SHOW DATABASES LIKE 'phpmyadmin';"
)

if ! bashio::var.has_value "${database}"; then
    bashio::log.info "Creating database for phpMyAdmin"
    mysql \
        -u "${username}" -p"${password}" \
        -h "${host}" -P "${port}" \
            < /var/www/phpmyadmin/sql/create_tables.sql
fi
