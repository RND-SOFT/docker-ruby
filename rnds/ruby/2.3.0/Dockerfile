FROM ruby:2.3.0-slim
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN apt-get update && apt-get upgrade -y && \
  apt-get -y install libxext6 libxrender1 curl git build-essential libmysqlclient-dev libpq-dev &&\
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc && \
  gem install bundler --no-ri --no-rdoc


RUN mkdir -p ~/.ssh && echo "Host * \
  \nStrictHostKeyChecking no \
  \nUserKnownHostsFile=/dev/null\n" >> ~/.ssh/config

WORKDIR /home/app

#CMD ["ruby", "-v"]
CMD ["tail", "-f", "/dev/null"]



