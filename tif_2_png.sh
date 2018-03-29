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
#Output directory 'png_out' needs to be in place before running script.
       convert $file -quiet -quality 70 -resize 50% -format png $dname/png_out/$fname.png

done
