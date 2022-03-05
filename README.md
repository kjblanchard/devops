The wedding website.

This is running on a Intel Nuc with Ubuntu Desktop installed as the OS.
The containers are controlled by Kubernetes running in Minikube

NGINX - reverse proxy and handling SSL
Jenkins - Handles auto rebuilding the Docker images on git changes and pushing to docker hub.
Flask - python web app

Linux (debian) requirements (Ansible is used to configure):
Minikube - for running all the containers
Kubectl - To talk to the kubernetes api
Helm - To handle jenkins deployment

Docker - Minikube runs on docker (not installed via ansible yet)

Run:
Start minikube (mount_minikube_volume.sh)
Use iptables to port forward if you need to access it outside the cluster (script for that in k8s folder)
Port forward from your router to the phsical host on 80 and 443 to the nodeports
profit

Traffic Flow to Website:
Internet --> Nucbuntu(Ubuntu Intel Nuc) --> Minikube(docker) --> NGINX(k8s pod) --> Flask(k8s pod, gunicorn)

Manual Steps:
Home router - port forward to nucbuntu, likely cannot be automated for me, as I'm using unifi.
Nucbuntu - Iptables to Minikube pod - future use ansible playbook to remove old entries and add new ones.