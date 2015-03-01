<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0" >

<xsl:output method="html" version="4.0"/>

<xsl:include href="ixiahit.xsl"/>

<xsl:template match="/">
	<html>
	<body>
		<xsl:apply-templates select="/*/*"/>
	</body>
	</html>
</xsl:template>

<xsl:template match="*">
	<p><xsl:apply-templates/></p>
</xsl:template>

</xsl:stylesheet>

