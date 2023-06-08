FROM nginx:1.20-alpine
RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev rust cargo
RUN pip3 install pip --upgrade
RUN pip3 install certbot-nginx
RUN mkdir /etc/letsencrypt

#Copy the nginx configuration files, the first is for generating/updating the cert, the second is for the actual webserver when the cert is prepared to point to our flask server.
COPY ./certbot_default.conf /etc/nginx/conf.d/default.conf.certbot
COPY ./default.conf /etc/nginx/conf.d/default.conf.webserver

#Make the keys folder where we will hold some things for when we need to generate the cert, and the configuration for generating the cert
ENV KEYS_FOLDER=/etc/certbot/conf/live/wedding.supergoon.com
RUN mkdir -p $KEYS_FOLDER

#This should be a bind mount, as it holds the actual certificate.
ENV CERT_FOLDER=/etc/letsencrypt/live/wedding.supergoon.com/
RUN mkdir -p $CERT_FOLDER

#Put our file into the daily cron to keep the cert updated and to run on a monthly basis, and add to crontabs.
ARG CRON_FOLDER=/etc/periodic/monthly/
COPY ./update_cert_cron.sh $CRON_FOLDER/update_cert_cron
COPY cronjobs /etc/crontabs/root
RUN chmod +x $CRON_FOLDER
RUN chmod +x $CRON_FOLDER/update_cert_cron
# Add the logging file to troubleshoot certificate renewals
RUN mkdir -p /var/log/wedding/test_file.txt

COPY ./get_ssl_keys.sh start.sh
RUN chmod +x start.sh

RUN ./start.sh; exit 0




