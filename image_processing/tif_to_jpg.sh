#!/bin/bash
  #Script to convert high quality tif images into jpgs
   srcdir="./path/to/source/"
   dstdir="./output/path/"

  for file in `find "$srcdir" -type f -name "*.tif"`;
  do
       echo -path $dstdir mogrify -quality 90 -resize 50% -format jpg $file 
       mogrify -path $dstdir -quality 90 -resize 50% -format jpg $file
#       echo cp `find "$srcdir" -type f -name "*.jpg"` $dstdir/
#       cp `find "$srcdir" -type f -name "*.jpg"` $dstdir/
#       rm $srcdir/*.jpg
done
