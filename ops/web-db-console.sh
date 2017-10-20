#!/usr/bin/env bash

basepath=$(cd `dirname $0`; pwd)

docker exec -it nuaactf-web-db mysql -uroot -pnuaactf-web-r00t -D sqli

