FROM ubuntu:16.10
MAINTAINER Thomas Steinbach <thomass@aikq.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      duplicity \
      rsync \
      ssh \
      lftp \
      python-paramiko \
      python-pexpect \
      python-requests \
      python-requests-oauthlib && \
    apt-get clean

RUN mkdir /root/oauthsync && touch /root/oauthsync/DELETEME

COPY setup_amazon_oauth /usr/local/bin/setup_amazon_oauth
RUN chmod +x /usr/local/bin/setup_amazon_oauth

COPY adbackend.py /usr/lib/python2.7/dist-packages/duplicity/backends/adbackend.py
COPY config /root/.ssh/config

ENTRYPOINT ["duplicity"]
