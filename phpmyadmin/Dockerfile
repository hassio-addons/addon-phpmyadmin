ARG BUILD_FROM=hassioaddons/base:7.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache \
        mariadb-client=10.4.12-r0 \
        nginx=1.16.1-r6 \
        php7-curl=7.3.16-r0 \
        php7-fpm=7.3.16-r0 \
        php7-gd=7.3.16-r0 \
        php7-json=7.3.16-r0 \
        php7-mbstring=7.3.16-r0 \
        php7-mysqli=7.3.16-r0 \
        php7-opcache=7.3.16-r0 \
        php7-session=7.3.16-r0 \
        php7-zip=7.3.16-r0 \
        php7=7.3.16-r0 \
    \
    && mkdir /var/www/phpmyadmin \
    && curl -L -s \
        "https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz" \
        | tar zxvf - --strip 1 -C /var/www/phpmyadmin \
    \
    && sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" \
        /var/www/phpmyadmin/libraries/vendor_config.php \
    \
    && find /var/www/ -type f -name "*.md" -depth -exec rm -f {} \; \
    && rm -f -r \
        /tmp/* \
        /etc/nginx \
        /var/www/phpmyadmin/setup \
        /var/www/phpmyadmin/examples \
        /var/www/phpmyadmin/test/ \
        /var/www/phpmyadmin/po \
        /var/www/phpmyadmin/composer.json \
        /var/www/phpmyadmin/RELEASE-DATE-*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="phpMyAdmin" \
    io.hass.description="A web interface for the official MariaDB add-on" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="A web interface for the official MariaDB add-on" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="phpMyAdmin" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/home-assistant-community-add-on-phpmyadmin/171729?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-phpmyadmin/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-phpadmin" \
    org.label-schema.vendor="Home Assistant Community Add-ons"
