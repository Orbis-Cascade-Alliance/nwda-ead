<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/ewg118/nwda-editor#" exclude-result-prefixes="xsl xs arch dcterms foaf rdf xsd vcard nwda" version="1.0">
	<xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Northwest Digital Archives | contact us</title>
				<link href="/nwda.css" rel="stylesheet" type="text/css"/>
				<script src="/scripts/AC_RunActiveContent.js" type="text/javascript">//</script>
				<script src="/scripts/AC_ActiveX.js" type="text/javascript">//</script>
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">//</script>
				<script src="/scripts/contact_functions.js" type="text/javascript">//</script>
				<style text="text/css">
					.archive-div{
						padding:10px;
					}
					.toggle-button{
						padding:0;
					}</style>
			</head>

			<body>
				<!-- include nav.html -->
                <xsl:copy-of select="document('../../nav.html')"/>
				<div id="wrapper">
					<!-- include tout.html -->
                    <xsl:copy-of select="document('../../tout.html')"/>
					<div id="content">
						<h2>contact us</h2>
						<xsl:apply-templates select="descendant::arch:Archive">
							<xsl:sort select="foaf:name" order="ascending" data-type="text"/>
						</xsl:apply-templates>
					</div>
				</div>
				<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
				</script>

				<xsl:comment>
					<![CDATA[
					<script type="text/javascript">
					var pageTracker = _gat._getTracker("UA-3516166-1");
					pageTracker._initData();
					pageTracker._trackPageview();
					</script>
					]]>
				</xsl:comment>

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

	<xsl:template match="arch:Archive">
		<div class="archive-div">
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
			<xsl:if test="nwda:visitation or nwda:facsimile or dcterms:description">
				<xsl:text> </xsl:text>
				<button class="toggle-button">+/-</button>
				<div style="display:none">
					<dl>
						<xsl:apply-templates select="dcterms:description"/>
						<xsl:apply-templates select="nwda:facsimile"/>
						<xsl:apply-templates select="nwda:visitation"/>
					</dl>
				</div>
			</xsl:if>
		</div>
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
