#!/bin/bash

cd /var/www/html/
wget --http-user nagiosadmin --http-passwd n4g10s 'http://10.150.20.15/nagios/cgi-bin/status.cgi?hostgroup=Production&style=detail&serviceprops=270346&hostprops=270346&sorttype=2&hoststatustypes=14&sortoption=3&limit=100&servicestatustypes=30&noheader=1' && \
	grep -v "^<td valign=top align=left width=33%" status.cgi\?hostgroup\=Production* > .status && \
	sed -i -e "s:</td><td valign=top align=center width=33%>:<td valign=top align=center width=100%>:" \
	       -e "s:^<head>:<head>\n<meta http-equiv="refresh" content="60">:" \
	       -e "s:<div id='pagelimit'>:_COSA_\n<div id='pagelimit'>:" \
               -e "s:Service Status Details For Host Group 'Production':INTERXION MONITOR:" .status && \
		{
			backIFS=$IFS
			IFS=$'\n'
			for i in $(cat .status) ; do
				if [ "$i" = "_COSA_" ]; then
					cat << EOM
<div align=center>
<form name=countdown class=c>
Refresh in <input type=text size=2 name=secs>
$(date "+%d-%m-%y %H:%M:%S")
</form>
</div>
<script> 
<!-- 
// 
 var milisec=0 
 var seconds=60
 document.countdown.secs.value='60' 

function display(){ 
 if (milisec<=0){ 
    milisec=9 
    seconds-=1 
 } 
 if (seconds<=-1){ 
    milisec=0 
    seconds+=1 
 } 
 else 
    milisec-=1 
    document.countdown.secs.value=seconds+"."+milisec+"s"
    setTimeout("display()",100) 
} 
display() 
--> 
</script>  
EOM
					continue
				else
					echo $i
				fi
			done
			IFS=$backIFS
		} >  /var/www/html/nagiosdivision2.html
rm -f .status status.cgi\?hostgroup\=Production*

