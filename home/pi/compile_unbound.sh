#!/bin/bash

sudo apt-get -y install libssl-dev
sudo apt-get -y install libexpat1-dev

sudo groupadd -g 991 unbound
sudo useradd -c "unbound-1.9.3" -d /var/lib/unbound -u 991 -g unbound -s /bin/false unbound

file=unbound-1.9.3
mkdir -p unbound
cd unbound
wget https://nlnetlabs.nl/downloads/unbound/$file.tar.gz
tar xzf $file.tar.gz 
cd $file

sudo ./configure --prefix=/usr --sysconfdir=/etc --disable-static --with-pidfile=/run/unbound.pid
sudo make
sudo make install
cd ..
cd ..
