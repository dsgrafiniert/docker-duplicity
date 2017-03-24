FROM ubuntu:16.10
MAINTAINER Dominik Schoen <dominik@familie-schoen.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      duplicity \
      rsync \
      cron \
      ssh \
      lftp \
      python-paramiko \
      python-pexpect \
      python-requests \
      python-requests-oauthlib \
      gettext-base && \
    apt-get clean

RUN mkdir /root/oauthsync && touch /root/oauthsync/DELETEME

COPY setup_amazon_oauth /usr/local/bin/setup_amazon_oauth
RUN chmod +x /usr/local/bin/setup_amazon_oauth

COPY adbackend.py /usr/lib/python2.7/dist-packages/duplicity/backends/adbackend.py
COPY config /root/.ssh/config
COPY duplicity_script.sh /opt/duplicity/duplicity_script.sh.template
COPY gpg-agent.conf /root/.gnupg/gpg-agent.conf
RUN chmod 0644 /root/.gnupg/gpg-agent.conf
RUN chmod 0700 /root/.gnupg
COPY incexcllist /conf/incexcllist


# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN ./usr/local/bin/entrypoint.sh
 
# Run the command on container startup
CMD cron && tail -f /var/log/cron.log

