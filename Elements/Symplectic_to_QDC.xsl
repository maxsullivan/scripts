<?xml version='1.0'?>
<xsl:stylesheet  version="1.0" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dcterms="http://purl.org/dc/terms/"
    >
<!-- 
<mets:mets xmlns:locmets="http://www.loc.gov/METS/" xmlns:mets="http://www.loc.gov/METS/" xmlns:dnx="http://www.exlibrisgroup.com/dps/dnx" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:premis="http://www.loc.gov/standards/premis" xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" xmlns:vuwschema="http://library.vuw.ac.nz" xmlns:thesis="http://www.ndltd.org/standards/metadata/current.html" xmlns:rights="http://cosimo.stanford.edu/sdr/metsrights/" xmlns:xlink="http://www.w3.org/1999/xlink"> -->



<!-- an XSLT stylesheet to convert symplectic's exported metadata format to Simplified Dublin Core -->

  <!-- Top-level entry -->
  <xsl:template match="metadataentries">
    <dc:record>
      <xsl:apply-templates select="metadataentry"/>
    </dc:record>
  </xsl:template>

  <!-- per-field conversion -->

  <xsl:template match="metadataentry[key/text()='dc.description.abstract']">
    <dcterms:abstract>
      <xsl:value-of select='value/text()'/> 
    </dcterms:abstract>
  </xsl:template>

  <xsl:template match="metadataentry[key/text()='dc.contributor.author']">
    <dc:creator>
      <xsl:value-of select='value/text()'/> 
    </dc:creator>
  </xsl:template>


  <xsl:template match="metadataentry[key/text()='dc.date.issued']">
    <dcterms:issued>
      <xsl:value-of select='value/text()'/> 
    </dcterms:issued>
  </xsl:template>


  <xsl:template match="metadataentry[key/text()='dc.identifier.issn']">
    <dcterms:issn>
      <xsl:value-of select='value/text()'/> 
    </dcterms:issn>
  </xsl:template>



  <!-- default -->
  <xsl:template match="metadataentry">

    <xsl:variable name="part">
      <xsl:choose>
	<xsl:when test="contains(substring-after(key/text(),'.'),'.')">
	  <xsl:value-of select="substring-before(substring-after(key/text(),'.'),'.')"/>
	</xsl:when>
	<xsl:otherwise> 
	  <xsl:value-of select="substring-after(key/text(),'.')"/>
 	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:element name='dc:{$part}'>
      <xsl:value-of select='value/text()'/> 
    </xsl:element>

  </xsl:template>

</xsl:stylesheet>
