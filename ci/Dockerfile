FROM ubuntu:24.10
LABEL maintainer="rahulkj@gmail.com"
LABEL maintainer_name="Rahul Jain"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ADD install-cli.sh /

RUN apt-get update && apt-get install -y --no-install-recommends git vim unzip uuid-runtime \
  iputils-ping dnsutils ca-certificates \
  telnet gnupg2 \
  curl wget \
  && apt-get autoremove \
  && chmod +x ./install-cli.sh \
  && ./install-cli.sh