FROM yalecthub/nginx-php:7.4

# Dockerfile for yalecthub/suitecrm image
# Author: Azeez Yahaya
# Date: 6/2/2024

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt upgrade -y && \
    apt install -y wget && \
    apt install -y unzip 

WORKDIR /srv/app

RUN wget https://suitecrm.com/download/141/suite714/563477/suitecrm-7-14-2.zip && \
    unzip -q suitecrm-7-14-2.zip && \
    mv SuiteCRM-7.14.2/* /srv/app && \
    rm -r SuiteCRM-7.14.2 && \
    rm -r suitecrm-7-14-2.zip

RUN chmod -R 755 . && \
    chmod -R 775 cache custom modules themes data upload && \
    chown -R www-data:www-data .
# RUN chmod 775 config_override.php 2>/dev/null

COPY init.sh /etc/init.sh

EXPOSE 80 443

ENTRYPOINT [ "sh", "/etc/init.sh" ]
