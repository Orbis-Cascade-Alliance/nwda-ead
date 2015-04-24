<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modifications and Revisions by Mark Carlson, 2004
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"><!-- ********************* <CONTROLACCESS> *********************** --><xsl:template match="controlaccess"><!-- P.S. Can't just select index [1] controlaccess because it may not be the group with
		the indexing terms. carlsonm --><fo:block>
         <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
            <xsl:value-of select="$controlaccess_head"/>
         </fo:block>
         <fo:block>
            <xsl:call-template name="group_subject"/>
            <xsl:if test="descendant::*[@encodinganalog='700'] or descendant::*[@encodinganalog='710']">
               <xsl:call-template name="group_other"/>
            </xsl:if>
         </fo:block>
         <!--<p class="top">
				<a href="#top" title="Top of finding aid"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
			</p>--></fo:block>
   </xsl:template>
   <xsl:template name="group_subject"><!-- The following test checks for any <controlaccess> elements that have child elements
not encoded altrender="nodisplay".  This test is necessary because sometimes
the NWDA browse terms that are suppressed are encoded within a single <controlaccess>
element and sometimes in a separate <controlaccess> element: see William H. Carlson
papers and John Ainsworth papers. The style sheet expects one of three scenarios:
1) a single <controlaccess> element with controlaccess elements and NWDA browse terms 
within that single element. (single list display)
2) a single <controlaccess> element with nested <controlaccess> elements (i.e. grouped display)
3) two <controlaccess> elements, one as either a single list or nested <controlaccess> elements and a separate <controlaccess> element that contains the NWDA browse terms
Other FA's to check: James F. Bishop (OSU Archives)
--><!-- This excludes any separate group <controlaccess> for NWDA browse terms --><xsl:if test="position()=1"/>
      <xsl:if test="descendant::*[not(@altrender='nodisplay')]"><!-- i.e. we don't want to print a "Subject" heading if there are more
<controlaccess> elements that need to be selected --><xsl:choose>
            <xsl:when test="child::controlaccess">
               <xsl:if test="child::p">
                  <xsl:apply-templates select="p"/>
               </xsl:if>
               <xsl:for-each select="controlaccess[child::*[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]]">
                  <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                     <xsl:apply-templates select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |         persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |         corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |         famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |         subject[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |         genreform[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |         geogname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |         occupation[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |         function[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |         title[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]"
                                          mode="controlaccess">
                        <xsl:sort select="normalize-space(.)"/>
                     </xsl:apply-templates>
                  </fo:list-block>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                  <xsl:apply-templates select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        subject[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        genreform[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        geogname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        occupation[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        function[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        title[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]"
                                       mode="controlaccess">
                     <xsl:sort select="normalize-space(.)"/>
                  </xsl:apply-templates>
               </fo:list-block>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template name="group_other">
      <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
         <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
               <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
               <fo:block font-weight="bold">Other Creators :</fo:block>
            </fo:list-item-body>
         </fo:list-item>
         <xsl:choose>
            <xsl:when test="child::controlaccess and controlaccess/*/@encodinganalog='700' or controlaccess/*/@encodinganalog='710'">
               <xsl:for-each select="controlaccess">
                  <xsl:apply-templates select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |        persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |        corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |        famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]"
                                       mode="controlaccess">
                     <xsl:sort select="normalize-space(.)"/>
                  </xsl:apply-templates>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |       persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |       corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |       famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]"
                                    mode="controlaccess">
                  <xsl:sort select="normalize-space(.)"/>
               </xsl:apply-templates>
            </xsl:otherwise>
         </xsl:choose>
      </fo:list-block>
      <!--
</xsl:if>
--></xsl:template>
   <xsl:template match="*" mode="controlaccess">
      <xsl:if test="position()=1">
         <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
               <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
               <fo:block font-weight="bold">
                  <xsl:call-template name="controlaccess_heads"/> : </fo:block>
            </fo:list-item-body>
         </fo:list-item>
      </xsl:if>
      <fo:list-item>
         <fo:list-item-label end-indent="label-end()">
            <fo:block/>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <fo:block>
               <xsl:variable name="facet">
                  <xsl:choose>
                     <xsl:when test="self::subject">f_subjects</xsl:when>
                     <xsl:when test="self::persname or self::corpname or self::famname or self::name">f_names</xsl:when>
                     <xsl:when test="self::function">f_functions</xsl:when>
                     <xsl:when test="self::geogname">f_places</xsl:when>
                     <xsl:when test="self::genreform">f_mattypes</xsl:when>
                     <xsl:when test="self::occupation">f_occupations</xsl:when>
                  </xsl:choose>
               </xsl:variable>
               <xsl:choose>
                  <xsl:when test="string-length($facet) &gt; 0">
                     <xsl:value-of select="."/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="."/>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:if test="@role and not(@role='subject')">
                  <xsl:text> (</xsl:text>
                  <xsl:value-of select="@role"/>
                  <xsl:text>)</xsl:text>
               </xsl:if>
            </fo:block>
         </fo:list-item-body>
      </fo:list-item>
      <!----></xsl:template>
   <xsl:template name="controlaccess_heads">
      <xsl:choose>
         <xsl:when test="self::corpname"> Corporate Names </xsl:when>
         <xsl:when test="self::famname"> Family Names </xsl:when>
         <xsl:when test="self::function"> Functions </xsl:when>
         <xsl:when test="self::geogname"> Geographical Names </xsl:when>
         <xsl:when test="self::genreform"> Form or Genre Terms </xsl:when>
         <xsl:when test="self::name"> Other Names </xsl:when>
         <xsl:when test="self::occupation"> Occupations </xsl:when>
         <xsl:when test="self::persname"> Personal Names </xsl:when>
         <xsl:when test="self::subject"> Subject Terms </xsl:when>
         <xsl:when test="self::title"> Titles within the Collection </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>
   <!-- ********************* </CONTROLACCESS HEADINGS> *********************** --><!-- ********************* </CONTROLACCESS> *********************** --></xsl:stylesheet>