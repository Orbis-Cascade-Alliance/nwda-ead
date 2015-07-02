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
                xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#"
                xmlns:arch="http://purl.org/archival/vocab/arch#"
                xmlns:ead="urn:isbn:1-931666-22-9"
                version="1.0"
                exclude-result-prefixes="nwda xsd vcard xsl fo ead">
   <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
   <xsl:param name="doc"/>
   <!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>--><!-- ********************* <XML_VARIABLES> *********************** --><xsl:variable name="identifier"
                 select="string(normalize-space(/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='eadid']/@identifier))"/>
   <xsl:variable name="titleproper">
      <xsl:value-of select="normalize-space(/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unittitle'])"/>
      <xsl:if test="/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']">
         <xsl:text>, </xsl:text>
         <xsl:value-of select="/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']"/>
      </xsl:if>
   </xsl:variable>
   <!--check later for not()altrender--><xsl:variable name="filingTitleproper"
                 select="string(normalize-space(/*[local-name()='ead']/*[local-name()='eadheader']//*[local-name()='titlestmt']/*[local-name()='titleproper'][@altrender]))"/>
   <xsl:variable name="dateLastRev">
      <xsl:value-of select="string(//*[local-name()='revisiondesc']/*[local-name()='change'][position()=last()]/*[local-name()='date']/@normal)"/>
   </xsl:variable>
   <!-- ********************* </XML_VARIABLES> *********************** --><!-- ********************* <MODULES> *********************** --><!--set stylesheet preferences --><xsl:include href="../nwda.mod.preferences.xsl"/>
   <!--HTML header table --><!-- Dublin Core MD --><!-- March 2015: Deprecated HTML head metadata in favor of RDFa following Aaron Rubinstein's arch ontology and dcterms --><!--<xsl:include href="nwda.mod.metadata.xsl"/>--><!--Major finding aid structures: bioghist, scopecontent, controlaccess, dsc etc.--><!--classes of generic elements... e.g. P class="abstract"
	nice idea, didn't run with it.
	<xsl:include href="nwda.mod.classes.xsl"/>--><!--line breaks, lists and such--><xsl:include href="nwda.mod.generics.xsl"/>
   <!--table of contents--><!--controlled access points--><xsl:include href="nwda.mod.controlaccess.xsl"/>
   <!--description of subordinate components--><xsl:include href="nwda.mod.dsc.xsl"/>
   <!--tables--><xsl:include href="nwda.mod.tables.xsl"/>
   <!--loose archdesc--><xsl:include href="nwda.mod.structures.xsl"/>
   <!-- *** RDF and CHO variables moved into nwda.mod.preferences.xsl *** --><!-- ********************* </MODULES> *********************** --><!-- Hide elements with altrender nodisplay and internal audience attributes--><xsl:template match="*[@altrender='nodisplay']"/>
   <xsl:template match="*[@audience='internal']"/>
   <!-- Hide elements not matched in-toto elsewhere--><xsl:template match="*[local-name()='profiledesc']"/>
   <xsl:template match="*[local-name()='eadheader']/*[local-name()='eadid'] | *[local-name()='eadheader']/*[local-name()='revisiondesc'] | *[local-name()='archdesc']/*[local-name()='did']"/>
   <xsl:template match="*[local-name()='ead']">
      <xsl:call-template name="html_base"/>
   </xsl:template>
   <xsl:template name="html_base">
      <fo:root font-size="11px" color="#666666" font-family="Verdana,Arial,Helvetica,Sans">
         <fo:layout-master-set>
            <fo:simple-page-master margin-right=".5in" margin-left=".5in" margin-bottom=".5in" margin-top=".5in"
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
               <fo:block color="#6c34a8" font-size="85%" intrusion-displace="line">
                  <fo:table>
                     <fo:table-body>
                        <fo:table-row>
                           <fo:table-cell>
                              <fo:block>
                                 <xsl:value-of select="$titleproper"/>
                              </fo:block>
                              <fo:block>
                                 <fo:basic-link show-destination="new"
                                                external-destination="{concat($serverURL, '/ark:/', $identifier)}">
                                    <xsl:value-of select="concat($serverURL, '/ark:/', $identifier)"/>
                                 </fo:basic-link>
                              </fo:block>
                           </fo:table-cell>
                           <fo:table-cell>
                              <fo:block text-align="right">
                                 <fo:page-number/>
                              </fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                     </fo:table-body>
                  </fo:table>
               </fo:block>
            </fo:static-content>
            <fo:flow flow-name="body">
               <fo:block font-size="24px" color="#6c34a8">
                  <xsl:value-of select="normalize-space(*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unittitle'])"/>
                  <xsl:if test="*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']">
                     <xsl:text>, </xsl:text>
                     <xsl:value-of select="*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']"/>
                  </xsl:if>
               </fo:block>
               <fo:block>
                  <xsl:apply-templates select="*[local-name()='archdesc']" mode="flag"/>
               </fo:block>
            </fo:flow>
         </fo:page-sequence>
      </fo:root>
   </xsl:template>
</xsl:stylesheet>