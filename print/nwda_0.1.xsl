<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1

Overhaul to HTML5/Bootstrap 3 by Ethan Gruber in March 2015.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/ewg118/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#" exclude-result-prefixes="nwda xsd vcard xsl">
	<xsl:output encoding="UTF-8" method="xml"/>

	<xsl:param name="doc"/>

	<!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="identifier" select="string(normalize-space(/ead/eadheader/eadid/@identifier))"/>
	<xsl:variable name="titleproper">
		<xsl:value-of select="normalize-space(/ead/archdesc/did/unittitle)"/>
		<xsl:if test="/ead/archdesc/did/unitdate">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="/ead/archdesc/did/unitdate"/>
		</xsl:if>
	</xsl:variable>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper" select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[@altrender]))"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="string(//revisiondesc/change[position()=last()]/date/@normal)"/>
	</xsl:variable>

	<!-- ********************* </XML_VARIABLES> *********************** -->
	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
	<xsl:include href="../nwda.mod.preferences.xsl"/>
	<!--line breaks, lists and such-->
	<!--<xsl:include href="nwda.mod.generics.xsl"/>
	<!-\-table of contents-\->
	<xsl:include href="nwda.mod.toc.xsl"/>
	<!-\-controlled access points-\->
	<xsl:include href="nwda.mod.controlaccess.xsl"/>
	<!-\-description of subordinate components-\->
	<xsl:include href="nwda.mod.dsc.xsl"/>
	<!-\-tables-\->
	<xsl:include href="nwda.mod.tables.xsl"/>

	<!-\-loose archdesc-\->
	<xsl:include href="nwda.mod.structures.xsl"/>-->

	<!-- *** RDF and CHO variables moved into nwda.mod.preferences.xsl *** -->


	<!-- ********************* </MODULES> *********************** -->
	<!-- Hide elements with altrender nodisplay and internal audience attributes-->
	<xsl:template match="*[@altrender='nodisplay']"/>
	<xsl:template match="*[@audience='internal']"/>
	<!-- Hide elements not matched in-toto elsewhere-->
	<xsl:template match="profiledesc"/>
	<xsl:template match="eadheader/eadid | eadheader/revisiondesc | archdesc/did"/>
	<xsl:template match="ead">
		<fo:root font-size="16pt">
			<fo:layout-master-set>
				<fo:simple-page-master margin-right="1in" margin-left="1in" margin-bottom="1in" margin-top="1in" page-width="8in" page-height="11in" master-name="bookpage">
					<fo:region-body region-name="bookpage-body" margin-bottom="5mm" margin-top="5mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="bookpage">
				<fo:title>
					<xsl:value-of select="$titleproper"/>
				</fo:title>

				<fo:flow flow-name="bookpage-body">
					<fo:block>
						<xsl:value-of select="$titleproper"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>

		</fo:root>
	</xsl:template>
</xsl:stylesheet>
