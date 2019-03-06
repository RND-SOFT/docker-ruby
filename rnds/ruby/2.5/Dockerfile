FROM ruby:2.5-alpine

RUN set -ex && \
  apk add --no-cache \
    bash \
    libxext \
    libxrender \
    curl \
    git \
    wget \
    ruby-libs \
    ruby-dev \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    dpkg-dev dpkg \
    gcc \
    gdbm-dev \
    glib-dev \
    libc-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    procps \
    readline-dev \
    tar \
    xz \
    yaml-dev \
    zlib-dev \
    g++ \
    make \
    mysql-dev \
    mysql-client \
    unixodbc \
    unixodbc-dev \
    postgresql-dev \
    postgresql-client \
    sqlite \
    sqlite-dev \
    nodejs \
    npm \
    tzdata \ 
    imagemagick && \
  npm install -g uglify-js && \
  echo 'gem: --no-document' > ~/.gemrc && \
  gem install bundler --no-document

RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no  \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config


WORKDIR /home/app

CMD ["/bin/bash"]



