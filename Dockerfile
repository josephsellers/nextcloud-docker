# Copied from here: https://memories.gallery/hw-transcoding/#docker-installations
FROM nextcloud:latest

RUN apt-get update && \
    apt-get install -y lsb-release wget gnupg2 unzip libx11-dev && \
    echo "deb http://ftp.debian.org/debian $(lsb_release -cs) non-free" >> \
       /etc/apt/sources.list.d/intel-graphics.list && \
    echo "deb https://repo.delellis.com.ar bullseye bullseye" > /etc/apt/sources.list.d/20-pdlib.list \
      && wget -qO - https://repo.delellis.com.ar/repo.gpg.key | apt-key add - && \
    apt-get update && \
    apt-get install -y intel-media-va-driver-non-free ffmpeg libdlib-dev libx11-dev && \
    rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/goodspb/pdlib/archive/master.zip \
  && mkdir -p /usr/src/php/ext/ \
  && unzip -d /usr/src/php/ext/ master.zip \
  && rm master.zip
RUN docker-php-ext-install pdlib-master

RUN echo memory_limit=1024M > /usr/local/etc/php/conf.d/memory-limit.ini

RUN wget https://github.com/matiasdelellis/pdlib-min-test-suite/archive/master.zip \
  && unzip -d /tmp/ master.zip \
  && rm master.zip
RUN cd /tmp/pdlib-min-test-suite-master \
    && make

COPY start.sh /
RUN chmod +x /start.sh 
CMD /start.sh

ENV NEXTCLOUD_UPDATE=26
