#!/usr/bin/env bash

basepath=$(cd `dirname $0`; pwd)

cd $basepath/../challenges

docker rm -f nuaactf-web-db
docker run -d --restart=always --name=nuaactf-web-db \
    -v $basepath/../data/web-db:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=nuaactf-web-r00t \
    mariadb:10.2

docker rm -f nuaactf-web-fpm
docker run -d --restart=always --name=nuaactf-web-fpm \
    -v $(pwd)/web:/app \
    --link=nuaactf-web-db:db \
    asuri/nuaactf-php-mysql

docker rm -f nuaactf-web-nginx
docker run -d --restart=always --name=nuaactf-web-nginx \
    -v $(pwd)/web:/app \
    -v $(pwd)/web/sign-in.conf:/etc/nginx/conf.d/sign-in.conf \
    -v $(pwd)/web/sqli_twice.conf:/etc/nginx/conf.d/sqli_twice.conf \
    -v $(pwd)/web/lfi.conf:/etc/nginx/conf.d/lfi.conf \
    -p 8001:8001 \
    -p 8002:8002 \
    -p 8004:8004 \
    --link=nuaactf-web-fpm:fpm \
    nginx:1.12

docker rm -f nuaactf-web-xss
docker run -d --restart=always --name=nuaactf-web-xss \
    -p 8003:3000 \
    asuri/nuaactf-web-xss
