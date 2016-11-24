#!/bin/bash

set -e

PHP_TIMEZONE1=`echo ${PHP_TIMEZONE} |sed  's|\/|\\\/|g'`

phpini=/usr/local/etc/php/php.ini

if [ ! -z "${PHP_MEMORY_LIMIT}" ]; then
    sed -i "s/memory_limit = 128M/memory_limit = ${PHP_MEMORY_LIMIT}M/g" ${phpini}
fi

if [ ! -z "${PHP_SHORT_OPEN_TAG}" ]; then
    sed -i "s/short_open_tag = Off/short_open_tag = ${PHP_SHORT_OPEN_TAG}/g" ${phpini}
fi

if [ ! -z "${PHP_UPLOAD_MAX_FILEZIZE}" ]; then
    sed -i "s/upload_max_filesize = 2M/upload_max_filesize = ${PHP_UPLOAD_MAX_FILEZIZE}M/g" ${phpini}
fi

if [ ! -z "${PHP_MAX_EXECUTION_TIME}" ]; then
    sed -i "s/max_execution_time = 30/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" ${phpini}
fi

if [ ! -z "${PHP_MAX_INPUT_TIME}" ]; then
    sed -i "s/max_input_time = 60/max_input_time = ${PHP_MAX_INPUT_TIME}/g" ${phpini}
fi

if [ ! -z "${PHP_DISPLAY_ERRORS}" ]; then
    sed -i "s/display_errors = Off/display_errors = ${PHP_DISPLAY_ERRORS}/g" ${phpini}
fi

if [ ! -z "${PHP_POST_MAX_SIZE}" ]; then
    sed -i "s/post_max_size = 8M/post_max_size = ${PHP_POST_MAX_SIZE}M/g" ${phpini}
fi

if [ ! -z "${PHP_ALLOW_URL_FOPEN}" ]; then
    sed -i "s/allow_url_fopen = On/allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}/g" ${phpini}
fi

if [ ! -z "${PHP_TIMEZONE}" ]; then
    sed -i "s/;date.timezone =/date.timezone = ${PHP_TIMEZONE1}/g" ${phpini}
fi

if [ -z "${PHP_MODULE_MEMCACHED}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini
else
    if [ ${PHP_MODULE_MEMCACHED} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini
    fi
fi

if [ -z "${PHP_MODULE_REDIS}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-redis.ini
else
    if [ ${PHP_MODULE_REDIS} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-redis.ini
    fi
fi

if [ -z "${PHP_MODULE_MONGO}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini
else
    if [ ${PHP_MODULE_MONGO} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini
    fi
fi

if [ -z "${PHP_MODULE_GEARMAN}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-gearman.ini
else
    if [ ${PHP_MODULE_GEARMAN} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-gearman.ini
    fi
fi

if [ -z "${PHP_MODULE_IMAP}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-imap.ini
else
    if [ ${PHP_MODULE_IMAP} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-imap.ini
    fi
fi

if [ -z "${PHP_MODULE_LDAP}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-ldap.ini
else
    if [ ${PHP_MODULE_LDAP} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-ldap.ini
    fi
fi

# Only PHP 5.6
if [ -z "${PHP_MODULE_XCACHE}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-xcache.ini
else
    if [ ${PHP_MODULE_XCACHE} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-xcache.ini
    fi
fi

if [ -z "${PHP_MODULE_OPCACHE}" ]; then
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
else
    if [ ${PHP_MODULE_OPCACHE} == 'Off' ]; then
	rm -f /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
    else
	echo "opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=2
opcache.fast_shutdown=1
opcache.enable_cli=1" > /usr/local/etc/php/conf.d/opcache.ini
    fi
fi

exec "$@"
