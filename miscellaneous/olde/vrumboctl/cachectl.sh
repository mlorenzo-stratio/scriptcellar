
VM_CATALOG=/dev/shm/vm_catalog
wget -O $VM_CATALOG http://cerberus.rumbo.com/vm_catalog >/dev/null 2>&1

CACHE_LIST=$(cat $VM_CATALOG | egrep -i '(terracotta|infinispan|redis)' | grep PRD | cut -d' ' -f2,3 | sort -u | sed -e 's/ /_/g' | sed -e 's/\n/ /g')

CACHE=$1
SERVICE=$(echo $CACHE | cut -d_ -f1 | tr '[:upper:]' '[:lower:]') 
APP=$(echo $CACHE | cut -d_ -f2)
SERVERS=$(cat $VM_CATALOG | grep -i -w $SERVICE 2>/dev/null | grep -i -w $APP 2>/dev/null | grep PRD | cut -d\; -f1)

case "$2" in
    start)
        for server in $SERVERS
        do
                ssh rumbo@$server "hostname && /etc/init.d/$SERVICE start && echo"
        done
	;;
    start-delete)
	if [ "$SERVICE" = "terracotta" ]
	then 
        	for server in $SERVERS
        	do
                	ssh rumbo@$server "hostname && /etc/init.d/$SERVICE start-delete && echo"
        	done
	fi
        ;;
    stop)
        for server in $SERVERS
        do
                ssh rumbo@$server "hostname && /etc/init.d/$SERVICE stop && echo"
        done
	;;
    status)
	for server in $SERVERS
	do
		ssh rumbo@$server "hostname && /etc/init.d/$SERVICE status && echo"
	done
	;;
    *)
	echo "Usage: $0 SERVICE {start|start-delete|stop|status}"
	echo
	echo "SERVICES:"
	echo $CACHE_LIST
	echo
	echo "NOTICE: Option start-delete is only valid for Terracotta. This option deletes all data and statistics and then starts up the service."
	echo
	exit 1
	;;
esac

