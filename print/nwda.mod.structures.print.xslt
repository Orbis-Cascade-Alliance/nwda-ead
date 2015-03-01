<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="profiledesc | revisiondesc | filedesc | eadheader | frontmatter"/>
<xsl:template name="coverpage">
<!-- New cover page -->
<table height="100%" width="95%" align="center"><tr valign="top"><td>
<div id="cptop" align="center">
<xsl:if test="contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg')">
<p align="center">
					<img alt="institutional logo" src="{//publicationstmt//extptr/@href}"/>
				</p>
</xsl:if>
<span class="repos">
<xsl:for-each select="archdesc/did/repository">

<xsl:variable name="selfRepos">

<xsl:apply-templates select="text()|*[not(self::*)]"/>
</xsl:variable>

<xsl:if test="string-length($selfRepos)&gt;0">
<xsl:value-of select="$selfRepos"/><br/>
</xsl:if>

<xsl:if test="string(corpname)">
<xsl:for-each select="corpname">
<xsl:if test="string-length(.)&gt;string-length(subarea)">
<xsl:apply-templates select="text()|*[not(self::subarea)]"/><br/>
</xsl:if>
</xsl:for-each>

<xsl:if test="string(corpname/subarea)">
<xsl:for-each select="corpname/subarea">
<xsl:apply-templates/><br/>
</xsl:for-each>
</xsl:if>

</xsl:if>
<xsl:if test="string(subarea)">
<xsl:apply-templates select="subarea"/><br/>
</xsl:if>
<xsl:if test="string(address)">
<xsl:apply-templates select="address"/><br/>
</xsl:if>
</xsl:for-each>
</span>
<br/><br/>
</div>
<div id="cpmiddle" align="center">
<span class="cptitle">
<xsl:for-each select="//titleproper[not(@audience='internal')][not(@altrender='nodisplay')][not(@type='filing')]">
<xsl:variable name="tp">
<xsl:apply-templates select="text() |* [not(self::date)]"/>
</xsl:variable>
<xsl:value-of select="normalize-space($tp)"/>
</xsl:for-each>
<xsl:if test="//titlestmt//subtitle">:<xsl:value-of select="//titlestmt//subtitle"/>	
</xsl:if>
<xsl:if test="//titlestmt//date"><xsl:text>, </xsl:text>
<xsl:value-of select="//titlestmt//date"/>
</xsl:if>
</span>
<br/><br/><br/>
<span class="cpunitid">
<xsl:if test="/ead/archdesc/did/unitid/@label">
<xsl:value-of select="/ead/archdesc/did/unitid/@label"/><xsl:text> </xsl:text>
</xsl:if>
<xsl:value-of select="/ead/archdesc/did/unitid"/></span>
<br/><br/><br/><br/><br/><br/>
<span class="cpauthor"><xsl:value-of select="//titlestmt//author"/></span>
<br/><br/>
<span class="cpencoder">
<xsl:for-each select="//profiledesc/creation">
<xsl:variable name="en" select="text() | *[not(self::date)]"/>
<xsl:value-of select="normalize-space($en)"/>
</xsl:for-each>
<xsl:if test="//profiledesc/creation/date">
<xsl:text>, </xsl:text>
<xsl:value-of select="//profiledesc/creation/date"/>
</xsl:if>
</span>
</div>
<!-- page break after -->
</td></tr>
<tr valign="bottom"><td>
<div id="cpfooter" align="center">
<span class="cpsponsor"><xsl:value-of select="//titlestmt/sponsor"/></span>
</div>
</td></tr></table>
<br clear="all"/>
</xsl:template>

	<!-- ********************* <FRONTMATTER> *********************** -->
	<xsl:template name="frontmatter">


		<div class="frontmatter">
		<!-- don't repeat titleproper in the print SS
			<h1 align="center" class="findaidtitles">
				<xsl:for-each select="//titleproper[1]">
					<xsl:apply-templates select="./text() | ./*[not(self::date)]"/>
					<xsl:if test="//titlestmt//subtitle">:<xsl:value-of select="//titlestmt//subtitle"/>	
					</xsl:if>
					<br/>
					<xsl:apply-templates select="./date"/>
				</xsl:for-each>
			</h1>
			<h4 align="center" class="author">
				<xsl:value-of select="//titlestmt//author"/>
			</h4>
			-->
