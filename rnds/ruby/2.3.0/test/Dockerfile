FROM rnds/ruby:2.3.0
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update &&\
  apt-get -y install xvfb libodbc1 libltdl7 libgconf-2-4 imagemagick &&\
  apt-get -y install fonts-liberation libappindicator1 libindicator7 libdbusmenu-gtk4 libdbusmenu-glib4 libpango1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add - &&\
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list &&\
  apt-get update &&\
  apt-get -y install google-chrome-stable chromedriver &&\
  wget 'http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~jessie_amd64.deb' &&\
  dpkg -i sphinxsearch_2.2.11-release-1~jessie_amd64.deb &&\
  rm sphinxsearch_2.2.11-release-1~jessie_amd64.deb &&\
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



ENV CHROME=/opt/google/chrome/google-chrome

RUN mv ${CHROME} ${CHROME}.orig &&\
  echo "#!/bin/sh" >> ${CHROME} &&\
  echo "exec ${CHROME}.orig --no-sandbox --disable-gpu --disable-sandbox --user-data-dir=/tmp/ \$@" >> ${CHROME} &&\
  chmod 777 ${CHROME}


WORKDIR /home/app


CMD ["tail", "-f", "/dev/null"]



