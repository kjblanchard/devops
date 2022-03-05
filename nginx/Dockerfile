# This is used to get and update certs used on the webserver.
FROM certbot/certbot:latest

#Install nginx
RUN apk add openssl curl ca-certificates && \
    printf "%s%s%s%s\n" "@nginx " "http://nginx.org/packages/alpine/v" `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` "/main" | tee -a /etc/apk/repositories && \
    curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && \
    mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/ && \
    apk add nginx@nginx && \
    apk add nginx-module-image-filter@nginx nginx-module-njs@nginx

#Copy the nginx configuration files, the first is for generating the cert, the second is for the actual webserver when the cert is prepared.
COPY ./certbot_default.conf /etc/nginx/conf.d/default.conf.certbot
COPY ./default.conf /etc/nginx/conf.d/default.conf.webserver

#Make the keys folder where we will hold some things for when we need to generate the cert.
ENV KEYS_FOLDER=/etc/certbot/conf/live/wedding.supergoon.com
RUN mkdir -p $KEYS_FOLDER
#This should be a bind mount, as it holds the actual certificate.
ENV CERT_FOLDER=/etc/letsencrypt/live/wedding.supergoon.com/

#Put our file into the daily cron to keep the cert updated
COPY ./update_cert_cron.sh /etc/periodic/daily/update_cert_cron.sh
#TODO update the DNS record in this daily cron as well, will need AWS creds and AWS CLI in a script


ENTRYPOINT ["echo"]
CMD ["hello world"]


