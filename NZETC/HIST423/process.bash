#!/bin/bash

# This is a file to convert TEI to text
XMLFILES="/home/sullivm1/RTD/nzetc/HIST423_XML/XSL_Samples/Input_Files/Far*.xml"
OUTPUTFILE="/home/sullivm1/RTD/nzetc/HIST423_XML/XSL_Samples/Output_Files/"

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
