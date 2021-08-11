ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:10.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache \
        mariadb-client=10.5.12-r0 \
        nginx=1.20.1-r3 \
        php7-curl=7.4.21-r0 \
        php7-fpm=7.4.21-r0 \
        php7-gd=7.4.21-r0 \
        php7-iconv=7.4.21-r0 \
        php7-json=7.4.21-r0 \
        php7-mbstring=7.4.21-r0 \
        php7-mysqli=7.4.21-r0 \
        php7-opcache=7.4.21-r0 \
        php7-session=7.4.21-r0 \
        php7-xml=7.4.21-r0 \
        php7-zip=7.4.21-r0 \
        php7=7.4.21-r0 \
    \
    && mkdir /var/www/phpmyadmin \
    && curl -L -s \
        "https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.tar.gz" \
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
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
