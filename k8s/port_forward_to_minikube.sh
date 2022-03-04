#!/bin/bash
#Need to add a removal shell script as well

if [ "$#" != "1" ]; then
	echo 'You need to pass in 1 paramte that is the service name.'
	exit 1
fi
service_name=$1

response=`minikube service $service_name --url | sed "s/http:\/\///"`
ip=`echo $response | cut -d ':' -f1`
port=`echo $response | cut -d ':' -f2`
echo $ip and $port

#sudo iptables -A PREROUTING -t nat -i wlp0s20f3 -p tcp --dport $port -j DNAT --to $ip:$port
#sudo iptables -A FORWARD -p tcp -d $ip --dport $port -j ACCEPT
