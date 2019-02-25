#!/bin/bash
#Script to convert high quality tif images into jpgs

srcdir="/home/max/RTD/Waireto_Implementation/Home_and_Building/Images/"
#srcfile=${srcdir}*/*.tif
dstdir="/home/max/RTD/Waireto_Implementation/Home_and_Building/Images/PDF"

#for file in `find "$srcdir" -type f -name "*.tif"`;
for file in `find "$srcdir" -type d`;
#for file in $srcfile

do
   echo $file
   # echo -path $dstdir mogrify -quality 90 -resize 50% -format jpg $file
   convert -limit memory 0 -limit map 0 $file/*.tif -compress jpeg -quality 100 $file.pdf

done
