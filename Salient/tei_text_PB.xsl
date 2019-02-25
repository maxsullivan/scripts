<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.loc.gov/METS/">
	<xsl:output method="text" indent="yes" omit-xml-declaration="no" />
	<xsl:template match="/">
	   <xsl:value-of select="tei:TEI/tei:text"/>
<!--	   	     <xsl:for-each select="//@n">PAGE BREAK <xsl:value-of select="."/>
	         </xsl:for-each>
-->
	</xsl:template>
	
	<xsl:template match="//pb">
             <xsl:copy>
                <xsl:for-each select="@n">
                  TEXT HERE
                  <xsl:value-of select="."/>
                </xsl:for-each>
	         </xsl:copy>
	</xsl:template>	
</xsl:stylesheet>