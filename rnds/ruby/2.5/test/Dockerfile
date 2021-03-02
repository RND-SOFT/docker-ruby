FROM rnds/ruby:2.5

RUN set -ex \
  && apk add --no-cache \
    xvfb \
    unixodbc-dev \
    libltdl \
    gconf \
    imagemagick \
    ttf-liberation \
    pango \
    proxychains-ng \
    binutils \
    openssh-client

ENV CHROMIUM=/usr/bin/chromium-browser

RUN set -ex \
  && apk add --no-cache chromium chromium-chromedriver \
  && mv ${CHROMIUM} ${CHROMIUM}.orig \
  && echo "#!/bin/sh" >> ${CHROMIUM} \
  && echo "exec ${CHROMIUM}.orig --no-sandbox --disable-gpu --disable-sandbox --user-data-dir=/tmp/ \$@" >> ${CHROMIUM} \
  && chmod 777 ${CHROMIUM}

RUN set -ex \
  && apk add --no-cache docker python python-dev


COPY  --from=docker/compose:alpine-1.28.5 /usr/local/bin/docker-compose /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN cp -f /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN docker-compose -version
  

RUN set -ex \
  && curl -sSLo /tmp/consul.zip https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip \
  && unzip -d /bin /tmp/consul.zip && strip /bin/consul && rm -rf /tmp/consul.zip \
  && mkdir -p /tmp/consul \
  && curl https://releases.rancher.com/cli2/v2.0.5/rancher-linux-amd64-v2.0.5.tar.gz | tar -xz \
  && cp ./rancher-*/rancher /bin/rancher \
  && rm -rf rancher-* \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && mv ./kubectl /bin \
  && chmod +x /bin/kubectl

RUN set -ex \
  && gem install pronto pronto-rubocop rubocop-rails pronto-flay json nokogiri gitlab rest-client bundler-audit rubycritic \
  && gem uninstall unicode-display_width --version '>=1.5.0' || true
  
RUN set -ex \
  && apk add --no-cache wkhtmltopdf libreoffice-writer
  
RUN set -ex \
  && gem install aggkit && gem update aggkit \
  && gem install nexus && gem update nexus \
  && gem install bundler && gem update bundler \
  && gem install bundler-audit && gem update bundler-audit \
  && gem install yard && gem update yard
  
RUN set -ex \
  && mv -f /usr/bin/docker-compose /usr/bin/docker-compose.orig
  
COPY docker-compose /usr/bin/
COPY docker-compose /usr/local/bin/
COPY rndslab.rb /usr/bin/

WORKDIR /home/app

 
CMD ["/bin/bash"]



