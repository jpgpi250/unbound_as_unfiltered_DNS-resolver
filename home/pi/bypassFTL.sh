#!/bin/bash

# add secondary IP address
sudo ip -4 addr add 192.168.2.47/27 dev eth0
file=/etc/dhcpcd.exit-hook
echo 'ip -4 addr add 192.168.2.47/27 dev eth0' | sudo tee -a $file

# modify 01-pihole.conf to listen on specific address
file=/etc/dnsmasq.d/01-pihole.conf
sudo sed -i 's/interface=/#&/' $file
echo 'listen-address=192.168.2.57' | sudo tee -a $file
echo 'listen-address=127.0.0.1' | sudo tee -a $file
sudo service pihole-FTL stop
sudo service pihole-FTL start

# modify unbound configuration
file=/etc/unbound/unbound.conf.d/unbound.conf
sudo sed -i '0,/\tinterface:/s//\tinterface: 192.168.2.47@5552\n&/' $file
sudo sed -i '0,/\taccess-control:/s//\taccess-control: 192.168.2.192\/26 allow\n&/' $file
sudo service unbound stop
sudo service unbound start

# add iptables rules to perfom redirection
sudo iptables -t nat -A PREROUTING -d 192.168.2.47 -p tcp --dport 53 -j REDIRECT --to-port 5552
sudo iptables -t nat -A PREROUTING -d 192.168.2.47 -p udp --dport 53 -j REDIRECT --to-port 5552

# save the iptables rules
sudo apt-get -y install iptables-persistent
sudo iptables-save | sudo tee /etc/iptables/rules.v4

# reboot
sudo reboot
