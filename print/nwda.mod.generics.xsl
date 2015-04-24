<?xml version="1.0" encoding="UTF-8"?>
<!--
Original coding by stephen.yearl@yale.edu 2003-04-25
Revisions and modifications by Mark Carlson 2004
Major or significant revision history:
2004-07-14 fix daoloc display
2004-07-14 treat <chronitem> separately
2004-07-14 code to treat chronlist differently
2004-09-27 adding test to remove excess space if <p> is in <dsc> 
2004-11-30 add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd>
2004-12-07 put chronlist into a table format instead of a def list
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"><!--links--><xsl:template match="ref">
      <xsl:attribute name="external-destination">#<xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:value-of select="parent::p/text()"/>
      <xsl:value-of select="."/>
      <xsl:if test="following-sibling::ref">
         <fo:block/>
      </xsl:if>
   </xsl:template>
   <xsl:template match="extref">
      <xsl:attribute name="external-destination">
         <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="extref[@xlink:href]">
      <xsl:attribute name="external-destination">
         <xsl:value-of select="@xlink:href"/>
      </xsl:attribute>
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="daogrp"><!--    <div class="daogrp"> --><xsl:apply-templates select="daoloc"/>
      <!--   </div> --></xsl:template>
   <xsl:template match="dao">
      <xsl:attribute name="external-destination">
         <xsl:value-of select="@href"/>. <xsl:value-of select="@content-role"/>
      </xsl:attribute>
      <xsl:value-of select="daodesc"/>
   </xsl:template>
   <!-- 2004-07-14 carlson mod to fix daoloc display --><xsl:template match="daoloc">
      <xsl:attribute name="external-destination"><!--<xsl:value-of disable-output-escaping="yes" select="@href"/> removed 7/23/07 by Ethan Gruber--><xsl:value-of select="@href"/>
      </xsl:attribute>   </xsl:template>
   <!--expan/abbr--><xsl:template match="abbr">
      <xsl:choose>
         <xsl:when test="$expandAbbr='true'">
            <xsl:value-of select="./@expan"/> ( <xsl:value-of select="."/>) </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="expan">
      <xsl:choose>
         <xsl:when test="$expandAbbr='true'">
            <xsl:value-of select="."/> ( <xsl:value-of select="./@abbr"/>) </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!--lists--><xsl:template match="bibliography/p[bibref]">
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="item | indexentry | bibref">
      <fo:list-item>
         <fo:list-item-label end-indent="label-end()">
            <fo:block/>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <fo:block>
               <xsl:apply-templates/>
            </fo:block>
         </fo:list-item-body>
      </fo:list-item>
   </xsl:template>
   <!-- 2004-07-14 carlsonm mod to treat <chronitem> separately --><xsl:template match="chronitem">
      <fo:table-row width="100%">
         <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                        border-bottom-style="solid"
                        padding="8px">
            <fo:block>
               <xsl:apply-templates select="date"/>
            </fo:block>
         </fo:table-cell>
         <!-- 2004-11-30 Carlson mod add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd> --><fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                        border-bottom-style="solid"
                        padding="8px">
            <fo:block>
               <xsl:choose>
                  <xsl:when test="event">
                     <fo:inline>
                        <xsl:apply-templates select="event"/>
                     </fo:inline>
                     <fo:block/>
                  </xsl:when>
                  <xsl:when test="eventgrp">
                     <xsl:apply-templates select="eventgrp" mode="chronlist"/>
                  </xsl:when>
               </xsl:choose>
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
   </xsl:template>
   <xsl:template match="eventgrp" mode="chronlist">
      <xsl:for-each select="event">
         <fo:inline>
            <xsl:apply-templates/>
         </fo:inline>
         <fo:block/>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="defitem">
      <fo:list-item>
         <fo:list-item-label end-indent="label-end()">
            <fo:block/>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <fo:block>
               <xsl:if test="./label">
                  <fo:inline font-weight="bold">
                     <xsl:value-of select="label"/>
                  </fo:inline>: </xsl:if>
               <xsl:value-of select="item"/>
            </fo:block>
         </fo:list-item-body>
      </fo:list-item>
   </xsl:template>
   <!-- 2004-07-14 carlsonm mod to treat chronlist differently --><!-- 2004-12-07 carlsonm: put chronlist into a table format instead of a def list --><xsl:template match="chronlist">
      <fo:inline>
         <xsl:apply-templates select="head"/>
      </fo:inline>
      <fo:table width="100%">
         <xsl:apply-templates select="./*[not(self::head)]"/>
      </fo:table>
   </xsl:template>
   <xsl:template match="list | index | fileplan | bibliography">
      <fo:inline>
         <xsl:apply-templates select="head"/>
      </fo:inline>
      <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
         <xsl:apply-templates select="./*[not(self::head)]"/>
      </fo:list-block>
   </xsl:template>
   <!-- where would an archivist be without... "misc"--><xsl:template match="change">
      <xsl:apply-templates select="./item"/> ( <xsl:apply-templates select="./date"/>) </xsl:template>
   <xsl:template match="*[@altrender='nodisplay']"/>
   <!--
	<xsl:template match="*[@role][not(parent::origination)][not(self::daogrp)]">

		<xsl:value-of select="."/>&#160;(
		<xsl:value-of select="./@role"/>)&#160;
	</xsl:template>
	--><!--<xsl:template match="*[@type='bulk']">
    <xsl:value-of select="."/>(<xsl:value-of select="./@type"/>)</xsl:template>
  <xsl:template match="*[@type='inclusive']">
    <xsl:value-of select="."/>(<xsl:value-of select="./@type"/>)</xsl:template>--><xsl:template match="ixiahit">
      <xsl:apply-templates/>
   </xsl:template>
   <!--ultra generics--><xsl:template match="emph">
      <xsl:choose>
         <xsl:when test="@render">
            <xsl:apply-templates select="*[@render]"/>
         </xsl:when>
         <xsl:otherwise>
            <fo:inline text-decoration="underline">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="lb">
      <fo:block/>
   </xsl:template>
   <xsl:template match="unitdate">
      <xsl:apply-templates/>
      <xsl:text/>
      <!-- original SY code
    <xsl:if test="@type">&#160;<xsl:text></xsl:text>(<xsl:value-of select="@type"/>)</xsl:if>	 
	 --><!-- 2004-07-16 carlsonm mod Do not display @type if c02+ --><xsl:if test="@type and not(ancestor::c01)">  <xsl:text/>( <xsl:value-of select="@type"/>) </xsl:if>
   </xsl:template>
   <xsl:template match="unitid" mode="archdesc">
      <fo:inline>
         <xsl:value-of select="."/>
         <xsl:if test="@type">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@type"/>
            <xsl:text>)</xsl:text>
         </xsl:if>
         <xsl:if test="not(position() = last())">
            <xsl:text>, </xsl:text>
         </xsl:if>
      </fo:inline>
   </xsl:template>
   <xsl:template match="unitdate" mode="archdesc">
      <xsl:value-of select="."/>
      <xsl:if test="@type">
         <xsl:text> (</xsl:text>
         <xsl:value-of select="@type"/>
         <xsl:text>)</xsl:text>
      </xsl:if>
      <xsl:if test="@normal">
         <fo:block>
            <xsl:choose>
               <xsl:when test="contains(@normal, '/')">
                  <xsl:variable name="start" select="substring-before(@normal, '/')"/>
                  <xsl:variable name="end" select="substring-after(@normal, '/')"/>
                  <xsl:choose>
                     <xsl:when test="@type='bulk'">
                        <fo:inline>
                           <xsl:value-of select="$start"/>
                        </fo:inline>
                        <fo:inline>
                           <xsl:value-of select="$end"/>
                        </fo:inline>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:inline>
                           <xsl:value-of select="$start"/>
                        </fo:inline>
                        <fo:inline>
                           <xsl:value-of select="$end"/>
                        </fo:inline>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when test="@type='bulk'">
                        <fo:inline>
                           <xsl:value-of select="@normal"/>
                        </fo:inline>
                        <fo:inline>
                           <xsl:value-of select="@normal"/>
                        </fo:inline>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:inline>
                           <xsl:value-of select="@normal"/>
                        </fo:inline>
                        <fo:inline>
                           <xsl:value-of select="@normal"/>
                        </fo:inline>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
         </fo:block>
      </xsl:if>
      <xsl:if test="not(position() = last())">
         <fo:block/>
      </xsl:if>
   </xsl:template>
   <xsl:template name="unitdate-datatype">
      <xsl:param name="date"/>
      <!--<xsl:choose>
			<xsl:when test="$date castable as xs:date">
				<xsl:attribute name="datatype">xsd:date</xsl:attribute>
			</xsl:when>
			<xsl:when test="$date castable as xs:gYearMonth">
				<xsl:attribute name="datatype">xsd:gYearMonth</xsl:attribute>
			</xsl:when>
			<xsl:when test="$date castable as xs:gYear">
				<xsl:attribute name="datatype">xsd:gYear</xsl:attribute>
			</xsl:when>
		</xsl:choose>--></xsl:template>
   <!-- March 2015: For displaying the container within c01/did. Revision specification 7.1.2 --><xsl:template match="container" mode="c01">
      <xsl:if test="@type">
         <xsl:value-of select="concat(translate(substring(@type, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(@type, 2))"/>
         <xsl:text/>
      </xsl:if>
      <xsl:value-of select="."/>
      <xsl:if test="not(position()=last())">
         <xsl:text>, </xsl:text>
      </xsl:if>
   </xsl:template>
   <xsl:template match="extent">
      <xsl:choose>
         <xsl:when test="position() = 1">
            <fo:inline>
               <xsl:value-of select="."/>
            </fo:inline>
         </xsl:when>
         <xsl:otherwise>
            <fo:inline>
               <xsl:text>(</xsl:text>
               <xsl:value-of select="."/>
               <xsl:text>)</xsl:text>
            </fo:inline>
            <xsl:if test="not(position() = last())">
               <xsl:text/>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p"><!-- 2004-09-27 carlsonm: adding test to remove excess space if <p> is in <dsc> 
