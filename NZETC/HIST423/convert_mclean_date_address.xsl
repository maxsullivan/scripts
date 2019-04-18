<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:tei="http://www.tei-c.org/ns/1.0">
	<xsl:output method="text" indent="yes" omit-xml-declaration="no" />
	<xsl:template match="/">
	  Letter place: <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:opener//tei:name[@type='geographic']"/>
	  
	  Letter date: <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:opener//tei:date[@when]"/>
	</xsl:template>
</xsl:stylesheet>