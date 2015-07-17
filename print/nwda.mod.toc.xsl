<?xml version="1.0" encoding="UTF-8"?>
<!-- This stylesheet is for generating the table of contents sidebar	
	Edited September 2007 by Ethan Gruber, 
	Rewritten into HTML5/Bootstrap in 2015 by Ethan Gruber --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ead="urn:isbn:1-931666-22-9"
                version="1.0"
                exclude-result-prefixes="fo ead"><!-- ********************* <TABLE OF CONTENTS> *********************** --><!-- TOC TEMPLATE - creates Table of Contents --><xsl:template name="toc">
      <fo:block font-size="20px" color="#6c34a8" margin-bottom="10px" margin-top="20px">Table of Contents</fo:block>
      <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
         <xsl:if test="*[local-name()='did']">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="#overview">
                        <xsl:value-of select="$overview_head"/>
                     </fo:basic-link>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(*[local-name()='bioghist'])">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:for-each select="*[local-name()='bioghist']">
                        <xsl:choose>
                           <xsl:when test="./*[local-name()='head']/text()='Biographical Note'">
                              <fo:basic-link text-decoration="underline" color="#337ab7"
                                             external-destination="#{$bioghist_id}">
                                 <xsl:value-of select="$bioghist_head"/>
                              </fo:basic-link>
                           </xsl:when>
                           <!--SY original code	<xsl:when test="starts-with(@encodinganalog, '545')"> --><!--carlsonm mod 2004-07-09 only use bio head when encodinganalog is 5450 as opposed to 5451 --><xsl:when test="starts-with(@encodinganalog, '5450')">
                              <fo:basic-link text-decoration="underline" color="#337ab7"
                                             external-destination="#{$bioghist_id}">
                                 <xsl:value-of select="$bioghist_head"/>
                              </fo:basic-link>
                           </xsl:when>
                           <xsl:otherwise>
                              <fo:basic-link text-decoration="underline" color="#337ab7"
                                             external-destination="#{$historical_id}">
                                 <xsl:value-of select="$historical_head"/>
                              </fo:basic-link>
                           </xsl:otherwise>
                        </xsl:choose>
                        <fo:block/>
                     </xsl:for-each>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(*[local-name()='odd']/*)">
            <xsl:for-each select="*[local-name()='odd'][not(@audience='internal')]">
               <fo:list-item>
                  <fo:list-item-label end-indent="label-end()">
                     <fo:block/>
                  </fo:list-item-label>
                  <fo:list-item-body start-indent="body-start()">
                     <fo:block>
                        <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="#{$odd_id}">
                           <xsl:choose>
                              <xsl:when test="@type='hist'">
                                 <xsl:value-of select="$odd_head_histbck"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:value-of select="$odd_label"/>
                              </xsl:otherwise>
                           </xsl:choose>
                        </fo:basic-link>
                     </fo:block>
                  </fo:list-item-body>
               </fo:list-item>
            </xsl:for-each>
         </xsl:if>
         <xsl:if test="string(*[local-name()='scopecontent'])">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <fo:basic-link text-decoration="underline" color="#337ab7"
                                    external-destination="#{$scopecontent_id}">
                        <xsl:value-of select="$scopecontent_head"/>
                     </fo:basic-link>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="(string(*[local-name()='userestrict'])) or (string(*[local-name()='altformavail']))">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="#"/>
                     <fo:basic-link text-decoration="underline" color="#337ab7"
                                    external-destination="#{$useinfo_id}">
                        <xsl:value-of select="$useinfo_head"/>
                     </fo:basic-link>
                     <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                        <xsl:if test="string(*[local-name()='altformavail'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$altformavail_id}">
                                       <xsl:value-of select="$altformavail_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='userestrict'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$userestrict_id}">
                                       <xsl:value-of select="$userestrict_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='prefercite'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$prefercite_id}">
                                       <xsl:value-of select="$prefercite_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                     </fo:list-block>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <!-- ADMINISTRATIVE INFO --><xsl:if test="string(*[local-name()='arrangement']) or string(*[local-name()='custodhist']) or string(*[local-name()='acqinfo'])       or string(*[local-name()='processinfo']) or     string(*[local-name()='accruals']) or      string(*[local-name()='separatedmaterial']) or string(*[local-name()='originalsloc'])     or string(*[local-name()='bibliography']) or     string(*[local-name()='otherfindaid']) or string(*[local-name()='relatedmaterial']) or      string(*[local-name()='index'])">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="#"/>
                     <fo:basic-link text-decoration="underline" color="#337ab7"
                                    external-destination="#administrative_info">
                        <xsl:text>Administrative Information</xsl:text>
                     </fo:basic-link>
                     <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                        <xsl:if test="string(*[local-name()='arrangement'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$arrangement_id}">
                                       <xsl:value-of select="$arrangement_head"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='custodhist'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$custodhist_id}">
                                       <xsl:value-of select="$custodhist_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='acqinfo'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$acqinfo_id}">
                                       <xsl:value-of select="$acqinfo_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='accruals'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$accruals_id}">
                                       <xsl:value-of select="$accruals_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='processinfo'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$processinfo_id}">
                                       <xsl:value-of select="$processinfo_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='separatedmaterial'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$separatedmaterial_id}">
                                       <xsl:value-of select="$separatedmaterial_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='bibliography'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$bibliography_id}">
                                       <xsl:value-of select="$bibliography_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='otherfindaid'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$otherfindaid_id}">
                                       <xsl:value-of select="$otherfindaid_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='relatedmaterial'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$relatedmaterial_id}">
                                       <xsl:value-of select="$relatedmaterial_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='appraisal'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$appraisal_id}">
                                       <xsl:value-of select="$appraisal_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                        <xsl:if test="string(*[local-name()='originalsloc'])">
                           <fo:list-item>
                              <fo:list-item-label end-indent="label-end()">
                                 <fo:block/>
                              </fo:list-item-label>
                              <fo:list-item-body start-indent="body-start()">
                                 <fo:block>
                                    <fo:basic-link text-decoration="underline" color="#337ab7"
                                                   external-destination="#{$originalsloc_id}">
                                       <xsl:value-of select="$originalsloc_label"/>
                                    </fo:basic-link>
                                 </fo:block>
                              </fo:list-item-body>
                           </fo:list-item>
                        </xsl:if>
                     </fo:list-block>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(*[local-name()='dsc'])">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <xsl:if test="//*[local-name()='c02']">
                        <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="#"/>
                     </xsl:if>
                     <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="#{$dsc_id}">
                        <xsl:value-of select="$dsc_head"/>
                     </fo:basic-link>
                     <xsl:if test="//*[local-name()='dsc'][not(@type='in-depth')]">
                        <xsl:call-template name="dsc_links"/>
                     </xsl:if>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
         <xsl:if test="string(*[local-name()='controlaccess']/*/*[local-name()='subject']) or string(*[local-name()='controlaccess']/*[local-name()='subject'])">
            <fo:list-item>
               <fo:list-item-label end-indent="label-end()">
                  <fo:block/>
               </fo:list-item-label>
               <fo:list-item-body start-indent="body-start()">
                  <fo:block>
                     <fo:basic-link text-decoration="underline" color="#337ab7"
                                    external-destination="#{$controlaccess_id}">
                        <xsl:value-of select="$controlaccess_head"/>
                     </fo:basic-link>
                  </fo:block>
               </fo:list-item-body>
            </fo:list-item>
         </xsl:if>
      </fo:list-block>
   </xsl:template>
   <xsl:template name="dsc_links"><!-- if there are c02's anywhere in the dsc, then display the c01 headings
			if there are no c02's, all of the c01's are an in-depth type of dsc --><xsl:if test="//*[local-name()='c02']">
         <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
            <xsl:for-each select="//*[local-name()='c01']">
               <fo:list-item>
                  <fo:list-item-label end-indent="label-end()">
                     <fo:block/>
                  </fo:list-item-label>
                  <fo:list-item-body start-indent="body-start()">
                     <fo:block>
                        <fo:basic-link text-decoration="underline" color="#337ab7">
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
                              <xsl:when test="./*[local-name()='did']/*[local-name()='unittitle']"><!--<xsl:value-of select="position()"/>.&#160;--><xsl:value-of select="./*[local-name()='did']/*[local-name()='unittitle']"/>
                              </xsl:when>
                              <!-- 2004-07-14 carlsonm mod: select unitid no matter encodinganalog if no unittitle --><xsl:when test="./*[local-name()='did']/*[local-name()='unitid']/text() and not(./*[local-name()='did']/*[local-name()='unittitle'])">
                                 <xsl:if test="*[local-name()='did']/*[local-name()='unitid']/@type='accession'"> Accession No.  </xsl:if>
                                 <xsl:value-of select="./*[local-name()='did']/*[local-name()='unitid']"/>
                              </xsl:when>
                              <xsl:otherwise><!--<xsl:value-of select="position()"/>.&#160;-->Subordinate Component # <xsl:value-of select="position()"/>
                              </xsl:otherwise>
                           </xsl:choose>
                           <!-- END what if no unitititle--></fo:basic-link>
                     </fo:block>
                  </fo:list-item-body>
               </fo:list-item>
            </xsl:for-each>
         </fo:list-block>
      </xsl:if>
   </xsl:template>
   <!-- ********************* </TABLE OF CONTENTS> *********************** --></xsl:stylesheet>