#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

sudo apt-get -y install libtool 
sudo apt-get -y install php7.3-dev 
sudo apt-get -y install php7.3-redis
sudo apt-get -y install php-mbstring

# https://packagist.org/packages/erik-dubbelboer/php-redis-admin
cd /var/www/html
sudo git clone https://github.com/ErikDubbelboer/phpRedisAdmin.git
cd phpRedisAdmin
sudo git clone https://github.com/nrk/predis.git vendor

sudo service lighttpd stop
sudo service lighttpd start
