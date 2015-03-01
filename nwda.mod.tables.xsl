<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="table">
		<table bodrder="0" cellpadding="1" cellspacing="2" width="90%" align="center">
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="thead">
		<thead align="top">
			<tr>
				<xsl:for-each select=".//entry">
					<td>
						<p class="table_head">
							<b>
								<xsl:apply-templates/>
							</b>
						</p>
					</td>
					<td>
						<p>&#160;</p>
					</td>
				</xsl:for-each>
			</tr>
		</thead>
		<tr>
			<td>
				<p>&#160;</p>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="row">
		<tr align="top">
			<xsl:for-each select="./entry">
				<td>
					<p class="table_entry">
						<xsl:apply-templates/>
					</p>
				</td>
				<td>
					<p>&#160;</p>
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