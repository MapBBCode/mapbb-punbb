#!/bin/sh
TARGET=dist/mapbbcode_punbb.zip
DIR=mapbbcode
MAPBBCODE=js
mkdir $DIR
cp manifest.xml $DIR
cp map.gif $DIR
cp map16.gif $DIR
echo "<html><head><title>.</title></head><body>.</body></html>" > $DIR/index.html

mkdir $DIR/lang
cp $DIR/index.html $DIR/lang
for LANG in lang/* ; do
	LANGDIR=$DIR/lang/`basename $LANG .php`
	mkdir $LANGDIR
	cp $LANG $LANGDIR/pun_mapbbcode.php
	cp $DIR/index.html $LANGDIR
done

if [ ! -e $MAPBBCODE ]; then
git clone https://github.com/MapBBCode/mapbbcode.git $MAPBBCODE
fi
cd $MAPBBCODE
git pull origin master
cd ..

mkdir $DIR/js
cp -r $MAPBBCODE/dist/lib/* $DIR/js
cp $MAPBBCODE/dist/mapbbcode.js $DIR/js
cp $MAPBBCODE/dist/mapbbcode-config.js $DIR/js
cp $MAPBBCODE/dist/mapbbcode-window.html $DIR/js
mkdir $DIR/js/lang
cp $MAPBBCODE/src/strings/* $DIR/js/lang
rm $TARGET
zip -qr $TARGET $DIR
rm -r $DIR
