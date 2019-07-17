#!/bin/bash
#a script to create md5sums from directories of files

#Path to tiffs
#FILEPATH=./Master-TIFFS/Vol21-29/VUWCouncil_Vol_29/*
#Path to PDFs
FILEPATH=./Vol-11-20
END=13

LOG_FILE=./MD5Vol_PDRTest_Local_Vol11-13.txt
#LOG_FILE=./MD5-Local-1999-2004.txt

for files in $(seq 11 $END);
#for files in ./Vol-01-10/*;

do
    echo $files
    echo md5sum $FILEPATH/VUWCouncil_Vol_$files.pdf
    md5sum $FILEPATH/VUWCouncil_Vol_$files.pdf >> $LOG_FILE
    #echo Getting MD5SUM for $files 
    #md5sum $files >> $LOG_FILE 
    
done
