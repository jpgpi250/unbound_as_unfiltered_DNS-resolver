The files in this repository are for use with the configuration, explained here:
https://discourse.pi-hole.net/t/unbound-as-unfiltered-dns-resolver-alternative-for-pihole-disable/20246

Most files contain specific IPv4, IPv6 and subnet examples.
They need to be replaced to make your configuration work
Some files also contain paths to the files that are being modified by the scripts.
They need to be replaced with the actual location of your configuration files

The script /home/pi/bypassFTL.sh compiles unbound from source. This only works if unbount isn’t already on your system!
The script /home/pi/compile_unbound.sh makes the modifications,required to allow unbound to be used as unfiltered DNS resolver.

so (example IP's)
setting the DNS server to 192.168.2.57 would give the client ad blocking (using pihole)
setting the DNS server to 192.168.2.47 would give the client unfiltered DNS

The file , a windows script, can be placed on the desktop. When the cmd runs (as administrator) the client will switch from ad blocking to unfiltered for 10 seconds, giving you the time to hit the refresh button. 

More info on pihole + unbound here:
https://docs.pi-hole.net/guides/unbound/
