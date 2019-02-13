FROM ruby:2.6-slim
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get upgrade -y \
  && apt-get -y install libxext6 libxrender1 curl wget git build-essential \
  && apt-get -y  install xvfb libodbc1 libltdl7 libgconf-2-4 imagemagick \
  && apt-get -y install fonts-liberation libappindicator1 libindicator7 libdbusmenu-gtk4 libdbusmenu-glib4 libpango1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 \
  && apt-get -y install proxychains \
  && apt-get clean && apt-get autoremove && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get -y install mysql-client unixodbc libpq5 default-libmysqlclient-dev libsqlite3-dev libpq-dev nodejs imagemagick \
  && npm install uglify-js -g \
  && apt-get clean && apt-get autoremove && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && apt-get update \
  && apt-get -y install google-chrome-stable chromedriver \
  && apt-get clean && apt-get autoremove && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CHROME=/opt/google/chrome/google-chrome

RUN set -ex \
  && mv ${CHROME} ${CHROME}.orig \
  && echo "#!/bin/sh" >> ${CHROME} \
  && echo "exec ${CHROME}.orig --no-sandbox --disable-gpu --disable-sandbox --user-data-dir=/tmp/ \$@" >> ${CHROME} \
  && chmod 777 ${CHROME}

RUN apt-get update && apt-get remove docker || true && apt-get remove docker-engine || true && apt-get remove docker.io || true \
  && apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common unzip \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce \
  && apt-get clean && apt-get autoremove && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -ex \
  && curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose 

RUN set -ex \
  && curl -sSLo /tmp/consul.zip https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip \
  && unzip -d /bin /tmp/consul.zip && strip /bin/consul && rm -rf /tmp/consul.zip \
  && mkdir -p /tmp/consul

RUN set -ex \
  && curl https://releases.rancher.com/cli2/v2.0.5/rancher-linux-amd64-v2.0.5.tar.gz | tar -xz \
  && cp ./rancher-*/rancher /bin/rancher \
  && rm -rf rancher-* \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && mv ./kubectl /bin \
  && chmod +x /bin/kubectl

RUN set -ex \
  && echo 'gem: --no-ri --no-rdoc' > ~/.gemrc \
  && gem install bundler

RUN set -ex \
  && mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no  \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

RUN set -ex \
  && gem install docker_toolkit && gem update docker_toolkit  \
  && gem install aggkit && gem update aggkit 

WORKDIR /home/app

CMD ["/bin/bash"]

