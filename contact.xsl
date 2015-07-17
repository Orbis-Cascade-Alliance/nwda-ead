<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#" exclude-result-prefixes="xsl xs arch dcterms foaf rdf xsd vcard nwda" version="1.0">
	<xsl:output encoding="UTF-8" method="html" omit-xml-declaration="yes" doctype-public="html"/>

	<xsl:include href="nwda.mod.preferences.xsl"/>
	<xsl:include href="nwda.mod.html.header.xsl"/>

	<xsl:template match="/">
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <meta name="google-site-verification" content="Jzd19gch6s4FFczJFYTH8hFo9AZ2otlHRX-6B5ij-c0" />
                <meta name="description" content="Archives West provides access to descriptions of primary sources in the Western United States, including correspondence, diaries, or photographs. Digital reproductions of primary sources are available in some cases." />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"/>
                <link rel="stylesheet" type="text/css" href="/global.css"/>
                <script type="text/javascript" src="/analytics.js"></script>
                <link rel="stylesheet" type="text/css" href="/az.css"/>
                <script src="/az.js"></script>
                <title>Archives West: Contact</title>
            </head>
			<body>
                <div id="header">
                    <div id="headercontent" class="wcon">
                        <div id="headerlogo">
                            <a class="" href="/" id="headerlogotxt">Archives West</a>
                            <img src="/orbis-white.png" id="orbis-head-logo"/>
                        </div>
                        <div id="headerlinks">
                            <a href="/about" class="">about</a>
                            <a href="/contact" class="">contact</a>
                            <a href="/help" class="">help</a>
                        </div>
                        <div class="cf"></div>
                    </div>
                </div>
        
                <div id="contactcontent" class="wcon">
                    <h2>Contact Participating Repositories</h2>

                    <!-- jean.francois.lauze@gmail.com > added a placeholder for the a-z anchors... -->
                    <div id="atoz"></div>
                    <table class="table table-striped" style="font-size: 0.8em;">
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

                    <p>
                        Please report web site functionality problems to
                        <a href="mailto:webmaster@orbiscascade.org">webmaster@orbiscascade.org</a>
                    </p>
                </div>

                <div id="footer">
                    <a href="http://www.orbiscascade.org"><img src="/orbislogo.png"/></a>
                </div>
            </body>
		</html>
	</xsl:template>

	<xsl:template match="arch:Archive">
		
		<tr id="{substring-after(@rdf:about, '#')}">
			<td>				
				<xsl:choose>
					<xsl:when test="foaf:homepage/@rdf:resource">
                        <a class="anchorme" href="{foaf:homepage/@rdf:resource}" target="_blank">
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
					<span class="glyphicon glyphicon-triangle-right"> </span>
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
