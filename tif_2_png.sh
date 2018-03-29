#!/bin/bash
  #Script to convert high quality tif images into pngs
srcdir="./Test"
#srcfiles=${srcdir}/*

for file in `find "$srcdir" -type f -name "*.tif"`;
  
do 
       fname=$(basename "$file" .tif)
       dname=$(dirname "$file")
       echo "$fname"
       echo "$dname"
       #echo ${file%.tif}
       #echo convert -quality 70 -resize 50% -format png $file 
       convert $file -quiet -quality 70 -resize 50% -format png $dname/png_out/$fname.png

done