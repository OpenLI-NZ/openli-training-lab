FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/openli-coll

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
        openli-collector \
        libtrace4-tools \
	rsyslog \
        iputils-ping \
        iproute2 \
        tcpdump \
        less \
        vim \
        procps

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

COPY collector-config.yaml /etc/openli/
COPY entrypoint.sh /entrypoint.sh
RUN mkdir /home/openli-coll/pcaps/
COPY openli-lab-pcaps.tar.gz /home/openli-coll/pcaps/
RUN cd pcaps && tar -xvzf openli-lab-pcaps.tar.gz && rm openli-lab-pcaps.tar.gz

RUN mkdir /etc/openli/ssl
COPY ca-crt.pem /etc/openli/ssl/
COPY collector-crt.pem /etc/openli/ssl/
COPY collector-key.pem /etc/openli/ssl/

RUN chmod 644 /etc/openli/ssl/*-crt.pem
RUN chmod 600 /etc/openli/ssl/*-key.pem

RUN chown rabbitmq:rabbitmq /etc/openli/ssl/*.pem

COPY rabbitmq.conf /home/openli-coll
COPY README /home/openli-coll
COPY stop_rsyslog.sh /usr/sbin
COPY stop_collector.sh /usr/sbin
COPY stop_rabbitmq.sh /usr/sbin

ENTRYPOINT ["/entrypoint.sh"]
