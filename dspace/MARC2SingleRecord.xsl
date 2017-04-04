<xsl:stylesheet version="1.0" 
		xmlns:marc="http://www.loc.gov/MARC21/slim" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="url"/>

  <xsl:template match="/">
    <xsl:comment> searched for '<xsl:value-of select="$url"/>'    </xsl:comment>
    <marc:collection>
      <xsl:apply-templates select="*/*[.//text() = $url]"/>
    </marc:collection>
  </xsl:template>

  <xsl:template match="record">
    <marc:record>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </marc:record>
  </xsl:template>

  <xsl:template match="leader">
    <marc:leader>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </marc:leader>
  </xsl:template>

  <xsl:template match="controlfield">
    <marc:controlfield>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </marc:controlfield>
  </xsl:template>

  <xsl:template match="datafield">
    <marc:datafield>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </marc:datafield>
  </xsl:template>

  <xsl:template match="subfield">
    <marc:subfield>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </marc:subfield>
  </xsl:template>

  <xsl:template match="@*|*|processing-instruction()|comment()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
