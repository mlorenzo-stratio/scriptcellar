#!/bin/bash
# This is a sample shell script showing how you can submit the SCHEDULE_HOST_SVC_DOWNTIME command
# to Nagios.  Adjust variables to fit your environment as necessary.

now=`date +%s`
commandfile='/usr/local/nagios/var/rw/nagios.cmd'
host="$1"
service="$2"

date_ini=$(date -d "$3" +%s)
date_end=$(date -d "$4" +%s)

if [ -z "$host" ] || [ -z "$service" ] || [ -z "$date_ini" ] || [ -z "$date_end" ]; then
	echo "Usage: $0 <host> <service> <date_ini> <date_end>"
	exit 1
fi
# SCHEDULE_SVC_DOWNTIME;<host_name>;<service_desription><start_time>;<end_time>;<fixed>;<trigger_id>;<duration>;<author>;<comment>
/usr/bin/printf "[%lu] SCHEDULE_SVC_DOWNTIME;$host;$service;$date_ini;$date_end;1;0;7200;Nagios Admin;Scheduled downtime\n" $now > $commandfile
