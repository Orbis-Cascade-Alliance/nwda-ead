<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modifications and Revisions by Mark Carlson, 2004
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="urn:isbn:1-931666-22-9"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"
                exclude-result-prefixes="fo ead"><!-- ********************* <CONTROLACCESS> *********************** --><xsl:template match="*[local-name()='controlaccess']"><!-- P.S. Can't just select index [1] controlaccess because it may not be the group with
		the indexing terms. carlsonm --><fo:block>
         <fo:block font-size="20px" color="#6c34a8" margin-bottom="10px" margin-top="20px">
            <xsl:value-of select="$controlaccess_head"/>
         </fo:block>
         <fo:block><!--<xsl:call-template name="group_subject"/>
				<xsl:if test="descendant::*[@encodinganalog='700'] or descendant::*[@encodinganalog='710']">
					<xsl:call-template name="group_other"/>
				</xsl:if>--><!-- handle controlled access terms in lists that will always contain list items --><xsl:if test="descendant::*[local-name()='subject'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">subject</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='persname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">persname</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='corpname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">corpname</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='famname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">famname</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='name'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">name</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='geogname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">geogname</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='genreform'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">genreform</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='occupation'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">occupation</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='function'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">function</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="descendant::*[local-name()='title'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]">
               <xsl:call-template name="generate-list">
                  <xsl:with-param name="name">title</xsl:with-param>
               </xsl:call-template>
            </xsl:if>
            <!-- handle other names which start 700+ @encodinganalogs --><xsl:if test="descendant::*[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
               <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block font-weight="bold">Other Creators :</fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                           <xsl:if test="descendant::*[local-name()='persname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
                              <xsl:call-template name="generate-list">
                                 <xsl:with-param name="other">true</xsl:with-param>
                                 <xsl:with-param name="name">persname</xsl:with-param>
                              </xsl:call-template>
                           </xsl:if>
                           <xsl:if test="descendant::*[local-name()='corpname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
                              <xsl:call-template name="generate-list">
                                 <xsl:with-param name="other">true</xsl:with-param>
                                 <xsl:with-param name="name">corpname</xsl:with-param>
                              </xsl:call-template>
                           </xsl:if>
                           <xsl:if test="descendant::*[local-name()='famname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
                              <xsl:call-template name="generate-list">
                                 <xsl:with-param name="other">true</xsl:with-param>
                                 <xsl:with-param name="name">famname</xsl:with-param>
                              </xsl:call-template>
                           </xsl:if>
                           <xsl:if test="descendant::*[local-name()='name'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
                              <xsl:call-template name="generate-list">
                                 <xsl:with-param name="other">true</xsl:with-param>
                                 <xsl:with-param name="name">name</xsl:with-param>
                              </xsl:call-template>
                           </xsl:if>
                        </fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
               </fo:list-block>
            </xsl:if>
         </fo:block>
      </fo:block>
   </xsl:template>
   <xsl:template name="generate-list">
      <xsl:param name="name"/>
      <xsl:param name="other"/>
      <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
         <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
               <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
               <fo:block font-weight="bold">
                  <xsl:call-template name="controlaccess_heads">
                     <xsl:with-param name="name">
                        <xsl:value-of select="$name"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:text> : </xsl:text>
               </fo:block>
            </fo:list-item-body>
         </fo:list-item>
         <xsl:choose>
            <xsl:when test="$other='true'">
               <xsl:apply-templates select="descendant::*[local-name()=$name][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog,       '7')]"
                                    mode="controlaccess">
                  <xsl:sort/>
               </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="descendant::*[local-name()=$name][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog,       '7'))]"
                                    mode="controlaccess">
                  <xsl:sort/>
               </xsl:apply-templates>
            </xsl:otherwise>
         </xsl:choose>
      </fo:list-block>
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
            <xsl:when test="child::*[local-name()='controlaccess']">
               <xsl:apply-templates select="*[local-name()='p']"/>
               <xsl:for-each select="*[local-name()='controlaccess'][child::*[not(@audience='internal') and not(@altrender='nodisplay') and string-length(text()|*)!=0]]">
                  <xsl:if test="not(child::*[starts-with(@encodinganalog, '7')])">
                     <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                        <xsl:apply-templates select="*[local-name()='name'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog,          '7'))] |          *[local-name()='persname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog,          '7'))] |          *[local-name()='corpname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog,          '7'))] |          *[local-name()='famname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog,          '7'))] |          *[local-name()='subject'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |          *[local-name()='genreform'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |          *[local-name()='geogname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |          *[local-name()='occupation'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |          *[local-name()='function'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |          *[local-name()='title'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]"
                                             mode="controlaccess">
                           <xsl:sort select="normalize-space(.)"/>
                        </xsl:apply-templates>
                     </fo:list-block>
                  </xsl:if>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                  <xsl:apply-templates select="*[local-name()='name'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))]        |        *[local-name()='persname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        *[local-name()='corpname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        *[local-name()='famname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] |        *[local-name()='subject'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        *[local-name()='genreform'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        *[local-name()='geogname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        *[local-name()='occupation'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        *[local-name()='function'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] |        *[local-name()='title'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]"
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
            <xsl:when test="child::*[local-name()='controlaccess'] and *[local-name()='controlaccess']/*/@encodinganalog='700' or *[local-name()='controlaccess']/*/@encodinganalog='710'">
               <xsl:for-each select="*[local-name()='controlaccess']">
                  <xsl:apply-templates select="*[local-name()='name'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |        *[local-name()='persname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |        *[local-name()='corpname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |        *[local-name()='famname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]"
                                       mode="controlaccess">
                     <xsl:sort select="normalize-space(.)"/>
                  </xsl:apply-templates>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="*[local-name()='name'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |       *[local-name()='persname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |       *[local-name()='corpname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] |       *[local-name()='famname'][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]"
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
      <fo:list-item>
         <fo:list-item-label end-indent="label-end()">
            <fo:block/>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <fo:block>
               <xsl:variable name="facet">
                  <xsl:choose>
                     <xsl:when test="local-name()='subject'">f_subjects</xsl:when>
                     <xsl:when test="local-name()='persname' or local-name()='corpname' or local-name()='famname' or local-name()='name'">f_names</xsl:when>
                     <xsl:when test="local-name()='function'">f_functions</xsl:when>
                     <xsl:when test="local-name()='geogname'">f_places</xsl:when>
                     <xsl:when test="local-name()='genreform'">f_mattypes</xsl:when>
                     <xsl:when test="local-name()='occupation'">f_occupations</xsl:when>
                  </xsl:choose>
               </xsl:variable>
               <xsl:choose>
                  <xsl:when test="string-length($facet) &gt; 0">
                     <fo:basic-link text-decoration="underline" color="#337ab7"
                                    external-destination="{$serverURL}/search/results.aspx?t=i&amp;q=0&amp;{$facet}={translate(normalize-space(.), ' ', '+')}">
                        <xsl:value-of select="normalize-space(.)"/>
                     </fo:basic-link>
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
   </xsl:template>
   <xsl:template name="controlaccess_heads">
      <xsl:param name="name"/>
      <xsl:choose>
         <xsl:when test="$name='corpname'"> Corporate Names </xsl:when>
         <xsl:when test="$name='famname'"> Family Names </xsl:when>
         <xsl:when test="$name='function'"> Functions </xsl:when>
         <xsl:when test="$name='geogname'"> Geographical Names </xsl:when>
         <xsl:when test="$name='genreform'"> Form or Genre Terms </xsl:when>
         <xsl:when test="$name='name'"> Other Names </xsl:when>
         <xsl:when test="$name='occupation'"> Occupations </xsl:when>
         <xsl:when test="$name='persname'"> Personal Names </xsl:when>
         <xsl:when test="$name='subject'"> Subject Terms </xsl:when>
         <xsl:when test="$name='title'"> Titles within the Collection </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>
   <!-- ********************* </CONTROLACCESS HEADINGS> *********************** --><!-- ********************* </CONTROLACCESS> *********************** --></xsl:stylesheet>