#!/bin/bash
#need to get the ip and port from the minikube service command so that this is dynamic
#also need to remove this when you are stopping minikube
if [ $# -ne 2]; then
    echo 'Wrong number of params'
    exit 1
fi
port=$1
ip=$2
echo $port and $ip

#sudo iptables -A PREROUTING -t nat -i wlp0s20f3 -p tcp --dport $port -j DNAT --to $ip:$port
#sudo iptables -A FORWARD -p tcp -d $ip --dport $port -j ACCEPT