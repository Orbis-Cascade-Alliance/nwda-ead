<?xml version="1.0" encoding="UTF-8"?>
<!--
Original encoding by
Stephen Yearl
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
Revisions and enhancements by
Mark Carlson
2004-06, 2004-10, 2004-11, 2004-12
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#"
                xmlns:arch="http://purl.org/archival/vocab/arch#"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:exsl="http://exslt.org/common"
                version="1.0"
                exclude-result-prefixes="nwda xsd vcard xsl msxsl exsl">
   <xsl:template match="profiledesc | revisiondesc | filedesc | eadheader | frontmatter"/>
   <!-- ********************* <FOOTER> *********************** --><xsl:template match="publicationstmt">
      <fo:block font-size="18px" color="#6b6b6b" margin-bottom="10px" margin-top="10px">
         <xsl:value-of select="/ead/eadheader//titlestmt/author"/>
         <fo:block/>
         <xsl:value-of select="./date"/>
      </fo:block>
      <!--<xsl:if test="$editor-active = 'true'">
			<xsl:if test="string($rdf//foaf:thumbnail/@rdf:resource)">
				<img alt="institutional logo" style="max-height:100px" src="{$rdf//foaf:thumbnail/@rdf:resource}"/>
			</xsl:if>
		</xsl:if>--></xsl:template>
   <!-- ********************* <END FOOTER> *********************** --><!-- ********************* <OVERVIEW> *********************** --><xsl:template match="archdesc">
      <xsl:call-template name="collection_overview"/>
      <fo:block border-top-style="solid"/>
      <xsl:apply-templates select="bioghist | scopecontent | odd"/>
      <xsl:call-template name="useinfo"/>
      <xsl:call-template name="administrative_info"/>
      <fo:block border-top-style="solid"/>
      <xsl:apply-templates select="dsc"/>
      <xsl:apply-templates select="controlaccess"/>
   </xsl:template>
   <!-- ********************* COLLECTION OVERVIEW *********************** --><xsl:template name="collection_overview">
      <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
         <xsl:value-of select="$overview_head"/>
      </fo:block>
      <fo:block>
         <fo:table>
            <fo:table-body><!--origination--><xsl:if test="string(did/origination)">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:choose>
                              <xsl:when test="did/origination/*/@role">
                                 <xsl:variable name="orig1" select="substring(did/origination/*/@role, 1, 1)"/>
                                 <xsl:value-of select="translate($orig1, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                                 <xsl:value-of select="substring(did/origination/*/@role, 2)"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:value-of select="$origination_label"/>
                              </xsl:otherwise>
                           </xsl:choose>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="did/origination"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--collection title--><xsl:if test="did/unittitle">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$unittitle_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="did/unittitle[1]"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--collection dates--><xsl:if test="did/unitdate">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$dates_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="did/unitdate" mode="archdesc"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--collection physdesc--><xsl:if test="did/physdesc">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$physdesc_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:for-each select="did/physdesc">
                              <xsl:apply-templates select="extent"/>
                              <!-- multiple extents contained in parantheses --><xsl:if test="string(physfacet) and string(extent)">  :  </xsl:if>
                              <xsl:apply-templates select="physfacet"/>
                              <xsl:if test="string(dimensions) and string(physfacet)">  ;  </xsl:if>
                              <xsl:apply-templates select="dimensions"/>
                              <xsl:if test="not(position()=last())">
                                 <fo:block/>
                              </xsl:if>
                           </xsl:for-each>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--collection physloc--><xsl:if test="did/physloc">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$physloc_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:for-each select="did/physloc">
                              <xsl:apply-templates/>
                              <xsl:if test="not(position()=last())">
                                 <fo:block/>
                              </xsl:if>
                           </xsl:for-each>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--collection #--><xsl:if test="did/unitid">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$collectionNumber_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="did/unitid" mode="archdesc"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--collection abstract/summary--><xsl:if test="did/abstract">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$abstract_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="did/abstract"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--contact information--><xsl:choose>
                  <xsl:when test="$editor-active='true'">
                     <fo:table-row>
                        <fo:table-cell text-align="right" font-weight="bold" width="160px">
                           <fo:block margin-right="10px">
                              <xsl:value-of select="$contactinformation_label"/>
                           </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <fo:block>
                              <xsl:choose>
                                 <xsl:when test="$platform='linux'">
                                    <xsl:apply-templates select="exsl:node-set($rdf)//arch:Archive" mode="repository"/>
                                    <xsl:apply-templates select="exsl:node-set($rdf)//arch:Archive" mode="contact"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:apply-templates select="msxsl:node-set($rdf)//arch:Archive" mode="repository"/>
                                    <xsl:apply-templates select="msxsl:node-set($rdf)//arch:Archive" mode="contact"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </fo:block>
                        </fo:table-cell>
                     </fo:table-row>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:if test="did/repository">
                        <fo:table-row>
                           <fo:table-cell text-align="right" font-weight="bold" width="160px">
                              <fo:block margin-right="10px">
                                 <xsl:value-of select="$contactinformation_label"/>
                              </fo:block>
                           </fo:table-cell>
                           <fo:table-cell>
                              <fo:block>
                                 <xsl:for-each select="did/repository">
                                    <xsl:variable name="selfRepos">
                                       <xsl:value-of select="normalize-space(text())"/>
                                    </xsl:variable>
                                    <xsl:if test="string-length($selfRepos)&gt;0">
                                       <fo:inline>
                                          <xsl:value-of select="$selfRepos"/>
                                       </fo:inline>
                                       <fo:block/>
                                    </xsl:if>
                                    <xsl:if test="string(corpname)">
                                       <xsl:for-each select="corpname">
                                          <xsl:if test="string-length(.)&gt;string-length(subarea)">
                                             <fo:inline>
                                                <xsl:apply-templates select="text()|*[not(self::subarea)]"/>
                                             </fo:inline>
                                             <fo:block/>
                                          </xsl:if>
                                       </xsl:for-each>
                                       <xsl:if test="string(corpname/subarea)">
                                          <xsl:for-each select="corpname/subarea">
                                             <xsl:apply-templates/>
                                             <fo:block/>
                                          </xsl:for-each>
                                       </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="string(subarea)">
                                       <xsl:apply-templates select="subarea"/>
                                       <fo:block/>
                                    </xsl:if>
                                    <xsl:if test="string(address)">
                                       <xsl:apply-templates select="address"/>
                                    </xsl:if>
                                 </xsl:for-each>
                              </fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                     </xsl:if>
                  </xsl:otherwise>
               </xsl:choose>
               <!-- inserted accessrestrict as per March 2015 revision specifications --><xsl:if test="accessrestrict">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$accessrestrict_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:for-each select="accessrestrict/p">
                              <xsl:value-of select="."/>
                              <xsl:if test="not(position()=last())">
                                 <xsl:text/>
                              </xsl:if>
                           </xsl:for-each>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!-- inserted accessrestrict as per March 2015 revision specifications --><xsl:if test="otherfindaid">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$otherfindaid_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:for-each select="otherfindaid/p">
                              <xsl:value-of select="."/>
                              <xsl:if test="not(position()=last())">
                                 <xsl:text/>
                              </xsl:if>
                           </xsl:for-each>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--finding aid creation information--><xsl:if test="/ead/eadheader/profiledesc/creation and $showCreation='true'">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$creation_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="/ead/eadheader/profiledesc/creation"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--finding aid revision information--><xsl:if test="/ead/eadheader/profiledesc/creation and $showRevision='true'">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$revision_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:apply-templates select="/ead/eadheader/revisiondesc/change"/>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--language note--><xsl:if test="did/langmaterial">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">
                           <xsl:value-of select="$langmaterial_label"/>
                        </fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <xsl:choose>
                              <xsl:when test="langmaterial/text()">
                                 <fo:inline>
                                    <xsl:apply-templates select="did/langmaterial"/>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:for-each select="did/langmaterial/language">
                                    <fo:inline>
                                       <xsl:apply-templates select="."/>
                                    </fo:inline>
                                    <xsl:if test="not(position()=last())">
                                       <xsl:text>, </xsl:text>
                                    </xsl:if>
                                 </xsl:for-each>
                              </xsl:otherwise>
                           </xsl:choose>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
               <!--sponsor; March 2015, moved sponsor to Administration Information --><!--<xsl:if test="/ead/eadheader//sponsor[1]">
						<dt>
							<xsl:value-of select="$sponsor_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="/ead/eadheader//sponsor[1]"/>
						</dd>
					</xsl:if>--><!-- display link to Harvester CHOs if $hasCHOs is 'true' --><xsl:if test="$hasCHOs = 'true'">
                  <fo:table-row>
                     <fo:table-cell text-align="right" font-weight="bold" width="160px">
                        <fo:block margin-right="10px">Digital Objects</fo:block>
                     </fo:table-cell>
                     <fo:table-cell>
                        <fo:block>
                           <fo:basic-link external-destination="{concat('http://harvester.orbiscascade.org/apis/get?ark=ark:/', //eadid/@identifier)}">yes</fo:basic-link>
                        </fo:block>
                     </fo:table-cell>
                  </fo:table-row>
               </xsl:if>
            </fo:table-body>
         </fo:table>
      </fo:block>
   </xsl:template>
   <!-- ********************* </OVERVIEW> *********************** --><xsl:template name="sect_separator">
      <fo:block margin-bottom="10px">^ Return to Top</fo:block>
   </xsl:template>
   <!-- ********************* START COLLECTION IMAGE *********************** --><xsl:template name="collection_image"><!-- the call for this template has been commented out so that only logos and not collection images display, EG 2007-08-27 --><!-- margin-top is 100% to force collection image to be bottom-aligned while the institutional logo is top-aligned. --><fo:block>
         <fo:block>
            <fo:external-graphic src=""/>
         </fo:block>
         <fo:block>
            <xsl:apply-templates select="did/daogrp/daodesc | daogrp/daodesc"/>
         </fo:block>
      </fo:block>
   </xsl:template>
   <!-- ********************* END COLLECTION IMAGE *********************** --><!-- ********************* <ARCHDESC_MINOR_CHILDREN> *********************** --><!--this template generically called by arbitrary groupings: see per eg. relatedinfo template --><xsl:template name="archdesc_minor_children">
      <xsl:param name="withLabel"/>
      <xsl:if test="$withLabel='true'">
         <fo:block font-size="18px" color="#6b6b6b" margin-bottom="10px" margin-top="10px">
            <xsl:if test="@id"/>
            <xsl:choose><!--pull in correct label, depending on what is actually matched--><xsl:when test="name()='altformavail'">
                  <xsl:value-of select="$altformavail_label"/>
               </xsl:when>
               <xsl:when test="name()='arrangement'">
                  <xsl:value-of select="$arrangement_label"/>
               </xsl:when>
               <xsl:when test="name()='bibliography'">
                  <xsl:value-of select="$bibliography_label"/>
               </xsl:when>
               <xsl:when test="name()='accessrestrict'">
                  <xsl:value-of select="$accessrestrict_label"/>
               </xsl:when>
               <xsl:when test="name()='userestrict'">
                  <xsl:value-of select="$userestrict_label"/>
               </xsl:when>
               <xsl:when test="name()='prefercite'">
                  <xsl:value-of select="$prefercite_label"/>
               </xsl:when>
               <xsl:when test="name()='accruals'">
                  <xsl:value-of select="$accruals_label"/>
               </xsl:when>
               <xsl:when test="name()='acqinfo'">
                  <xsl:value-of select="$acqinfo_label"/>
               </xsl:when>
               <xsl:when test="name()='appraisal'">
                  <xsl:value-of select="$appraisal_label"/>
               </xsl:when>
               <!-- original SY code
						<xsl:when test="name()='bibliography' and ./head">

							<a name="{$bibliography_id}"></a>
							<xsl:value-of select="./head/text()"/>
						</xsl:when>
						--><xsl:when test="name()='custodhist'">
                  <xsl:value-of select="$custodhist_label"/>
               </xsl:when>
               <xsl:when test="name()='scopecontent'">
                  <xsl:value-of select="$scopecontent_label"/>
               </xsl:when>
               <xsl:when test="name()='separatedmaterial'">
                  <xsl:value-of select="$separatedmaterial_label"/>
               </xsl:when>
               <xsl:when test="name()='relatedmaterial'">
                  <xsl:value-of select="$relatedmaterial_label"/>
               </xsl:when>
               <xsl:when test="name()='originalsloc'">
                  <xsl:value-of select="$originalsloc_label"/>
               </xsl:when>
               <xsl:when test="name()='origination'">
                  <xsl:value-of select="$origination_label"/>
               </xsl:when>
               <xsl:when test="name()='otherfindaid'">
                  <xsl:value-of select="$otherfindaid_label"/>
               </xsl:when>
               <xsl:when test="name()='processinfo'">
                  <xsl:value-of select="$processinfo_label"/>
               </xsl:when>
               <xsl:when test="name()='odd'">
                  <xsl:value-of select="$odd_label"/>
               </xsl:when>
               <xsl:when test="name()='physdesc'">
                  <xsl:value-of select="$physdesc_label"/>
               </xsl:when>
               <xsl:when test="name()='physloc'">
                  <xsl:value-of select="$physloc_label"/>
               </xsl:when>
               <xsl:when test="name()='phystech'">
                  <xsl:value-of select="$phystech_label"/>
               </xsl:when>
               <xsl:when test="name()='fileplan'">
                  <xsl:value-of select="$fileplan_label"/>
               </xsl:when>
               <xsl:when test="name()='index'">
                  <xsl:value-of select="$index_label"/>
               </xsl:when>
               <xsl:when test="name()='sponsor'">
                  <xsl:value-of select="$sponsor_label"/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </fo:block>
      </xsl:if>
      <!-- 2004-11-30 Suppress the display of all <head> elements (with exceptions).  Example, Pauling finding aid of OSU SC --><!-- 2004-12-06 Process physdesc separately --><xsl:choose>
         <xsl:when test="self::physdesc">
            <fo:block>
               <xsl:apply-templates select="extent"/>
               <xsl:if test="string(physfacet) and string(extent)">
                  <xsl:text> : </xsl:text>
               </xsl:if>
               <xsl:apply-templates select="physfacet"/>
               <xsl:if test="string(dimensions) and string(physfacet)">
                  <xsl:text> ; </xsl:text>
               </xsl:if>
               <xsl:apply-templates select="dimensions"/>
            </fo:block>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates select="self::node()"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="self::origination and child::*/@role">  ( <xsl:value-of select="child::*/@role"/>) </xsl:if>
   </xsl:template>
   <!-- ********************* </ARCHDESC_MINOR_CHILDREN> *********************** --><!-- ********************* <BIOGHIST> *********************** --><xsl:template name="bioghist" match="//bioghist">
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="parent::archdesc">
               <xsl:text>top_bioghist</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>bioghist</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="head/text()='Biographical Note' and not(ancestor::dsc)">
            <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
               <xsl:value-of select="$bioghist_head"/>
            </fo:block>
         </xsl:when>
         <!-- SY Original	<xsl:when test="starts-with(@encodinganalog, '545')"> --><!-- carlson mod 2004-07-09 only use Bioghist head if encodinganalog starts with 5450 as opposed to 5451 --><xsl:when test="starts-with(@encodinganalog, '5450') and not(ancestor::dsc)">
            <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
               <xsl:value-of select="$bioghist_head"/>
            </fo:block>
         </xsl:when>
         <xsl:otherwise>
            <xsl:if test="not(ancestor::dsc)">
               <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
                  <xsl:value-of select="$historical_head"/>
               </fo:block>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
      <fo:block>
         <xsl:for-each select="p">
            <fo:block margin-bottom="10px">
               <xsl:apply-templates/>
            </fo:block>
         </xsl:for-each>
      </fo:block>
   </xsl:template>
   <!-- ********************* </BIOGHIST> *********************** --><!-- ********************* <SCOPECONTENT> *********************** --><xsl:template name="scopecontent" match="scopecontent[1]">
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="parent::archdesc">
               <xsl:text>top_scopecontent</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>scopecontent</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not(ancestor::dsc)">
         <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
            <xsl:value-of select="$scopecontent_head"/>
         </fo:block>
      </xsl:if>
      <fo:block>
         <xsl:for-each select="p">
            <fo:block margin-bottom="10px">
               <xsl:apply-templates/>
            </fo:block>
         </xsl:for-each>
         <!--<xsl:apply-templates select="./*[not(self::head)]"/>--></fo:block>
      <!--<xsl:call-template name="sect_separator" />--></xsl:template>
   <!-- ********************* </SCOPECONTENT> *********************** --><!-- ********************* <ODD> *********************** --><xsl:template name="odd" match="//odd">
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="parent::archdesc">
               <xsl:text>top_odd</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>odd</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="@type='hist'  and not(ancestor::dsc)">
            <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
               <xsl:value-of select="$odd_head_histbck"/>
            </fo:block>
         </xsl:when>
         <xsl:otherwise>
            <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
               <xsl:value-of select="$odd_head"/>
            </fo:block>
         </xsl:otherwise>
      </xsl:choose>
      <fo:block>
         <xsl:for-each select="p">
            <fo:block margin-bottom="10px">
               <xsl:apply-templates/>
            </fo:block>
         </xsl:for-each>
      </fo:block>
   </xsl:template>
   <!-- ********************* </ODD> *********************** --><!-- ********************* <USEINFO> *********************** --><xsl:template name="useinfo"><!-- removed accessrestrict from this section, moved to Collection Overview, as per March 2015 spec --><xsl:if test="altformavail | userestrict | prefercite">
         <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
            <xsl:if test="@id"/>
            <xsl:value-of select="$useinfo_head"/>
         </fo:block>
         <fo:block>
            <xsl:for-each select="altformavail | userestrict | prefercite">
               <xsl:call-template name="archdesc_minor_children">
                  <xsl:with-param name="withLabel">true</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </fo:block>
      </xsl:if>
      <!--<xsl:call-template name="sect_separator" />--></xsl:template>
   <!-- ********************* </USEINFO> *********************** --><!-- ************************* ADMINISTRATIVE INFO - COLLAPSED BY DEFAULT ******************** --><xsl:template name="administrative_info">
      <xsl:if test="@id"/>
      <fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
         <xsl:text>Administrative Information</xsl:text>
      </fo:block>
      <fo:block>
         <xsl:apply-templates select="arrangement"/>
         <xsl:call-template name="admininfo"/>
         <xsl:if test="string(index[not(ancestor::dsc)])">
            <xsl:apply-templates select="index"/>
         </xsl:if>
      </fo:block>
   </xsl:template>
   <!-- ******************** END ADMINISTRATIVE INFO ******************** --><!-- ********************* <ARRANGEMENT> *********************** --><xsl:template name="arrangement" match="//arrangement">
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="parent::archdesc">
               <xsl:text>top_arrangement</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>arrangement</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not(ancestor::dsc)">
         <xsl:if test="@id"/>
         <fo:block font-size="18px" color="#6b6b6b" margin-bottom="10px" margin-top="10px">Arrangement</fo:block>
      </xsl:if>
      <fo:block>
         <xsl:apply-templates select="./*[not(self::head)]"/>
      </fo:block>
   </xsl:template>
   <!-- ********************* </ARRANGEMENT> *********************** --><!-- ********************* <ADMININFO> *********************** --><xsl:template name="admininfo">
      <xsl:if test="acqinfo | accruals | custodhist | processinfo | separatedmaterial | bibliography | otherfindaid | relatedmaterial | originalsloc | appraisal | //sponsor">
         <xsl:if test="not(ancestor::dsc)">
            <xsl:choose>
               <xsl:when test="@id"/>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:if>
         <fo:block>
            <xsl:for-each select="custodhist | acqinfo | accruals | processinfo | separatedmaterial | bibliography | otherfindaid | relatedmaterial | appraisal | originalsloc | //sponsor">
               <xsl:call-template name="archdesc_minor_children">
                  <xsl:with-param name="withLabel">true</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </fo:block>
      </xsl:if>
      <!--<xsl:call-template name="sect_separator" />--></xsl:template>
   <!-- ********************* </ADMININFO> *********************** --><!-- ********************* <INDEX> *********************** --><xsl:template match="index" name="index">
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="parent::archdesc">
               <xsl:text>top_index</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>index</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not(ancestor::dsc)">
         <xsl:if test="@id"/>
      </xsl:if>
      <fo:block>
         <fo:table width="100%">
            <xsl:apply-templates select="p"/>
            <xsl:apply-templates select="listhead"/>
            <fo:table-body width="100%">
               <xsl:apply-templates select="indexentry"/>
            </fo:table-body>
         </fo:table>
      </fo:block>
      <xsl:call-template name="sect_separator"/>
   </xsl:template>
   <xsl:template match="listhead">
      <fo:table-header>
         <fo:table-row width="100%">
            <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                           border-bottom-style="solid"
                           padding="8px">
               <fo:block>
                  <xsl:apply-templates select="head01"/>
               </fo:block>
            </fo:table-cell>
            <fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
                           border-bottom-style="solid"
                           padding="8px">
               <fo:block>
                  <xsl:apply-templates select="head02"/>
               </fo:block>
            </fo:table-cell>
         </fo:table-row>
      </fo:table-header>
   </xsl:template>
   <xsl:template match="indexentry">
      <fo:table-row width="100%">
         <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                        border-bottom-style="solid"
                        padding="8px">
            <fo:block>
               <xsl:apply-templates select="corpname | famname | function | genreform | geogname | name | occupation | persname | subject | title"/>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
                        border-bottom-style="solid"
                        padding="8px">
            <fo:block>
               <xsl:for-each select="ref | ptrgrp/ref">
                  <xsl:choose>
                     <xsl:when test="@target">
                        <xsl:apply-templates/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:apply-templates/>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:if test="not(position() = last())">
                     <xsl:text>, </xsl:text>
                  </xsl:if>
               </xsl:for-each>
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
   </xsl:template>
   <!-- ********************* </INDEX> *********************** --><!-- ********************* <physloc> ********************** --><xsl:template match="c01/did/physloc">
      <fo:block>
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>
   <!-- ********************* </physloc> ********************* --><xsl:template match="c01//accessrestrict | c01//userestrict | c01//note">
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="self::accessrestrict">
               <xsl:text>accessrestrict</xsl:text>
            </xsl:when>
            <xsl:when test="self::userestrict">
               <xsl:text>userestrict</xsl:text>
            </xsl:when>
            <xsl:when test="self::note">
               <xsl:text>note</xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <fo:block>
         <xsl:for-each select="p">
            <fo:block margin-bottom="10px">
               <xsl:apply-templates/>
            </fo:block>
         </xsl:for-each>
      </fo:block>
   </xsl:template>
   <!-- 2014 September: templates for rendering repository metadata from RDF/XML --><xsl:template match="arch:Archive" mode="repository">
      <xsl:choose>
         <xsl:when test="foaf:homepage/@rdf:resource">
            <xsl:value-of select="foaf:name"/>
         </xsl:when>
         <xsl:otherwise>
            <fo:inline>
               <xsl:value-of select="foaf:name"/>
            </fo:inline>
         </xsl:otherwise>
      </xsl:choose>
      <fo:block/>
      <xsl:if test="nwda:subRepository">
         <xsl:value-of select="nwda:subRepository"/>
         <fo:block/>
      </xsl:if>
   </xsl:template>
   <xsl:template match="arch:Archive" mode="contact">
      <xsl:if test="vcard:hasAddress">
         <xsl:for-each select="vcard:hasAddress/rdf:Description/*">
            <xsl:value-of select="."/>
            <fo:block/>
         </xsl:for-each>
      </xsl:if>
      <xsl:if test="vcard:hasTelephone[vcard:Voice]">
         <xsl:variable name="number"
                       select="substring-after(vcard:hasTelephone/vcard:Voice/vcard:hasValue/@rdf:resource, '+')"/>
         <xsl:text>Telephone: </xsl:text>
         <xsl:value-of select="concat(substring($number, 1, 3), '-', substring($number, 4, 3), '-', substring($number, 7, 4))"/>
         <fo:block/>
      </xsl:if>
      <xsl:if test="vcard:hasTelephone[vcard:Fax]">
         <xsl:variable name="number"
                       select="substring-after(vcard:hasTelephone/vcard:Fax/vcard:hasValue/@rdf:resource, '+')"/>
         <xsl:text>Fax: </xsl:text>
         <xsl:value-of select="concat(substring($number, 1, 3), '-', substring($number, 4, 3), '-', substring($number, 7, 4))"/>
         <fo:block/>
      </xsl:if>
      <xsl:if test="string(vcard:hasEmail/@rdf:resource)">
         <xsl:value-of select="substring-after(vcard:hasEmail/@rdf:resource, ':')"/>
         <fo:block/>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>