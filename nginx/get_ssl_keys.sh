#!/bin/sh
#Generate a cert if you need one, otherwise start the server.
generate_cert(){
    nginx -s stop
    cp /etc/nginx/conf.d/default.conf.certbot /etc/nginx/conf.d/default.conf
    nginx
    certbot --nginx -d wedding.supergoon.com -d www.wedding.supergoon.com
    nginx -s stop
}

configure_prod_server(){
    cp /etc/nginx/conf.d/default.conf.webserver /etc/nginx/conf.d/default.conf
}
if [ -e $CERT_FOLDER/fullchain.pem ]; then
    configure_prod_server
 else
    generate_cert
    configure_prod_server
fi
