FROM ruby:2.5-alpine

RUN set -ex \
  && apk add --no-cache \
    autoconf \
    bash \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    cmake \
    coreutils \
    curl \
    dpkg-dev dpkg \
    g++ \
    gcc \
    gdbm-dev \
    git \
    glib-dev \
    imagemagick \
    libc-dev \
    libffi-dev \
    libxext \
    libxml2-dev \
    libxrender \
    libxslt-dev \
    linux-headers \
    make \
    make \
    mysql-client \
    mysql-dev \
    ncurses-dev \
    nodejs \
    npm \
    yarn \
    pkgconfig \
    postgresql-client \
    postgresql-dev \
    procps \
    readline-dev \
    ruby-dev \
    ruby-libs \
    sqlite \
    sqlite-dev \
    tar \
    tzdata \ 
    unixodbc \
    unixodbc-dev \
    wget \
    xz \
    yaml-dev \
    zlib-dev \
  && npm install -g uglify-js \
  && echo 'gem: --no-ri --no-rdoc' > ~/.gemrc \
  && gem install bundler --no-document \
  && rm -rf /var/cache/apk/*

RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no  \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

RUN set -ex \
  && apk add --no-cache \
    file \
    file-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /home/app

CMD ["/bin/bash"]



