## Описание

Это Dockerfile, позволяющие собрать простой образ для Docker с Apache и PHP (как модуль). Имеется возможность изменения параметров PHP, доступно две версии PHP 7.0 и 5.6.

PHP собран с поддержкой следующих модулей: gd, mysqli, opcache, pdo, pdo_mysql, intl, dom, xml, xsl, xmlrpc, zip, bz2, fileinfo, curl, iconv, json, soap, memcached

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

### Примеры использования

```
sudo docker run -d -e 'PHP_TIMEZONE=Europe/Moscow' -e 'PHP_MEMORY_LIMIT=512' -e 'PHP_SHORT_OPEN_TAG=On' -e 'PHP_UPLOAD_MAX_FILEZIZE=16' -e 'PHP_MAX_EXECUTION_TIME=120' -e 'PHP_MAX_INPUT_TIME=120' -e 'PHP_DISPLAY_ERRORS=On' -e 'PHP_POST_MAX_SIZE=32' -e 'PHP_ALLOW_URL_FOPEN=Off'  mirafox/apache-php
```
