#!/bin/bash
date="$(date --date="yesterday" '+%Y/%m/%d')"
start="${date} 00:00:00"
stop="${date} 23:59:59"
begintm=$(TZ=CET date --date="$start" +"%s")
endtm=$(TZ=CET date --date="$stop" +"%s")
sqlite3 "/etc/pihole/pihole-FTL.db" "select * from queries where status = 2 AND timestamp BETWEEN $begintm AND $endtm;" | cut -d'|' -f5 | sort -u | while read line
do
	sleep 1
	dig @127.10.10.2 -p 5552 +dnssec $line
done
