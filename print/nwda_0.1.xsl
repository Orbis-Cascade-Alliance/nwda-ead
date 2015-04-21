<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1

Overhaul to HTML5/Bootstrap 3 by Ethan Gruber in March 2015.
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:nwda="https://github.com/ewg118/nwda-editor#"
                xmlns:arch="http://purl.org/archival/vocab/arch#"
                version="1.0"
                exclude-result-prefixes="nwda xsd vcard xsl fo">
	  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	  <xsl:param name="doc"/>

	  <!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="identifier"
                 select="string(normalize-space(/ead/eadheader/eadid/@identifier))"/>
	  <xsl:variable name="titleproper">
		    <xsl:value-of select="normalize-space(/ead/archdesc/did/unittitle)"/>
		    <xsl:if test="/ead/archdesc/did/unitdate">
			      <xsl:text>, </xsl:text>
			      <xsl:value-of select="/ead/archdesc/did/unitdate"/>
		    </xsl:if>
	  </xsl:variable>
	  <!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper"
                 select="string(normalize-space(/ead/eadheader//titlestmt/titleproper[@altrender]))"/>
	  <xsl:variable name="dateLastRev">
		    <xsl:value-of select="string(//revisiondesc/change[position()=last()]/date/@normal)"/>
	  </xsl:variable>

	  <!-- ********************* </XML_VARIABLES> *********************** -->
	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
	<xsl:include href="../nwda.mod.preferences.xsl"/>
	  <!--HTML header table -->
	
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
	<xsl:template match="profiledesc"/>
	  <xsl:template match="eadheader/eadid | eadheader/revisiondesc | archdesc/did"/>
	  <xsl:template match="ead">
		    <xsl:call-template name="html_base"/>
	  </xsl:template>


	


	  <xsl:template name="html_base">
      <fo:root font-size="12px" color="#6b6b6b"
               font-family="georgia, 'times new roman', times, serif">
         <fo:layout-master-set>
            <fo:simple-page-master margin-right="1in" margin-left="1in" margin-bottom="1in" margin-top="1in"
                                   page-width="8in"
                                   page-height="11in"
                                   master-name="content">
               <fo:region-body region-name="body" margin-bottom=".5in"/>
               <fo:region-after region-name="footer" extent=".5in"/>
            </fo:simple-page-master>
         </fo:layout-master-set>
         <fo:page-sequence master-reference="content">
            <fo:title>
               <xsl:value-of select="$titleproper"/>
            </fo:title>
            <fo:static-content flow-name="footer">
               <fo:block>
                  <xsl:value-of select="concat($serverURL, '/ark:/', $identifier)"/>
               </fo:block>
            </fo:static-content>
            <fo:flow flow-name="body">
               <fo:block font-size="36px" color="#676D38">
                  <xsl:value-of select="normalize-space(archdesc/did/unittitle)"/>
                  <xsl:if test="archdesc/did/unitdate">
                     <xsl:text>, </xsl:text>
                     <xsl:value-of select="archdesc/did/unitdate"/>
                  </xsl:if>
               </fo:block>
               <fo:block>
                  <xsl:apply-templates select="archdesc"/>
               </fo:block>
            </fo:flow>
         </fo:page-sequence>
      </fo:root>
   </xsl:template>


</xsl:stylesheet>