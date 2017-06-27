FROM rnds/passenger:slim
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update &&\
  apt-get install -y docker-compose build-essential &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
