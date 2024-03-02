#!/bin/bash
# This file is placed at /usr/local/bin on nucbuntu and ran at startup. Succeeded ansible
# Started by /etc/systemd/system/setup-iptables.service
# This needs to be added to ansible config in the future.
exec &> /tmp/iptables_configure.log

minikube_ip_address="192.168.49.2"
minikube_http_port="30007"
minikube_ssl_port="30008"
#interface_name="wlp0s20f3"
interface_name="eno1"

# Clear existing rules
iptables -F

# Add forwarding rules
iptables -A FORWARD -p tcp -d "$minikube_ip_address" --dport "$minikube_http_port" -j ACCEPT
iptables -A FORWARD -p tcp -d "$minikube_ip_address" --dport "$minikube_ssl_port" -j ACCEPT

# Forward incoming traffic to Minikube
iptables -t nat -A PREROUTING -i "$interface_name" -p tcp --dport 80 -j DNAT --to-destination "$minikube_ip_address:$minikube_http_port"
iptables -t nat -A PREROUTING -i "$interface_name" -p tcp --dport 443 -j DNAT --to-destination "$minikube_ip_address:$minikube_ssl_port"
