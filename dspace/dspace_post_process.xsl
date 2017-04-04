<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:locmets="http://www.loc.gov/METS/"
		xmlns:mets="http://www.exlibrisgroup.com/xsd/dps/rosettaMets" 
		xmlns:dnx="http://www.exlibrisgroup.com/dps/dnx" 
		xmlns:dc="http://purl.org/dc/elements/1.1/" 
		xmlns:dcterms="http://purl.org/dc/terms/" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:mods="http://www.loc.gov/mods/v3"
		xmlns:premis="http://www.loc.gov/standards/premis" 
		xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
		xmlns:vuwschema="http://library.vuw.ac.nz"
		xmlns:thesis="http://www.ndltd.org/standards/metadata/current.html"
		xmlns:rights="http://cosimo.stanford.edu/sdr/metsrights/"
		xmlns:xlink="http://www.w3.org/1999/xlink">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

	<xsl:template match="@xmlns | @xsi:schemaLocation"/>
	
	<!-- clone  <dc:identifier type="dcterms:URI" xml:lang="">http://hdl.handle.net/10063/5408</dc:identifier> -->
        <xsl:template match="node()[local-name() = 'identifier'][@*='dcterms:URI'][contains(text(),'hdl.handle.net')]">
          <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
          </xsl:copy>
          <xsl:copy>
            <xsl:apply-templates select="*|@*"/>
            <xsl:text>http://researcharchive.vuw.ac.nz/handle/</xsl:text><xsl:value-of select="substring(text(),23)"/>
          </xsl:copy>
          <xsl:copy>
            <xsl:apply-templates select="*|@*"/>
            <xsl:text>http://dx.doi.org/</xsl:text><xsl:value-of select="substring(text(),23)"/>
          </xsl:copy>
        </xsl:template>

	<xsl:template match="@*|*|processing-instruction()|comment()">
	  <xsl:copy>
	    <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
	  </xsl:copy>
	</xsl:template>

	
</xsl:stylesheet>
