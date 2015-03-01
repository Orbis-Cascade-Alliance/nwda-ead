<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="*[local-name(.) = 'ixiahit']">
		<span style="font-weight:bold;color:red">
			<a name="{@number}"/>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
</xsl:stylesheet>
