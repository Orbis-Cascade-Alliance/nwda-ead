<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1

Overhaul to HTML5/Bootstrap 3 by Ethan Gruber in March 2015.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/ewg118/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="nwda xsd vcard xsl exsl msxsl
	rdf arch dcterms foaf">
	<xsl:output encoding="UTF-8" method="html" omit-xml-declaration="yes" doctype-public="html"/>

	<xsl:param name="doc"/>

	<!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="identifier" select="string(normalize-space(/ead/eadheader/eadid/@identifier))"/>
	<xsl:variable name="titleproper" select="string(normalize-space(/ead/archdesc/did/unittitle))"/>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper" select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[@altrender]))"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="string(//revisiondesc/change[position()=last()]/date/@normal)"/>
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

	<!--get RDF -->
	<xsl:variable name="rdf">
		<xsl:if test="$editor-active = 'true'">
			<xsl:choose>
				<xsl:when test="$mode='linux'">
					<xsl:copy-of select="exsl:node-set(document(concat($pathToRdf, //eadid/@mainagencycode, '.xml'))/rdf:RDF)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="msxsl:node-set(document(concat($pathToRdf, //eadid/@mainagencycode, '.xml'))/rdf:RDF)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="hasCHOs">
		<xsl:if test="$harvester-active = 'true'">
			<xsl:if test="string(//eadid/@identifier) and descendant::dao[@role='harvest-all' and string(@href)]">
				<!-- if there is an ARK in eadid/@identifier and at least one dao with a 'harvest-all' @role, then assume CHOs is true: ASP.NET seems not use allow URIs in xsl document() function -->
				<xsl:text>true</xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:variable>

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
		<html lang="en" prefix="dcterms: http://purl.org/dc/terms/    foaf: http://xmlns.com/foaf/0.1/    owl:  http://www.w3.org/2002/07/owl#    rdf:  http://www.w3.org/1999/02/22-rdf-syntax-ns#
			skos: http://www.w3.org/2004/02/skos/core#    dcterms: http://purl.org/dc/terms/    arch: http://purl.org/archival/vocab/arch#    xsd: http://www.w3.org/2001/XMLSchema#">
			<head>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<!-- Dublin Core metadata-->
				<!--<xsl:call-template name="md.dc"/>-->
				<!-- jquery -->
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">//</script>
				<!-- bootstrap -->
				<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/>
				<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js">//</script>

				<!-- local styling -->
				<link href="{$pathToFiles}{$styleFileName}" rel="stylesheet"/>
				<link href="{$serverURL}/ark:/{$identifier}" rel="canonical"/>
				<script language="javascript" type="text/javascript" src="{$pathToFiles}jqs.js">//</script>
				<title>
					<xsl:value-of select="$titleproper"/>
				</title>
			</head>
			<body>
				<xsl:call-template name="html.header.table"/>
				<div class="container-fluid">	
					<div class="row pull-right">
						<div class="col-md-12">
							<ul class="list-inline">
								<li>
									<strong>Share:</strong>
								</li>
								<li>
									<!-- AddThis Button BEGIN -->
									<div class="addthis_toolbox addthis_default_style">
										<a class="addthis_button_preferred_1"/>
										<a class="addthis_button_preferred_2"/>
										<a class="addthis_button_preferred_3"/>
										<a class="addthis_button_preferred_4"/>
										<a class="addthis_button_compact"/>
										<a class="addthis_counter addthis_bubble_style"/>
									</div>
									<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=xa-525d63ef6a07cd89"/>
								</li>
								<li>
									<strong>Export:</strong>
								</li>
								<li>
									<a href="{$serverURL}/ark:/{$identifier}.xml">XML</a>
								</li>
								<li>
									<a href="{$serverURL}/ark:/{$identifier}.pdf">PDF</a>
								</li>
							</ul>
						</div>
					</div>
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

				<!--<script type="text/javascript">
        var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
        document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
				<script type="text/javascript">
		if (typeof(_gat) == "object") {
			var pageTracker = _gat._getTracker("UA-3516166-1");
			pageTracker._setLocalRemoteServerMode();
			pageTracker._trackPageview();
		}
		</script>-->
			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>
