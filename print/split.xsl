<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu

-->

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:MARC="http://marc.com">
	<!--<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>-->
	<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
	<xsl:strip-space elements="*"/>



<xsl:variable name="file_name" select="starts-with(datafield[@tag='035']/marc:subfield[@code='a'],'HVT')" />

<xsl:template match="marc:record">
<xsl:document href="{$file_name}">
  <xsl:copy-of select="." /> 
  </xsl:document>

	</xsl:template>
</xsl:stylesheet>

