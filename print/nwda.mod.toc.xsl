<?xml version="1.0" encoding="UTF-8"?>
<!-- This stylesheet is for generating the table of contents sidebar	
	Edited September 2007 by Ethan Gruber, 
	Rewritten into HTML5/Bootstrap in 2015 by Ethan Gruber --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"
                exclude-result-prefixes="fo"><!-- ********************* <TABLE OF CONTENTS> *********************** --><!-- TOC TEMPLATE - creates Table of Contents --><xsl:template name="toc">
      <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">Table of Contents</fo:block>
      <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
         <xsl:if test="did">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block/>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(bioghist)">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:for-each select="bioghist">
                        <xsl:choose>
                           <xsl:when test="./head/text()='Biographical Note'">
                              <xsl:value-of select="$bioghist_head"/>
                           </xsl:when>
                           <!--SY original code	<xsl:when test="starts-with(@encodinganalog, '545')"> --><!--carlsonm mod 2004-07-09 only use bio head when encodinganalog is 5450 as opposed to 5451 --><xsl:when test="starts-with(@encodinganalog, '5450')">
                              <xsl:value-of select="$bioghist_head"/>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:value-of select="$historical_head"/>
                           </xsl:otherwise>
                        </xsl:choose>
                        <fo:block/>
                     </xsl:for-each>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(odd/*)">
            <xsl:for-each select="odd[not(@audience='internal')]">
               <fo:list-item>
                  <fo:list-item-label end-indent="label-end()">
                     <fo:block/>
                  </fo:list-item-label>
                  <fo:list-item-body start-indent="body-start()">
                     <fo:block>
                        <xsl:choose>
                           <xsl:when test="@type='hist'">
                              <xsl:value-of select="$odd_head_histbck"/>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:value-of select="$odd_label"/>
                           </xsl:otherwise>
                        </xsl:choose>
                     </fo:block>
                  </fo:list-item-body>
               </fo:list-item>
            </xsl:for-each>
         </xsl:if>
         <xsl:if test="string(scopecontent)">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:value-of select="$scopecontent_head"/>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="(string(accessrestrict)) or (string(userestrict)) or (string(altformavail))">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:value-of select="$useinfo_head"/>
                     <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                        <xsl:if test="string(altformavail)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$altformavail_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(accessrestrict)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$accessrestrict_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(userestrict)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$userestrict_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(prefercite)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$prefercite_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                     </fo:list-block>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <!-- ADMINISTRATIVE INFO --><xsl:if test="string(arrangement) or string(custodhist) or string(acqinfo)       or string(processinfo) or string(accruals) or      string(separatedmaterial) or string(originalsloc)     or string(bibliography) or string(otherfindaid) or string(relatedmaterial) or      string(index)">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:text>Administrative Information</xsl:text>
                     <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                        <xsl:if test="string(arrangement)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$arrangement_head"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(custodhist)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$custodhist_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(acqinfo)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$acqinfo_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(accruals)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$accruals_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(processinfo)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$processinfo_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(separatedmaterial)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$separatedmaterial_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(bibliography)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$bibliography_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(otherfindaid)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$otherfindaid_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(relatedmaterial)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$relatedmaterial_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(appraisal)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$appraisal_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(originalsloc)">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <xsl:value-of select="$originalsloc_label"/>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                     </fo:list-block>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(dsc)">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:if test="//c02"/>
                     <xsl:value-of select="$dsc_head"/>
                     <xsl:if test="//dsc[not(@type='in-depth')]">
                        <xsl:call-template name="dsc_links"/>
                     </xsl:if>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(controlaccess/*/subject) or string(controlaccess/subject)">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:value-of select="$controlaccess_head"/>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
      </fo:list-block>
   </xsl:template>
   <xsl:template name="dsc_links"><!-- if there are c02's anywhere in the dsc, then display the c01 headings
			if there are no c02's, all of the c01's are an in-depth type of dsc --><xsl:if test="//c02">
         <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
            <xsl:for-each select="//c01">
               <fo:list-item>
                  <fo:list-item-label end-indent="label-end()">
                     <fo:block/>
                  </fo:list-item-label>
                  <fo:list-item-body start-indent="body-start()">
                     <fo:block>
                        <xsl:attribute name="external-destination">
                           <xsl:choose>
                              <xsl:when test="@id">
                                 <xsl:value-of select="concat('#', @id)"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:value-of select="concat('#', generate-id())"/>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:attribute>
                        <!-- what if no unitititle--><xsl:choose>
                           <xsl:when test="./did/unittitle"><!--<xsl:value-of select="position()"/>.&#160;--><xsl:value-of select="./did/unittitle"/>
                           </xsl:when>
                           <!-- 2004-07-14 carlsonm mod: select unitid no matter encodinganalog if no unittitle --><xsl:when test="./did/unitid/text() and not(./did/unittitle)">
                              <xsl:if test="did/unitid/@type='accession'"> Accession No.  </xsl:if>
                              <xsl:value-of select="./did/unitid"/>
                           </xsl:when>
                           <xsl:otherwise><!--<xsl:value-of select="position()"/>.&#160;-->Subordinate Component # <xsl:value-of select="position()"/>
                           </xsl:otherwise>
                        </xsl:choose>
                        <!-- END what if no unitititle--></fo:block>
                  </fo:list-item-body>
               </fo:list-item>
            </xsl:for-each>
         </fo:list-block>
      </xsl:if>
   </xsl:template>
   <!-- ********************* </TABLE OF CONTENTS> *********************** --></xsl:stylesheet>