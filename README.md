# Supergoon Devops

## Random DevOps Tools

- Most of the repos below build docker images on github actions.

### GoonDDNS

Cronjob that automatically updates AWS route53 records for hosting

- [Github](https://github.com/supergoongaming/sg_ddns)

### Supergoon Nginx

Reverse proxy / ssl termination for all supergoon endpoints.

- [Github](https://github.com/supergoongaming/sg_nginx)

### Supergoon Certbot

Cronjob that updates letsencrypt certs every month to prevent expiration

- [Github](https://github.com/supergoongaming/sg_certbot)

### Supergoon Website

This is the portfolio page for supergoon.com

- [Website](https://supergoon.com)
- [Github](https://github.com/supergoongaming/sg_com)

### Wedding Website - wedding.supergoon.com

This is a golang website for our wedding. Made for fun.

- [Website]( https://wedding.supergoon.com)
- [Github](https://github.com/supergoongaming/sg_wedding)

### Discord Bot

This handles updating the discord server when releases happen, and slash cmds.

- [Github](https://github.com/kjblanchard/sggDiscordBot)

### Host info

- Host: Intel Nuc
- OS - Proxmox 9.1
- Container Orchestration - Kubernetes (k3s)

## Setup

### Tools

- Ansible - Configure the VMs and Pods
- Docker - For things not migrated to k8s
- K3s - easy local k8s

### Traffic Flow to Website

- Internet --> k3s VM --> NGINX(k8s pod) --> Apps

## Authors

- [@kevin blanchard](https://www.github.com/kjblanchard)

