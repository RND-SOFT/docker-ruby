FROM rnds/ruby:2.3.0
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update &&\
  apt-get -y  install xvfb libodbc1 libltdl7 libgconf-2-4 imagemagick &&\
  apt-get -y install fonts-liberation libappindicator1 libindicator7 libdbusmenu-gtk4 libdbusmenu-glib4 libpango1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 &&\
  apt-get -y install proxychains &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add - &&\
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list &&\
  apt-get update  &&\
  apt-get -y install google-chrome-stable chromedriver &&\
  wget 'http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~jessie_amd64.deb' &&\
  dpkg -i sphinxsearch_2.2.11-release-1~jessie_amd64.deb &&\
  rm sphinxsearch_2.2.11-release-1~jessie_amd64.deb &&\
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



ENV CHROME=/opt/google/chrome/google-chrome

RUN mv ${CHROME} ${CHROME}.orig &&\
  echo "#!/bin/sh" >> ${CHROME} &&\
  echo "exec ${CHROME}.orig --no-sandbox --disable-gpu --disable-sandbox --user-data-dir=/tmp/ \$@" >> ${CHROME}   &&\
  chmod 777 ${CHROME}

RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc \
  && gem install docker_toolkit --no-ri --no-rdoc \
  && gem update docker_toolkit --no-ri --no-rdoc

RUN apt-get update && apt-get remove docker || true && apt-get remove docker-engine || true && apt-get remove docker.io || true \
  && apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common unzip \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce \
  && apt-get clean \
  && apt-get autoremove \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose 
 
RUN curl -sSLo /tmp/consul.zip https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip \
  && unzip -d /bin /tmp/consul.zip && strip /bin/consul && rm -rf /tmp/consul.zip \
  && mkdir -p /tmp/consul

RUN set -ex \
  && curl https://releases.rancher.com/cli2/v2.0.5/rancher-linux-amd64-v2.0.5.tar.gz | tar -xz \
  && cp ./rancher-*/rancher /bin/rancher \
  && rm -rf rancher-* \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && mv ./kubectl /bin \
  && chmod +x /bin/kubectl
  
  


WORKDIR /home/app

 
CMD ["tail", "-f", "/dev/null"]



