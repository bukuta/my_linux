#!/bin/sh
yum -y install git gcc vim man mlocate make cmake cpack
yum -y install zlib zlib-devel openssl opsnssl-devel pcre pcre-devel

git clone https://github.com/nginx/nginx.git

cd nginx
sh ./configure
make
make install
