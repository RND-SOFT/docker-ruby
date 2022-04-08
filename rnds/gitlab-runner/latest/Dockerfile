# syntax=docker/dockerfile:experimental
FROM docker:20.10.12-alpine3.14
MAINTAINER Firmhouse "kinnalru@gmail.com"

WORKDIR /home/app

RUN mkdir -p ~/.ssh && echo -e "Host * \
  \n  StrictHostKeyChecking no \
  \n  UserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

RUN set -ex \
  && apk add --no-cache ca-certificates curl wget \
  && curl -k https://rnds.pro/bundle_ca.crt --output /usr/local/share/ca-certificates/bundle_ca.crt \
  && cat /usr/local/share/ca-certificates/bundle_ca.crt >> /etc/ssl/certs/ca-certificates.crt \
  && update-ca-certificates

RUN set -ex \
  && sed 's%dl-cdn.alpinelinux.org%library.rnds.pro/repository%' -i /etc/apk/repositories \
  && sed 's%http://%https://%' -i /etc/apk/repositories

RUN --mount=type=cache,target=/var/cache/apk ln -vsf /var/cache/apk /etc/apk/cache \
  && set -ex \
  && apk add --no-cache \
    ca-certificates \
    tar \
    xz \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    bash \
    postgresql-dev \
    postgresql-client \
    libstdc++ \
    libressl \
    libressl-dev \
    sqlite \
    sqlite-dev \
    libxml2 \
    wget \
    python3 \
    python2 \
    jq \
    curl \
    libcurl \
    curl-dev \
    tzdata \
    pcre \
    git \
    socat \
    openssh

RUN --mount=type=cache,target=/var/cache/apk ln -vsf /var/cache/apk /etc/apk/cache \
  && set -ex \
  && apk add --no-cache \
    linux-headers \
    coreutils \
    dpkg-dev \
    dpkg \
    gdbm-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    ncurses-dev \
    procps \
    readline-dev \
    make \
    cmake \
    gcc \
    g++ \
    ruby \
    ruby-libs \
    ruby-dev \
    ruby-etc ruby-json ruby-irb ruby-rake ruby-bigdecimal \
    glib-dev \
    libc-dev \
    yaml-dev \
    zlib-dev \
    ansible \
    nomad

RUN set -ex \ 
  && gem sources --remove https://rubygems.org \
  && gem sources --remove https://rails-assets.org \
  && gem sources --add https://library.rnds.pro/repository/rubygems/ \
  && gem sources --add https://library.rnds.pro/repository/rails-assets/

RUN echo 'gem: --no-ri --no-rdoc --no-document' > ~/.gemrc \
  && gem install docker_toolkit && gem update docker_toolkit \
  && gem install aggkit && gem update aggkit

RUN set -ex \
  && apk add --no-cache \
    nodejs \
    yarn \
    python3-dev \
    py3-pip \
    py-setuptools

RUN gem install rspec activesupport bigdecimal json awesome_print \
  httparty bundler bundler-audit socksify net-ssh io-console etc \
  pronto pronto-rubocop rubocop-rails pronto-flay nokogiri gitlab rest-client rubycritic 

COPY pullcache.sh pushcache.sh /usr/bin/

RUN set -ex \
  && pip3 install s3cmd

COPY  --from=docker/compose:alpine-1.28.6 /usr/local/bin/docker-compose /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN cp -f /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN mv -f /usr/bin/docker-compose /usr/bin/docker-compose.orig
COPY docker-compose /usr/bin/
COPY docker-compose /usr/local/bin/

RUN chmod +x /usr/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

CMD ["/bin/bash"]





