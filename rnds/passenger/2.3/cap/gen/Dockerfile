FROM rnds/passenger:2.3-cap
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update &&\
  apt-get install -y libreoffice-writer &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
