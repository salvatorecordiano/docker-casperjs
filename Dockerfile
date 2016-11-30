FROM ubuntu:14.04
MAINTAINER Salvatore Cordiano <docker@parallel.it>

ENV DEBIAN_FRONTEND noninteractive
ENV PHANTOMJS_VERSION 2.1.1

RUN apt-get update && apt-get install -y nodejs npm wget libfreetype6 libfontconfig
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN node -v
RUN npm -v

WORKDIR /apps

COPY resources/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 /apps/phantomjs/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2
# ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 /apps/phantomjs/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2
# RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 -P /apps/phantomjs/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2
RUN tar jxvf /apps/phantomjs/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 -C /usr/local/
RUN ln -s /usr/local/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
RUN phantomjs -v

RUN npm install -g casperjs
RUN casperjs --version

COPY resources/test.js /apps/test.js
RUN casperjs test.js
