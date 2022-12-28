FROM rnds/ruby:3.0

RUN set -ex \
  && apk add --no-cache \
    xvfb \
    unixodbc-dev \
    libltdl \
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
  && apk add --no-cache docker python2 python2-dev
  
RUN set -ex \
  && cd /tmp \
  && wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.5.tgz \
  && tar zxvf ./docker-20.10.5.tgz \
  && cp -f docker/docker /usr/bin 

COPY  --from=docker/compose:alpine-1.28.5 /usr/local/bin/docker-compose /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN cp -f /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN docker-compose -version

COPY  --from=harbor.rnds.pro/aggredator/consul:latest /bin/consul /bin/consul
RUN chmod +x /bin/consul

RUN set -ex \
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



