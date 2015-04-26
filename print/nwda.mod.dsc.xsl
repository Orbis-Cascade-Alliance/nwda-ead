<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modications and Revisions by Mark Carlson, 2004

and by Ethan Gruber, July/August 2007

Most of this stylesheet was rewritten in July/August 2007 to fix display issues, but more importantly, to 
reduce the post-transformation filesize to be comparable to the size of the XML file.

Changes:

03/01/13    KEF     The "c01//did" template was counting <head /> and <p /> elements as
                    siblings when generating the "ppos" variable, leading to "off-by-one" errors
                    for "Detailed descripton" sidelinks to internal anchors.  I fixed this
                    as noted at the point of change.

01/27/14    KEF     The <extref/> element was being turned into a URL for elements with
                    a path of /ead/archdesc/dsc/c01/c02/did/unitid/extref.  Used a
                    "apply-templates" rather than "value-of" to resolve this.  (Migrated
                    from Utah pilot site XSLT with original note date of 08/18/11.)

--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ead="urn:isbn:1-931666-22-9"
                version="1.0"
                exclude-result-prefixes="ead fo"><!-- Set this variable to the server/folder path that points to the icon image file on your server.  
		This should end with a forward /, e.g. http://myserver.com/images/ --><xsl:variable name="pathToIcon">http://nwda-db.orbiscascade.org/xsl/support/</xsl:variable>
   <!-- Set this variable to the filename of the icon image, e.g. icon.jpg --><xsl:variable name="iconFilename">camicon.gif</xsl:variable>
   <xsl:variable name="lcChars">abcdefghijklmnopqrstuvwxyz</xsl:variable>
   <xsl:variable name="lcCharsHyphen">abcdefghijklmnopqrstuvwxyz-</xsl:variable>
   <xsl:variable name="lcCharsSlash">abcdefghijklmnopqrstuvwxyz/</xsl:variable>
   <xsl:variable name="ucChars">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
   <xsl:variable name="repCode"
                 select="translate(//*[local-name()='eadid']/@mainagencycode,$ucChars,$lcChars)"/>
   <!-- ********************* <DSC> *********************** --><xsl:template name="dsc" match="*[local-name()='dsc']">
      <xsl:if test="@id"/>
      <fo:block font-size="20px" color="#676D38" margin-bottom="10px" margin-top="20px">
         <xsl:value-of select="$dsc_head"/>
      </fo:block>
      <fo:block>
         <xsl:choose><!-- if there are c02's apply normal templates --><xsl:when test="descendant::*[local-name()='c02']">
               <xsl:apply-templates select="*[not(self::*[local-name()='head'])]"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="*[local-name()='p']"/>
               <!-- if there are no c02's then all of the c01s are displayed as rows in a table, like an in-depth finding aid --><fo:table width="100%" table-layout="fixed">
                  <xsl:choose>
                     <xsl:when test="descendant::*[local-name()='did']/*[local-name()='container'][2]">
                        <xsl:choose>
                           <xsl:when test="descendant::*[local-name()='did']/*[local-name()='unitdate']">
                              <fo:table-column column-width="10%"/>
                              <fo:table-column column-width="10%"/>
                              <fo:table-column column-width="60%"/>
                              <fo:table-column column-width="20%"/>
                           </xsl:when>
                           <xsl:otherwise>
                              <fo:table-column column-width="10%"/>
                              <fo:table-column column-width="10%"/>
                              <fo:table-column column-width="80%"/>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:choose>
                           <xsl:when test="descendant::*[local-name()='did']/*[local-name()='unitdate']">
                              <fo:table-column column-width="15%"/>
                              <fo:table-column column-width="65%"/>
                              <fo:table-column column-width="20%"/>
                           </xsl:when>
                           <xsl:otherwise>
                              <fo:table-column column-width="15%"/>
                              <fo:table-column column-width="85%"/>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:call-template name="table_label"/>
                  <xsl:call-template name="indepth"/>
               </fo:table>
            </xsl:otherwise>
         </xsl:choose>
      </fo:block>
   </xsl:template>
   <!-- ********************* </DSC> *********************** --><!-- ********************* <SERIES> *************************** --><xsl:template match="*[local-name()='c01']">
      <xsl:if test="@id"/>
      <xsl:for-each select=" *[@id] | *[local-name()='did']/*[@id]"/>
      <fo:block>
         <xsl:call-template name="dsc_table"/>
         <xsl:if test="//*[local-name()='c02'] or position()=last()"><!--<p class="top">
					<a href="#top" title="Top of finding aid"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				</p>--></xsl:if>
      </fo:block>
   </xsl:template>
   <!-- ********************* </SERIES> *************************** --><!-- ********************* In-Depth DSC Type ********************* --><xsl:template name="indepth">
      <fo:table-body width="100%">
         <xsl:for-each select="*[local-name()='c01']">
            <xsl:if test="*[local-name()='did']/*[local-name()='container']">
               <xsl:call-template name="container_row"/>
            </xsl:if>
            <xsl:variable name="current_pos" select="position()"/>
            <fo:table-row width="100%">
               <xsl:choose>
                  <xsl:when test="parent::node()/descendant::*[local-name()='container']">
                     <xsl:choose>
                        <xsl:when test="not(parent::node()/descendant::*[local-name()='did']/*[local-name()='container'][2])">
                           <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                          border-bottom-style="solid"
                                          padding="8px">
                              <fo:block>
                                 <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]"/>
                              </fo:block>
                           </fo:table-cell>
                           <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                          border-bottom-style="solid"
                                          padding="8px">
                              <fo:block/>
                           </fo:table-cell>
                        </xsl:when>
                        <xsl:otherwise>
                           <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                          border-bottom-style="solid"
                                          padding="8px">
                              <fo:block>
                                 <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]"/>
                              </fo:block>
                           </fo:table-cell>
                           <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                          border-bottom-style="solid"
                                          padding="8px">
                              <fo:block>
                                 <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][2]"/>
                              </fo:block>
                           </fo:table-cell>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise><!-- no table cell --></xsl:otherwise>
               </xsl:choose>
               <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                              border-bottom-style="solid"
                              padding="8px">
                  <fo:block>
                     <xsl:if test="string(*[local-name()='did']/*[local-name()='unitid'])">
                        <xsl:value-of select="*[local-name()='did']/*[local-name()='unitid']"/>
                        <xsl:if test="*[local-name()='did']/*[local-name()='unittitle']">
                           <xsl:text>: </xsl:text>
                        </xsl:if>
                     </xsl:if>
                     <xsl:apply-templates select="*[local-name()='did']/*[local-name()='unittitle']"/>
                     <xsl:if test="($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')      and        string(descendant::*[local-name()='unitdate'])">
                        <xsl:text>, </xsl:text>
                        <xsl:for-each select="*[local-name()='did']/*[local-name()='unitdate']">
                           <xsl:value-of select="."/>
                           <xsl:if test="not(position() = last())">
                              <xsl:text>, </xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                     </xsl:if>
                     <xsl:call-template name="c0x_children"/>
                  </fo:block>
               </fo:table-cell>
               <xsl:if test="not($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')">
                  <xsl:if test="ancestor::*[local-name()='c01']/descendant::*[local-name()='unitdate']">
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block>
                           <xsl:for-each select="*[local-name()='did']/*[local-name()='unitdate']">
                              <xsl:value-of select="."/>
                              <xsl:if test="not(position() = last())">
                                 <xsl:text>, </xsl:text>
                              </xsl:if>
                           </xsl:for-each>
                        </fo:block>
                     </fo:table-cell>
                  </xsl:if>
               </xsl:if>
            </fo:table-row>
         </xsl:for-each>
      </fo:table-body>
   </xsl:template>
   <!-- ********************* ANALYTICOVER/COMBINED DSC TYPE *************************** --><!--columnar dates are the default--><xsl:template name="dsc_table">
      <xsl:variable select="count(../../preceding-sibling::*)+1" name="pppos"/>
      <xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/>
      <xsl:variable select="count(preceding-sibling::*)+1" name="cpos"/>
      <fo:block>
         <xsl:apply-templates select="*[local-name()='did']"/>
      </fo:block>
      <xsl:if test="descendant::*[local-name()='c02']">
         <fo:table width="100%" table-layout="fixed">
            <xsl:choose>
               <xsl:when test="descendant::*[local-name()='did']/*[local-name()='container'][2]">
                  <xsl:choose>
                     <xsl:when test="descendant::*[local-name()='did']/*[local-name()='unitdate']">
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="60%"/>
                        <fo:table-column column-width="20%"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="80%"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when test="descendant::*[local-name()='did']/*[local-name()='unitdate']">
                        <fo:table-column column-width="15%"/>
                        <fo:table-column column-width="65%"/>
                        <fo:table-column column-width="20%"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:table-column column-width="15%"/>
                        <fo:table-column column-width="85%"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
            <!-- calls the labels for the table --><xsl:call-template name="table_label"/>
            <fo:table-body width="100%">
               <xsl:if test="@level='item' or @level='file'">
                  <fo:table-row width="100%">
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block>
                           <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                      text-transform="capitalize">
                              <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]/@type"/>
                           </fo:inline>
                        </fo:block>
                     </fo:table-cell>
                     <xsl:if test="*[local-name()='did']/*[local-name()='container'][2]">
                        <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                       border-bottom-style="solid"
                                       padding="8px">
                           <fo:block>
                              <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                         text-transform="capitalize">
                                 <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][2]/@type"/>
                              </fo:inline>
                           </fo:block>
                        </fo:table-cell>
                     </xsl:if>
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block/>
                     </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row width="100%">
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block>
                           <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]"/>
                        </fo:block>
                     </fo:table-cell>
                     <xsl:if test="*[local-name()='did']/*[local-name()='container'][2]">
                        <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                       border-bottom-style="solid"
                                       padding="8px">
                           <fo:block>
                              <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][2]"/>
                           </fo:block>
                        </fo:table-cell>
                     </xsl:if>
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block/>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <xsl:apply-templates select="*[local-name()='c02']|*[local-name()='c03']|*[local-name()='c04']|*[local-name()='c05']|*[local-name()='c06']|*[local-name()='c07']|*[local-name()='c08']|*[local-name()='c09']|*[local-name()='c10']|*[local-name()='c11']|*[local-name()='c12']"/>
            </fo:table-body>
         </fo:table>
      </xsl:if>
   </xsl:template>
   <!-- ********************* </DSC TABLE> *************************** --><!-- ********************* LABELS FOR TABLE ********************* --><xsl:template name="table_label">
      <fo:table-header>
         <fo:table-row width="100%">
            <xsl:choose>
               <xsl:when test="descendant::*[local-name()='container']">
                  <xsl:choose>
                     <xsl:when test="not(descendant::*[local-name()='did']/*[local-name()='container'][2]) and not(descendant::*[local-name()='did']/*[local-name()='container'][3])">
                        <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                                       border-bottom-style="solid"
                                       padding="8px">
                           <fo:block>
                              <fo:inline font-size="85%" font-weight="bold">Container(s)</fo:inline>
                           </fo:block>
                        </fo:table-cell>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                                       border-bottom-style="solid"
                                       padding="8px">
                           <fo:block>
                              <fo:inline font-size="85%" font-weight="bold">Container(s)</fo:inline>
                           </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                                       border-bottom-style="solid"
                                       padding="8px">
                           <fo:block/>
                        </fo:table-cell>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                                 border-bottom-style="solid"
                                 padding="8px">
                     <fo:block/>
                  </fo:table-cell>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="string(descendant::*[local-name()='unittitle'])">
               <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                              border-bottom-style="solid"
                              padding="8px">
                  <fo:block>
                     <fo:inline font-size="85%" font-weight="bold">Description</fo:inline>
                  </fo:block>
               </fo:table-cell>
            </xsl:if>
            <xsl:if test="not($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')">
               <xsl:if test="string(descendant::*[local-name()='unitdate'])">
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                                 border-bottom-style="solid"
                                 padding="8px">
                     <fo:block>
                        <fo:inline font-size="85%" font-weight="bold">Dates</fo:inline>
                     </fo:block>
                  </fo:table-cell>
               </xsl:if>
            </xsl:if>
         </fo:table-row>
      </fo:table-header>
   </xsl:template>
   <!-- ********************* END LABELS FOR TABLE ************************** --><!-- ********************* START c0xs *************************** --><xsl:template match="*[local-name()='c02']|*[local-name()='c03']|*[local-name()='c04']|*[local-name()='c05']|*[local-name()='c06']|*[local-name()='c07']|*[local-name()='c08']|*[local-name()='c09']|*[local-name()='c10']|*[local-name()='c11']|*[local-name()='c12']"><!-- this determines the number of containers (max of 2) so that when the template is called to display the text in the container
			field, a paramer is passed to display the data of did/container[$container_number].  this has replaced slews of conditionals that 
			nested tables --><xsl:if test="@id"/>
      <!-- ********* ROW FOR DISPLAYING CONTAINER TYPES ********* --><xsl:if test="*[local-name()='did']/*[local-name()='container']">
         <xsl:call-template name="container_row"/>
      </xsl:if>
      <!-- *********** ROW FOR DISPLAYING CONTAINER, CONTENT, AND DATE DATA **************--><!--all c0x level items are their own row; indentation created by css only--><fo:table-row width="100%"><!-- if there is only one container, the td is 170 pixels wide, otherwise 85 for two containers --><xsl:choose>
            <xsl:when test="not(*[local-name()='did']/*[local-name()='container'][2])">
               <xsl:choose><!-- a colspan of 2 is assigned to a c0x that does not have 2 containers if any descendants of its c01 parent
							have 2 containers --><xsl:when test="ancestor-or-self::*[local-name()='c01']/descendant::*[local-name()='did']/*[local-name()='container'][2]">
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px"
                                    number-columns-spanned="2">
                        <fo:block>
                           <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]"/>
                        </fo:block>
                     </fo:table-cell>
                  </xsl:when>
                  <xsl:otherwise>
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block>
                           <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]"/>
                        </fo:block>
                     </fo:table-cell>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:when test="*[local-name()='did']/*[local-name()='container'][2]">
               <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                              border-bottom-style="solid"
                              padding="8px">
                  <fo:block>
                     <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][1]"/>
                  </fo:block>
               </fo:table-cell>
               <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                              border-bottom-style="solid"
                              padding="8px">
                  <fo:block>
                     <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][2]"/>
                  </fo:block>
               </fo:table-cell>
            </xsl:when>
         </xsl:choose>
         <xsl:variable select="count(../../preceding-sibling::*)+1" name="pppos"/>
         <xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/>
         <xsl:variable select="count(preceding-sibling::*)+1" name="cpos"/>
         <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                        border-bottom-style="solid"
                        padding="8px">
            <fo:block>
               <xsl:variable name="indent">
                  <xsl:value-of select="(number(substring-after(local-name(), 'c')) - 2) * 2"/>
               </xsl:variable>
               <xsl:attribute name="padding-left">
                  <xsl:value-of select="concat($indent, 'em')"/>
               </xsl:attribute>
               <fo:block>
                  <xsl:for-each select=" *[@id] | *[local-name()='did']/*[@id]"/>
                  <xsl:if test="*[local-name()='did']/*[local-name()='unittitle']">
                     <xsl:choose><!-- series, subseries, etc are bold --><xsl:when test="(@level='series' or @level='subseries' or @otherlevel='sub-subseries' or @level='otherlevel') and child::node()/*[local-name()='did']">
                           <fo:inline font-weight="bold">
                              <xsl:if test="string(*[local-name()='did']/*[local-name()='unitid'])"><!--
                                         When this was a "value-of", <extref/> elements were
                                         not being turned into URL's.  "apply-templates" makes this
                                         happen, as well as just outputting the value of the <unitid/>
                                         element if it's just text.
                                    --><!-- <xsl:value-of select="did/unitid"/> --><xsl:apply-templates select="*[local-name()='did']/*[local-name()='unitid']"/>
                                 <xsl:text>: </xsl:text>
                              </xsl:if>
                              <xsl:apply-templates select="*[local-name()='did']/*[local-name()='unittitle']"/>
                           </fo:inline>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:if test="string(*[local-name()='did']/*[local-name()='unitid'])">
                              <xsl:value-of select="*[local-name()='did']/*[local-name()='unitid']"/>
                              <xsl:text>: </xsl:text>
                           </xsl:if>
                           <xsl:apply-templates select="*[local-name()='did']/*[local-name()='unittitle']"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:if>
                  <!-- if the layout for the date is inline instead of columnar, address that issue --><xsl:if test="$repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps'">
                     <xsl:for-each select="*[local-name()='did']/*[local-name()='unitdate']"><!-- only insert comma if it comes after a unittitle - on occasion there is a unitdate but no unittitle --><xsl:if test="parent::node()/*[local-name()='unittitle']">
                           <xsl:text>, </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="."/>
                        <!-- place a semicolon between multiple unitdates --><xsl:if test="not(position() = last())">
                           <xsl:text>; </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                  </xsl:if>
                  <xsl:call-template name="c0x_children"/>
               </fo:block>
            </fo:block>
         </fo:table-cell>
         <!-- if the date layout is columnar, then the column is displayed --><xsl:if test="not($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')">
            <xsl:if test="ancestor::*[local-name()='c01']/descendant::*[local-name()='unitdate']">
               <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                              border-bottom-style="solid"
                              padding="8px">
                  <fo:block>
                     <xsl:for-each select="*[local-name()='did']/*[local-name()='unitdate']">
                        <xsl:choose>
                           <xsl:when test="(parent::node()/parent::node()[@level='series'] or parent::node()/parent::node()[@level='subseries']         or          parent::node()/parent::node()[@otherlevel='sub-subseries'] or parent::node()/parent::node()[@level='otherlevel'])">
                              <fo:inline font-weight="bold">
                                 <xsl:value-of select="."/>
                              </fo:inline>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:value-of select="."/>
                           </xsl:otherwise>
                        </xsl:choose>
                        <!-- place a semicolon and a space between dates --><xsl:if test="not(position() = last())">
                           <xsl:text>; </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                  </fo:block>
               </fo:table-cell>
            </xsl:if>
         </xsl:if>
      </fo:table-row>
      <xsl:apply-templates select="*[local-name()='c02']|*[local-name()='c03']|*[local-name()='c04']|*[local-name()='c05']|*[local-name()='c06']|*[local-name()='c07']|*[local-name()='c08']|*[local-name()='c09']|*[local-name()='c10']|*[local-name()='c11']|*[local-name()='c12']"/>
   </xsl:template>
   <!-- APPLY TEMPLATES FOR UNITTITLE --><xsl:template match="*[local-name()='unittitle']">
      <xsl:apply-templates/>
      <xsl:if test="parent::node()/*[local-name()='daogrp']">
         <xsl:apply-templates select="parent::node()/*[local-name()='daogrp']"/>
      </xsl:if>
   </xsl:template>
   <!-- ********************* END c0xs *************************** --><!-- *** CONTAINER ROW ** --><xsl:template name="container_row"><!-- variables are created to grab container type data.
		this logic basically only creates the row and its table cells if there is firstor second container
		data returned from the template call.  this logic cuts back on processing time for the server
		and download time for the user - Ethan Gruber 7/29/07 --><xsl:variable name="first_container">
         <xsl:call-template name="container_type1"/>
      </xsl:variable>
      <xsl:variable name="second_container">
         <xsl:call-template name="container_type">
            <xsl:with-param name="container_number" select="2"/>
         </xsl:call-template>
      </xsl:variable>
      <!-- if none of the container variables contains any data, the row will not be created --><xsl:if test="string($first_container) or string($second_container)">
         <fo:table-row width="100%">
            <xsl:choose><!-- for two containers --><xsl:when test="*[local-name()='did']/*[local-name()='container'][2]">
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                 border-bottom-style="solid"
                                 padding="8px">
                     <fo:block>
                        <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                   text-transform="capitalize">
                           <xsl:value-of select="$first_container"/>
                        </fo:inline>
                     </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                 border-bottom-style="solid"
                                 padding="8px">
                     <fo:block>
                        <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                   text-transform="capitalize">
                           <xsl:value-of select="$second_container"/>
                        </fo:inline>
                     </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                 border-bottom-style="solid"
                                 padding="8px">
                     <fo:block/>
                  </fo:table-cell>
                  <xsl:if test="ancestor::*[local-name()='c01']/descendant::*[local-name()='unitdate']">
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block/>
                     </fo:table-cell>
                  </xsl:if>
               </xsl:when>
               <!-- for one container --><xsl:otherwise>
                  <xsl:variable name="container_colspan">
                     <xsl:choose>
                        <xsl:when test="/*[local-name()='ead']/*[local-name()='dsc'][@type='in-depth'] |          /*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='dsc'][@type='in-depth']">
                           <xsl:choose>
                              <xsl:when test="ancestor-or-self::*[local-name()='dsc']/descendant::*[local-name()='did']/*[local-name()='container'][2]">2</xsl:when>
                              <xsl:otherwise>1</xsl:otherwise>
                           </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:choose>
                              <xsl:when test="ancestor-or-self::*[local-name()='c01']/descendant::*[local-name()='did']/*[local-name()='container'][2]">2</xsl:when>
                              <xsl:otherwise>1</xsl:otherwise>
                           </xsl:choose>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:variable>
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                 border-bottom-style="solid"
                                 padding="8px"
                                 number-columns-spanned="{$container_colspan}">
                     <fo:block>
                        <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                   text-transform="capitalize">
                           <xsl:value-of select="$first_container"/>
                        </fo:inline>
                     </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                 border-bottom-style="solid"
                                 padding="8px">
                     <fo:block/>
                  </fo:table-cell>
                  <xsl:if test="ancestor::*[local-name()='c01']/descendant::*[local-name()='unitdate']">
                     <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                                    border-bottom-style="solid"
                                    padding="8px">
                        <fo:block/>
                     </fo:table-cell>
                  </xsl:if>
               </xsl:otherwise>
            </xsl:choose>
         </fo:table-row>
      </xsl:if>
   </xsl:template>
   <!-- ******************** DISPLAYS TYPE OF CONTAINER ****************** --><xsl:template name="container_type1">
      <xsl:variable name="current_val">
         <xsl:value-of select="*[local-name()='did']/*[local-name()='container']/@type"/>
      </xsl:variable>
      <xsl:variable name="last_val">
         <xsl:if test="$current_val">
            <xsl:value-of select="preceding-sibling::node()/*[local-name()='did']/*[local-name()='container']/@type"/>
         </xsl:if>
      </xsl:variable>
      <!-- if the last value is not equal to the first value, then the regularize_container template is called.  --><xsl:if test="$last_val != $current_val">
         <xsl:call-template name="regularize_container">
            <xsl:with-param name="current_val">
               <xsl:value-of select="$current_val"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   <xsl:template name="container_type">
      <xsl:param name="container_number"/>
      <xsl:variable name="current_val">
         <xsl:value-of select="*[local-name()='did']/*[local-name()='container'][$container_number]/@type"/>
      </xsl:variable>
      <xsl:variable name="last_val">
         <xsl:if test="$current_val">
            <xsl:value-of select="preceding-sibling::node()/*[local-name()='did']/*[local-name()='container'][$container_number]/@type"/>
         </xsl:if>
      </xsl:variable>
      <!-- if the last value is not equal to the first value, then the regularize_container template is called.  --><xsl:if test="$last_val != $current_val">
         <xsl:call-template name="regularize_container">
            <xsl:with-param name="current_val">
               <xsl:value-of select="$current_val"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   <!-- ******************** END TYPE OF CONTAINER ****************** --><!-- ******************** CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** --><xsl:template name="regularize_container"><!-- this is for converting container/@type to a regularized phrase.  The list can be expanded as needed.  The otherwise
			statement outputs the @type if no matches are found (it is capitalized by the CSS file) --><xsl:param name="current_val"/>
      <xsl:choose>
         <xsl:when test="$current_val = 'box'">
            <xsl:text>Box</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'folder'">
            <xsl:text>Folder</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'box-folder'">
            <xsl:text>Box/Folder</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'volume'">
            <xsl:text>Volume</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'microfilm-reel' or $current_val = 'microfilm'">
            <xsl:text>Microfilm Reel</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'microfiche'">
            <xsl:text>Microfiche</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'oversize-folder'">
            <xsl:text>Oversize Folder</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'audiocassette'">
            <xsl:text>Cassette</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'audiocassette-side'">
            <xsl:text>Cassette/Side</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'counter' or $current_val = 'counternumber'">
            <xsl:text>Cassette Counter</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'accession'">
            <xsl:text>Accession No.</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'carton'">
            <xsl:text>Carton</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'reel'">
            <xsl:text>Reel</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'frame'">
            <xsl:text>Frame</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'oversize'">
            <xsl:text>Oversize</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'reel-frame'">
            <xsl:text>Reel/Frame</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'album'">
            <xsl:text>Album</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'page'">
            <xsl:text>Page</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'map-case'">
            <xsl:text>Map Case</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'folio'">
            <xsl:text>Folio</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'verticalfile'">
            <xsl:text>Vertical File</xsl:text>
         </xsl:when>
         <xsl:when test="$current_val = 'rolled-document'">
            <xsl:text>Rolled Document</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$current_val"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!-- ******************** END CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** --><xsl:template name="c0x_children"><!-- for displaying extent, physloc, etc.  this is brought over from the original mod.dsc --><!-- added note in addition to did/note for item 2F on revision specifications--><xsl:if test="string(*[local-name()='did']/*[local-name()='origination'] | *[local-name()='did']/*[local-name()='physdesc'] | *[local-name()='did']/*[local-name()='physloc'] |    *[local-name()='did']/*[local-name()='note'] | *[local-name()='arrangement'] | *[local-name()='odd']| *[local-name()='scopecontent'] | *[local-name()='acqinfo'] |    *[local-name()='custodhist'] | *[local-name()='processinfo'] | *[local-name()='note'] | *[local-name()='bioghist'] | *[local-name()='accessrestrict'] |    *[local-name()='userestrict'] |    *[local-name()='index'] | *[local-name()='altformavail'])">
         <xsl:for-each select="*[local-name()='did']">
            <xsl:for-each select="*[local-name()='origination'] | *[local-name()='physdesc'] | *[local-name()='physloc'] | *[local-name()='note']">
               <xsl:choose>
                  <xsl:when test="self::*[local-name()='physdesc']">
                     <fo:block>
                        <xsl:apply-templates select="*[local-name()='extent'][1]"/>
                        <!-- multiple extents contained in parantheses --><xsl:if test="string(*[local-name()='extent'][2])">
                           <xsl:text/>
                           <xsl:for-each select="*[local-name()='extent'][position() &gt; 1]">
                              <xsl:text>(</xsl:text>
                              <xsl:value-of select="."/>
                              <xsl:text>)</xsl:text>
                              <xsl:if test="not(position() = last())">
                                 <xsl:text/>
                              </xsl:if>
                           </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='physfacet']) and string(*[local-name()='extent'])">
                           <xsl:text> : </xsl:text>
                        </xsl:if>
                        <xsl:for-each select="*[local-name()='physfacet']">
                           <xsl:apply-templates select="."/>
                           <xsl:if test="not(position() = last())">
                              <xsl:text>; </xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                        <xsl:if test="string(*[local-name()='dimensions']) and string(*[local-name()='physfacet'])">
                           <xsl:text>;</xsl:text>
                        </xsl:if>
                        <xsl:for-each select="*[local-name()='dimensions']">
                           <xsl:apply-templates select="."/>
                           <xsl:if test="not(position() = last())">
                              <xsl:text>; </xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                        <!-- if genreform exists, insert a line break and then display genreforms separated by semicolons --><xsl:if test="*[local-name()='genreform']">
                           <fo:block/>
                        </xsl:if>
                        <xsl:for-each select="*[local-name()='genreform']">
                           <xsl:apply-templates select="."/>
                           <xsl:if test="not(position() = last())">
                              <xsl:text>.  </xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                     </fo:block>
                  </xsl:when>
                  <xsl:otherwise>
                     <fo:block>
                        <xsl:apply-templates/>
                        <xsl:if test="self::*[local-name()='origination'] and child::*/@role"> (<xsl:value-of select="child::*/@role"/>) </xsl:if>
                     </fo:block>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:for-each select="*[local-name()='arrangement'] | *[local-name()='odd'] | *[local-name()='acqinfo'] | *[local-name()='accruals'] | *[local-name()='custodhist'] |     *[local-name()='processinfo'] | *[local-name()='separatedmaterial'] | *[local-name()='scopecontent'] | *[local-name()='note'] | *[local-name()='origination'] |     *[local-name()='physdesc'] | *[local-name()='physloc'] | *[local-name()='bioghist'] |     *[local-name()='accessrestrict'] | *[local-name()='userestrict'] |     *[local-name()='altformavail']">
            <fo:block>
               <xsl:apply-templates/>
            </fo:block>
         </xsl:for-each>
         <xsl:if test="*[local-name()='index']">
            <xsl:apply-templates select="*[local-name()='index']"/>
         </xsl:if>
      </xsl:if>
   </xsl:template>
   <!-- kept from original mod.dsc --><xsl:template match="*[local-name()='c01']//*[local-name()='did']"><!-- c01 only --><xsl:choose><!-- original SY code
				<xsl:when test="parent::c01 or parent::*[@level='subseries']">
			--><xsl:when test="parent::*[local-name()='c01'] and //*[local-name()='c02']">
            <xsl:if test="count(parent::*[local-name()='c01']/preceding-sibling::*[local-name()='c01'])!='0'"/>
            <!-- 
                     KEF:  Line below was introducing "off-by-one" problems.  Replaced it
                     with explicit check for c01 siblings. 
                --><!-- <xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/> --><xsl:variable select="count(../preceding-sibling::*[local-name()='c01'])+1" name="ppos"/>
            <fo:block font-size="14px" color="#6b6b6b" margin-bottom="10px" margin-top="10px"><!-- what if no unitititle--><xsl:choose>
                  <xsl:when test="./*[local-name()='unittitle']">
                     <xsl:if test="string(*[local-name()='unitid'])">
                        <xsl:if test="*[local-name()='unitid']/@label">
                           <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                      text-transform="capitalize">
                              <xsl:value-of select="*[local-name()='unitid']/@label"/>
                              <xsl:text> </xsl:text>
                              <xsl:if test="*[local-name()='unitid']/@type='counter' or *[local-name()='unitid']/@type='counternumber'"> Cassette Counter  </xsl:if>
                           </fo:inline>
                        </xsl:if>
                        <xsl:if test="$repCode='wau-ar' and *[local-name()='unitid'][@type='accession']"> Accession No.  </xsl:if>
                        <xsl:value-of select="*[local-name()='unitid']"/>: <xsl:text> </xsl:text>
                     </xsl:if>
                     <xsl:apply-templates select="*[local-name()='unittitle']"/>
                     <xsl:if test="string(*[local-name()='unitdate']) and string(*[local-name()='unittitle'])">, </xsl:if>
                     <xsl:if test="string(*[local-name()='unitdate'])">
                        <xsl:for-each select="*[local-name()='unitdate']">
                           <xsl:choose>
                              <xsl:when test="@type='bulk'">  (bulk <xsl:apply-templates/>) </xsl:when>
                              <xsl:otherwise>
                                 <xsl:apply-templates/>
                                 <xsl:if test="not(position()=last())">, </xsl:if>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:for-each>
                     </xsl:if>
                  </xsl:when>
                  <!-- SY Original Code
							<xsl:when test="./unitid[@encodinganalog='245$a']/text() and not(./unittitle)">
						--><xsl:when test="./*[local-name()='unitid']/text() and not(./*[local-name()='unittitle'])">
                     <xsl:if test="*[local-name()='unitid']/@label">
                        <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                   text-transform="capitalize">
                           <xsl:value-of select="*[local-name()='unitid']/@label"/>
                           <xsl:text> </xsl:text>
                           <xsl:if test="*[local-name()='unitid']/@type='counter' or *[local-name()='unitid']/@type='counternumber'"> Cassette Counter  </xsl:if>
                        </fo:inline>
                     </xsl:if>
                     <xsl:if test="$repCode='wau-ar' and *[local-name()='unitid'][@type='accession']"><!--  and ../c01[@otherlevel='accession'] --> Accession No.  </xsl:if>
                     <xsl:value-of select="*[local-name()='unitid']"/>
                  </xsl:when>
                  <xsl:when test="./*[local-name()='unitdate']/text() and not(./*[local-name()='unittitle'])">
                     <xsl:value-of select="./*[local-name()='unitdate']"/>
                  </xsl:when>
                  <xsl:otherwise>Subordinate Component # <xsl:value-of select="count(parent::*[local-name()='c01']/preceding-sibling::*[local-name()='c01'])+1"/>
                  </xsl:otherwise>
               </xsl:choose>
               <!-- END what if no unitititle--></fo:block>
            <!-- March 2015: Adding container display as per revision specification 7.1.2 --><xsl:if test="count(*[local-name()='container']) &gt; 0">
               <fo:block margin-bottom="10px">
                  <strong>Container(s): </strong>
                  <xsl:apply-templates select="*[local-name()='container']" mode="c01"/>
               </fo:block>
            </xsl:if>
         </xsl:when>
         <xsl:when test="$repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps'"><!-- 2004-09-26 carlsonm mod to add display for <unitid> --><!-- Tracking # 4.10 Collins Land Company display --><xsl:if test="string(*[local-name()='unitid'])">
               <xsl:if test="*[local-name()='unitid']/@label">
                  <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                             text-transform="capitalize">
                     <xsl:value-of select="*[local-name()='unitid']/@label"/>
                     <xsl:text> </xsl:text>
                  </fo:inline>
               </xsl:if>
               <xsl:if test="*[local-name()='unitid']/@type='counter' or *[local-name()='unitid']/@type='counternumber'"> Cassette Counter  </xsl:if>
               <xsl:apply-templates select="*[local-name()='unitid']"/>: <xsl:text>  </xsl:text>
            </xsl:if>
            <xsl:apply-templates select="*[local-name()='unittitle']"/>
            <!-- carlsonm 2004-09-26 not sure what the original intent was for this.  The <unitdate> element is not displaying in UMt Great Falls Breweries, Tracking #4.80 --><!--
					<xsl:if test="unittitle and unitdate and not(parent::c01)">,&#160;</xsl:if>
					
					<xsl:if test="not(parent::c01)">
					
					carlsonm mod 2004-09-26 adding comma before date OBSOLETE, REVISED
					<xsl:if test="string(unitdate) and string(unittitle)">,&#160;</xsl:if>
					
					<xsl:apply-templates select="./unitdate"/>
					
					</xsl:if>
				--><!-- 2004-10-02 new mod for date so that empty elements will be ignored --><xsl:if test="string(*[local-name()='unitdate']) and string(*[local-name()='unittitle'])">, </xsl:if>
            <xsl:if test="string(*[local-name()='unitdate'])">
               <xsl:for-each select="*[local-name()='unitdate']">
                  <xsl:choose>
                     <xsl:when test="@type='bulk'">  (bulk <xsl:apply-templates/>) </xsl:when>
                     <xsl:otherwise>
                        <xsl:apply-templates/>
                        <xsl:if test="not(position()=last())">, </xsl:if>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:for-each>
            </xsl:if>
            <!-- March 2015: Adding container display as per revision specification 7.1.2 --><xsl:if test="count(*[local-name()='container']) &gt; 0">
               <fo:block margin-bottom="10px">
                  <strong>Container(s): </strong>
                  <xsl:apply-templates select="*[local-name()='container']" mode="c01"/>
               </fo:block>
            </xsl:if>
         </xsl:when>
         <!-- carlsonm This is where the unittitle info is output when it is a c01 list only --><xsl:otherwise>
            <xsl:if test="*[local-name()='unittitle']/@label">
               <xsl:value-of select="*[local-name()='unittitle']/@label"/>  </xsl:if>
            <!-- what if no unitititle--><xsl:choose>
               <xsl:when test="./*[local-name()='unittitle']">
                  <xsl:if test="string(*[local-name()='unitid'])">
                     <xsl:if test="*[local-name()='unitid']/@label">
                        <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                   text-transform="capitalize">
                           <xsl:value-of select="*[local-name()='unitid']/@label"/>
                           <xsl:text> </xsl:text>
                        </fo:inline>
                     </xsl:if>
                     <xsl:if test="*[local-name()='unitid']/@type='counter' or *[local-name()='unitid']/@type='counternumber'"> Cassette Counter  </xsl:if>
                     <xsl:value-of select="*[local-name()='unitid']"/>: <xsl:text>  </xsl:text>
                  </xsl:if>
                  <xsl:apply-templates select="./*[local-name()='unittitle']"/>
                  <xsl:apply-templates select="*[local-name()='daogrp']"/>
                  <!-- carlsonm add --><!--
							<xsl:if test="./unitdate">,&#160;<xsl:value-of select="./unitdate"/>
							</xsl:if>
						--><!-- end add --></xsl:when>
               <xsl:when test="./*[local-name()='unitid']/text() and not(./*[local-name()='unittitle'])">
                  <xsl:if test="*[local-name()='unitid']/@label">
                     <fo:inline color="#676d38" font-size="85%" text-decoration="none"
                                text-transform="capitalize">
                        <xsl:value-of select="*[local-name()='unitid']/@label"/>
                        <xsl:text> </xsl:text>
                     </fo:inline>
                  </xsl:if>
                  <xsl:if test="*[local-name()='unitid']/@type='counter' or *[local-name()='unitid']/@type='counternumber'"> Cassette Counter  </xsl:if>
                  <xsl:value-of select="*[local-name()='unitid']"/>
               </xsl:when>
               <xsl:when test="./*[local-name()='unitdate']/text() and not(./*[local-name()='unittitle'])">
                  <xsl:value-of select="./*[local-name()='unitdate']"/>
               </xsl:when>
               <!-- carlsonm 2004-07-15 the following test governs whether a second unittitle should display when there is only a single c01 --><!-- commented out, it doesn't display --><!-- SY original code
						<xsl:when test="./unitid[@encodinganalog='245$a']/text() and not(./unittitle)">
						<xsl:value-of select="./unitid"/>
						</xsl:when>
					--><xsl:otherwise>Subordinate Component</xsl:otherwise>
            </xsl:choose>
            <!-- END what if no unitititle--><!-- March 2015: Adding container display as per revision specification 7.1.2 --><xsl:if test="count(*[local-name()='container']) &gt; 0">
               <fo:block margin-bottom="10px">
                  <strong>Container(s): </strong>
                  <xsl:apply-templates select="*[local-name()='container']" mode="c01"/>
               </fo:block>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
      <!--non-unittitle,unitdate,unitid descriptive information--><!-- This now only processes the following elements within <c01>.  The context at this
			point is <c01><did>.  Lower components are processed in a separate section --><xsl:if test="string(*[local-name()='acqinfo'] | *[local-name()='accruals'] | *[local-name()='custodhist'] | *[local-name()='processinfo'] | *[local-name()='separatedmaterial'] |    *[local-name()='physdesc'] | *[local-name()='physloc'] | *[local-name()='origination'] | *[local-name()='note'] | following-sibling::*[local-name()='odd'] |    following-sibling::*[local-name()='scopecontent'] |    following-sibling::*[local-name()='arrangement'] | following-sibling::*[local-name()='bioghist']  |    following-sibling::*[local-name()='accessrestrict']  | following-sibling::*[local-name()='userestrict']  | following-sibling::*[local-name()='note']) and parent::*[local-name()='c01']">
         <xsl:for-each select="*[local-name()='acqinfo'] | *[local-name()='accruals'] | *[local-name()='custodhist'] | *[local-name()='processinfo'] | *[local-name()='separatedmaterial'] |     *[local-name()='physdesc'] | *[local-name()='physloc'] | *[local-name()='origination'] | *[local-name()='note'] | following-sibling::*[local-name()='odd'] |     following-sibling::*[local-name()='scopecontent']     | following-sibling::*[local-name()='arrangement'] | following-sibling::*[local-name()='bioghist']  |     following-sibling::*[local-name()='accessrestrict']  | following-sibling::*[local-name()='userestrict']  | following-sibling::*[local-name()='note']">
            <xsl:call-template name="archdesc_minor_children">
               <xsl:with-param name="withLabel">false</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <!-- 2004-12-02 carlsonm: This inserts a blank line when there are c02 + 
					See UMt McGowan Commercial Company, first <c01> as an example
				--><!--
					<xsl:if test="string(descendant::c02)">
					<br/>
					</xsl:if>
				--></xsl:if>
   </xsl:template>
   <xsl:template match="*[local-name()='daogrp']">
      <xsl:choose><!-- First, check whether we are dealing with one or two <arc> elements --><xsl:when test="*[local-name()='arc'][2]">
            <xsl:if test="*[local-name()='arc'][2]/@show='new'"/>
            <xsl:for-each select="*[local-name()='daoloc']"><!-- This selects the <daoloc> element that matches the @label attribute from <daoloc> and the @to attribute
							from the second <arc> element --><xsl:if test="@label = following::*[local-name()='arc'][2]/@to">
                  <xsl:attribute name="external-destination">
                     <xsl:value-of select="@href"/>
                  </xsl:attribute>
               </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="*[local-name()='daoloc']">
               <xsl:if test="@label = following::*[local-name()='arc'][1]/@to">
                  <fo:external-graphic src="{@href}"/>
                  <xsl:if test="string(*[local-name()='daodesc'])">
                     <fo:block/>
                     <fo:inline>
                        <xsl:apply-templates/>
                     </fo:inline>
                  </xsl:if>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
         <!-- i.e. no second <arc> element --><xsl:otherwise>
            <xsl:choose>
               <xsl:when test="*[local-name()='arc'][1][@show='embed'] and *[local-name()='arc'][1][@actuate='onload']">
                  <xsl:for-each select="*[local-name()='daoloc']">
                     <xsl:if test="@label = following-sibling::*[local-name()='arc'][1]/@to">
                        <fo:external-graphic src="{@href}"/>
                        <xsl:if test="string(*[local-name()='daodesc'])">
                           <fo:block/>
                           <fo:inline>
                              <xsl:apply-templates/>
                           </fo:inline>
                        </xsl:if>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:when>
               <xsl:when test="(*[local-name()='arc'][1][@show='replace'] or *[local-name()='arc'][1][@show='new']) and *[local-name()='arc'][1][@actuate='onrequest']">
                  <xsl:choose><!-- when a textual hyperlink is desired, i.e. <resource> element contains data --><xsl:when test="string(*[local-name()='resource'])">
                        <xsl:for-each select="*[local-name()='daoloc']">
                           <xsl:if test="@label = following::*[local-name()='arc'][1]/@to">
                              <xsl:attribute name="external-destination">
                                 <xsl:value-of select="@href"/>
                              </xsl:attribute>
                              <xsl:if test="following::*[local-name()='arc'][1]/@show='new'"/>
                           </xsl:if>
                        </xsl:for-each>
                        <xsl:apply-templates/>
                     </xsl:when>
                     <xsl:otherwise><!-- if <resource> element is empty, produce an icon that can be used to traverse the link --><xsl:for-each select="*[local-name()='daoloc']">
                           <xsl:if test="@label = following::*[local-name()='arc'][1]/@to">
                              <xsl:attribute name="external-destination">
                                 <xsl:value-of select="@href"/>
                              </xsl:attribute>
                              <xsl:if test="following::*[local-name()='arc'][1]/@show='new'"/>
                           </xsl:if>
                           <fo:external-graphic src="{$pathToIcon}{$iconFilename}"/>
                        </xsl:for-each>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>