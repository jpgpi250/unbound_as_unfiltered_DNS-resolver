#!/bin/bash

sudo apt-get -y install libssl-dev
sudo apt-get -y install libexpat1-dev
sudo apt-get -y install libevent-dev

# redis
sudo apt-get -y install redis-server
# reference configuration file changes https://habilisbest.com/install-redis-on-your-raspberrypi
file=/etc/redis/redis.conf
sudo sed -i '/tcp-backlog 511/s/^/#/g' $file
sudo sed -i '/#tcp-backlog 511/a tcp-backlog 63' $file
sudo sed -i '/syslog-enabled no/s/^# //g' $file
sudo sed -i '/databases 16/s/^/#/g' $file
sudo sed -i '/#databases 16/a databases 1' $file
sudo sed -i '/always-show-logo yes/s/^/#/g' $file
sudo sed -i '/#always-show-logo yes/a always-show-logo no' $file
sudo sed -i '/stop-writes-on-bgsave-error yes/s/^/#/g' $file
sudo sed -i '/#stop-writes-on-bgsave-error yes/a stop-writes-on-bgsave-error no' $file
sudo sed -i '/rdbcompression yes/s/^/#/g' $file
sudo sed -i '/#rdbcompression yes/a rdbcompression no' $file
sudo sed -i '/# maxmemory <bytes>/a maxmemory 32M' $file
sudo sed -i '/# maxmemory-policy noeviction/a maxmemory-policy allkeys-lru' $file
sudo sed -i '/slowlog-max-len 128/s/^/#/g' $file
sudo sed -i '/#slowlog-max-len 128/a slowlog-max-len 16' $file
sudo service redis stop
sudo service redis start

# library, required to compile unbound --with-libhiredis
sudo apt-get install libhiredis-dev

# user
sudo groupadd -g 991 unbound
sudo useradd -c "unbound-1.10.0" -d /var/lib/unbound -u 991 -g unbound -s /bin/false unbound

file=unbound-1.10.0
mkdir -p unbound
cd unbound
wget https://nlnetlabs.nl/downloads/unbound/$file.tar.gz
tar xzf $file.tar.gz 
cd $file

sudo ./configure --prefix=/usr --sysconfdir=/etc --disable-static --enable-tfo-client --enable-tfo-server --with-libevent --with-libhiredis --enable-cachedb --with-pidfile=/run/unbound.pid
sudo make
sudo make install
cd ..
cd ..
