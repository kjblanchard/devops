# Wedding Website

This is a website for our upcoming wedding.  It has a lot of elements to it, mostly for fun.
https://wedding.supergoon.com

Host: Intel Nuc \
OS - Ubuntu Desktop \
Container Orchestration - Kubernetes (minikube) \

Containers \
NGINX - Reverse Proxy / SSL \
Flask - webapp \

Tools \
Ansible - Configure the Intel Nuc \
Terraform - Deploy the kubernetes components \
Helm - ? \
Minikube - local k8s running as a docker container \

Traffic Flow to Website:
Internet --> Nucbuntu(Ubuntu Intel Nuc) --> Minikube(docker) --> NGINX(k8s pod) --> Flask(k8s pod, gunicorn)

## Authors

- [@kevin blanchard](https://www.github.com/kjblanchard)

