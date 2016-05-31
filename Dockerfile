FROM ubuntu:16.04
MAINTAINER Thomas Steinbach <thomass@aikq.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      duplicity \
      rsync \
      ssh \
      lftp \
      python-paramiko \
      python-pexpect && \
    apt-get clean

COPY config /root/.ssh/config

ENTRYPOINT ["duplicity"]
