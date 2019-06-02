The files in this repository are for use with the configuration, explained here:
https://discourse.pi-hole.net/t/unbound-as-unfiltered-dns-resolver-alternative-for-pihole-disable/20246

Most files contain specific IPv4, IPv6 and subnet examples.
They need to be replaced to make your configuration work
Some files also contain paths to the files that are being modified by the scripts.
They need to be replaced with the actual location of your configuration files

The script /home/pi/.sh compiles unbound from source. This only works if unbount isn’t already on your system!
The script /home/pi/.sh makes the modifications to allow unbound to be used as unfiltered DNS resolver.

More info on pihole + unbound here:
https://docs.pi-hole.net/guides/unbound/
