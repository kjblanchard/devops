# This is used as an init container in kubernetes to spawn a certificate.
FROM certbot/certbot:latest

#Install nginx, as this is needed for us to get the cert.
RUN apk add openssl curl ca-certificates && \
    printf "%s%s%s%s\n" "@nginx " "http://nginx.org/packages/alpine/v" `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` "/main" | tee -a /etc/apk/repositories && \
    curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && \
    mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/ && \
    apk add nginx@nginx && \
    apk add nginx-module-image-filter@nginx nginx-module-njs@nginx

#Copy the nginx configuration file.
COPY ./default.conf /etc/nginx/conf.d/default.conf

#Generate a temporary certificate so that we can generate one with certbot
ARG KEYS_FOLDER=/etc/certbot/conf/live/wedding.supergoon.com
RUN mkdir -p $KEYS_FOLDER
RUN nginx
#Override the certbot entrypoint and cmd so that we can use it as init container
ENTRYPOINT ["echo"]
CMD ["hello world"]

# RUN openssl req -batch -newkey rsa:1024 -new -nodes -x509 -days 2 -keyout $KEYS_FOLDER/privkey.pem -out $KEYS_FOLDER/fullchain.pem
# RUN certbot certonly --webroot -w /var/www/challenge -d www.wedding.supergoon.com -d wedding.supergoon.com -m blanchardkevinj@gmail.com --agree-tos

