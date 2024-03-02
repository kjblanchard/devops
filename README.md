# Supergoon Devops
## Handles Terraform and Ansible config for Supergoon Components and kubernetes host
- Most of the repos below build docker images on github actions.  Workflow is to update the repo, then update the terraform image version in this repo to update.

### GoonDDNS
This is a cronjob that automatically updates AWS route53 records for hosting from home with a dynamic IP
- [Github](https://github.com/supergoongaming/sg_ddns)

### Supergoon Nginx
Reverse proxy / ssl termination for all supergoon endpoints.  Also restarts nginx as needed for updating certs
- [Github](https://github.com/supergoongaming/sg_nginx)

### Supergoon Certbot
Cronjob that updates letsencrypt certs every month to prevent expiration
- [Github](https://github.com/supergoongaming/sg_certbot)

### Supergoon Website
This is the portfolio page for supergoon.com
- [Website](https://supergoon.com)
- [Github](https://github.com/supergoongaming/sg_com)

### Wedding Website - wedding.supergoon.com

This is a golang website for our wedding.  It has a lot of elements to it, mostly for fun.
- [Website]( https://wedding.supergoon.com)
- [Github](https://github.com/supergoongaming/sg_wedding)




### Host info
- Host: Intel Nuc
- OS - Ubuntu Desktop
- Container Orchestration - Kubernetes (minikube)


## Setup
### Tools
- Ansible - Configure the Intel Nuc
- Terraform - Deploy the kubernetes components
- Helm - Will move off of terraform one day.
- Minikube - local k8s running as a docker container

### Traffic Flow to Website:
- Internet --> Nucbuntu(Ubuntu Intel Nuc) --> Minikube(docker) --> NGINX(k8s pod) --> Apps

## Authors

- [@kevin blanchard](https://www.github.com/kjblanchard)

