#
# adapted from official Joomla Dockerfile: https://github.com/joomla/docker-joomla (GPL v2)
#

FROM php:7.3-apache

# Disable remote database security requirements.
ENV JOOMLA_INSTALLATION_DISABLE_LOCALHOST_CHECK=1

# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Install PHP extensions
RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libbz2-dev \
        libjpeg-dev \
        libldap2-dev \
        libmemcached-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
    ; \
    \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    debMultiarch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)"; \
    docker-php-ext-configure ldap --with-libdir="lib/$debMultiarch"; \
    docker-php-ext-install -j "$(nproc)" \
        bz2 \
        gd \
        ldap \
        mysqli \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        zip \
    ; \
    \
# pecl will claim success even if one install fails, so we need to perform each install separately
    pecl install APCu-5.1.17; \
    pecl install memcached-3.1.3; \
    pecl install redis-4.3.0; \
    \
    docker-php-ext-enable \
        apcu \
        memcached \
        redis \
    ;
#    \
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
#    apt-mark auto '.*' > /dev/null; \
#    apt-mark manual $savedAptMark; \
#    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
#        | awk '/=>/ { print $3 }' \
#        | sort -u \
#        | xargs -r dpkg-query -S \
#        | cut -d: -f1 \
#        | sort -u \
#        | xargs -rt apt-mark manual; \
#    \
#    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
#    rm -rf /var/lib/apt/lists/*

#VOLUME /var/www/html

# Define Joomla version and expected SHA512 signature
#ENV JOOMLA_VERSION %%VERSION%%

# Download package and extract to web volume
#RUN set -ex; \
#    curl -o joomla.tar.bz2 -SL https://github.com/joomla/joomla-cms/releases/download/${JOOMLA_VERSION}/Joomla_${JOOMLA_VERSION}-Stable-Full_Package.tar.bz2; \
#    echo "$JOOMLA_SHA512 *joomla.tar.bz2" | sha512sum -c -; \
#    mkdir /usr/src/joomla; \
#    tar -xf joomla.tar.bz2 -C /usr/src/joomla; \
#    rm joomla.tar.bz2; \
#    chown -R www-data:www-data /usr/src/joomla

# Copy init scripts and custom .htaccess
#COPY makedb.php /makedb.php

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
