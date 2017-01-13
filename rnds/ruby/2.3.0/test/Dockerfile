FROM rnds/ruby:2.3.0
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get upgrade -y && \
  apt-get -y install xvfb libodbc1 libltdl7 libgconf-2-4 imagemagick &&\
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add - &&\
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list &&\
  apt-get -y install fonts-liberation libappindicator1 libindicator7 libdbusmenu-gtk4 libdbusmenu-glib4 libpango1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 &&\
  apt-get -y install google-chrome-stable chromedriver &&\
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /home/app

CMD ["tail", "-f", "/dev/null"]



