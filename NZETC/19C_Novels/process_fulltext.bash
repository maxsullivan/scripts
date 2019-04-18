#!/bin/bash

# This is a file to convert TEI to text
XMLFILES="./*.xml"
OUTPUTFILE="./XSL_Output/"

for file in ${XMLFILES};
do
    echo processing $file
    basename $file
    echo $basename
    base=`basename ${file}`
    touch $OUTPUTFILE/$base.txt
    #echo $base
    xsltproc --novalid ./convert.xsl $file > $OUTPUTFILE/$base.txt 

done
