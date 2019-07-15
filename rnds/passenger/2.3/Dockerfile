FROM rnds/openssl-gost AS openssl-gost
FROM phusion/passenger-ruby23
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get -o Dpkg::Options::="--force-confold" upgrade -y &&\
  apt-get -y install curl wget openssh-client git build-essential net-tools &&\
  apt-get -y install libxext6 libxrender1&&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
  ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime

COPY --from=openssl-gost /usr/local/ssl /usr/local/ssl
COPY --from=openssl-gost /usr/local/ssl/bin/openssl /usr/bin/openssl
COPY --from=openssl-gost /usr/local/ssl/lib/pkgconfig/* /usr/lib/x86_64-linux-gnu/pkgconfig/
COPY --from=openssl-gost /usr/local/ssl/lib/lib* /usr/lib/

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

RUN bash -lc 'rvm --default use ruby-2.3.7'

RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc &&\
  gem install bundler -v '~> 1.17' --no-ri --no-rdoc

RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

RUN find /etc/ImageMagick* -name policy.xml -exec sed -i "/pattern=\"PDF\"/d" {} \;

ENV HOME /root

WORKDIR /home/app

CMD ["/sbin/my_init"]



