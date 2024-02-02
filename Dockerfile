FROM php:7.4-fpm

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

RUN mkdir /srv/app

COPY nginx/nginx.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /etc/entrypoint.sh

COPY --chown=www-data:www-data suitecrm_src /srv/app

# RUN mkdir /srv/app/public

# RUN echo 'php_value upload_max_filesize 256M' > '/srv/app/public/.htaccess'

WORKDIR /srv/app

RUN chmod -R 755 . && \
    chmod -R 775 cache custom modules themes data upload && \
    chown www-data:www-data .
    # chmod 775 config_override.php 2>/dev/null

EXPOSE 80 443

# USER www-data

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
