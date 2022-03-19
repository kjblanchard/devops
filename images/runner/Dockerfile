FROM zenika/terraform-aws-cli
USER root
RUN apt update -y && apt upgrade -y && \
    apt install curl gunicorn python3-flask -y
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
WORKDIR /usr/src/app
COPY . .
USER 1001
ENV FLASK_APP main.py
CMD [ "gunicorn", "-w", "4", "-b", ":80", "main:app" ]