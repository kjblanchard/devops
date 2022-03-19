#!/bin/sh
nginx -s stop
cp /etc/nginx/conf.d/default.conf.certbot /etc/nginx/conf.d/default.conf
nginx
certbot renew
nginx -s stop
cp /etc/nginx/conf.d/default.conf.webserver /etc/nginx/conf.d/default.conf
nginx
