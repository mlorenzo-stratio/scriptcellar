#!/bin/bash
# This is a sample shell script showing how you can submit the SCHEDULE_HOST_SVC_DOWNTIME command
# to Nagios.  Adjust variables to fit your environment as necessary.

now=`date +%s`
commandfile='/usr/local/nagios/var/rw/nagios.cmd'
host="$1"

date_ini=$(date -d "$2" +%s)
date_end=$(date -d "$3" +%s)

if [ -z "$host" ] || [ -z "$date_ini" ] || [ -z "$date_end" ]; then
	echo "Usage: $0 <host> <date_ini> <date_end>"
	exit 1
fi
# SCHEDULE_HOST_DOWNTIME;<host_name>;<start_time>;<end_time>;<fixed>;<trigger_id>;<duration>;<author>;<comment>
/usr/bin/printf "[%lu] SCHEDULE_HOST_DOWNTIME;$host;$date_ini;$date_end;1;0;7200;Nagios Admin;Scheduled downtime\n" $now > $commandfile
