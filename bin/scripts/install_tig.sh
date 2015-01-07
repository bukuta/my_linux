#!/bin/sh
echo "install tig"
cd ~/devspace/
git clone https://github.com/jonas/tig.git
cd tig
make
make install
clear
echo "tig installed"
