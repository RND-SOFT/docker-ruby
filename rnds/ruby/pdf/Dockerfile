FROM ruby:2.5-slim as build

ARG PRIVATE_REPO

WORKDIR /home/app

RUN echo "source 'https://rubygems.org'\nsource '${PRIVATE_REPO}' do \n gem 'gimli' end \n " > Gemfile \
  && bundle package --all --no-install

FROM ruby:2.5-slim

RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no  \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

RUN set -ex \
  && apt-get update && apt-get upgrade -y \
  && apt-get -y install --no-install-recommends --no-install-suggests \
    libxext6 libxrender1 curl wget imagemagick \
    unixodbc libpq5 libsqlite3-dev libpq-dev \
    gettext-base \
    xz-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  
RUN find /etc/ImageMagick* -name policy.xml -exec sed -i "/pattern=\"PDF\"/d" {} \;

ARG DEBIAN_FRONTEND=noninteractive

RUN set -ex \
  && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
  && tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
  && mv wkhtmltox/bin/wkhtmlto* /usr/bin/ \
  && ln -nfs /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf \
  && rm -rf wkhtmltox*

WORKDIR /home/app
RUN echo 'gem: --no-document' > ~/.gemrc

RUN set -ex \
  && apt-get -y update \
  && apt-get -y install --no-install-recommends --no-install-suggests build-essential locales \
  && echo ru_RU.UTF-8 UTF-8 >> /etc/locale.gen \
  && dpkg-reconfigure locales && locale-gen \
  # && gem install gimli && gem update gimli \
  && apt-get purge -y --auto-remove build-essential \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -ex \
  && echo deb http://deb.debian.org/debian buster main contrib non-free >> /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y install --no-install-recommends --no-install-suggests build-essential \
    fonts-freefont-otf fonts-freefont-ttf t1-cyrillic fonts-liberation  \
    fonts-cantarell ttf-mscorefonts-installer \
  && dpkg-reconfigure fontconfig \
  && fc-cache -f -v \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  

COPY --from=build /home/app/vendor/cache /home/app/vendor/cache

RUN set -ex \
  && gem install /home/app/vendor/cache/gimli-*.gem \
  && rm -rf /home/app/vendor

ENV LC_ALL=ru_RU.UTF-8
ENV LANG=ru_RU.UTF-8
ENV COVER_PATH=/home/common/cover.html.in
ENV HEADER_PATH=/home/common/header.html.in
ENV FOOTER_PATH=/home/common/footer.html.in


run locale

ADD example /home/example/
ADD common /home/common/

ADD make_example.sh makepdf.sh /usr/bin/

CMD ["/bin/bash"]



