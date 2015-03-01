<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1

Overhaul to HTML5/Bootstrap 3 by Ethan Gruber in March 2015.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/ewg118/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common">
	<!--<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>-->
	<xsl:output encoding="UTF-8"/>

	<xsl:param name="doc"/>

	<!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="identifier" select="string(normalize-space(/ead/eadheader/eadid/@identifier))"/>
	<xsl:variable name="titleproper" select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[1]))"/>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper" select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[@altrender]))"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="string(//revisiondesc/change[position()=last()]/date/@normal)"/>
	</xsl:variable>

	<xsl:variable name="empty-rdf">
		<rdf:RDF/>
	</xsl:variable>

	<xsl:variable name="rdf">
		<xsl:choose>
			<xsl:when test="$editor-active = 'true'">
				<xsl:choose>
					<xsl:when test="$mode='linux'">
						<xsl:copy-of select="exsl:node-set(document(concat($pathToRdf, //eadid/@mainagencycode, '.xml'))/rdf:RDF)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="msxsl:node-set(document(concat($pathToRdf, //eadid/@mainagencycode, '.xml'))/rdf:RDF)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$mode='linux'">
						<xsl:copy-of select="exsl:node-set($empty-rdf)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="msxsl:node-set($empty-rdf)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:variable>
	<xsl:variable name="hasCHOs">
		<xsl:if test="$harvester-active = 'true'">
			<xsl:if test="string(//eadid/@identifier) and descendant::dao[@role='harvest-all' and string(@href)]">
				<!-- if there is an ARK in eadid/@identifier and at least one dao with a 'harvest-all' @role, then assume CHOs is true: ASP.NET seems not use allow URIs in xsl document() function -->
				<xsl:text>true</xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:variable>
	<!-- ********************* </XML_VARIABLES> *********************** -->
	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
	<xsl:include href="nwda.mod.preferences.xsl"/>
	<!--HTML header table -->
	<xsl:include href="nwda.mod.html.header.xsl"/>
	<!-- Dublin Core MD -->
	<xsl:include href="nwda.mod.metadata.xsl"/>
	<!--Major finding aid structures: bioghist, scopecontent, controlaccess, dsc etc.-->
	<!--<xsl:include href="nwda.mod.structures_0.1.xsl"/>-->
	<!--classes of generic elements... e.g. P class="abstract"
	nice idea, didn't run with it.
	<xsl:include href="nwda.mod.classes.xsl"/>-->
	<!--line breaks, lists and such-->
	<xsl:include href="nwda.mod.generics.xsl"/>
	<!--table of contents-->
	<xsl:include href="nwda.mod.toc.xsl"/>
	<!--controlled access points-->
	<xsl:include href="nwda.mod.controlaccess.xsl"/>
	<!--description of subordinate components-->
	<xsl:include href="nwda.mod.dsc.xsl"/>
	<!--tables-->
	<xsl:include href="nwda.mod.tables.xsl"/>


	<!--loose archdesc-->
	<xsl:include href="nwda.mod.structures.xsl"/>

	<!-- ********************* </MODULES> *********************** -->
	<!-- Hide elements with altrender nodisplay and internal audience attributes-->
	<xsl:template match="*[@altrender='nodisplay']"/>
	<xsl:template match="*[@audience='internal']"/>
	<!-- Hide elements not matched in-toto elsewhere-->
	<xsl:template match="profiledesc"/>
	<xsl:template match="eadheader/eadid | eadheader/revisiondesc | archdesc/did"/>
	<xsl:template match="ead">
		<xsl:call-template name="html_base"/>
	</xsl:template>


	<xsl:template name="highlight" match="//ixiahit">
		<span style="font-weight:bold;color:black;background-color:#FFFF33;">
			<a id="{@number}"/>
			<xsl:apply-templates/>
		</span>
	</xsl:template>


	<xsl:template name="html_base">
		<html lang="en">
			<head>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<!-- Dublin Core metadata-->
				<!--<xsl:call-template name="md.dc"/>-->
				<!-- bootstrap -->
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"/>
				<!-- bootstrap -->
				<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/>

				<link href="{$pathToFiles}{$styleFileName}" rel="stylesheet"/>
				<link href="/css/header.css" rel="stylesheet" type="text/css"/>
				<link href="{$serverURL}/ark:/{$identifier}" rel="canonical"/>
				<script language="javascript" type="text/javascript" src="{$pathToFiles}jqs.js">{}</script>
				<title>
					<xsl:value-of select="$titleproper"/>
				</title>
			</head>
			<body>
				<xsl:call-template name="html.header.table"/>
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12 text-center">
							<h1>
								<xsl:value-of select="/ead/archdesc/did/unittitle/text()"/>
							</h1>
							<xsl:if test="/ead/archdesc/did/unittitle/unitdate or /ead/archdesc/did/unitdate">
								<xsl:choose>
									<xsl:when test="/ead/archdesc/did/unittitle/unitdate">
										<h2>
											<xsl:value-of select="/ead/archdesc/did/unittitle/unitdate"/>
										</h2>
									</xsl:when>
									<xsl:when test="/ead/archdesc/did/unitdate">
										<h2>
											<xsl:value-of select="/ead/archdesc/did/unitdate"/>
										</h2>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
						</div>
					</div>
					<div class="row">
						<div class="col-md-3 navBody">
							<xsl:call-template name="toc"/>
						</div>
						<div class="col-md-9">
							<xsl:apply-templates select="archdesc"/>
							<div class="footer">
								<xsl:apply-templates select="/ead/eadheader/filedesc/publicationstmt"/>
							</div>
						</div>
					</div>
				</div>

				<script type="text/javascript">
        var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
        document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
				<script type="text/javascript">
		if (typeof(_gat) == "object") {
			var pageTracker = _gat._getTracker("UA-3516166-1");
			pageTracker._setLocalRemoteServerMode();
			pageTracker._trackPageview();
		}
		</script>
			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>
