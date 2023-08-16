# Copied from here: https://github.com/nextcloud/docker/blob/master/25/apache/Dockerfile
FROM nextcloud:apache

RUN set -ex; \
    apt-get update; \
    apt-get install -y ffmpeg; \
    rm -rf /var/lib/apt/lists/*

CMD ["apache2-foreground"]

ENV NEXTCLOUD_UPDATE=15
