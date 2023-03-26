#!/bin/bash

if [ -z "$(ls -A /etc/nginx)" ]; then
    cp -a /etc/nginx-default/* /etc/nginx/
fi