<!-- carlsonm mod 2004-09-25 test now allows for gif or jpg file extension -->
<!--
			<xsl:if test="contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg')">

				<p align="center">
					<img alt="institutional logo" src="{//publicationstmt//extptr/@href}"/>
				</p>
			</xsl:if>


			<h4 align="center" class="date.copyright">
				<xsl:value-of select="//publicationstmt/date"/>
			</h4>
	-->			
		</div>
		
	</xsl:template>

	<!-- ********************* <FRONTMATTER> *********************** -->

	<!-- ********************* <OVERVIEW> *********************** -->
	<xsl:template match="archdesc">
		<div class="archdesc">
			<div class="overview">
			<!-- revised "overview" heading table -->
							<table border="0" align="center" summary="Collection level overview of the {//unitname[1]}" width="100%">
					
						<tr>
							<td>
							<center>
								<h3 class="overview-print">
									<a name="overview" id="overview"/>
									<xsl:call-template name="section_head">
										<xsl:with-param name="structhead" select="$overview_head"/>
									</xsl:call-template>
								</h3>
								</center>
							</td>
						</tr>
</table>
			
				<table border="0">
				<!--
					<thead class="thead">
						<tr>
							<th colspan="5">
							<center>
								<h3 class="overview-print">
									<a name="overview" id="overview"/>
									<xsl:call-template name="section_head">
										<xsl:with-param name="structhead" select="$overview_head"/>
									</xsl:call-template>
								</h3>
								</center>
							</th>
						</tr>
					</thead>
					-->
					<tbody class="tbody">
						<!--contact information-->
						<xsl:if test="did/repository">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$contactinformation_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
<!-- carlsonm mod 2004-09-25 select every possible element and display in order encoded -->
<xsl:for-each select="did/repository">

<xsl:variable name="selfRepos">

<xsl:apply-templates select="text()|*[not(self::*)]"/>
</xsl:variable>

<xsl:if test="string-length($selfRepos)&gt;0">
<xsl:value-of select="$selfRepos"/><br/>
</xsl:if>

<xsl:if test="string(corpname)">
<xsl:for-each select="corpname">
<xsl:if test="string-length(.)&gt;string-length(subarea)">
<xsl:apply-templates select="text()|*[not(self::subarea)]"/><br/>
</xsl:if>
</xsl:for-each>

<xsl:if test="string(corpname/subarea)">
<xsl:for-each select="corpname/subarea">
<xsl:apply-templates/><br/>
</xsl:for-each>
</xsl:if>

</xsl:if>
<xsl:if test="string(subarea)">
<xsl:apply-templates select="subarea"/><br/>
</xsl:if>
<xsl:if test="string(address)">
<xsl:apply-templates select="address"/><br/>
</xsl:if>

<!--
<xsl:if test="self::corpname">
<xsl:for-each select="subarea">
<xsl:if test="string(self::subarea)">
<xsl:apply-templates/>
</xsl:if>
</xsl:for-each>
</xsl:if>
</xsl:for-each>
-->
</xsl:for-each>
<!-- Original SY code
										<xsl:choose>
											<xsl:when test="did/repository//subarea">
												<b>
												<xsl:apply-templates select="did/repository/corpname/text() | did/repository/corpname/*[not(self::subarea)]"/>
												</b>
												<br/>
												<b>
												<xsl:value-of select="did/repository/corpname/subarea"/>
					
												</b>
											</xsl:when>
											<xsl:otherwise>
												<xsl:for-each select="did/repository/*[not(name()='address')]">
													<b>
														<xsl:value-of select="did/repository/*[not(name()='address')]"/>
														<xsl:text> </xsl:text>
													</b>
												</xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>

										<xsl:apply-templates select="did/repository/address"/>
