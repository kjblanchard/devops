#!/bin/sh
#This is how you actually start minikube, could be added to ansible if it isn't started.
minikube start --driver=docker --mount /kube_host