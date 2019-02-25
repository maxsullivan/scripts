#!/bin/bash

for FNAME in Salient*.xml.draft

do
   echo $FNAME
   if [ -e $FNAME ]
    then
        #Add sort title

        sed -i 's/<title type="marc245">Salient<\/title>/<title type="marc245">Salient<\/title><title type="sort">Salient<\/title>/g' $FNAME

        #Add name mark up to resp statements
        sed -i 's/<name>Keyboarded by KiwiTech/<name key="name-446992" type="organisation">Keyboarded by KiwiTech/g' $FNAME

        sed -i 's/<name>KiwiTech/<name key="name-446992" type="organisation">KiwiTech/g' $FNAME
        
        #Correct publication date
        sed -i 's/<date when="2015">2015<\/date>/<date when="2016">2016<\/date>/g' $FNAME
        
        #Correct copyright date
        sed -i 's/copyright 2015/copyright 2016/g' $FNAME

        #Correct publisher in source description and mark up name
        sed -i -e 's@<publisher>Victoria University College.*@<publisher><name key="name-413461" type="organisation">Victoria University College Students Association</name></publisher>@g' $FNAME

        #Mark up publication place in source description
        sed -i 's/<pubPlace>Wellington<\/pubPlace>/<pubPlace><name key="name-008844" type="place">Wellington<\/name><\/pubPlace>/g' $FNAME

        #Add catalog information and bibid
        sed -i 's/Source copy consulted:<\/idno>/Source copy consulted: Victoria University of Wellington Library, JC Beaglehole Room, LG741 V67 S<\/idno><idno type="vuw-bbid">505094<\/idno>/g' $FNAME
    fi

done
