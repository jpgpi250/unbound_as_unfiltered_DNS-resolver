#!/bin/bash

sudo apt-get -y install libssl-dev
sudo apt-get -y install libexpat1-dev
sudo apt-get -y install libevent-dev

# redis
sudo apt-get -y install redis-server
# reference configuration file changes https://habilisbest.com/install-redis-on-your-raspberrypi
file=/etc/redis/redis.conf
sudo sed -i '/# maxmemory <bytes>/a maxmemory 50M' $file
sudo sed -i '/stop-writes-on-bgsave-error yes/s/^/#/g' $file
sudo sed -i '/#stop-writes-on-bgsave-error yes/a stop-writes-on-bgsave-error no' $file
sudo sed -i '/# maxmemory-policy noeviction/a maxmemory-policy allkeys-lru' $file
sudo service redis stop
sudo service redis start

# library, required to compile unbound --with-libhiredis
sudo apt-get install libhiredis-dev

# user
sudo groupadd -g 991 unbound
sudo useradd -c "unbound-1.9.4" -d /var/lib/unbound -u 991 -g unbound -s /bin/false unbound

file=unbound-1.9.4
mkdir -p unbound
cd unbound
wget https://nlnetlabs.nl/downloads/unbound/$file.tar.gz
tar xzf $file.tar.gz 
cd $file

sudo ./configure --prefix=/usr --sysconfdir=/etc --disable-static --with-libevent --with-libhiredis --enable-cachedb --with-pidfile=/run/unbound.pid
sudo make
sudo make install
cd ..
cd ..
