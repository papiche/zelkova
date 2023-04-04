#!/bin/bash

optipng leaf.png

convert leaf.png -resize 256x256 \
        -define icon:auto-resize="256,128,96,64,48,32,16" \
        favicon.ico

convert leaf.png -resize 256x256 favicon.png
convert leaf.png -resize 32x32 favicon-32x32.png
convert leaf.png -resize 16x16 favicon-16x16.png


cp favicon.png ../../web/
cp favicon.ico ../../web/
cp favicon-32x32.png ../../web/icons/
cp favicon-16x16.png ../../web/icons/

for i in 192 512; do convert leaf.png -resize $ix$i ../../web/icons/Icon-$i.png; done
for i in 192 512; do convert leaf.png -resize $ix$i ../../web/icons/Icon-maskable-$i.png; done


#!/bin/bash

BASE=leaf.png

#IOS=../../../../../ios/Runner/Assets.xcassets/LaunchImage.imageset
#IOSICON=../../../../../ios/Runner/Assets.xcassets/AppIcon.appiconset

# ls $BASE
# ls $IOS

#convert $BASE -resize 48x mipmap-mdpi/launch_image.png
#convert $BASE -resize 72x mipmap-hdpi/launch_image.png
#convert $BASE -resize 96x mipmap-xhdpi/launch_image.png
#convert $BASE -resize 144x mipmap-xxhdpi/launch_image.png
#convert $BASE -resize 192x mipmap-xxxhdpi/launch_image.png
#
#cp mipmap-mdpi/launch_image.png $IOS/LaunchImage.png
#cp mipmap-xhdpi/launch_image.png $IOS/LaunchImage@2x.png
#cp mipmap-xxhdpi/launch_image.png $IOS/LaunchImage@3x.png


#cp mipmap-xxxhdpi/launch_image.png $IOS/LaunchImage@4x.png

DEST=../..
convert $BASE -resize 48x $DEST/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
convert $BASE -resize 72x $DEST/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
convert $BASE -resize 96x $DEST/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
convert $BASE -resize 144x $DEST/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
convert $BASE -resize 192x $DEST/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

# convert $BASE -resize 1024x1024 $IOSICON/Icon-App-1024x1024@1x.png
# convert $BASE -resize 20x20 $IOSICON/Icon-App-20x20@1x.png
# convert $BASE -resize 40x40 $IOSICON/Icon-App-20x20@2x.png
# convert $BASE -resize 60x60 $IOSICON/Icon-App-20x20@3x.png
# convert $BASE -resize 29x29 $IOSICON/Icon-App-29x29@1x.png
# convert $BASE -resize 58x58 $IOSICON/Icon-App-29x29@2x.png
# convert $BASE -resize 87x87 $IOSICON/Icon-App-29x29@3x.png
# convert $BASE -resize 40x40 $IOSICON/Icon-App-40x40@1x.png
# convert $BASE -resize 80x80 $IOSICON/Icon-App-40x40@2x.png
# convert $BASE -resize 120x120 $IOSICON/Icon-App-40x40@3x.png
# convert $BASE -resize 120x120 $IOSICON/Icon-App-60x60@2x.png
# convert $BASE -resize 180x180 $IOSICON/Icon-App-60x60@3x.png
# convert $BASE -resize 76x76 $IOSICON/Icon-App-76x76@1x.png
# convert $BASE -resize 152x152 $IOSICON/Icon-App-76x76@2x.png
# convert $BASE -resize 167x167 $IOSICON/Icon-App-83.5x83.5@2x.png
