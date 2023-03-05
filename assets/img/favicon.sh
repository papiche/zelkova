#!/bin/bash

optipng gbrevedot.png

convert gbrevedot.png -resize 256x256 \
        -define icon:auto-resize="256,128,96,64,48,32,16" \
        favicon.ico

for i in 192 512; do convert gbrevedot.png -resize $ix$i ../../web/icons/Icon-$i.png; done
for i in 192 512; do convert gbrevedot.png -resize $ix$i ../../web/icons/Icon-maskable-$i.png; done
