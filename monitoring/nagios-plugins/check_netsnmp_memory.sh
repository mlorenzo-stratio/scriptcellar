#!/bin/bash

USER1="/usr/lib/nagios/plugins"

WARNING_MEM=$4
CRITICAL_MEM=$5
WARNING_SWAP=$6
CRITICAL_SWAP=$7

RESULT=$($USER1/check_netsnmp_memory.pl -H $1 -$2 -C $3 -L "Memory" -A 'avail_real,user,used_swap,cached,buffer' -a 'avail_real,user,cached,buffer,%used_swap,%user_real,%cached_real' -w ",,,,$WARNING_SWAP%,$WARNING_MEM%," -c ",,,,$CRITICAL_SWAP%,$CRITICAL_MEM%,")
EXIT_CODE=$?
PERFDATA=$(echo $RESULT | cut -d '|' -f2)
RESULT=$(echo $RESULT | cut -d '|' -f1)
echo $PERFDATA | while IFS=' ' read user used_swap cached buffer avail_real; do
    avail_real=$(echo $(echo $avail_real | cut -d '=' -f2)*1024*1024 | bc)
    user=$(echo $(echo $user | cut -d '=' -f2)*1024*1024 | bc)
    used_swap=$(echo $(echo $used_swap | cut -d '=' -f2)*1024*1024 | bc)
    cached=$(echo $(echo $cached | cut -d '=' -f2)*1024*1024 | bc)
    buffer=$(echo $(echo $buffer | cut -d '=' -f2)*1024*1024 | bc)
    echo "$RESULT| user=$user"B" used_swap=$used_swap"B" cached=$cached"B" buffer=$buffer"B" avail_real=$avail_real"B
done
exit $EXIT_CODE
