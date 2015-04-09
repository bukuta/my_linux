#!/bin/env bash
base=/tmp/gcc4.8
mkdir -p $base
function install_gcc(){
  #curl http://gcc.skazkaforyou.com/releases/gcc-4.8.2/gcc-4.8.2.tar.gz -o $base/gcc-4.8.3.tar.gz
  cd $base
  #tar -xf gcc-4.8.2.tar.gz
  #cd gcc-4.8.2
  #./contrib/download_prerequistites
  mkdir gcc-build-4.8.2 
  cd gcc-build-4.8.2
  echo $(pwd)
  ../gcc-4.8.2/configure --enable-checking=release --enable-threads=posix --enable-languages=c,c++ --with-gmp=/usr/local/gmp-4.3.2 --with-mpfr=/usr/local/mpfr-2.4.2 --with-mpc=/usr/local/mpc-0.8.1 \
  && make && make install
  gcc --version
}
function install_dependencies(){
  depbase=/tmp/gcc4.8/deps
  mkdir -p $depbase
  #cd $depbase
  #curl -O ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
  #tar -xf gmp-4.3.2.tar.bz2 \
  #  && mkdir gmp-build \
  #  && cd gmp-build \
  #  && ../gmp-4.3.2/configure --prefix=/usr/local/gmp-4.3.2\
  #  && make &&make check && sudo make install

  #cd $depbase
  #curl -O ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2
  #tar -xf mpfr-2.4.2.tar.bz2 \
  #  && mkdir mpfr-build \
  #  && cd mpfr-build \
  #  && ../mpfr-2.4.2/configure --prefix=/usr/local/mpfr-2.4.2 --with-gmp=/usr/local/gmp-4.3.2 \
  #  && make && make check && sudo make install
  #
  cd $depbase
  #curl -O ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz
  #tar -xf mpc-0.8.1.tar.gz \
  #  && mkdir mpc-build \
    echo "mpc-build" \
    && cd mpc-build \
    && ../mpc-0.8.1/configure --prefix=/usr/local/mpc-0.8.1 --with-gmp=/usr/local/gmp-4.3.2 --with-mpfr=/usr/local/mpfr-2.4.2\
    && make && make check && sudo make install
}
#install_dependencies
install_gcc