Tracking # 4.20
--><xsl:choose>
         <xsl:when test="not(ancestor::dsc) or parent::dsc">
            <fo:block margin-bottom="10px">
               <xsl:apply-templates/>
            </fo:block>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
            <xsl:if test="not(position()=last()) and c01">
               <fo:block/>
               <fo:block/>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="controlaccess[@type='lower']">
      <xsl:value-of select="name()"/>
      <xsl:apply-templates>
         <xsl:sort order="ascending" data-type="text"/>
      </xsl:apply-templates>
      <fo:block/>
      <!--

						<xsl:apply-templates>
						ddd<xsl:sort order="ascending" data-type="text"/>ddd
					</xsl:apply-templates><br />	--></xsl:template>
   <xsl:template match="address">
      <fo:block margin-bottom="10px"><!-- the following code distinguishes between a text-only address line and a url or email address --><xsl:for-each select="addressline">
            <xsl:choose><!-- if the addressline contains http://, a href is created --><xsl:when test="contains(normalize-space(.), 'http://')">
                  <xsl:choose>
                     <xsl:when test="substring-before(normalize-space(.), 'http://')">
                        <xsl:value-of select="substring-before(normalize-space(.), 'http://')"/>
                        <fo:basic-link external-destination="http://{substring-after(normalize-space(.), 'http://')}">
                           <xsl:text>http://</xsl:text>
                           <xsl:value-of select="substring-after(normalize-space(.), 'http://')"/>
                        </fo:basic-link>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:if test="not(position() = last())">
                     <fo:block/>
                  </xsl:if>
               </xsl:when>
               <!-- if the @ symbol is contained, it is assumed to be an email address --><xsl:when test="contains(normalize-space(.), '@')">
                  <xsl:choose><!-- if email address is preceded by a space, i. e. "Email: foo@bar.com", only the foo@bar.com is made a mailto link --><xsl:when test="contains(normalize-space(.), ' ')">
                        <xsl:value-of select="substring-before(normalize-space(.), ' ')"/>
                        <xsl:text/>
                        <xsl:value-of select="substring-after(normalize-space(.), ' ')"/>
                        <!-- insert break only if it's not the last line.  this will cut back on unnecessary whitespace --><xsl:if test="not(position() = last())">
                           <fo:block/>
                        </xsl:if>
                     </xsl:when>
                     <!-- otherwise, the whole line is.  this is assuming these are the only two options seen.  standards in email and http 
								address lines should be further developed --><xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:if test="not(position() = last())">
                           <fo:block/>
                        </xsl:if>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="normalize-space(.)"/>
                  <xsl:if test="not(position() = last())">
                     <fo:block/>
                  </xsl:if>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </fo:block>
   </xsl:template>
   <xsl:template match="div">
      <fo:block margin-bottom="10px">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>
   <!-- suppress all heads
  <xsl:template match="head">
     <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
