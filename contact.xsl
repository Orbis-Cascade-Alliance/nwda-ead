<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/ewg118/nwda-editor#" exclude-result-prefixes="xsl xs arch dcterms foaf rdf xsd vcard nwda" version="1.0">
	<xsl:output encoding="UTF-8" method="html" omit-xml-declaration="yes" doctype-public="html"/>

	<xsl:include href="nwda.mod.preferences.xsl"/>
	<xsl:include href="nwda.mod.html.header.xsl"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Northwest Digital Archives | Contact Us</title>
				<!--<link href="/nwda.css" rel="stylesheet" type="text/css"/>
				<script src="/scripts/AC_RunActiveContent.js" type="text/javascript">//</script>
				<script src="/scripts/AC_ActiveX.js" type="text/javascript">//</script>
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">//</script>
				<script src="/scripts/contact_functions.js" type="text/javascript">//</script>-->
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<!-- jquery -->
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">//</script>
				<!-- bootstrap -->
				<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/>
				<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js">//</script>

				<!-- local styling -->
				<link href="{$pathToCss}{$styleFileName}" rel="stylesheet"/>
				<!--<script language="javascript" type="text/javascript" src="{$pathToJavascript}contact_functions.js">//</script>-->

				<script type="text/javascript">
					if (typeof(_gat) == "object") {
					var pageTracker = _gat._getTracker("UA-3516166-1");
					pageTracker._setLocalRemoteServerMode();
					pageTracker._trackPageview();
					}
				</script>
			</head>

			<body>
				<xsl:call-template name="html.header"/>
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<h2>Contact Us</h2>
							<table class="table table-striped">
								<thead>
									<tr>
										<th style="width:25%">Repository</th>
										<th>Information</th>
									</tr>
								</thead>
								<tbody>
									<xsl:apply-templates select="descendant::arch:Archive">
										<xsl:sort select="foaf:name" order="ascending" data-type="text"/>
									</xsl:apply-templates>
								</tbody>
							</table>														
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="arch:Archive">
		<tr>
			<td>
				<xsl:choose>
					<xsl:when test="foaf:homepage/@rdf:resource">
						<a href="{foaf:homepage/@rdf:resource}" target="_blank">
							<xsl:value-of select="normalize-space(foaf:name)"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space(foaf:name)"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:if test="nwda:visitation or nwda:facsimile or dcterms:description">
					<dl class="dl-horizontal">
						<xsl:apply-templates select="dcterms:description"/>
						<xsl:apply-templates select="nwda:facsimile"/>
						<xsl:apply-templates select="nwda:visitation"/>
					</dl>
				</xsl:if>
			</td>
			<!--<xsl:if test="nwda:visitation or nwda:facsimile or dcterms:description">
				<xsl:text> </xsl:text>
				
				<a href="#" class="toggle-button">
					<span class="glyphicon glyphicon-plus"> </span>
				</a>
				<div style="display:none">
					<dl class="dl-horizontal">
						<xsl:apply-templates select="dcterms:description"/>
						<xsl:apply-templates select="nwda:facsimile"/>
						<xsl:apply-templates select="nwda:visitation"/>
					</dl>
				</div>
			</xsl:if>-->
		</tr>
	</xsl:template>

	<xsl:template match="nwda:visitation|nwda:facsimile|dcterms:description">
		<dt>
			<strong>
				<xsl:choose>
					<xsl:when test="name()='nwda:visitation'">Visitation Info</xsl:when>
					<xsl:when test="name()='nwda:facsimile'">Copy Info</xsl:when>
					<xsl:when test="name()='dcterms:description'">Collection Info</xsl:when>
				</xsl:choose>
			</strong>
		</dt>
		<dd>
			<!-- insert a class attribute for URL parsing -->
			<xsl:if test="not(string(@rdf:resource))">
				<xsl:attribute name="class">info-text</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="string(@rdf:resource)">
					<a href="{@rdf:resource}" target="_blank">
						<xsl:value-of select="@rdf:resource"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</dd>
	</xsl:template>

</xsl:stylesheet>
