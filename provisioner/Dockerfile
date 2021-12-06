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
        libtrace4-tools \
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

RUN mkdir /etc/openli/ssl
COPY ca-crt.pem /etc/openli/ssl/
COPY provisioner-crt.pem /etc/openli/ssl/
COPY provisioner-key.pem /etc/openli/ssl/

RUN chown openli:openli /etc/openli/ssl/*.pem
RUN chmod 644 /etc/openli/ssl/*-crt.pem
RUN chmod 600 /etc/openli/ssl/*-key.pem

COPY stop_provisioner.sh /usr/sbin/
COPY stop_rsyslog.sh /usr/sbin/

ENTRYPOINT ["/entrypoint.sh"]