--><xsl:template match="title">
      <fo:inline font-style="italic">
         <xsl:apply-templates/>
      </fo:inline>
   </xsl:template>
   <xsl:template match="*[@type='restricted']">
      <fo:inline>
         <xsl:value-of select="."/>
      </fo:inline>
   </xsl:template>
   <!-- ********************* <* @render> *********************** --><xsl:template match="*[@render]">
      <xsl:choose>
         <xsl:when test="@render='bold'">
            <fo:inline font-weight="bold">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='italic'">
            <fo:inline font-style="italic">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='bolditalic'">
            <fo:inline font-weight="bold">
               <fo:inline font-style="italic">
                  <xsl:apply-templates/>
               </fo:inline>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='underline'">
            <fo:inline text-decoration="underline">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='boldunderline'">
            <fo:inline font-weight="bold">
               <fo:inline text-decoration="underline">
                  <xsl:apply-templates/>
               </fo:inline>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='quoted'">" <xsl:apply-templates/>" </xsl:when>
         <xsl:when test="@render='doublequote'">" <xsl:apply-templates/>" </xsl:when>
         <xsl:when test="@render='bolddoublequote'">
            <fo:inline font-weight="bold">" <xsl:apply-templates/>" </fo:inline>
         </xsl:when>
         <xsl:when test="@render='nonproport'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="@render='singlequote'">' <xsl:apply-templates/>' </xsl:when>
         <xsl:when test="@render='boldsinglequote'">
            <fo:inline font-weight="bold">" <xsl:apply-templates/>' </fo:inline>
         </xsl:when>
         <xsl:when test="@render='sub'">
            <fo:inline font-size="smaller" vertical-align="sub">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='super'">
            <fo:inline font-size="smaller" vertical-align="super">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@render='smcaps'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="@render='boldsmcaps'">
            <fo:inline font-weight="bold">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <!-- ********************* </* @render> *********************** --></xsl:stylesheet>