-->

									</p>
								</td>
								<!--
								<td rowspan="6">

									<xsl:choose>
										<xsl:when test="did/daogrp/daoloc or daogrp/daoloc">
											<xsl:call-template name="collection_image"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>&#160;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								-->
							</tr>
						</xsl:if>
						<!--sponsor-->
						<!--
						<xsl:if test="//sponsor[1]">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top">
									<h5 class="label">
										<xsl:value-of select="$sponsor_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:apply-templates select="//sponsor[1]"/>
									</p>
								</td>
								<td></td>
							</tr>
						</xsl:if>
						-->
						<!--finding aid creation information-->
						<xsl:if test="//profiledesc/creation and $showCreation='true'">
						<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$creation_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:apply-templates select="//profiledesc/creation"/>
									</p>
								</td>
								<td></td>
							</tr>
						</xsl:if>
						<!--finding aid revision information-->
						<xsl:if test="//profiledesc/creation and $showRevision='true'">
						<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$revision_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:apply-templates select="//revisiondesc/change"/>
									</p>
								</td>
								<td></td>
							</tr>
						</xsl:if>
						<!--collection #-->
						<xsl:if test="did/unitid">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$collectionNumber_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:apply-templates select="did/unitid[1]"/><xsl:if test="did/unitid[2]"> (<xsl:value-of select="did/unitid[1]/@type"/>), <xsl:apply-templates select="did/unitid[2]"/> (<xsl:value-of select="did/unitid[2]/@type"/>)</xsl:if>
									</p>
								</td>
								<td></td>
							</tr>
						</xsl:if>
						<!--origination-->
						<xsl:if test="did/origination">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
