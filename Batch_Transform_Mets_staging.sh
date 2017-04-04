#!/bin/bash

# For Dspace METS files apply xsl transformation to transform to Rosetta METS. XSL, Dspace files and this script need to be in the same directory.
# This takes two parameters:
#	t = the path where the source lives
#	o = the path where the rosetta deposits should be created
# The script assumes that the source deposit dirs will be named research-xxx 
#
# Usage:
# 	./Batch_Tranform_Mets.sh -t /path/to/dspace/exports -o /path/to/where/files/should/be/created
#
# Authors: Max Sullivan, Brendan Farrell, Stuart Yeates

#SIP_DIR="./research*"
# Get user input
while getopts s:o:user option
do
        case "${option}"
        in
				s) TARGETPATH=${OPTARG};;
				o) OUTPUTPATH=${OPTARG};;
        esac
done 

#check that the output folder exists, create it if it doesnt
if [ ! -d $OUTPUTPATH ]; then
	mkdir $OUTPUTPATH
fi

#set the SIP DIR i.e. all dirs prefixed with research in the TARGETPATH
SIP_DIR=$TARGETPATH"/research*"

# Loop through each directory
for IN_DIR in $SIP_DIR
do

    #Count the number of mets.xml files to make sure there is only 1
    xmlcount=$(find "$IN_DIR" -name mets.xml | wc -l)
    echo "total number of xml files: $xmlcount"
    #if count is one convert mets to rosetta mets
    if [[ "$xmlcount" = 1 ]]; then


        #check directory exists	
	SIP_DIR_NAME=$(basename $IN_DIR)
	echo "Processing" $SIP_DIR_NAME
	if [ ! -d $SIP_DIR_NAME ]; then
	    mkdir $SIP_DIR_NAME
	fi
		#check that the deposit folder exists, create it if it doesnt
	if [ ! -d $OUTPUTPATH/$SIP_DIR_NAME ]; then
	    mkdir $OUTPUTPATH/$SIP_DIR_NAME
	    mkdir $OUTPUTPATH/$SIP_DIR_NAME/content
	    mkdir $OUTPUTPATH/$SIP_DIR_NAME/content/streams
			#cp $xml_file/mets.xml $OUTPUTPATH/$SIP_DIR_NAME/content/mets.xml
	    cp $IN_DIR/bitstream* $OUTPUTPATH/$SIP_DIR_NAME/content/streams/
	fi

			# Convert the mets.xml in the OUTPUTPATH to rosetta METS
	xsltproc --novalid ./dspace_mods_to_dc_mets_staging.xsl $IN_DIR/mets.xml | xsltproc --novalid ./dspace_post_process.xsl - | xmllint --format - > /tmp/tmp-METS.xml

	ID=`grep hdl.handle.net  $IN_DIR/mets.xml  | tr '<>"' '\012' | grep hdl.handle.net | uniq | sed 's^http://hdl.handle.net^^'`
	echo ID=$ID
	echo ID='$ID'
	URL=http://researcharchive.vuw.ac.nz/handle$ID
	xsltproc --stringparam 'url' $URL MARC2SingleRecord.xsl BIBLIOGRAPHIC_3805366240002386_1.xml  | xmllint --format - > /tmp/tmp-MARC.xml
	grep marc:controlfield /tmp/tmp-MARC.xml > /dev/null
	if [ $? = 0 ]; then
	    echo found MARC!
	    line=`sed -n '/MARC21/='  /tmp/tmp-METS.xml`
	    echo $line
	    head --lines $(($line - 1 )) < /tmp/tmp-METS.xml >  /tmp/tmp-METS2.xml
	    cat /tmp/tmp-MARC.xml | tail --lines +2  >>  /tmp/tmp-METS2.xml
	    tail  --lines +$(($line +1 )) < /tmp/tmp-METS.xml  >>  /tmp/tmp-METS2.xml 
	    cp /tmp/tmp-METS2.xml  $OUTPUTPATH/$SIP_DIR_NAME/content/mets.xml
	else
	    cp  /tmp/tmp-METS.xml  $OUTPUTPATH/$SIP_DIR_NAME/content/mets.xml

	fi

	
                #make dc title file
	if  [ -f $OUTPUTPATH/$SIP_DIR_NAME/content/mets.xml ]; then
                        #echo if mets file exists
	    thistime=`date`
            echo mets file exists $OUTPUTPATH/$SIP_DIR_NAME/content/mets.xml
                         #Find the dc title
            dcidentifier=`grep -oPm1 "(?<=title>)[^<]+" $OUTPUTPATH/$SIP_DIR_NAME/content/mets.xml`
                         #create the dc Title file
            echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><record xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dcterms=\"http://purl.org/dc/terms/\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\"><dc:title>$dcidentifier $thistime</dc:title></record>" | xmllint --format - > $OUTPUTPATH/$SIP_DIR_NAME/dc.xml
            xmllint --noout $OUTPUTPATH/$SIP_DIR_NAME/dc.xml
                #end of dc title file section
	else
	    echo too many xml files $xmlcount
	fi
    fi
done
