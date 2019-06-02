#!/bin/bash

indexfile=/var/www/html/nmapweb/index.php
sudo sed -i 's#/opt/local/bin/nmap#/usr/bin/nmap#' $indexfile
classfile=/var/www/html/nmapweb/nmap.cls.php
sudo sed -i 's#-P0#-Pn#' $indexfile
sudo sed -i 's#-sR#-sV#' $indexfile

# /usr/bin/nmap permissions
sudo chmod 4755 /usr/bin/nmap

# since running Nmap with setuid, as we are doing, is a major security risk 
# we add lighttpd security for nmapweb
# allow only access from a specific IP (your workstation)
file=/etc/lighttpd/external.conf
if ! grep -q "/nmapweb/" $file; then
	echo '$HTTP["remoteip"] != "192.168.2.228" {' | sudo tee -a $file
    echo '  $HTTP["url"] =~ "^/nmapweb/" {' | sudo tee -a $file
    echo '    url.access-deny = ( "" )' | sudo tee -a $file
    echo '  }' | sudo tee -a $file
    echo '}' | sudo tee -a $file
fi
sudo service lighttpd stop
sudo service lighttpd start
