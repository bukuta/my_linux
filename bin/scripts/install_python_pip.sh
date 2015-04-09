#!/bin/env bash
base=/tmp/python.pip
if [ -d $base ] ;then
  echo "$base exists"
else
  mkdir -p $base
fi
cd $base
yum install python-devel
function install_setuptools(){
  cd $base
  curl -O https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
  tar xf setuptools-1.4.2.tar.gz
  cd setuptools-1.4.2
  python setup.py install
}
function install_pip(){
  cd $base
  curl -O https://pypi.python.org/packages/source/p/pip/pip-6.1.1.tar.gz
  tar xf pip-6.1.1.tar.gz
  cd pip-6.1.1
  python setup.py install
}
function cleanup(){
  if [ -d $base ]
  then
    echo "rm -rf $base"
    rm -rf $base
  else
    echo "no $base"
  fi
}
install_setuptools
install_pip
cleanup
