FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/openli-testagency

RUN apt-get -y update && apt-get -y install \
            apt-transport-https \
            curl \
            gnupg \
            lsb-release

RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandio/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandder/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libtrace/cfg/setup/bash.deb.sh' | bash

RUN apt-get -y update && apt-get -y install \
        libtrace4-tools \
        iproute2 \
        iputils-ping \
        tcpdump \
        less \
        vim \
        procps


COPY README /home/openli-testagency
