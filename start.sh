#!/bin/sh

# Number of fcgi workers
if [ -z "$FCGI_CHILDREN" ]; then
  FCGI_CHILDREN=$(nproc)
fi

spawn-fcgi -F $FCGI_CHILDREN -U nginx -G nginx -M 600 -s /var/run/fcgiwrap.sock /usr/bin/fcgiwrap

nginx -g "daemon off;"
