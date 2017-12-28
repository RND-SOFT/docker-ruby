FROM phusion/passenger-ruby23
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get upgrade -y &&\
  apt-get -y install curl wget openssh-client git build-essential &&\
  apt-get -y install libxext6 libxrender1&&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
  ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime

RUN apt-get update &&\
  apt-get -y install unixodbc libpq5 libpq-dev nodejs npm &&\
  apt-get -y install mysql-client libmysqlclient-dev libsqlite3-dev imagemagick mc &&\
  npm install uglify-js -g &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'openssl_conf = openssl_def' > /tmp/ssl.conf &&\
  cat /etc/ssl/openssl.cnf >> /tmp/ssl.conf &&\
  echo "\
\n[openssl_def] \
\nengines = engine_section \
\n\
\n[engine_section] \
\ngost = gost_section \
\n\
\n[gost_section] \
\nsoft_load=1 \
\ndefault_algorithms = ALL" >> /tmp/ssl.conf &&\
  mv /tmp/ssl.conf /etc/ssl/openssl.cnf

RUN bash -lc 'rvm --default use ruby-2.3.3'

RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc &&\
  gem install bundler --no-ri --no-rdoc

RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

ENV HOME /root

WORKDIR /home/app

CMD ["/sbin/my_init"]



