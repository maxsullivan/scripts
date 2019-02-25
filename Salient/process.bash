#!/bin/bash

# This is a script to convert TEI to text
XMLFILES="/home/sullivm1/RTD/nzetc/convert_files/Salient*199*"
OUTPUTFILE="/home/sullivm1/RTD/nzetc/SalientResearch"

for file in ${XMLFILES};
do
    echo processing $file
    basename $file
    echo $basename
    base=`basename ${file}`
    #echo $base
    xsltproc --novalid ./tei_text.xsl $file > $OUTPUTFILE/$base.txt 

done
