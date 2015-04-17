#
# RethinkDB container, with backup
#
# Version     0.1
#

FROM huahaiy/debian

MAINTAINER Huahai Yang <hyang@juji-inc.com>

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN \
  echo "===> install RethinkDB..."  && \
  apt-get update && \
  apt-get install -y --force-yes lsb-release && \
  echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/rethinkdb.list && \
  apt-get update && \
  wget -O- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && \
  apt-get install -y --force-yes rethinkdb python-pip && \
  pip install rethinkdb 

COPY ./backup.sh /

RUN \
  echo "===> install supervisor and setup backup..."  && \
  apt-get install -y supervisor && \
  mkdir -p /backup && \
  mkdir -p /var/log/supervisor && \
  \
  \
  echo "===> clean up..."  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./docker-entrypoint.sh /

ENV PATH /usr/local/bin:$PATH

VOLUME ["/data","/backup"]

WORKDIR /data

EXPOSE 8080 28015 29015 

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["supervisord"]
