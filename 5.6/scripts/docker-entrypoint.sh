#!/bin/bash

set -e

phpini=/usr/local/etc/php/php.ini

# php environment
PHP_ALLOW_URL_FOPEN=${PHP_ALLOW_URL_FOPEN:-On}
PHP_DISPLAY_ERRORS=${PHP_DISPLAY_ERRORS:-Off}
PHP_MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME:-30}
PHP_MAX_INPUT_TIME=${PHP_MAX_INPUT_TIME:-60}
PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-128}
PHP_POST_MAX_SIZE=${PHP_POST_MAX_SIZE:-8}
PHP_SHORT_OPEN_TAG=${PHP_SHORT_OPEN_TAG:-On}
PHP_TIMEZONE=${PHP_TIMEZONE:-Europe/Moscow}
PHP_UPLOAD_MAX_FILEZIZE=${PHP_UPLOAD_MAX_FILEZIZE:-2}

PHP_TZ=`echo ${PHP_TIMEZONE} |sed  's|\/|\\\/|g'`

# addition modules
PHP_MODULE_MEMCACHED=${PHP_MODULE_MEMCACHED:-Off}
PHP_MODULE_REDIS=${PHP_MODULE_REDIS:-Off}
PHP_MODULE_MONGO=${PHP_MODULE_MONGO:-Off}
PHP_MODULE_GEARMAN=${PHP_MODULE_GEARMAN:-Off}
PHP_MODULE_IMAP=${PHP_MODULE_IMAP:-Off}
PHP_MODULE_LDAP=${PHP_MODULE_LDAP:-Off}
PHP_MODULE_OPCACHE=${PHP_MODULE_OPCACHE:-Off}
PHP_MODULE_XCACHE=${PHP_MODULE_XCACHE:-Off}

# set timezone
echo ${PHP_TIMEZONE} | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

sed -i \
    -e "s/memory_limit = 128M/memory_limit = ${PHP_MEMORY_LIMIT}M/g" \
    -e "s/short_open_tag = Off/short_open_tag = ${PHP_SHORT_OPEN_TAG}/g" \
    -e "s/upload_max_filesize = 2M/upload_max_filesize = ${PHP_UPLOAD_MAX_FILEZIZE}M/g" \
    -e "s/max_execution_time = 30/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" \
    -e "s/max_input_time = 60/max_input_time = ${PHP_MAX_INPUT_TIME}/g" \
    -e "s/display_errors = Off/display_errors = ${PHP_DISPLAY_ERRORS}/g" \
    -e "s/post_max_size = 8M/post_max_size = ${PHP_POST_MAX_SIZE}M/g" \
    -e "s/allow_url_fopen = On/allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}/g" \
    -e "s/;date.timezone =/date.timezone = ${PHP_TZ}/g" \
    ${phpini}

if [ ${PHP_MODULE_MEMCACHED} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini
fi

if [ ${PHP_MODULE_REDIS} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-redis.ini
fi

if [ ${PHP_MODULE_MONGO} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini
fi

if [ ${PHP_MODULE_GEARMAN} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-gearman.ini
fi

if [ ${PHP_MODULE_IMAP} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-imap.ini
fi

if [ ${PHP_MODULE_LDAP} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-ldap.ini
fi

if [ ${PHP_MODULE_OPCACHE} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
    rm -f /usr/local/etc/php/conf.d/opcache.ini
fi

# Only PHP 5.6
if [ ${PHP_MODULE_XCACHE} == 'Off' ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-xcache.ini
    rm -f /usr/local/etc/php/conf.d/xcache.ini
fi

/usr/bin/supervisord -n -c /etc/supervisord.conf

exec "$@"
