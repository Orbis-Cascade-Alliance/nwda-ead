<?xml version="1.0" encoding="UTF-8"?>

<!-- This stylesheet is for generating the table of contents sidebar	
	Last modified - September 2007 by Ethan Gruber -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <!-- ********************* <TABLE OF CONTENTS> *********************** -->
  <!-- TOC TEMPLATE - creates Table of Contents -->
  <xsl:template name="toc">
    <div class="navHead">Table of Contents</div>
    <div class="navBody">
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td>
            <xsl:text/>
            <a id="toc"></a>
          </td>
        </tr>
        <xsl:if test="archdesc/did">
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td class="toc1">
              <a href="#overview" id="showoverview">
                <xsl:value-of select="$overview_head"/>
              </a>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="string(archdesc/bioghist)">
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td class="toc1">
              <xsl:for-each select="archdesc/bioghist">
                <xsl:choose>
                  <xsl:when test="./head/text()='Biographical Note'">
                    <a href="#{$bioghist_id}" class="showbioghist">
                      <xsl:value-of select="$bioghist_head"/>
                    </a>
                  </xsl:when>
                  <!--SY original code	<xsl:when test="starts-with(@encodinganalog, '545')"> -->
                  <!--carlsonm mod 2004-07-09 only use bio head when encodinganalog is 5450 as opposed to 5451 -->
                  <xsl:when test="starts-with(@encodinganalog, '5450')">
                    <a href="#{$bioghist_id}" class="showbioghist">
                      <xsl:value-of select="$bioghist_head"/>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>
                    <a href="#{$historical_id}" class="showbioghist">
                      <xsl:value-of select="$historical_head"/>
                    </a>
                  </xsl:otherwise>
                </xsl:choose>
                <br/>
              </xsl:for-each>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="string(archdesc/odd/*)">
          <xsl:for-each select="archdesc/odd[not(@audience='internal')]">
            <tr>
              <td>
                <xsl:text>&#160;</xsl:text>
              </td>
              <td class="toc1">
                <a href="#{$odd_id}" class="ltoc1">
                  <xsl:choose>
                    <!-- Original SY code
											<xsl:when test="string(archdesc/odd/head)">
											<xsl:value-of select="archdesc/odd/head"/>
											</xsl:when>
											
											<xsl:otherwise>
											<xsl:value-of select="$odd_label"/>
											</xsl:otherwise>
										-->
                    <!-- carlsonm mod 2004-07-12 This addresses the "Historical background" heading display-->
                    <xsl:when test="@type='hist'">
                      <xsl:value-of select="$odd_head_histbck"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$odd_label"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </a>
                <br/>
              </td>
            </tr>
          </xsl:for-each>
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="string(archdesc/scopecontent)">
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td class="toc1">
              <a href="#{$scopecontent_id}" class="showscopecontent">
                <xsl:value-of select="$scopecontent_head"/>
              </a>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
          </tr>
        </xsl:if>
        <xsl:if
					test="(string(archdesc/accessrestrict)) or (string(archdesc/userestrict)) or (string(archdesc/altformavail))">
          <tr>
            <td style="vertical-align:top">
              <input type="button" id="toggle_useinfo" class="toc_togglebutton" onclick="fadeFast('h_useinfo')"
								value="+/-"/>
            </td>
            <td class="toc1">
              <a href="#{$useinfo_id}" class="showuseinfo">
                <xsl:value-of select="$useinfo_head"/>
              </a>
            </td>
          </tr>
          <tbody style="display:none" id="h_useinfo">

            <xsl:if test="string(archdesc/altformavail)">
              <tr>
                <td class="useinfo_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="useinfo_item"  >
                  <a href="#{$altformavail_id}" class="showuseinfo">
                    <xsl:value-of select="$altformavail_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/accessrestrict)">
              <tr>
                <td class="useinfo_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="useinfo_item">
                  <a href="#{$accessrestrict_id}" class="showuseinfo">
                    <xsl:value-of select="$accessrestrict_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/userestrict)">
              <tr>
                <td class="useinfo_buffer" >
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="useinfo_item" >
                  <a href="#{$userestrict_id}" class="showuseinfo">
                    <xsl:value-of select="$userestrict_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/prefercite)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$prefercite_id}" class="showuseinfo">
                    <xsl:value-of select="$prefercite_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
          </tbody>
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
          </tr>
        </xsl:if>

        <!-- ADMINISTRATIVE INFO -->

        <xsl:if
					test="string(archdesc/arrangement) or string(archdesc/custodhist) or string(archdesc/acqinfo) 
					or string(archdesc/processinfo) or string(archdesc/accruals) or string(archdesc/separatedmaterial) or string(archdesc/originalsloc)
					or string(archdesc/bibliography) or string(archdesc/otherfindaid) or string(archdesc/relatedmaterial) or string(archdesc/index)">

          <tr>
            <td style="vertical-align:top">
              <input type="button" id="toggle_admin_menu" class="toc_togglebutton" onclick="fadeFast('h_admin')"
								value="+/-"/>
            </td>
            <td class="toc1">
              <a href="#administrative_info" class="showai">
                <xsl:text>Administrative Information</xsl:text>
              </a>
            </td>
          </tr>
          <tbody style="display:none" id="h_admin">
            <xsl:if test="string(archdesc/arrangement)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item" >
                  <a href="#{$arrangement_id}" class="showai">
                    <xsl:value-of select="$arrangement_head"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/custodhist)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$custodhist_id}" class="showai">
                    <xsl:value-of select="$custodhist_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/acqinfo)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$acqinfo_id}" class="showai">
                    <xsl:value-of select="$acqinfo_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/accruals)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$accruals_id}" class="showai">
                    <xsl:value-of select="$accruals_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/processinfo)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$processinfo_id}" class="showai">
                    <xsl:value-of select="$processinfo_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/separatedmaterial)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$separatedmaterial_id}" class="showai">
                    <xsl:value-of select="$separatedmaterial_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/bibliography)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$bibliography_id}" class="showai">
                    <xsl:value-of select="$bibliography_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/otherfindaid)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$otherfindaid_id}" class="showai">
                    <xsl:value-of select="$otherfindaid_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/relatedmaterial)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$relatedmaterial_id}" class="showai">
                    <xsl:value-of select="$relatedmaterial_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/appraisal)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{appraisal_id}" class="showai">
                    <xsl:value-of select="$appraisal_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="string(archdesc/originalsloc)">
              <tr>
                <td class="admin_buffer">
                  <xsl:text>&#160;</xsl:text>
                </td>
                <td class="admin_item">
                  <a href="#{$originalsloc_id}" class="showai">
                    <xsl:value-of select="$originalsloc_label"/>
                  </a>
                </td>
              </tr>
            </xsl:if>
          </tbody>
        </xsl:if>
        <!-- END ADMINISTRATIVE INFO -->
        <!-- Don't need a link to "other creators" from the TOC-->
        <xsl:if test="string(archdesc/dsc)">
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
          </tr>
          <tr>
            <td style="vertical-align:top">
              <xsl:if test="//c02">
                <input type="button" id="toggle_toc_dsc" class="toc_togglebutton" onclick="fadeFast('h_toc_dsc')"
									value="+/-"/>
              </xsl:if>
            </td>
            <td class="toc1">
              <a href="#{$dsc_id}" class="showdsc">
                <xsl:value-of select="$dsc_head"/>
              </a>
              <br/>
              <br/>
            </td>
          </tr>
          <tbody id="h_toc_dsc">
            <xsl:if test="//dsc[not(@type='in-depth')]">
              <xsl:call-template name="dsc_links"/>
            </xsl:if>
          </tbody>
        </xsl:if>
        <xsl:if
  test="string(archdesc/controlaccess/*/subject) or string(archdesc/controlaccess/subject)">
          <tr>
            <td>
              <xsl:text>&#160;</xsl:text>
            </td>
            <td class="toc1">
              <a href="#{$controlaccess_id}" class="showcontrolaccess">
                <xsl:text>Subjects</xsl:text>
              </a>
            </td>
          </tr>
        </xsl:if>
      </table>
    </div>
  </xsl:template>
  <xsl:template name="dsc_links">
    <!-- if there are c02's anywhere in the dsc, then display the c01 headings
			if there are no c02's, all of the c01's are an in-depth type of dsc -->
    <xsl:if test="//c02">
      <xsl:for-each select="//c01">
        <tr>
          <td class="toc_dsc_buffer">
            <xsl:text>&#160;</xsl:text>
          </td>
          <td class="toc_dsc_item">
            <p>
              <a href="#{name()}_{position()}" class="showdsc">
                <!-- what if no unitititle-->
                <xsl:choose>
                  <xsl:when test="./did/unittitle">
                    <!--<xsl:value-of select="position()"/>.&#160;-->
                    <xsl:value-of select="./did/unittitle"/>
                  </xsl:when>
                  <!-- 2004-07-14 carlsonm mod: select unitid no matter encodinganalog if no unittitle -->
                  <xsl:when test="./did/unitid/text() and not(./did/unittitle)">
                    <xsl:if test="did/unitid/@type='accession'">
                      Accession
                      No.&#160;
                    </xsl:if>
                    <xsl:value-of select="./did/unitid"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <!--<xsl:value-of select="position()"/>.&#160;-->Subordinate
                    Component # <xsl:value-of select="position()"/>
                  </xsl:otherwise>
                </xsl:choose>
                <!-- END what if no unitititle-->
              </a>
            </p>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <!-- ********************* </TABLE OF CONTENTS> *********************** -->
</xsl:stylesheet>
