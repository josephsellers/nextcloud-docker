# Copied from here: https://github.com/nextcloud/docker/blob/master/25/apache/Dockerfile
FROM nextcloud:apache

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        apache2-foreground \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV NEXTCLOUD_UPDATE=1
