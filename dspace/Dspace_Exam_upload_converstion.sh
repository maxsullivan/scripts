#!/bin/bash
#Script to convert a comma-seperated dump of courses to xml
#Script prepares objects and metadata for upload to dspace

PDFPATH=/home/sullivm1/Testing/Exams/PDFS

# if necessary, dedup the courses with a onliner such as 
# cat courses.csv |  awk -F\| '{if($4!=PF){printf("\n%s", $0)} else {printf(", %s", $13)};PF=$4} END {print("\n")} ' > courses-deduped.csv

IFS="|"
cat courses.csv | while  read ID X1 X2 SUBJECT X3 SHORT_TITLE TITLE_EN X4 SCHOOL X4 FACULTY APPROVAL LECTURER 
#cat courses.csv | while  read ID SUBJECT YEAR TRI SHORT_TITLE TITLE_EN TITLE_MI SCHOOLCODE FACULTYCODE APPROVAL LECTURER TYPE LANGUAGE CREATED UPDATED NOTES RS
#while read line
do
    YEAR=2015
    TRI=3
    LANGUAGE=en_NZ
    RS=RS

    if false
    then
	echo ID=$ID SUBJECT=$SUBJECT YEAR=$YEAR TRI=$TRI SHORT_TITLE=$SHORT_TITLE TITLE_EN=$TITLE_EN LANGUAGE=$LANGUAGE FACULTY=$FACULTY SCHOOL=$SCHOOL LECTURER=$LECTURER RS=$RS
    else


#    if [ "$RS" -a "$RS" = "RS" -a "$APPROVAL" -a "$APPROVAL" = "E"  ]
#    then
        if [ ! -e ${PDFPATH}/${YEAR}_${TRI}_${SUBJECT}.pdf ]
        then
           
            echo BADNESS ! RS= $RS APPROVAL= $APPROVAL ${PDFPATH}/${YEAR}_${TRI}_${SUBJECT}.pdf !!!
	    echo  ${PDFPATH}/${YEAR}_${TRI}_${SUBJECT}.pdf >> ./BADNESS.$$.list
        else

            mkdir -p imports/$ID
            cp $PDFPATH/${YEAR}_${TRI}_${SUBJECT}.pdf  ./imports/$ID
	    touch $PDFPATH/${YEAR}_${TRI}_${SUBJECT}.pdf  
	    touch ./imports/$ID/${YEAR}_${TRI}_${SUBJECT}.pdf
            echo ${YEAR}_${TRI}_${SUBJECT}.pdf > imports/$ID/contents
            
            echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > ./imports/$ID/dublin_core.xml
            echo "<dublin_core  schema=\"dc\">" >> ./imports/$ID/dublin_core.xml
            
    # titles
            if [ "$TITLE_MI" -a "$TITLE_MI" != "-"  ]
            then
                echo "<dcvalue element=\"title\" qualifier=\"full\">"$SUBJECT: $SHORT_TITLE: $TITLE_MI / $TITLE_EN"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            else
                echo "<dcvalue element=\"title\" qualifier=\"full\">"$SUBJECT: $SHORT_TITLE: $TITLE_EN"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi
            
            if [ "$TITLE_EN" -a "$TITLE_EN" != "-"  ]
            then
                echo "<dcvalue element=\"title\" qualifier=\"short\" language=\"en_NZ\">"$TITLE_EN"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi
            
            if [ "$TITLE_MI" -a "$TITLE_MI" != "-"  ]
            then
                echo "<dcvalue element=\"title\" qualifier=\"short\" language=\"mi_NZ\">"$TITLE_MI"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi
            
            if [ "$LANGUAGE" -a "$LANGUAGE" != "-"  ]
            then
                echo "<dcvalue element=\"language\" qualifier=\"none\">"$LANGUAGE"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi
            
            if [ "$SHORT_TITLE" -a "$SHORT_TITLE" != "-"  ]
            then
                echo "<dcvalue element=\"subject\" qualifier=\"none\" language=\"en_NZ\">"$SHORT_TITLE"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi 
            if [ "$SUBJECT" -a "$SUBJECT" != "-"  ]
            then
                echo "<dcvalue element=\"subject\" qualifier=\"course\" language=\"en_NZ\">"$SUBJECT"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi
            if [ "$YEAR" -a "$YEAR" != "-"  ]
            then
#                echo "<dcvalue element=\"date\" qualifier=\"none\">"$YEAR"</dcvalue>" >> ./imports/$ID/dublin_core.xml
                if [ "$TRI" -a "$TRI" != "-"  ]
                then
                    echo "<dcvalue element=\"date\" qualifier=\"semester\">"$YEAR:$TRI"</dcvalue>" >> ./imports/$ID/dublin_core.xml
                fi
            fi
            echo "<dcvalue element=\"format\" qualifier=\"none\">pdf</dcvalue>" >> ./imports/$ID/dublin_core.xml
            echo "<dcvalue element=\"type\" qualifier=\"none\">text</dcvalue>" >> ./imports/$ID/dublin_core.xml
            
            LECTURER=`echo $LECTURER | perl -pe 's/(\w+)/\u\L$1/g'`
            if [ "$LECTURER" -a "$LECTURER" != "-"  ]
            then
                echo "<dcvalue element=\"contributor\" qualifier=\"author\">"$LECTURER"</dcvalue>" >> ./imports/$ID/dublin_core.xml
            fi
            
            echo "</dublin_core>" >> ./imports/$ID/dublin_core.xml

            
            
            echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > ./imports/$ID/metadata_vuwschema.xml
            echo "<dublin_core schema=\"vuwschema\">" >> ./imports/$ID/metadata_vuwschema.xml
            
            if [ "$SCHOOL" -a "$SCHOOL" != "-"  ]
            then
                echo "<dcvalue element=\"contributor\" qualifier=\"unit\">"$SCHOOL"</dcvalue>" >> ./imports/$ID/metadata_vuwschema.xml
            fi
            if [  "$FACULTY" -a "$FACULTY" != "-"  ]
            then
                echo "<dcvalue element=\"contributor\" qualifier=\"unit\">"$FACULTY"</dcvalue>" >> ./imports/$ID/metadata_vuwschema.xml
            fi

            echo "</dublin_core>" >> ./imports/$ID/metadata_vuwschema.xml
            
        fi
    fi
 #   fi
done

#escape ampersands
sed -i 's/&/&amp;/' ./imports/*/*.xml
