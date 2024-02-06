FROM php:7.4-fpm

# Dockerfile used to build yalecthub/nginx-php:7.4 image
# Author: Azeez Yahaya
# Date: 6/2/2024

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
        apt install -y \
        nginx \
        libzip-dev libpng-dev libjpeg-dev zip \
        libicu-dev libc-client-dev libkrb5-dev && \
        docker-php-ext-install zip gd pdo mysqli pdo_mysql opcache && \
        docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap && \
        docker-php-ext-configure intl && docker-php-ext-install intl && \
        apt remove -y libicu-dev icu-devtools && \
        apt autoremove -y

RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
        } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini

COPY entrypoint.sh /etc/entrypoint.sh
COPY nginx/nginx.conf /etc/nginx/sites-enabled/default

COPY --chown=www-data:www-data public /srv/app

WORKDIR /srv/app

EXPOSE 80 443

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
