#!/usr/bin/env bash

PASSWORD=nuaactf-ctfd-root

docker exec -it nuaactf-db mysql -uroot -p$PASSWORD ctfd

