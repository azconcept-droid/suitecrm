FROM yalect/nginx-php

RUN mkdir /var/www/app

COPY entrypoint.sh /var/entrypoint.sh

COPY --chown=www-data:www-data suitecrm_src /var/www/app


WORKDIR /var/www/app

RUN chmod -R 755 . && \
    chmod -R 775 cache custom modules themes data upload && \
    chown www-data:www-data .

EXPOSE 80

# USER www-data

ENTRYPOINT ["sh", "/var/entrypoint.sh"]