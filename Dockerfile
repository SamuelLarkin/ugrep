# step 1: create a debian or ubuntu container for ugrep named "ugrep"
# docker -D build --no-cache -t ugrep .
#
# step 2: run bash in the container, e.g. to run ugrep from the command line
# docker run -it ugrep bash
# or
# docker run -it --mount type=bind,source=$PWD,target=/mnt ugrep bash
#
# step 3: run ugrep in the container, for example:
# ugrep -r -n -tjava Hello ugrep/tests/

# debian or ubuntu
FROM ubuntu

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        make \
        vim \
        git \
        clang \
        wget \
        unzip \
        ca-certificates \
        libpcre2-dev \
        libz-dev \
        libbz2-dev \
        liblzma-dev \
        liblz4-dev \
        libzstd-dev && \
    git clone --depth=1 https://github.com/Genivia/ugrep && \
    cd ugrep && \
    ./build.sh && \
    make install && \
    ugrep -V && \
    cd ../ && \
    rm -rf ugrep && \
    apt-get remove -y \
        make \
        git \
        libpcre2-dev \
        libz-dev \
        libbz2-dev \
        liblzma-dev \
        liblz4-dev \
        libzstd-dev && \
    rm -rf /var/lib/apt/lists/*
