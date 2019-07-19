FROM alpine
MAINTAINER ZL Deng, dawnmsg@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install all required softwares
ADD image/bin    /usr/local/bin

RUN apk add --update --no-cache bash && install.sh && \
    rm /usr/local/bin/install.sh

ENV PATH="/bracken:${PATH}"