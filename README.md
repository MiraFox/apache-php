## Описание

Это Dockerfile, позволяющие собрать простой образ для Docker с Apache и PHP (как модуль). Имеется возможность изменения параметров PHP, доступно две версии PHP 7.0 и 5.6.

### PHP собран с поддержкой следующих модулей

 - **Расширения, включенные по умолчанию:** gd, mysqli, pdo, pdo_mysql, intl, dom, xml, xsl, xmlrpc, zip, bz2, fileinfo, curl, iconv, json, soap, calendar, gettext, mcrypt, tidy, phar, gettext, mysql (доступно только для php 5.6), imagick
 - **Расширения, отключенные по умолчанию:** mongodb, gearman, opcache, memcached , redis, imap, ldap, xcache (доступно только для PHP 5.6)

## Репозиторий GIT

Репозиторий исходных файлов данного проекта: [https://github.com/MiraFox/apache-php](https://github.com/MiraFox/apache-php)

## Версии

| Tag | Apache | PHP |
|-----|-------|-----|
| latest | 2.4.10 | 7.0.13 |
| 5.6 | 2.4.10 | 5.6.28 |

## Использование Docker Hub

```
sudo docker pull mirafox/apache-php
```

## Запуск

```
sudo docker run -d mirafox/apache-php
```

## Доступные параметры конфигурации

### Параметры изменяющие настройки PHP

 - **PHP_TIMEZONE**: устанавливает временную зону date.timezone, по умолчанию пусто
 - **PHP_MEMORY_LIMIT**: устанавливает значение директивы memory_limit, по умолчанию 128M
 - **PHP_SHORT_OPEN_TAG**: устанавливает значение директоривы short_open_tag, по умолчанию Off
 - **PHP_UPLOAD_MAX_FILEZIZE**: устанавливает значение директивы upload_max_filesize, по умолчанию 2M
 - **PHP_MAX_EXECUTION_TIME**: устанавливает значение директивы max_execution_time, по умолчанию 30
 - **PHP_MAX_INPUT_TIME**: устанавливает значение директивы max_input_time, по умолчанию 60
 - **PHP_DISPLAY_ERRORS**: устанавливает значение директивы display_errors, по умолчанию Off
 - **PHP_POST_MAX_SIZE**: устанавливает значение директивы post_max_size, по умолчанию 8M
 - **PHP_ALLOW_URL_FOPEN**: устанавливает значение директивы allow_url_fopen, по умолчанию On

#### Примеры использования

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

#### Примеры использования

```
sudo docker run -d -e 'PHP_MODULE_MEMCACHED=On' -d mirafox/apache-php
```
