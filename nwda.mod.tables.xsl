<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
	<xsl:template match="table">
		<table class="table table-striped">
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="thead">
		<thead>
			<tr>
				<xsl:for-each select=".//entry">
					<th>
						<xsl:apply-templates/>
					</th>					
				</xsl:for-each>
			</tr>
		</thead>		
	</xsl:template>
	<xsl:template match="row">
		<tr>
			<xsl:for-each select="./entry">
				<td>
					<xsl:apply-templates/>
				</td>				
			</xsl:for-each>
		</tr>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
</metaInformation>
-->