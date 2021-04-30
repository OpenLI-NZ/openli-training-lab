FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/openli-prov

RUN apt-get -y update && apt-get -y install \
            apt-transport-https \
            curl \
            gnupg \
            lsb-release

RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandio/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandder/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libtrace/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/openli/cfg/setup/bash.deb.sh' | bash

RUN apt-get -y update && apt-get -y install \
        openli-provisioner \
	rsyslog \
        iproute2 \
        iputils-ping \
        tcpdump \
        less \
        vim \
        procps

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

COPY provisioner-config.yaml /etc/openli/
COPY intercept-config.yaml /etc/openli/running-intercept-config.yaml
RUN chown openli:openli /etc/openli/*.yaml
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
