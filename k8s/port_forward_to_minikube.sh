#!/bin/bash
#Need to add a removal shell script as well

if [ "$#" == "1" ]; then
	service_name=$1
	response=`minikube service $service_name --url`
	get_url_add_to_iptables $response
else
	while (( "$#" )); do        # While there are arguments still to be shifted
	get_url_add_to_iptables $1
	shift
	done
done
fi

get_url_add_to_iptables(){
	without_http=`echo $1 | set "s/http:\/\///`
	ip=`echo $without_http | cut -d ':' -f1`
	port=`echo $without_http | cut -d ':' -f2`
	sudo iptables -A PREROUTING -t nat -i wlp0s20f3 -p tcp --dport $port -j DNAT --to $ip:$port
	sudo iptables -A FORWARD -p tcp -d $ip --dport $port -j ACCEPT
}


