#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

KRAKEN2_VERSION=2.0.7-beta
BRACKEN_VERSION=2.2

ESSENTIALS='perl'
BUILD_PACKAGES='build-base bzip2-dev zlib-dev ca-certificates wget'

KRAKEN2_URL=http://github.com/DerrickWood/kraken2/archive/v${KRAKEN2_VERSION}.tar.gz 
BRACKEN_URL=https://github.com/jenniferlu717/Bracken/archive/v${BRACKEN_VERSION}.tar.gz

apk update && apk add --no-cache ${ESSENTIALS} ${BUILD_PACKAGES}

wget ${KRAKEN2_URL} && \
    tar zvxf v${KRAKEN2_VERSION}.tar.gz && \
    cd /kraken2-${KRAKEN2_VERSION} && \
    ./install_kraken2.sh /usr/local/bin && \
    cd / &&
    rm -rf kraken2-${KRAKEN2_VERSION} v${KRAKEN2_VERSION}.tar.gz

wget ${BRACKEN_URL} && \
    tar zvxf v${BRACKEN_VERSION}.tar.gz && \
    mv Bracken-${BRACKEN_VERSION} bracken && \
    cd /bracken && \
    sh ./install_bracken.sh && \
    ln -s /bracken/bracken /usr/local/bin/bracken && \
    ln -s /bracken/bracken-build /usr/local/bin/bracken-build && \
    cd src/ && rm -rf *.o *.h *.cpp Makefile && \
    cd / && \
    rm -rf v${BRACKEN_VERSION}.tar.gz

rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* 

apk update && apk del ${BUILD_PACKAGES}
