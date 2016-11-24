FROM php:7.0-apache
MAINTAINER Ruzhentsev Alexandr noc@mirafox.ru

COPY config/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y git libpng12-dev libjpeg-dev libsqlite3-dev libicu-dev libmemcached-dev \
        libxml2-dev libxslt1-dev libcurl4-gnutls-dev libbz2-dev libzip-dev libc-client2007e-dev \
        libkrb5-dev libmcrypt-dev libtidy-dev libldb-dev libldap2-dev libmagick++-dev libgearman-dev \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
    && docker-php-ext-configure ldap  --with-ldap=/usr \
    && docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && pecl install mongodb imagick \
    && docker-php-ext-install \
        bz2 calendar curl dom fileinfo gd \
        gettext gettext iconv imap intl json ldap \
        mcrypt mysqli opcache pdo pdo_mysql phar \
        soap tidy xml xmlrpc xsl zip \
    && git clone https://github.com/php-memcached-dev/php-memcached memcached \
    && ( \
        cd memcached && git checkout php7 && phpize \
        && ./configure --with-php-config=/usr/local/bin/php-config \
        && make && make install \
    ) \
    && rm -r memcached \
    && git clone https://github.com/phpredis/phpredis.git \
    && ( \
        cd phpredis && phpize \
        && ./configure \
        && make -j$(nproc) && make install \
    ) \
    && rm -r phpredis \
    && git clone https://github.com/wcgallego/pecl-gearman.git \
    && ( \
        cd pecl-gearman && phpize \
        && ./configure \
        && make -j$(nproc) && make install \
    ) \
    && rm -r pecl-gearman \
    && docker-php-ext-enable redis memcached mongodb imagick gearman

RUN a2enmod rewrite expires

VOLUME /var/www/html

EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh \
    && chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]
