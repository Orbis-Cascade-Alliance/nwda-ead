<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="fo ead">
	<xsl:template match="*[local-name()='table']">
		<xsl:if test="*[local-name()='head']">
			<h4>
				<xsl:value-of select="*[local-name()='head']"/>
			</h4>
		</xsl:if>
		<table class="table table-striped">
			<xsl:apply-templates select="*[not(local-name()='head')]"/>
		</table>
	</xsl:template>
	<xsl:template match="*[local-name()='tbody']">
		<tbody>
			<xsl:apply-templates/>
		</tbody>
	</xsl:template>
	<xsl:template match="*[local-name()='thead']">
		<thead>
			<tr>
				<xsl:for-each select=".//*[local-name()='entry']">
					<th>
						<xsl:apply-templates/>
					</th>
				</xsl:for-each>
			</tr>
		</thead>
	</xsl:template>
	<xsl:template match="*[local-name()='row']">
		<tr>
			<xsl:for-each select="./*[local-name()='entry']">
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
