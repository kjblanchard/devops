#!/bin/sh
#This is how you actually start minikube, could be added to ansible if it isn't started.
# Started by /etc/systemd/system/start-minikube.service
# This needs to be added to ansible config in the future.

# This file is placed at /usr/local/bin on nucbuntu and ran at startup.
# minikube start --driver=docker --mount /kube_host
minikube start --mount-string="/kube_host:/kube_host" --mount

# If there is issues with minikube certificate, delete and then start:
# minikube delete