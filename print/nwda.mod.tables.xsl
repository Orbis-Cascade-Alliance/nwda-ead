<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ead="urn:isbn:1-931666-22-9"
                version="1.0"
                exclude-result-prefixes="fo ead">
   <xsl:template match="*[local-name()='table']">
      <fo:table table-layout="fixed">
         <xsl:choose>
            <xsl:when test="count(descendant::*[local-name()='colspec']) &gt; 0">
               <xsl:variable name="count">
                  <xsl:value-of select="count(descendant::*[local-name()='colspec'])"/>
               </xsl:variable>
               <xsl:for-each select="descendant::*[local-name()='colspec']">
                  <fo:table-column column-width="{floor(100 div $count)}%"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise/>
         </xsl:choose>
         <xsl:apply-templates/>
      </fo:table>
   </xsl:template>
   <xsl:template match="*[local-name()='thead']">
      <fo:table-header>
         <fo:table-row>
            <xsl:for-each select=".//*[local-name()='entry']">
               <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                              border-bottom-style="solid"
                              padding="8px">
                  <fo:block>
                     <xsl:apply-templates/>
                  </fo:block>
               </fo:table-cell>
            </xsl:for-each>
         </fo:table-row>
      </fo:table-header>
   </xsl:template>
   <xsl:template match="*[local-name()='row']">
      <fo:table-row>
         <xsl:for-each select="./*[local-name()='entry']">
            <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                           border-bottom-style="solid"
                           padding="8px">
               <fo:block>
                  <xsl:apply-templates/>
               </fo:block>
            </fo:table-cell>
         </xsl:for-each>
      </fo:table-row>
   </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
</metaInformation>
-->