The files in this repository are for use with the configuration, explained here:
https://discourse.pi-hole.net/t/unbound-as-unfiltered-dns-resolver-alternative-for-pihole-disable/20246 (unfiltered DNS)
and here:
 (unbound + Redis - Cache DB Module Options).

Everything is tested on a raspberry pi model 3B, running the raspbian buster lite version september 2019

Most files contain specific IPv4, IPv6 and subnet examples.
They need to be replaced to make your configuration work!

The scripts also contain paths to the files that are being modified by the scripts.
They need to be replaced with the actual location of your configuration files!

WARNING: it may be wise, even for advanced users, to execute the scripts line by line (copy/paste) this to allow you to keep track of what is actually been changed!

The script /home/pi/compile_unbound.sh compiles unbound from source, using the "Cache DB Module Options" (Redis). This only works if unbount isn’t already installed on your system!

The script /home/pi/bypassFTL.sh makes the modifications,required to allow unbound to be used as unfiltered DNS resolver.

The script /home/pi/install_phpRedisAdmin.sh installs the files, required to look at the Redis data, in the lighttpd folder. Checkup on Redis, using a browser (http://<IP-ADDRESS of pihole>/phpRedisAdmin/).

The script /home/pi/nmapweb is only a partial script, it doesn't download the zipfile. You need to be registered to download this file!
The instructions to install nmapweb can be found here:https://discourse.pi-hole.net/t/run-nmap-security-audit-tool-from-a-web-interface/20351
Read the instructions, and perform the necessary steps, before executing the script!

If you decide to run the scripts, despite the WARNING, you must exexute the with sudo, eg. sudo ./bypassFTL.sh

so (example IP's):

setting the DNS server to 192.168.2.57 would give the client ad blocking (using pihole)

setting the DNS server to 192.168.2.47 would give the client unfiltered DNS

If you are using pihole DHCP, an example to configure alternative DNS server can be found here:
https://raw.githubusercontent.com/deathbybandaid/piadvanced/master/piholetweaks/dnsmasqtweaks/04-bypass.conf

The file bypass_pihole.cmd, a windows script, can be placed on the desktop. When the cmd runs (as administrator) the client will switch from ad blocking to unfiltered for 10 seconds, giving you the time to hit the refresh button of your browser. 

More info on pihole + unbound here:
https://docs.pi-hole.net/guides/unbound/
