<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"
                exclude-result-prefixes="fo">
   <xsl:template match="table">
      <fo:table width="100%">
         <xsl:apply-templates/>
      </fo:table>
   </xsl:template>
   <xsl:template match="thead">
      <fo:table-header>
         <fo:table-row width="100%">
            <xsl:for-each select=".//entry">
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
   <xsl:template match="row">
      <fo:table-row width="100%">
         <xsl:for-each select="./entry">
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