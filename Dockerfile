FROM nextcloud:latest

# Copied from here: https://github.com/matiasdelellis/facerecognition/issues/693
RUN sudo apt update \
      && sudo apt install -y wget gnupg2 unzip

    # install dlib

    sudo apt-get install libx11-dev -y

    git clone https://github.com/davisking/dlib.git
    cd dlib/dlib
    mkdir build
    cd build
    cmake -DBUILD_SHARED_LIBS=ON ..
    make
    sudo make install

    # Install pdlib extension

    wget https://github.com/goodspb/pdlib/archive/master.zip \
      && mkdir -p /usr/src/php/ext/ \
      && unzip -d /usr/src/php/ext/ master.zip \
      && rm master.zip
    docker-php-ext-install pdlib-master

    sudo apt-get install -y libbz2-dev
    docker-php-ext-install bz2

    # Increase memory limits
    echo memory_limit=1024M > /usr/local/etc/php/conf.d/memory-limit.ini

    # These last lines are just for testing the extension.. You can delete them.
    wget https://github.com/matiasdelellis/pdlib-min-test-suite/archive/master.zip \
      && unzip -d /tmp/ master.zip \
      && rm master.zip
    cd /tmp/pdlib-min-test-suite-master \
        && make


# Copied from here: https://memories.gallery/hw-transcoding/#docker-installations
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

ENV NEXTCLOUD_UPDATE=26
