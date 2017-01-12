FROM rnds/ruby:2.3.0
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get upgrade -y && \
  apt-get -y install chromium xvfb chromedriver libodbc1 libltdl7 libgconf-2-4 imagemagick &&\
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /home/app

CMD ["tail", "-f", "/dev/null"]



