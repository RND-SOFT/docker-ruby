FROM phusion/passenger-full
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get upgrade -y &&\
  apt-get -y install libxext6 libxrender1 curl wget git build-essential &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update &&\
  apt-get -y install mysql-client unixodbc libpq5 libmysqlclient-dev libsqlite3-dev libpq-dev nodejs npm &&\
  npm install uglify-js -g &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc &&\
  gem install bundler --no-ri --no-rdoc

RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

ENV HOME /root

WORKDIR /home/app

CMD ["/sbin/my_init"]



