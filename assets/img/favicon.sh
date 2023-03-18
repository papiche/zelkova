#!/bin/bash

optipng leaf.png

convert leaf.png -resize 256x256 \
        -define icon:auto-resize="256,128,96,64,48,32,16" \
        favicon.ico

convert leaf.png -resize 256x256 favicon.png

cp favicon.png ../../web/
cp favicon.ico ../../web/

for i in 192 512; do convert leaf.png -resize $ix$i ../../web/icons/Icon-$i.png; done
for i in 192 512; do convert leaf.png -resize $ix$i ../../web/icons/Icon-maskable-$i.png; done
