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
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/ewg118/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

	<xsl:template match="profiledesc | revisiondesc | filedesc | eadheader | frontmatter"/>

	<!-- ********************* <FOOTER> *********************** -->

	<xsl:template match="publicationstmt">
		<h4>
			<xsl:value-of select="/ead/eadheader//titlestmt/author"/>
			<br/>
			<xsl:value-of select="./date"/>
		</h4>
		<xsl:if test="$editor-active = 'true'">
			<xsl:if test="string($rdf//foaf:thumbnail/@rdf:resource)">
				<img alt="institutional logo" style="max-height:100px" src="{$rdf//foaf:thumbnail/@rdf:resource}"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- ********************* <END FOOTER> *********************** -->
	<!-- ********************* <OVERVIEW> *********************** -->
	<xsl:template match="archdesc">

		<!-- these variables are for defining the rowspan of a column that is created in the existence of a collection image or institutional logo.
		the rowspan was hardcoded as six, but if the rowspan does not exactly equal the number of rows in the Overview of Collection
		the institutional logo and collection image will not be aligned properly to the top or bottom, respectively.-->

		<!--		<xsl:variable name="did_children" select="count(did/child::node())"/>
		<xsl:variable name="sponsor">
			<xsl:choose>
				<xsl:when test="//sponsor[1]">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="creation">
			<xsl:choose>
				<xsl:when test="//profiledesc/creation and $showCreation='true'">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="revision">
			<xsl:choose>
				<xsl:when test="//profiledesc/creation and $showRevision='true'">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="overview_children"
			select="$did_children + $sponsor + $creation + $revision"/>-->

		<h3>
			<xsl:if test="@id">
				<a id="{@id}"/>
			</xsl:if>
			<a id="overview"/>
			<xsl:value-of select="$overview_head"/>
			<small>
				<a href="#" class="toggle-button" id="toggle-overview">
					<span class="glyphicon glyphicon-minus"/>
				</a>
			</small>
		</h3>

		<div class="archdesc">
			<div class="overview" id="overview-content">
				<dl class="dl-horizontal">
					<!--origination-->
					<xsl:if test="string(did/origination)">
						<dt>
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
						</dt>
						<dd>
							<xsl:apply-templates select="did/origination"/>
						</dd>
					</xsl:if>
					<!--collection title-->
					<xsl:if test="did/unittitle">
						<dt>
							<xsl:value-of select="$unittitle_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="did/unittitle[1]"/>
						</dd>
					</xsl:if>
					<!--collection dates-->
					<xsl:if test="did/unitdate">
						<dt>
							<xsl:value-of select="$dates_label"/>
						</dt>
						<dd>
							<xsl:for-each select="did/unitdate">
								<!--ought to pull in unitdate template-->
								<xsl:apply-templates/>
								<xsl:if test="@type">
									<xsl:text> </xsl:text>( <xsl:value-of select="@type"/> ) </xsl:if>
								<xsl:if test="position() != last()">
									<br/>
								</xsl:if>

							</xsl:for-each>
						</dd>
					</xsl:if>
					<!--collection physdesc-->
					<xsl:if test="did/physdesc">
						<dt>
							<xsl:value-of select="$physdesc_label"/>
						</dt>
						<dd>
							<xsl:for-each select="did/physdesc">
								<xsl:apply-templates select="extent[1]"/>
								<!-- multiple extents contained in parantheses -->
								<xsl:if test="string(extent[2])">
									<xsl:text> </xsl:text>
									<xsl:for-each select="extent[position() &gt; 1]">
										<xsl:text>(</xsl:text>
										<xsl:value-of select="."/>
										<xsl:text>)</xsl:text>
										<xsl:if test="not(position() = last())">
											<xsl:text> </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="string(physfacet) and string(extent)"> &#160;:&#160; </xsl:if>
								<xsl:apply-templates select="physfacet"/>
								<xsl:if test="string(dimensions) and string(physfacet)"> &#160;;&#160; </xsl:if>
								<xsl:apply-templates select="dimensions"/>
								<xsl:if test="not(position()=last())">
									<br/>
								</xsl:if>
							</xsl:for-each>
						</dd>
					</xsl:if>
					<!--collection physloc-->
					<xsl:if test="did/physloc">
						<dt>
							<xsl:value-of select="$physloc_label"/>
						</dt>
						<dd>
							<xsl:for-each select="did/physloc">
								<xsl:apply-templates/>
								<xsl:if test="not(position()=last())">
									<br/>
								</xsl:if>
							</xsl:for-each>
						</dd>
					</xsl:if>
					<!--collection #-->
					<xsl:if test="did/unitid">
						<dt>
							<xsl:value-of select="$collectionNumber_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="did/unitid[1]"/>
							<xsl:if test="did/unitid[2]"> ( <xsl:value-of select="did/unitid[1]/@type"/>), <xsl:apply-templates select="did/unitid[2]"/> ( <xsl:value-of select="did/unitid[2]/@type"/>)
							</xsl:if>
						</dd>
					</xsl:if>
					<!--collection abstract/summary-->
					<xsl:if test="did/abstract">
						<dt>
							<xsl:value-of select="$abstract_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="did/abstract"/>
						</dd>
					</xsl:if>
					<!--contact information-->
					<xsl:choose>
						<xsl:when test="$editor-active='true'">
							<dt>
								<xsl:value-of select="$contactinformation_label"/>
							</dt>
							<dd>
								<xsl:apply-templates select="$rdf//arch:Archive" mode="repository"/>
								<xsl:apply-templates select="$rdf//arch:Archive" mode="contact"/>
							</dd>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="did/repository">
								<dt>
									<xsl:value-of select="$contactinformation_label"/>
								</dt>
								<dd>
									<xsl:for-each select="did/repository">
										<xsl:variable name="selfRepos">
											<xsl:apply-templates select="text()|*[not(self::*)]"/>
										</xsl:variable>
										<xsl:if test="string-length($selfRepos)&gt;0">
											<xsl:value-of select="$selfRepos"/>
											<br/>
										</xsl:if>
										<xsl:if test="string(corpname)">
											<xsl:for-each select="corpname">
												<xsl:if test="string-length(.)&gt;string-length(subarea)">
													<xsl:apply-templates select="text()|*[not(self::subarea)]"/>
													<br/>
												</xsl:if>
											</xsl:for-each>
											<xsl:if test="string(corpname/subarea)">
												<xsl:for-each select="corpname/subarea">
													<xsl:apply-templates/>
													<br/>
												</xsl:for-each>
											</xsl:if>
										</xsl:if>
										<xsl:if test="string(subarea)">
											<xsl:apply-templates select="subarea"/>
											<br/>
										</xsl:if>
										<xsl:if test="string(address)">
											<xsl:apply-templates select="address"/>
										</xsl:if>
									</xsl:for-each>
								</dd>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<!--finding aid creation information-->
					<xsl:if test="/ead/eadheader/profiledesc/creation and $showCreation='true'">
						<dt>
							<xsl:value-of select="$creation_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="/ead/eadheader/profiledesc/creation"/>
						</dd>
					</xsl:if>

					<!--finding aid revision information-->
					<xsl:if test="/ead/eadheader/profiledesc/creation and $showRevision='true'">
						<dt>
							<xsl:value-of select="$revision_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="/ead/eadheader/revisiondesc/change"/>
						</dd>
					</xsl:if>
					<!--language note-->
					<xsl:if test="did/langmaterial">
						<dt>
							<xsl:value-of select="$langmaterial_label"/>
						</dt>
						<dd>
							<xsl:choose>
								<xsl:when test="langmaterial/text()">
									<xsl:apply-templates select="did/langmaterial"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="did/langmaterial/language">
										<xsl:apply-templates select="."/>
										<xsl:if test="not(position()=last())">
											<xsl:text>, </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</dd>
					</xsl:if>
					<!--sponsor-->
					<xsl:if test="/ead/eadheader//sponsor[1]">
						<dt>
							<xsl:value-of select="$sponsor_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="/ead/eadheader//sponsor[1]"/>
						</dd>
					</xsl:if>
					<!-- display link to Harvester CHOs if $hasCHOs is 'true' -->
					<xsl:if test="$hasCHOs = 'true'">
						<dt>Cultural Heritage Objects</dt>
						<dd>
							<a href="{concat('http://harvester.orbiscascade.org/apis/get?ark=ark:/', //eadid/@identifier)}">
								<xsl:value-of select="concat('http://harvester.orbiscascade.org/apis/get?ark=ark:/', //eadid/@identifier)"/>
							</a>
						</dd>
					</xsl:if>
				</dl>
			</div>
			<hr/>
			<xsl:apply-templates select="bioghist | scopecontent | odd"/>
			<xsl:call-template name="useinfo"/>
			<xsl:call-template name="administrative_info"/>
			<hr/>

			<xsl:apply-templates select="dsc"/>
			<xsl:apply-templates select="controlaccess"/>
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

		<!-- the call for this template has been commented out so that only logos and not collection images display, EG 2007-08-27 -->

		<!-- margin-top is 100% to force collection image to be bottom-aligned while the institutional logo is top-aligned. -->
		<div style="padding:4px; text-align:center" class="collection_image">

			<div style="padding-top:20px;">
				<xsl:element name="img">
					<xsl:attribute name="src">
						<xsl:value-of select="did/daogrp/daoloc/@href | daogrp/daoloc/@href"/>
					</xsl:attribute>
				</xsl:element>
			</div>


			<div>
				<xsl:apply-templates select="did/daogrp/daodesc | daogrp/daodesc"/>
			</div>
		</div>

	</xsl:template>
	<!-- ********************* END COLLECTION IMAGE *********************** -->
	<!-- ********************* <ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!--this template generically called by arbitrary groupings: see per eg. relatedinfo template -->
	<xsl:template name="archdesc_minor_children">
		<xsl:param name="label"/>
		<xsl:param name="nodeName"/>
		<xsl:param name="withLabel"/>
		<xsl:param name="foo"/>
		<xsl:if test="$withLabel='true'">
			<b>
				<xsl:if test="@id">
					<a id="{@id}"/>
				</xsl:if>
				<xsl:choose>
					<!--pull in correct label, depending on what is actually matched-->
					<xsl:when test="name()='altformavail'">
						<a id="{$altformavail_id}"/>
						<xsl:value-of select="$altformavail_label"/>
					</xsl:when>
					<xsl:when test="name()='arrangement'">
						<a id="{$arrangement_label}"/>
						<xsl:value-of select="$arrangement_label"/>
					</xsl:when>
					<xsl:when test="name()='bibliography'">
						<a id="{$bibliography_id}"/>
						<xsl:value-of select="$bibliography_label"/>
					</xsl:when>
					<xsl:when test="name()='accessrestrict'">
						<a id="{$accessrestrict_id}"/>
						<xsl:value-of select="$accessrestrict_label"/>
					</xsl:when>
					<xsl:when test="name()='userestrict'">
						<a id="{$userestrict_id}"/>
						<xsl:value-of select="$userestrict_label"/>
					</xsl:when>
					<xsl:when test="name()='prefercite'">
						<a id="{$prefercite_id}"/>
						<xsl:value-of select="$prefercite_label"/>
					</xsl:when>
					<xsl:when test="name()='accruals'">
						<a id="{$accruals_id}"/>
						<xsl:value-of select="$accruals_label"/>
					</xsl:when>
					<xsl:when test="name()='acqinfo'">
						<a id="{$acqinfo_id}"/>
						<xsl:value-of select="$acqinfo_label"/>
					</xsl:when>
					<xsl:when test="name()='appraisal'">
						<a id="{$appraisal_id}"/>
						<xsl:value-of select="$appraisal_label"/>
					</xsl:when>
					<!-- original SY code
						<xsl:when test="name()='bibliography' and ./head">

							<a name="{$bibliography_id}"></a>
							<xsl:value-of select="./head/text()"/>
						</xsl:when>
						-->
					<xsl:when test="name()='custodhist'">
						<a id="{$custodhist_id}"/>
						<xsl:value-of select="$custodhist_label"/>
					</xsl:when>
					<xsl:when test="name()='scopecontent'">
						<a id="{$scopecontent_label}"/>
						<xsl:value-of select="$scopecontent_label"/>
					</xsl:when>
					<xsl:when test="name()='separatedmaterial'">
						<a id="{$separatedmaterial_id}"/>
						<xsl:value-of select="$separatedmaterial_label"/>
					</xsl:when>
					<xsl:when test="name()='relatedmaterial'">
						<a id="{$relatedmaterial_id}"/>
						<xsl:value-of select="$relatedmaterial_label"/>
					</xsl:when>
					<xsl:when test="name()='originalsloc'">
						<a id="{$originalsloc_id}"/>
						<xsl:value-of select="$originalsloc_label"/>
					</xsl:when>
					<xsl:when test="name()='origination'">
						<a id="{$origination_id}"/>
						<xsl:value-of select="$origination_label"/>
					</xsl:when>
					<xsl:when test="name()='otherfindaid'">
						<a id="{$otherfindaid_id}"/>
						<xsl:value-of select="$otherfindaid_label"/>
					</xsl:when>
					<xsl:when test="name()='processinfo'">
						<a id="{$processinfo_id}"/>
						<xsl:value-of select="$processinfo_label"/>
					</xsl:when>
					<xsl:when test="name()='odd'">
						<a id="{$odd_id}"/>
						<xsl:value-of select="$odd_label"/>
					</xsl:when>
					<xsl:when test="name()='physdesc'">
						<a id="{$physdesc_id}"/>
						<xsl:value-of select="$physdesc_label"/>
					</xsl:when>
					<xsl:when test="name()='physloc'">
						<a id="{$physloc_id}"/>
						<xsl:value-of select="$physloc_label"/>
					</xsl:when>
					<xsl:when test="name()='phystech'">
						<a id="{$phystech_id}"/>
						<xsl:value-of select="$phystech_label"/>
					</xsl:when>
					<xsl:when test="name()='fileplan'">
						<a id="{$fileplan_id}"/>
						<xsl:value-of select="$fileplan_label"/>
					</xsl:when>
					<xsl:when test="name()='index'">
						<a id="{$index_id}"/>
						<xsl:value-of select="$index_label"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</b> : <xsl:text>&#160;</xsl:text>
		</xsl:if>
		<!-- 2004-11-30 Suppress the display of all <head> elements (with exceptions).  Example, Pauling finding aid of OSU SC -->
		<!-- 2004-12-06 Process physdesc separately -->
		<xsl:choose>
			<xsl:when test="self::physdesc">
				<div class="{name()}">
					<xsl:apply-templates select="extent[1]"/>
					<xsl:if test="string(extent[2])"> &#160;( <xsl:apply-templates select="extent[2]"/>) </xsl:if>
					<xsl:if test="string(physfacet) and string(extent)"> &#160;:&#160; </xsl:if>
					<xsl:apply-templates select="physfacet"/>
					<xsl:if test="string(dimensions) and string(physfacet)"> &#160;;&#160; </xsl:if>
					<xsl:apply-templates select="dimensions"/>
				</div>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates select="self::node()"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="self::origination and child::*/@role"> &#160;( <xsl:value-of select="child::*/@role"/>) </xsl:if>

	</xsl:template>
	<!-- ********************* </ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!-- ********************* <BIOGHIST> *********************** -->
	<xsl:template name="bioghist" match="//bioghist">
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
				<a id="{$bioghist_id}"/>
				<h3>
					<xsl:value-of select="$bioghist_head"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-minus"/>
						</a>
					</small>
				</h3>
			</xsl:when>
			<!-- SY Original	<xsl:when test="starts-with(@encodinganalog, '545')"> -->
			<!-- carlson mod 2004-07-09 only use Bioghist head if encodinganalog starts with 5450 as opposed to 5451 -->
			<xsl:when test="starts-with(@encodinganalog, '5450') and not(ancestor::dsc)">
				<a id="{$bioghist_id}"/>
				<h3>
					<xsl:value-of select="$bioghist_head"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-minus"/>
						</a>
					</small>
				</h3>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(ancestor::dsc)">
					<a id="{$historical_id}"/>
					<h3>
						<xsl:value-of select="$historical_head"/>
						<small>
							<a href="#" class="toggle-button" id="toggle-{$class}">
								<span class="glyphicon glyphicon-minus"/>
							</a>
						</small>
					</h3>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<div class="{$class}">
			<xsl:if test="name(..) = 'archdesc'">
				<xsl:attribute name="id">
					<xsl:value-of select="concat($class, '-content')"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </BIOGHIST> *********************** -->
	<!-- ********************* <SCOPECONTENT> *********************** -->
	<xsl:template name="scopecontent" match="scopecontent[1]">
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
			<a id="{$scopecontent_id}"/>
			<h3>
				<xsl:value-of select="$scopecontent_head"/>
				<small>
					<a href="#" class="toggle-button" id="toggle-{$class}">
						<span class="glyphicon glyphicon-minus"/>
					</a>
				</small>
			</h3>
		</xsl:if>

		<div class="{$class}">
			<xsl:if test="name(..) = 'archdesc'">
				<xsl:attribute name="id">
					<xsl:value-of select="concat($class, '-content')"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
			<!--<xsl:apply-templates select="./*[not(self::head)]"/>-->
		</div>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </SCOPECONTENT> *********************** -->
	<!-- ********************* <ODD> *********************** -->
	<xsl:template name="odd" match="//odd">
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
				<a id="{$odd_id}"/>
				<h3>
					<xsl:value-of select="$odd_head_histbck"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-minus"/>
						</a>
					</small>
				</h3>
			</xsl:when>
			<xsl:otherwise>
				<a id="{$odd_id}"/>
				<h3>
					<xsl:value-of select="$odd_head"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-minus"/>
						</a>
					</small>
				</h3>
			</xsl:otherwise>
		</xsl:choose>

		<div class="{$class}">
			<xsl:if test="name(..) = 'archdesc'">
				<xsl:attribute name="id">
					<xsl:value-of select="concat($class, '-content')"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </ODD> *********************** -->
	<!-- ********************* <USEINFO> *********************** -->
	<xsl:template name="useinfo">
		<xsl:if test="altformavail | accessrestrict | userestrict | prefercite">
			<h3>
				<xsl:if test="@id">
					<a id="{@id}"/>
				</xsl:if>
				<a id="{$useinfo_id}"/>
				<xsl:value-of select="$useinfo_head"/>
				<small>
					<a href="#" class="toggle-button" id="toggle-usediv">
						<span class="glyphicon glyphicon-minus"/>
					</a>
				</small>
			</h3>
			<div class="use" id="usediv-content">
				<xsl:for-each select="altformavail | accessrestrict | userestrict | prefercite">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </USEINFO> *********************** -->
	<!-- ************************* ADMINISTRATIVE INFO - COLLAPSED BY DEFAULT ******************** -->
	<xsl:template name="administrative_info">
		<xsl:if test="@id">
			<a id="{@id}"/>
		</xsl:if>
		<a id="administrative_info"/>
		<h3>
			<xsl:text>Administrative Information</xsl:text>
			<small>
				<a href="#" class="toggle-button" id="toggle-ai">
					<span class="glyphicon glyphicon-minus"/>
				</a>
			</small>
		</h3>
		<div class="ai" id="ai-content">
			<xsl:apply-templates select="arrangement"/>
			<xsl:call-template name="admininfo"/>
			<xsl:if test="string(index[not(ancestor::dsc)])">
				<xsl:apply-templates select="index"/>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ******************** END ADMINISTRATIVE INFO ******************** -->
	<!-- ********************* <ARRANGEMENT> *********************** -->
	<xsl:template name="arrangement" match="//arrangement">
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
			<xsl:if test="@id">
				<a id="{@id}"/>
			</xsl:if>
			<a id="{$arrangement_id}"/>
			<b>Arrangement :</b>
		</xsl:if>
		<div class="{$class}">
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
	</xsl:template>
	<!-- ********************* </ARRANGEMENT> *********************** -->
	<!-- ********************* <ADMININFO> *********************** -->
	<xsl:template name="admininfo">
		<xsl:if test="acqinfo | accruals | custodhist | processinfo | separatedmaterial | bibliography | otherfindaid | relatedmaterial | originalsloc | appraisal">
			<xsl:if test="not(ancestor::dsc)">
				<xsl:if test="@id">
					<a id="{@id}"/>
				</xsl:if>
				<a id="{$admininfo_id}"/>
			</xsl:if>
			<div class="admininfo">
				<xsl:for-each select="custodhist | acqinfo | accruals | processinfo | separatedmaterial | bibliography | otherfindaid | relatedmaterial | appraisal | originalsloc">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
		<!--<xsl:call-template name="sect_separator" />-->
	</xsl:template>
	<!-- ********************* </ADMININFO> *********************** -->
	<!-- ********************* <INDEX> *********************** -->
	<xsl:template match="index" name="index">
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
			<xsl:if test="@id">
				<a id="{@id}"/>
			</xsl:if>
			<a id="{$index_id}"/>
		</xsl:if>
		<div class="{$class}">
			<table width="100%">
				<xsl:apply-templates select="p"/>
				<xsl:apply-templates select="listhead"/>
				<xsl:apply-templates select="indexentry"/>
			</table>
		</div>
		<xsl:call-template name="sect_separator"/>
	</xsl:template>

	<xsl:template match="listhead">
		<tr valign="top">
			<td style="padding-left: 10px; text-decoration:underline;" width="50%">
				<xsl:apply-templates select="head01"/>
			</td>
			<td style="padding-left: 10px; text-decoration:underline;" width="50%">
				<xsl:apply-templates select="head02"/>
			</td>
		</tr>

	</xsl:template>

	<xsl:template match="indexentry">
		<tr valign="top">
			<td style="padding-left: 10px;" width="50%">
				<xsl:apply-templates select="corpname | famname | function | genreform | geogname | name | occupation | persname | subject | title"/>
			</td>
			<td style="padding-left: 10px;" width="50%">
				<xsl:for-each select="ref | ptrgrp/ref">
					<xsl:choose>
						<xsl:when test="@target">
							<a href="#{@target}">
								<xsl:apply-templates/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="not(position() = last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>

	<!-- ********************* </INDEX> *********************** -->
	<!-- ********************* <physloc> ********************** -->
	<xsl:template match="c01/did/physloc">
		<div class="physdesc">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- ********************* </physloc> ********************* -->
	<xsl:template match="c01//accessrestrict | c01//userestrict | c01//note">
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

		<div class="{$class}">
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>

	<!-- 2014 September: templates for rendering repository metadata from RDF/XML -->
	<xsl:template match="arch:Archive" mode="repository">
		<xsl:choose>
			<xsl:when test="foaf:homepage/@rdf:resource">
				<a href="{foaf:homepage/@rdf:resource}" target="_blank">
					<xsl:value-of select="foaf:name"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="foaf:name"/>
			</xsl:otherwise>
		</xsl:choose>

		<br/>
		<xsl:if test="nwda:subRepository">
			<xsl:value-of select="nwda:subRepository"/>
			<br/>
		</xsl:if>

	</xsl:template>

	<xsl:template match="arch:Archive" mode="contact">
		<xsl:if test="vcard:hasAddress">
			<xsl:for-each select="vcard:hasAddress/rdf:Description/*">
				<xsl:value-of select="."/>
				<br/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="vcard:hasTelephone[vcard:Voice]">
			<xsl:variable name="number" select="substring-after(vcard:hasTelephone/vcard:Voice/vcard:hasValue/@rdf:resource, '+')"/>
			<xsl:text>Telephone: </xsl:text>
			<xsl:value-of select="concat(substring($number, 1, 3), '-', substring($number, 4, 3), '-', substring($number, 7, 4))"/>
			<br/>
		</xsl:if>
		<xsl:if test="vcard:hasTelephone[vcard:Fax]">
			<xsl:variable name="number" select="substring-after(vcard:hasTelephone/vcard:Fax/vcard:hasValue/@rdf:resource, '+')"/>
			<xsl:text>Fax: </xsl:text>
			<xsl:value-of select="concat(substring($number, 1, 3), '-', substring($number, 4, 3), '-', substring($number, 7, 4))"/>
			<br/>
		</xsl:if>
		<xsl:if test="string(vcard:hasEmail/@rdf:resource)">
			<a href="{vcard:hasEmail/@rdf:resource}">
				<xsl:value-of select="substring-after(vcard:hasEmail/@rdf:resource, ':')"/>
			</a>
			<br/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
