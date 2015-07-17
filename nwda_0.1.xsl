<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1

Overhaul to HTML5/Bootstrap 3 by Ethan Gruber in March 2015.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#"
	xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="nwda xsd vcard xsl fo ead">
	<xsl:output encoding="UTF-8" method="html" omit-xml-declaration="yes" doctype-public="html"/>

	<xsl:param name="doc"/>

	<!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="identifier" select="string(normalize-space(/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='eadid']/@identifier))"/>
	<xsl:variable name="titleproper">
		<xsl:value-of select="normalize-space(/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unittitle'])"/>
		<xsl:if test="/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']"/>
		</xsl:if>
	</xsl:variable>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper" select="string(normalize-space(/*[local-name()='ead']/*[local-name()='eadheader']//*[local-name()='titlestmt']/*[local-name()='titleproper'][@altrender]))"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="string(//*[local-name()='revisiondesc']/*[local-name()='change'][position()=last()]/*[local-name()='date']/@normal)"/>
	</xsl:variable>

	<!-- ********************* </XML_VARIABLES> *********************** -->
	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
	<xsl:include href="nwda.mod.preferences.xsl"/>
	<!--HTML header table -->
	<xsl:include href="nwda.mod.html.header.xsl"/>
	<!-- Dublin Core MD -->
	<!-- March 2015: Deprecated HTML head metadata in favor of RDFa following Aaron Rubinstein's arch ontology and dcterms -->
	<!--<xsl:include href="nwda.mod.metadata.xsl"/>-->
	<!--Major finding aid structures: bioghist, scopecontent, controlaccess, dsc etc.-->
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

	<!-- *** RDF and CHO variables moved into nwda.mod.preferences.xsl *** -->


	<!-- ********************* </MODULES> *********************** -->
	<!-- Hide elements with altrender nodisplay and internal audience attributes-->
	<xsl:template match="*[@altrender='nodisplay']"/>
	<xsl:template match="*[@audience='internal']"/>
	<!-- Hide elements not matched in-toto elsewhere-->
	<xsl:template match="*[local-name()='profiledesc']"/>
	<xsl:template match="*[local-name()='eadheader']/*[local-name()='eadid'] | *[local-name()='eadheader']/*[local-name()='revisiondesc'] | *[local-name()='archdesc']/*[local-name()='did']"/>
	<xsl:template match="*[local-name()='ead']">
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
				<title>
					<xsl:text>Archives West: </xsl:text>
					<xsl:value-of select="$titleproper"/>
				</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<!-- jquery -->
				<meta name="viewport" content="width=device-width, initial-scale=1"/>

				<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">//</script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">//</script>
				
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"/>

				<!-- local styling -->
				<link href="{$pathToCss}{$styleFileName}" rel="stylesheet"/>
				<link href="{$serverURL}/ark:/{$identifier}" rel="canonical"/>
				<link href="{$serverURL}/ark:/{$identifier}/pdf" rel="alternate" type="application/pdf"/>
				<script language="javascript" type="text/javascript" src="{$pathToJavascript}jqs.js">//</script>
				
				<!--<script language="javascript" type="text/javascript" src="{$pathToJavascript}2doc_search.js">//</script>-->
				<xsl:choose>
					<xsl:when test="$platform='linux'">
						<script language="javascript" type="text/javascript" src="{$pathToJavascript}jquery.appear.js">//</script>						
						<link rel="stylesheet" type="text/css" href="{$pathToCss}global.css"/>
					</xsl:when>
					<xsl:otherwise>
						<script language="javascript" type="text/javascript" src="/jquery.appear.js">//</script>
						<script language="javascript" type="text/javascript" src="/global.js">//</script>
						<link rel="stylesheet" type="text/css" href="/global.css"/>
					</xsl:otherwise>
				</xsl:choose>


				<!-- google analytics -->
				<meta name="google-site-verification" content="Jzd19gch6s4FFczJFYTH8hFo9AZ2otlHRX-6B5ij-c0"/>
				<script type="text/javascript" src=""/>
			</head>
			<body>
				<div id="header">
					<div id="headercontent" class="wcon">
						<div id="headerlogo">
							<a class="" href="/" id="headerlogotxt">Archives West</a>
							<img src="/orbis-white.png" id="orbis-head-logo"/>
						</div>
						<div id="headerlinks">
							<a href="/about.shtml" class="">about</a>
							<a href="/contact" class="">contact</a>
							<a href="/help.shtml" class="">help</a>
						</div>
						<div class="cf"/>
					</div>
				</div>
				<div class="container-fluid" typeof="arch:Collection" about="{$serverURL}/ark:/{$identifier}">
					<form action="/search/results.aspx" method="get">
						<div id="">
							<div class="wcon">
								<div id="homesearchzone" class="row">
									<div class="col-sm-6" style="padding-top: 20px;">
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
												<strong>Download/Print:</strong>
											</li>
											<li>
												<a href="{$serverURL}/ark:/{$identifier}/pdf">PDF</a>
											</li>
										</ul>
									</div>
									<div id="searchoptions" class="col-sm-6">
										<div class="tr1 p1">
											<div class="row">
												<span class="col-xs-4 labelsearch">Search</span>
												<span class="col-xs-8 text-right">
													<label>
														<input type="checkbox" name="d" value="1" />
														<span id="optionsearch"> digital objects only</span>
													</label>
												</span>
											</div>
											<div class="">
												<input type="text" id="searchValue" name="q" class="form-control" placeholder="By Keywords" />
											</div>
											<input type="hidden" id="t" name="t" value="k" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="color1b" style="margin: 20px 0; height: 4px;"></div>
					<div class="">
						<!-- March 2015: Moved TOC under the archdesc template to accommodate responsive framework.
						On extra small (phones) and small devices, (< 992 px wide), the TOC will be moved under Collection Overview -->
						
						<!-- April 2015: flag mode has been added to facilitate cleaner linking in the XSL:FO -->
						<xsl:apply-templates select="*[local-name()='archdesc']" mode="flag"/>						
					</div>
				</div>
				<div id="footer">
					<a href="http://www.orbiscascade.org">
						<img src="/orbislogo.png"/>
					</a>
				</div>
			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>
