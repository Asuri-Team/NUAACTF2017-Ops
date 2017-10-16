#/usr/bin/env bash

basepath=$(cd `dirname $0`; pwd)

cd $basepath/../
mkdir -p traffic/hello
mkdir -p traffic/leave
mkdir -p traffic/string

docker rm -f nuaactf-pwn-hello
docker run -d -p 20001:20000 --name=nuaactf-pwn-hello -v $(pwd)/traffic/hello:/var/lib/tcpdump asuri/nuaactf-hello-pwn

docker rm -f nuaactf-pwn-leave
docker run -d -p 20002:20000 --name=nuaactf-pwn-leave -v $(pwd)/traffic/leave:/var/lib/tcpdump asuri/nuaactf-leave

docker rm -f nuaactf-pwn-string
docker run -d -p 20003:20000 --name=nuaactf-pwn-string -v $(pwd)/traffic/string:/var/lib/tcpdump asuri/nuaactf-string

