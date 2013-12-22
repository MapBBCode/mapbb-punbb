#!/bin/sh
DISTFILE=mapbbcode-latest.zip
TARGET=dist/mapbbcode_punbb.zip
DIR=mapbbcode
MAPBBCODE=js

wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
mv mapbbcode $MAPBBCODE

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

mkdir $DIR/js
cp -r $MAPBBCODE/* $DIR/js/
rm -r $MAPBBCODE

rm -f $TARGET
zip -qr $TARGET $DIR
rm -r $DIR
