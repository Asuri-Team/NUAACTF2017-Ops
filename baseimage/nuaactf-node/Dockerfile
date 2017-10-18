FROM phusion/baseimage:0.9.22


RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list

RUN apt-get update && apt-get install -y apt-transport-https \
    && sed -i s/http:/https:/g /etc/apt/sources.list \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs phantomjs

RUN npm config set registry https://registry.npm.taobao.org && npm install -g yarn && rm -fr /root/.cache/*
RUN yarn config set registry https://registry.npm.taobao.org 

ADD phantomjs /usr/bin/phantomjs
RUN chmod +x /usr/bin/phantomjs

