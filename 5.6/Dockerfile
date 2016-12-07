FROM php:5.6-apache
MAINTAINER Ruzhentsev Alexandr noc@mirafox.ru

RUN apt-get update && apt-get -y upgrade && apt-get install -y git libbz2-dev supervisor ssl-cert libpng12-dev libjpeg-dev \
        libsqlite3-dev libicu-dev libmemcached-dev libxml2-dev libxslt1-dev libcurl4-gnutls-dev \
        libbz2-dev libzip-dev libc-client2007e-dev libkrb5-dev libmcrypt-dev libtidy-dev libldb-dev \
        libldap2-dev libmagick++-dev libgearman-dev \
    && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
    && docker-php-ext-configure ldap  --with-ldap=/usr \
    && docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && pecl install memcached mongodb imagick gearman \
    && docker-php-ext-install \
        bz2 calendar curl dom fileinfo gd \
        gettext gettext iconv imap intl json ldap \
        mcrypt mysql mysqli opcache pdo pdo_mysql \
        phar soap tidy xml xmlrpc xsl \
        zip \
    && curl -fsSL 'https://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.gz' -o xcache.tar.gz \
    && mkdir -p xcache \
    && tar -xf xcache.tar.gz -C xcache --strip-components=1 \
    && rm xcache.tar.gz \
    && ( \
        cd xcache && phpize \
        && ./configure --enable-xcache \
        && make -j$(nproc) && make install \
    ) \
    && rm -r xcache \
    && git clone https://github.com/phpredis/phpredis.git \
    && ( \
        cd phpredis && phpize \
        && ./configure \
        && make -j$(nproc) && make install \
    ) \
    && rm -r phpredis \
    && docker-php-ext-enable redis xcache memcached mongodb imagick gearman

RUN echo deb http://httpredir.debian.org/debian jessie-backports main | tee /etc/apt/sources.list.d/backports.list \
    && apt-get update && apt-get install -y python-certbot-apache -t jessie-backports \
    && apt-get purge --auto-remove -y gcc make \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY config/php.ini /usr/local/etc/php/
COPY config/supervisord.conf /etc/supervisord.conf
COPY scripts/ /usr/local/bin/
COPY src/ /var/www/html/

RUN chmod 755 /usr/local/bin/letsencrypt-init \
    && chmod 755 /usr/local/bin/letsencrypt-renew \
    && chmod 755 /usr/local/bin/docker-entrypoint.sh \
    && /usr/sbin/a2enmod rewrite expires ssl \
    && /usr/sbin/a2ensite default-ssl

VOLUME /var/www/html

EXPOSE 80 443

CMD ["/usr/local/bin/docker-entrypoint.sh"]
