#!/bin/sh
cp /etc/nginx/conf.d/default.conf.certbot /etc/nginx/conf.d/default.conf
nginx -s reload
certbot renew
cp /etc/nginx/conf.d/default.conf.webserver /etc/nginx/conf.d/default.conf
nginx -s reload
