<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ojs="http://pkp.sfu.ca">
	<xsl:output method="text" indent="yes" omit-xml-declaration="no" />
	<xsl:template match="@xmlns | @xsi:schemaLocation"/>
	<xsl:template match="/">

		<xsl:for-each select="ojs:issue/ojs:articles/ojs:article">
				  ---------
				  
		 Article Title - <xsl:value-of select="ojs:title"/>

	     Article DOI - <xsl:value-of select="ojs:id[@type='doi']"/>
	 <!-- Article Title - <xsl:value-of select="."/>
	  		 </xsl:for-each> 
	  	 
	  		 <xsl:for-each select="issue/articles/article/id[@type='doi']">
	  Article DOI - <xsl:value-of select="."/>
	
        	 </xsl:for-each>-->
         </xsl:for-each>
	  </xsl:template>
</xsl:stylesheet>
