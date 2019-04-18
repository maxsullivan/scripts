<?xml version='1.0'?>
<xsl:stylesheet  version="1.0" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<!-- an XSLT stylesheet to convert symplectic's exported metadata format to Simplified Dublin Core -->

  <!-- Top-level entry -->
  <xsl:template match="metadataentries">
    <dc:record>
      <xsl:apply-templates select="metadataentry"/>
    </dc:record>
  </xsl:template>

  <!-- per-field conversion -->
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
