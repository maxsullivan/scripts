<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:tei="http://www.tei-c.org/ns/1.0">
	<xsl:output method="text" indent="yes" omit-xml-declaration="no" />
	<xsl:template match="/">
	  Publication Place - <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblFull/tei:publicationStmt/tei:pubPlace"/>
	  
	  Publication Date - <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblFull/tei:publicationStmt/tei:date"/>
	</xsl:template>
</xsl:stylesheet>
