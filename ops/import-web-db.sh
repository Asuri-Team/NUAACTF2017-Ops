#!/usr/bin/env bash

basepath=$(cd `dirname $0`; pwd)

cd $basepath/../challenges

docker exec -i nuaactf-web-db mysql -uroot -pnuaactf-web-r00t <<EOF
create database if not exists sqli charset=utf8;
grant all privileges on sqli.* to sqli@'%' identified by 'sqli';                 
EOF

docker exec -i nuaactf-web-db mysql -uroot -pnuaactf-web-r00t -D sqli < $(pwd)/web/sqli_twice/schema.sql

