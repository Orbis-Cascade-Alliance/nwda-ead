<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
         xmlns:nwda="https://github.com/ewg118/nwda-editor#"
         xmlns:arch="http://purl.org/archival/vocab/arch#"
         xmlns:dcterms="http://purl.org/dc/terms/"
         xmlns:foaf="http://xmlns.com/foaf/0.1/"
         xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:msxsl="urn:schemas-microsoft-com:xslt">
	<!--<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>-->
	<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8" indent="no"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

	<xsl:param name="doc"/>

	<!--<xsl:strip-space elements="*"/>-->
	<xsl:template match="processing-instruction()"/>

	<!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
    <xsl:variable name="identifier" select="string(normalize-space(/ead/eadheader/eadid/@identifier))"/>
	<xsl:variable name="titleproper"
		select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[1]))"/>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper"
		select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[@altrender]))"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="string(//revisiondesc/change[position()=last()]/date/@normal)"/>
    </xsl:variable>
    <xsl:variable name="rdf" select="msxsl:node-set(document(concat('C:\Program Files (x86)\Apache Software Foundation\Tomcat 8.0\webapps\orbeon\WEB-INF\resources\repository_records\', //eadid/@mainagencycode, '.xml'))/rdf:RDF)">
        <!--        <xsl:value-of select="document(concat('C:\Program Files\Apache Software Foundation\Tomcat 8.0\webapps\orbeon\WEB-INF\resources\repository_records\', //eadid/@mainagencycode, '.xml'))/rdf:RDF/arch:Archive/@rdf:about"/>-->
    </xsl:variable>
    <xsl:variable name="hasCHOs">
        <xsl:if test="string(//eadid/@identifier) and descendant::dao[@role='harvest-all' and string(@href)]">
            <!-- if there is an ARK in eadid/@identifier and at least one dao with a 'harvest-all' @role, then assume CHOs is true: ASP.NET seems not use allow URIs in xsl document() function -->
            <xsl:text>true</xsl:text>
        </xsl:if>
    </xsl:variable>
	<!-- ********************* </XML_VARIABLES> *********************** -->
	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
	<xsl:include href="nwda.mod.preferences.xslt"/>
	<!--HTML header table -->
	<xsl:include href="nwda.mod.html.header.xslt"/>
	<!-- Dublin Core MD -->
	<xsl:include href="nwda.mod.metadata.xslt"/>
	<!--Major finding aid structures: bioghist, scopecontent, controlaccess, dsc etc.-->
	<!--<xsl:include href="nwda.mod.structures_0.1.xslt"/>-->
	<!--classes of generic elements... e.g. P class="abstract"
	nice idea, didn't run with it.
	<xsl:include href="nwda.mod.classes.xslt"/>-->
	<!--line breaks, lists and such-->
	<xsl:include href="nwda.mod.generics.xslt"/>
	<!--table of contents-->
	<xsl:include href="nwda.mod.toc.xslt"/>
	<!--controlled access points-->
	<xsl:include href="nwda.mod.controlaccess.xslt"/>
	<!--description of subordinate components-->
	<xsl:include href="nwda.mod.dsc.xslt"/>
	<!--tables-->
	<xsl:include href="nwda.mod.tables.xslt"/>


	<!--loose archdesc-->
	<xsl:include href="nwda.mod.structures.xslt"/>

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
      <a id="{@number}"></a>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
	

  <xsl:template name="html_base">
    <html>
      <head>
				<meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <!-- Dublin Core metadata-->
        <xsl:call-template name="md.dc"/>
        <style type="text/css" media="all">
          @import "<xsl:value-of select="$pathToFiles"
						/><xsl:value-of select="$styleFileName"/> ";
        </style>
        <!-- this so safari on mac osx can get it -->
        <link href="{$pathToFiles}{$styleFileName}" rel="stylesheet"/>
        <link href="/css/header.css" rel="stylesheet" type="text/css" />
        <link href="{$serverURL}/ark:/{$identifier}" rel="canonical" />
        <script language="javascript" type="text/javascript" src="{$pathToFiles}jqs.js">{}</script>
        <title>
          <xsl:value-of select="$titleproper"/>
        </title>
      </head>
      <body bgcolor="#ffffff" onload="hide('h_ai');">
        <a id="top"></a>
        <xsl:call-template name="html.header.table"/>
        <div class="frontmatter">
          <xsl:apply-templates select="/ead/eadheader//titlestmt/titleproper[1]" />
        </div>

        <table width="952" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td class="toc" style="height:100%; width:180px; vertical-align:top; background-color:#edede8; text-align:right;">
              <xsl:call-template name="toc"/>
            </td>
            <td class="body" style="vertical-align:top; height:100%" id="docBody">
              <xsl:apply-templates select="archdesc"/>
              <div class="footer">
                <xsl:apply-templates select="/ead/eadheader/filedesc/publicationstmt"/>
              </div>
              <xsl:comment>Comment Section</xsl:comment>
            </td>
          </tr> 
          
        </table>
        
        <script type="text/javascript">
        var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
        document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
        <script type = "text/javascript">
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
