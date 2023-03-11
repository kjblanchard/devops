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
    nginx
}
if [ -f "$CERT_FOLDER"/fullchain.pem ]; then
    echo 'Cert is available, not generating cert' >> /proc/1/fd/1
    configure_prod_server
 else
    echo 'Generating cert, then starting' >> /proc/1/fd/1
    generate_cert
    configure_prod_server
fi
