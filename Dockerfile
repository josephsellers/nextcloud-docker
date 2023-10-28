# Copied from here: https://memories.gallery/hw-transcoding/#docker-installations
FROM nextcloud:latest

RUN apt-get update && \
    apt-get install -y lsb-release && \
    echo "deb http://ftp.debian.org/debian $(lsb_release -cs) non-free" >> \
       /etc/apt/sources.list.d/intel-graphics.list && \
    apt-get update && \
    apt-get install -y intel-media-va-driver-non-free ffmpeg && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /
RUN chmod +x /start.sh 
CMD /start.sh

ENV NEXTCLOUD_UPDATE=29
