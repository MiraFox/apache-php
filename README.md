## Описание

Это Dockerfile, позволяющие собрать простой образ для Docker с Apache, PHP (как модуль) и поддержкой Let's Encrypt. Имеется возможность изменения параметров PHP, доступно три версии PHP 7.1, 7.0 и 5.6.

### PHP собран с поддержкой следующих модулей

 - **Расширения, включенные по умолчанию:** gd, mysqli, pdo, pdo_mysql, intl, dom, xml, xsl, xmlrpc, zip, bz2, fileinfo, curl, iconv, json, soap, calendar, gettext, mcrypt, tidy, phar, gettext, mysql (доступно только для php 5.6), imagick
 - **Расширения, отключенные по умолчанию:** mongodb, gearman, opcache, memcached , redis, imap, ldap, xcache (доступно только для PHP 5.6)

## Репозиторий Git

Репозиторий исходных файлов данного проекта: [https://github.com/MiraFox/apache-php](https://github.com/MiraFox/apache-php)

## Репозиторий Docker Hub

Расположение образа в Docker Hub: [https://hub.docker.com/r/mirafox/apache-php/](https://hub.docker.com/r/mirafox/apache-php/)

## Версии

| Tag | Apache | PHP |
|-----|-------|-----|
| latest | 2.4.10 | 7.1.0 |
| 7.1 | 2.4.10 | 7.1.0 |
| 7.0 | 2.4.10 | 7.0.14 |
| 5.6 | 2.4.10 | 5.6.29 |

## Использование Docker Hub

```
sudo docker pull mirafox/apache-php
```

## Запуск

```
sudo docker run -d -p 80:80 -p 443:443 \
    -v /home/username/sitename/www/:/var/www/html/ \
    -v /home/username/sitename/logs/:/var/log/apache2/ \
    mirafox/apache-php
```

## Доступные параметры конфигурации

### Параметры изменяющие настройки PHP

| Параметр | Изменяемая директива | По умолчанию |
|----------|----------------------|--------------|
|**PHP_ALLOW_URL_FOPEN**| allow_url_fopen | On |
|**PHP_DISPLAY_ERRORS**| display_errors | Off |
|**PHP_MAX_EXECUTION_TIME**| max_execution_time | 30 |
|**PHP_MAX_INPUT_TIME**| max_input_time | 60 |
|**PHP_MEMORY_LIMIT**| memory_limit | 128M |
|**PHP_POST_MAX_SIZE**| post_max_size | 8M |
|**PHP_SHORT_OPEN_TAG**| short_open_tag | On |
|**PHP_TIMEZONE**| date.timezone | Europe/Moscow |
|**PHP_UPLOAD_MAX_FILEZIZE**| upload_max_filesize | 2M |

#### Пример использования

```
sudo docker run -d \
    -e 'PHP_TIMEZONE=Europe/Moscow' \
    -e 'PHP_MEMORY_LIMIT=512' \
    -e 'PHP_SHORT_OPEN_TAG=On' \
    -e 'PHP_UPLOAD_MAX_FILEZIZE=16' \
    -e 'PHP_MAX_EXECUTION_TIME=120' \
    -e 'PHP_MAX_INPUT_TIME=120' \
    -e 'PHP_DISPLAY_ERRORS=On' \
    -e 'PHP_POST_MAX_SIZE=32' \
    -e 'PHP_ALLOW_URL_FOPEN=Off' \
    mirafox/apache-php
```

### Параметры подключения расширений PHP

 - **PHP_MODULE_MEMCACHED**: при установки в значение On подключается расширение memcached
 - **PHP_MODULE_OPCACHE**: при установки в значение On подключается расширение OPcache
 - **PHP_MODULE_XCACHE**: при установки в значение On подключается расширение XCache (только для версии PHP 5.6)
 - **PHP_MODULE_REDIS**: при установки в значение On подключается расширение Redis
 - **PHP_MODULE_MONGO**: при установки в значение On подключается расширение MongoDB
 - **PHP_MODULE_GEARMAN**: при установки в значение On подключается расширение Gearman
 - **PHP_MODULE_IMAP**: при установки в значение On подключается расширение IMAP
 - **PHP_MODULE_LDAP**: при установки в значение On подключается расширение LDAP

#### Пример использования

```
sudo docker run -d -e 'PHP_MODULE_MEMCACHED=On' -d mirafox/apache-php
```

## Поддержка Let's Encrypt

Данный образ имеет поддержку SSL сертификатов Let's Encrypt. Для установки сертификата необходимо при запуске контейнера добавить параметры:

 - **SSL_DOMAIN**: имя домена, на который будет выдан SSL сертификат
 - **SSL_EMAIL**: E-Mail администратора домена

**Оба параметра обязательны, если Вы желаете использовать Let's Encrypt**

#### Пример использования

```
sudo docker run -d \
    -e 'SSL_DOMAIN=example.com,www.example.com' \
    -e 'SSL_EMAIL=admin@example.com' \
    mirafox/apache-php
```

### Установка сертификата

```
docker exec -it <CONTAINER_NAME> /usr/local/bin/letsencrypt-init
```

### Перевыпуск сертификата

```
docker exec -it <CONTAINER_NAME> /usr/local/bin/letsencrypt-renew
```

## Использование PHP Composer

```
docker exec -it <CONTAINER_NAME> /usr/local/bin/composer
```
