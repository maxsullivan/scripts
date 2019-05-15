#!/bin/bash

#Script to check directories for PDF files. If 3 PDF files are present it will return a notification.

for dir in research-* ; 

do 
	ls $dir/*.pdf | wc -l; 
	#echo $dir;

	count=`ls $dir/*.pdf | wc -l`

	if [ "$count" -gt 2 ]
		then
			echo $dir "Check 3 + PDFs present"
		else
			echo $dir "OK 1-2 PDFs present"
	fi


done
