FROM php:5.6-apache
MAINTAINER Ruzhentsev Alexandr noc@mirafox.ru

COPY config/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y \
	libpng12-dev \
	libjpeg-dev \
	libsqlite3-dev \
	libicu-dev \
	libmemcached-dev \
	libxml2-dev \
	libxslt1-dev \
	libcurl4-gnutls-dev \
	libbz2-dev \
	libzip-dev \
	&& rm -rf /var/lib/apt/lists/* \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install \
	gd \
	mysqli \
	opcache \
	pdo \
	pdo_mysql \
	intl \
	dom \
	xml \
	xsl \
	xmlrpc \
	zip \
	bz2 \
	fileinfo \
	curl \
	iconv \
	json \
	soap

RUN { \
	echo 'opcache.memory_consumption=128'; \
	echo 'opcache.interned_strings_buffer=8'; \
	echo 'opcache.max_accelerated_files=4000'; \
	echo 'opcache.revalidate_freq=2'; \
	echo 'opcache.fast_shutdown=1'; \
	echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires

VOLUME /var/www/html

EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh \
    && chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]