<xsl:choose>
<xsl:when test="did/origination/*/@role">
<xsl:variable name="orig1" select="substring(did/origination/*/@role, 1, 1)"/>
<xsl:value-of select="translate($orig1, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/><xsl:value-of select="substring(did/origination/*/@role, 2)"/>:
</xsl:when>
<xsl:otherwise>
										<xsl:value-of select="$origination_label"/>:
</xsl:otherwise>
</xsl:choose>
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:apply-templates select="did/origination"/>
									</p>
								</td>
								<td rowspan="7"></td>
							</tr>
						</xsl:if>
						<!--collection title-->
						<xsl:if test="did/unittitle">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$unittitle_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:apply-templates select="did/unittitle[1]"/>
									</p>
								</td>
								<td rowspan="7"></td>
							</tr>
						</xsl:if>
						<!--collection dates-->
						<xsl:if test="did/unitdate">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$dates_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:for-each select="did/unitdate">
                      <!--ought to pull in unitdate template-->												<xsl:apply-templates /><xsl:if test="@type"><xsl:text> </xsl:text>(<xsl:value-of select="@type"/>)</xsl:if>
											<br/>
										</xsl:for-each>
									</p>
								</td>
								<td rowspan="7"></td>
							</tr>
						</xsl:if>
						<!--collection physdesc-->
						<xsl:if test="did/physdesc">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$physdesc_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:for-each select="did/physdesc/*">
											<xsl:apply-templates /><br/>
										</xsl:for-each>
									</p>
								</td>
								<td rowspan="7"></td>
							</tr>
						</xsl:if>
						
						<!--language note-->
						<xsl:if test="did/langmaterial">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview" colspan="2">
										<xsl:value-of select="$langmaterial_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top" colspan="2">
									<p><xsl:value-of select="did/langmaterial"/>
										<xsl:choose>
											<xsl:when test="langmaterial/text()">
												<xsl:apply-templates select="did/langmaterial"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:for-each select="did/langmaterial/language">
													<!--<xsl:if test="not(position()='1') or not(position()=last()-1)">,</xsl:if>
													<xsl:if test="position()=last()">and</xsl:if>-->
													<xsl:apply-templates select="did/langmaterial/language"/>&#160;
												</xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</p>
								</td>
							</tr>
						</xsl:if>
						<!--collection abstract/summary-->
						<xsl:if test="did/abstract">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview" colspan="2">
										<xsl:value-of select="$abstract_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top" colspan="2">
									<p>
										<xsl:apply-templates select="did/abstract"/><br/><br/>
									</p>
								</td>
							</tr>
						</xsl:if>
<!--collection physloc-->
						<xsl:if test="did/physloc">
							<tr>
								<td valign="top">&#160;</td>
								<td valign="top" nowrap="true">
									<h5 class="label-overview">
										<xsl:value-of select="$physloc_label"/>:
									</h5>
								</td>
								<td valign="top">&#160;</td>
								<td valign="top">
									<p>
										<xsl:for-each select="did/physloc">
											<xsl:apply-templates /><br/>
										</xsl:for-each>
									</p>
								</td>
								<td rowspan="7"></td>
							</tr>
						</xsl:if>						
							<tr>
								<td valign="top">&#160;</td>

							</tr>
					</tbody>
				</table>
			</div>
			<!--call in archdesc/bioghists, archdesc/scopecontent and dsc-->
			<!--<xsl:apply-templates/>-->
			<!--	<xsl:call-template name="scopecontent" />
			<xsl:call-template name="odd" />
			<xsl:call-template name="bioghist" />
			<xsl:call-template name="arrangement" />-->
			<xsl:apply-templates select="bioghist | scopecontent | arrangement | odd"/>
			<xsl:call-template name="admininfo"/>
			<xsl:call-template name="useinfo"/>
			<xsl:call-template name="relatedinfo"/>
			<xsl:apply-templates select="controlaccess" />
<xsl:apply-templates select="dsc"/>
			<!--<xsl:apply-templates select="dsc"/>
			<xsl:if test="index">
				<xsl:call-template name="index"/>
			</xsl:if>-->
		</div>
	</xsl:template>
	<!-- ********************* </OVERVIEW> *********************** -->


	<xsl:template name="sect_separator">
		<p class="top">
			<a href="#top" title="Top of finding aid">^ Return to Top</a>
		</p>
	</xsl:template>


	<!-- ********************* START COLLECTION IMAGE *********************** -->
	<xsl:template name="collection_image">
		<table align="center" border="0" cellspacing="0" cellpadding="4" class="collection_image">
			<tr valign="top" align="center">
				<td>
					<br/>
					<xsl:element name="img">
						<xsl:attribute name="src">
							<xsl:value-of select="did/daogrp/daoloc/@href | daogrp/daoloc/@href"/>
						</xsl:attribute>
					</xsl:element>
				</td>
			</tr>
			<tr align="center">
				<td><!--class="dao_desc"-->
					<xsl:apply-templates select="did/daogrp/daodesc | daogrp/daodesc"/>
					<br/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- ********************* END COLLECTION IMAGE *********************** -->


	<!-- ********************* <QUONDAM ADMININFO> *********************** -->
	<!--	<xsl:template match="altformavail | accessrestrict | userestrict | prefercite | accruals | acqinfo | appraisal | bibliography | custodhist | originalsloc | processinfo | separatedmaterial | relatedmaterial | otherfindaid | odd | phystech | fileplan | index">
	<xsl:call-template name="archdesc_minor_children">
			<xsl:with-param name="nodeName" select="name()"/>
			<xsl:with-param name="label" select="name()"/>
		</xsl:call-template>
	</xsl:template>-->
	<!-- ********************* <QUONDAM ADMININFO> *********************** -->

	<!-- ********************* <ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!--this template generically called by arbitrary groupings: see per eg. relatedinfo template -->
	<xsl:template name="archdesc_minor_children">
		<xsl:param name="label"/>
		<xsl:param name="nodeName"/>
		<xsl:param name="withLabel"/>
		<xsl:param name="foo"/>
		<div class="{name()}">
			<!--<xsl:value-of select="$nodeName"/> label <xsl:value-of select="$label"/>: not in XSLT 1.0, you don't!-->

				<!-- 
				original SY code <xsl:if test="$withLabel='true' and not(./head)"> -->
				<!-- 2004-07-16 carlsonm mod, ignore <head> tags -->
				<xsl:if test="$withLabel='true'">
				<b>
					<xsl:choose>
						<!--pull in correct label, depending on what is actually matched-->
						<xsl:when test="name()='altformavail'">
							<a name="{$altformavail_id}" />
							<xsl:value-of select="$altformavail_label"/>
						</xsl:when>
						<xsl:when test="name()='arrangement'">
							<a name="{$arrangement_label}"/>
							<xsl:value-of select="$arrangement_label"/>
						</xsl:when>
						<xsl:when test="name()='bibliography'">
							<a name="{$bibliography_id}" />
							<xsl:value-of select="$bibliography_label"/>
						</xsl:when>
						<xsl:when test="name()='accessrestrict'">
							<a name="{$accessrestrict_id}"/>
							<xsl:value-of select="$accessrestrict_label"/>
						</xsl:when>
						<xsl:when test="name()='userestrict'">
							<a name="{$userestrict_id}" />
							<xsl:value-of select="$userestrict_label"/>
						</xsl:when>
						<xsl:when test="name()='prefercite'">
							<a name="{$prefercite_id}" />
							<xsl:value-of select="$prefercite_label"/>
						</xsl:when>
						<xsl:when test="name()='accruals'">
							<a name="{$accruals_id}" />
							<xsl:value-of select="$accruals_label"/>
						</xsl:when>
						<xsl:when test="name()='acqinfo'">
							<a name="{$acqinfo_id}" />
							<xsl:value-of select="$acqinfo_label"/>
						</xsl:when>
						<xsl:when test="name()='appraisal'">
							<a name="{$appraisal_id}"/>
							<xsl:value-of select="$appraisal_label"/>
						</xsl:when>
						<!-- original SY code
						<xsl:when test="name()='bibliography' and ./head">

							<a name="{$bibliography_id}"/>
							<xsl:value-of select="./head/text()"/>
						</xsl:when>
						-->
						<xsl:when test="name()='custodhist'">
							<a name="{$custodhist_id}" />
							<xsl:value-of select="$custodhist_label"/>
						</xsl:when>
						<xsl:when test="name()='scopecontent'">
							<a name="{$scopecontent_label}" />
							<xsl:value-of select="$scopecontent_label"/>
						</xsl:when>
						<xsl:when test="name()='separatedmaterial'">
							<a name="{$separatedmaterial_id}" />
							<xsl:value-of select="$separatedmaterial_label"/>
						</xsl:when>
						<xsl:when test="name()='relatedmaterial'">
							<a name="{$relatedmaterial_id}"/>
							<xsl:value-of select="$relatedmaterial_label"/>
						</xsl:when>
						<xsl:when test="name()='originalsloc'">
							<a name="{$originalsloc_id}"/>
							<xsl:value-of select="$originalsloc_label"/>
						</xsl:when>
						<xsl:when test="name()='origination'">
							<a name="{$origination_id}"/>
							<xsl:value-of select="$origination_label"/>
						</xsl:when>
						
						<xsl:when test="name()='otherfindaid'">
							<a name="{$otherfindaid_id}"/>
							<xsl:value-of select="$otherfindaid_label"/>
						</xsl:when>
						<xsl:when test="name()='processinfo'">
							<a name="{$processinfo_id}"/>
							<xsl:value-of select="$processinfo_label"/>
						</xsl:when>
						<xsl:when test="name()='odd'">
							<a name="{$odd_id}" id="{$odd_id}"/>
							<xsl:value-of select="$odd_label"/>
						</xsl:when>
						<xsl:when test="name()='physdesc'">
							<a name="{$physdesc_id}"/>
							<xsl:value-of select="$physdesc_label"/>
						</xsl:when>
						<xsl:when test="name()='physloc'">
							<a name="{$physloc_id}"/>
							<xsl:value-of select="$physloc_label"/>
						</xsl:when>
						<xsl:when test="name()='phystech'">
							<a name="{$phystech_id}"/>
							<xsl:value-of select="$phystech_label"/>
						</xsl:when>
						<xsl:when test="name()='fileplan'">
							<a name="{$fileplan_id}" id="{$fileplan_id}"/>
							<xsl:value-of select="$fileplan_label"/>
						</xsl:when>
						<xsl:when test="name()='index'">
							<a name="{$index_id}" id="{$index_id}"/>
							<xsl:value-of select="$index_label"/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
					</b><!-- no colon in print ss per example :--><xsl:text>&#160;</xsl:text>
				</xsl:if>
				<xsl:apply-templates/>

		</div>
	</xsl:template>
	<!-- ********************* </ARCHDESC_MINOR_CHILDREN> *********************** -->

	<!-- ********************* <BIOGHIST> *********************** -->
	<xsl:template name="bioghist" match="//bioghist">
		<div class="bioghist">
			<xsl:choose>
				<!--Override the head!<xsl:when test="./head/text()!=''">
					<a name="{$bioghist_id}"></a>
					<h3 class="structhead">
						<xsl:value-of select="$bioghist_head"/>
					</h3>
				</xsl:when>-->
				<xsl:when test="./head/text()='Biographical Note'">
					<a name="{$bioghist_id}"></a>
					<h3 class="structhead">
						<xsl:value-of select="$bioghist_head"/>
					</h3>
				</xsl:when>
<!-- SY Original	<xsl:when test="starts-with(@encodinganalog, '545')"> -->
<!-- carlson mod 2004-07-09 only use Bioghist head if encodinganalog starts with 5450 as opposed to 5451 -->
				<xsl:when test="starts-with(@encodinganalog, '5450')">				
					<a name="{$bioghist_id}" ></a>
					<h3 class="structhead">
						<xsl:value-of select="$bioghist_head"/>

					</h3>
				</xsl:when>
				<xsl:otherwise>
					<a name="{$historical_id}"></a>
					<h3 class="structhead">
						<xsl:value-of select="$historical_head"/>

					</h3>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </BIOGHIST> *********************** -->



	<!-- ********************* <ODD> *********************** -->
	<xsl:template name="odd" match="//odd">
		<div class="odd">
			<a name="{$odd_id}"></a>
			<xsl:choose>
			
				<xsl:when test="@type='hist'">
					<h3 class="structhead">
						<xsl:value-of select="$odd_head_histbck"/>
					</h3>
				</xsl:when>
			
			<!-- supress independence of head:
				<xsl:when test="./head/text()!=''">
					<h3 class="structhead">
					<xsl:apply-templates select="head"/>
					</h3>
				</xsl:when>-->
				<xsl:otherwise>
					<h3 class="structhead">
						<xsl:value-of select="$odd_head"/>
					</h3>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </ODD> *********************** -->

	<!-- ********************* <SCOPECONTENT> *********************** -->
	<xsl:template name="scopecontent" match="scopecontent[1]">
		<div class="scopecontent">
			<a name="{$scopecontent_id}"></a>
					<h3 class="structhead">
						<xsl:value-of select="$scopecontent_head"/>
					</h3>
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </SCOPECONTENT> *********************** -->

	<!-- ********************* <ARRANGEMENT> *********************** -->
	<xsl:template name="arrangement" match="//arrangement">
		<div class="arrangement">
			<a name="{$arrangement_id}"></a>
					<h3 class="structhead">
						<xsl:value-of select="$arrangement_head"/>
					</h3>
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </ARRANGEMENT> *********************** -->

	<!-- ********************* <INDEX> *********************** -->
	<xsl:template match="//index" name="index">
		<div class="index">
			<a name="{$index_id}"></a>
					<h3 class="structhead">
						<xsl:value-of select="$index_head"/>
					</h3>
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </INDEX> *********************** -->

	<!-- ********************* <ADMININFO> *********************** -->
	<xsl:template name="admininfo">
		<xsl:if test="acqinfo | accruals | custodhist | processinfo | separatedmaterial | originalsloc">
			<div class="info">
				<a name="{$admininfo_id}"></a>
						<h3 class="structhead">
							<xsl:value-of select="$admininfo_head"/>
				</h3>
<!--
				<xsl:choose>
					<xsl:when test="./head/text()!=''">
						<xsl:apply-templates select="head"/>
					</xsl:when>
					<xsl:otherwise>
						<h3 class="structhead">
							<xsl:value-of select="$admininfo_head"/>
						</h3>
					</xsl:otherwise>
				</xsl:choose>
-->
				<xsl:for-each select="acqinfo | accruals | custodhist | processinfo | separatedmaterial | originalsloc">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </ADMININFO> *********************** -->

	<!-- ********************* <USEINFO> *********************** -->
	<xsl:template name="useinfo">
		<xsl:if test="accessrestrict | userestrict | prefercite | altformavail">
			<div class="info">
				<a name="{$useinfo_id}"></a>
						<h3 class="structhead">
							<xsl:value-of select="$useinfo_head"/>
						</h3>
<!--
				<xsl:choose>
					<xsl:when test="./head/text()!=''">
						<xsl:apply-templates select="head"/>
					</xsl:when>
					<xsl:otherwise>
						<h3 class="structhead">
							<xsl:value-of select="$useinfo_head"/>
						</h3>
					</xsl:otherwise>
				</xsl:choose>
-->
				<xsl:for-each select="accessrestrict | userestrict | prefercite | altformavail">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </USEINFO> *********************** -->

	<!-- ********************* <RELATEDINFO> *********************** -->
	<xsl:template name="relatedinfo">
		<xsl:if test="bibliography | otherfindaid | relatedmaterial">
			<div class="info">
				<a name="{$relatedinfo_id}"></a>
						<h3 class="structhead">
							<xsl:value-of select="$relatedinfo_head"/>
						</h3>
<!--
				<xsl:choose>
					<xsl:when test="./head/text()!=''">
						<xsl:apply-templates select="head"/>
					</xsl:when>
					<xsl:otherwise>
						<h3 class="structhead">
							<xsl:value-of select="$relatedinfo_head"/>
						</h3>
					</xsl:otherwise>
				</xsl:choose>
-->
				<xsl:for-each select="bibliography | otherfindaid | relatedmaterial">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- ********************* </RELATEDINFO> *********************** -->
</xsl:stylesheet>