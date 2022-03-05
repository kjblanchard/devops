#!/bin/sh
#This is used to request a new certificate from letsencrypt.  The first command allows us to start out webserver properly with the second command, only run if there is no certs.
if [ "$(ls -A cert_folder)" ]; then
    cp /etc/nginx/conf.d/default.conf.certbot /etc/nginx/conf.d/default.conf
    openssl req -batch -newkey rsa:1024 -new -nodes -x509 -days 2 -keyout $KEYS_FOLDER/privkey.pem -out $KEYS_FOLDER/fullchain.pem
    certbot certonly --webroot -w /var/www/challenge -d www.wedding.supergoon.com -d wedding.supergoon.com -m blanchardkevinj@gmail.com --agree-tos
fi
# After you get the cert (if needed), use the real nginx conf to serve the website
nginx stop
cp /etc/nginx/conf.d/default.conf.webserver /etc/nginx/conf.d/default.conf
nginx
