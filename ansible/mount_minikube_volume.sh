#!/bin/sh
# minikube mount <source directory>:<target directory>
minikube mount /etc/letsencrypt:/etc/letsencrypt
minikube mount /var/www/challenge/.well-known/acme-challenge enf3rno/sg_certbot:/var/www/challenge/.well-known/acme-challenge enf3rno/sg_certbot