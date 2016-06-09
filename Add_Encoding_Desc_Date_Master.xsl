<xsl:stylesheet version="1.0" 
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xtm="http://www.topicmaps.org/xtm/1.0/"
                xmlns:nzetc="http://nzetc.victoria.ac.nz/structure"
                exclude-result-prefixes="nzetc xsl tei">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<!-- Script to insert encodingDesc and profileDesc into teiHeader -->


<!-- Match correct publication date in the sourceDesc and create a variable -->
   <xsl:variable name="date" select="//tei:sourceDesc//tei:date[@when][1][contains(text(),'19')]"/>

   <xsl:template match="tei:encodingDesc|tei:profileDesc"/>

<!-- Match closing teiHeader -->
   <xsl:template match="tei:teiHeader">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      
      <!-- Insert encodingDesc and ProfileDesc -->
       <encodingDesc>
      <editorialDecl>
        <p>All unambiguous end-of-line hyphens have been removed and the trailing part of a word has been joined to the preceding line, except in the case of those words that break over a page.</p>
        <p xml:id="ETC">Some keywords in the header are a local Electronic Text Collection scheme to aid in establishing analytical groupings.</p>
        <p>In order to make new content available faster this work has been uploaded but does not have comprehensive name authority mark up for sub-works and corresponding authors. We will endeavour to add this mark up as soon as possible.</p>
      </editorialDecl>
     <classDecl>
        <taxonomy xml:id="nzetc-subjects">
          <bibl>
            <title>NZETC Subject Headings</title>
          </bibl>
        </taxonomy>
      </classDecl>
    </encodingDesc>
    <profileDesc xml:id="profileDesc-0001">
      <creation>
        <!-- Copy date variable defined above -->
        <xsl:copy-of select="$date"/>
      </creation>
      <langUsage>
        <language ident="en">English</language>
      </langUsage>
      <textClass>
        <keywords scheme="http://nzetc.victoria.ac.nz/nzetc-subjects">
          <list>
            <item><rs key="subject-000001" type="subject">General NZ History</rs></item>
          </list>
        </keywords>
      </textClass>
    </profileDesc>
    </xsl:copy>

   </xsl:template>


  <!-- for all other xml components, let them pass through -->
  <xsl:template match="@*|*|processing-instruction()|comment()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
      
