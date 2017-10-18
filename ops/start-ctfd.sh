#!/usr/bin/env bash

basepath=$(cd `dirname $0`; pwd)

cd $basepath/../

mkdir -p $(pwd)/data/CTFd/logs
mkdir -p $(pwd)/data/CTFd/uploads

chmod 777 $(pwd)/data/CTFd/logs
chmod 777 $(pwd)/data/CTFd/uploads

docker rm -f nuaactf-db
docker run -d --restart=always -e MYSQL_ROOT_PASSWORD=nuaactf-ctfd-root -e MYSQL_USER=ctfd -e MYSQL_PASSWORD=ctfd -v $(pwd)/data/mysql:/var/lib/mysql --name=nuaactf-db mariadb:10.2 

docker rm -f nuaactf-redis
docker run -d --restart=always --name=nuaactf-redis redis:3.2

docker rm -f nuaactf-ctfd
docker run -d --restart=always \
    -e REDIS_URL=redis://redis:6379/0 \
    -e DATABASE_URL=mysql+pymysql://root:nuaactf-ctfd-root@db/ctfd \
    -v $(pwd)/data/CTFd/logs:/app/ctfd/CTFd/logs \
    -v $(pwd)/data/CTFd/uploads:/app/ctfd/CTFd/uploads \
    --link=nuaactf-db:db \
    --link=nuaactf-redis:redis \
    --name=nuaactf-ctfd \
    -p 8000:8000 \
    asuri/ctfd-uwsgi


