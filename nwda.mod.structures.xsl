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
	xmlns:res="http://www.w3.org/2005/sparql-results#" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#"
	xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:ead="urn:isbn:1-931666-22-9"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="nwda xsd vcard xsl msxsl exsl ead
	rdf foaf dcterms">

	<xsl:template match="*[local-name()='profiledesc'] | *[local-name()='revisiondesc'] | *[local-name()='filedesc'] | *[local-name()='eadheader'] | *[local-name()='frontmatter']"/>

	<!-- ********************* <FOOTER> *********************** -->

	<xsl:template match="*[local-name()='publicationstmt']">
		<h4>
			<xsl:value-of select="/*[local-name()='ead']/*[local-name()='eadheader']//*[local-name()='titlestmt']/*[local-name()='author']"/>
			<br/>
			<xsl:value-of select="./*[local-name()='date']"/>
		</h4>
		<!--<xsl:if test="$editor-active = 'true'">
			<xsl:if test="string($rdf//foaf:thumbnail/@rdf:resource)">
				<img alt="institutional logo" style="max-height:100px" src="{$rdf//foaf:thumbnail/@rdf:resource}"/>
			</xsl:if>
		</xsl:if>-->
	</xsl:template>

	<!-- ********************* <END FOOTER> *********************** -->
	<!-- ********************* <OVERVIEW> *********************** -->
	<xsl:template match="*[local-name()='archdesc']" mode="flag">
		<div class="col-md-3 navBody hidden-xs hidden-sm">
			<div class="toc-fixed">
				<xsl:call-template name="toc"/>
			</div>
		</div>
		<div class="col-md-9">
			<div id="special1" style="margin: 20px 0;">
				<!-- banner -->
			</div>
			<h1 class="color1">
				<xsl:value-of select="normalize-space(/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unittitle'])"/>
				<xsl:if test="/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="/*[local-name()='ead']/*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']"/>
				</xsl:if>
			</h1>
			<div class="archdesc" id="docBody">
				<xsl:call-template name="collection_overview"/>
				<hr/>
				<div class="navBody visible-xs visible-sm hidden-md">
					<xsl:call-template name="toc"/>
					<hr/>
				</div>
				<xsl:apply-templates select="*[local-name()='controlaccess']"/>
				<hr/>
				<xsl:apply-templates select="*[local-name()='bioghist'] | *[local-name()='scopecontent'] | *[local-name()='odd']"/>
				<xsl:call-template name="useinfo"/>
				<xsl:call-template name="administrative_info"/>
				<hr/>

				<xsl:apply-templates select="*[local-name()='dsc']"/>

			</div>
			<div class="footer">
				<xsl:apply-templates select="/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='filedesc']/*[local-name()='publicationstmt']"/>
			</div>
		</div>

	</xsl:template>

	<!-- ********************* COLLECTION OVERVIEW *********************** -->
	<xsl:template name="collection_overview">
		<h3>
			<a id="overview"/>
			<xsl:value-of select="$overview_head"/>
			<small>
				<a href="#" class="toggle-button" id="toggle-overview">
					<span class="glyphicon glyphicon-triangle-bottom"> </span>
				</a>
			</small>
		</h3>
		<div class="overview overview-content">
			<dl class="dl-horizontal">
				<!--origination-->
				<xsl:if test="string(*[local-name()='did']/*[local-name()='origination'])">
					<dt>
						<xsl:choose>
							<xsl:when test="*[local-name()='did']/*[local-name()='origination']/*/@role">
								<xsl:variable name="orig1" select="substring(*[local-name()='did']/*[local-name()='origination']/*/@role, 1, 1)"/>
								<xsl:value-of select="translate($orig1, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
								<xsl:value-of select="substring(*[local-name()='did']/*[local-name()='origination']/*/@role, 2)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$origination_label"/>
							</xsl:otherwise>
						</xsl:choose>
					</dt>
					<dd property="dcterms:creator">
						<xsl:apply-templates select="*[local-name()='did']/*[local-name()='origination']"/>
					</dd>
				</xsl:if>
				<!--collection title-->
				<xsl:if test="*[local-name()='did']/*[local-name()='unittitle']">
					<dt>
						<xsl:value-of select="$unittitle_label"/>
					</dt>
					<dd property="dcterms:title">
						<xsl:apply-templates select="*[local-name()='did']/*[local-name()='unittitle'][1]"/>
					</dd>
				</xsl:if>
				<!--collection dates-->
				<xsl:if test="*[local-name()='did']/*[local-name()='unitdate']">
					<dt>
						<xsl:value-of select="$dates_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="*[local-name()='did']/*[local-name()='unitdate']" mode="archdesc"/>
					</dd>
				</xsl:if>
				<!--collection physdesc-->
				<xsl:if test="*[local-name()='did']/*[local-name()='physdesc']">
					<dt>
						<xsl:value-of select="$physdesc_label"/>
					</dt>
					<dd>
						<xsl:for-each select="*[local-name()='did']/*[local-name()='physdesc']">
							<xsl:apply-templates select="*[local-name()='extent']"/>
							<!-- multiple extents contained in parantheses -->
							<xsl:if test="string(*[local-name()='physfacet']) and string(*[local-name()='extent'])"> &#160;:&#160; </xsl:if>
							<xsl:apply-templates select="*[local-name()='physfacet']"/>
							<xsl:if test="string(*[local-name()='dimensions']) and string(*[local-name()='physfacet'])"> &#160;;&#160; </xsl:if>
							<xsl:apply-templates select="*[local-name()='dimensions']"/>
							<xsl:if test="not(position()=last())">
								<br/>
							</xsl:if>
						</xsl:for-each>
					</dd>
				</xsl:if>
				<!--collection #-->
				<xsl:if test="*[local-name()='did']/*[local-name()='unitid']">
					<dt>
						<xsl:value-of select="$collectionNumber_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="*[local-name()='did']/*[local-name()='unitid']" mode="archdesc"/>
					</dd>
				</xsl:if>
				<!--collection abstract/summary-->
				<xsl:if test="*[local-name()='did']/*[local-name()='abstract']">
					<dt>
						<xsl:value-of select="$abstract_label"/>
					</dt>
					<dd property="dcterms:abstract">
						<xsl:apply-templates select="*[local-name()='did']/*[local-name()='abstract']"/>
					</dd>
				</xsl:if>
				<!--contact information-->
				<xsl:choose>
					<xsl:when test="$editor-active='true'">
						<dt>
							<xsl:value-of select="$contactinformation_label"/>
						</dt>
						<dd>
							<xsl:choose xml:id="process-rdf">
								<xsl:when test="$platform='linux'">
									<xsl:apply-templates select="exsl:node-set($rdf)//arch:Archive" mode="repository"/>
									<xsl:apply-templates select="exsl:node-set($rdf)//arch:Archive" mode="contact"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="msxsl:node-set($rdf)//arch:Archive" mode="repository"/>
									<xsl:apply-templates select="msxsl:node-set($rdf)//arch:Archive" mode="contact"/>
								</xsl:otherwise>
							</xsl:choose>

						</dd>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="*[local-name()='did']/*[local-name()='repository']">
							<dt>
								<xsl:value-of select="$contactinformation_label"/>
							</dt>
							<dd>
								<xsl:for-each select="*[local-name()='did']/*[local-name()='repository']">
									<xsl:variable name="selfRepos">
										<xsl:value-of select="normalize-space(text())"/>
									</xsl:variable>
									<xsl:if test="string-length($selfRepos)&gt;0">
										<span property="arch:heldBy">
											<xsl:value-of select="$selfRepos"/>
										</span>
										<br/>
									</xsl:if>
									<xsl:if test="string(*[local-name()='corpname'])">
										<xsl:for-each select="*[local-name()='corpname']">
											<xsl:if test="string-length(.)&gt;string-length(*[local-name()='subarea'])">
												<span property="arch:heldBy">
													<xsl:apply-templates select="text()|*[not(self::*[local-name()='subarea'])]"/>
												</span>
												<br/>
											</xsl:if>
										</xsl:for-each>
										<xsl:if test="string(*[local-name()='corpname']/*[local-name()='subarea'])">
											<xsl:for-each select="*[local-name()='corpname']/*[local-name()='subarea']">
												<xsl:apply-templates/>
												<br/>
											</xsl:for-each>
										</xsl:if>
									</xsl:if>
									<xsl:if test="string(*[local-name()='subarea'])">
										<xsl:apply-templates select="*[local-name()='subarea']"/>
										<br/>
									</xsl:if>
									<xsl:if test="string(*[local-name()='address'])">
										<xsl:apply-templates select="*[local-name()='address']"/>
									</xsl:if>
								</xsl:for-each>
							</dd>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

				<!-- inserted accessrestrict as per March 2015 revision specifications -->
				<xsl:if test="*[local-name()='accessrestrict']">
					<dt>
						<xsl:value-of select="$accessrestrict_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="*[local-name()='accessrestrict']"/>						
					</dd>
				</xsl:if>

				<!-- inserted accessrestrict as per March 2015 revision specifications -->
				<xsl:if test="*[local-name()='otherfindaid']">
					<dt>
						<xsl:value-of select="$otherfindaid_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="*[local-name()='otherfindaid']"/>						
					</dd>
				</xsl:if>

				<!--finding aid creation information-->
				<xsl:if test="/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='profiledesc']/*[local-name()='creation'] and $showCreation='true'">
					<dt>
						<xsl:value-of select="$creation_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='profiledesc']/*[local-name()='creation']"/>
					</dd>
				</xsl:if>

				<!--finding aid revision information-->
				<xsl:if test="/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='profiledesc']/*[local-name()='creation'] and $showRevision='true'">
					<dt>
						<xsl:value-of select="$revision_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="/*[local-name()='ead']/*[local-name()='eadheader']/*[local-name()='revisiondesc']/*[local-name()='change']"/>
					</dd>
				</xsl:if>

				<!--language note-->
				<xsl:if test="*[local-name()='did']/*[local-name()='langmaterial']">
					<dt>
						<xsl:value-of select="$langmaterial_label"/>
					</dt>
					<dd>
						<xsl:choose>
							<xsl:when test="*[local-name()='langmaterial']/text()">
								<span property="dcterms:language">
									<xsl:apply-templates select="*[local-name()='did']/*[local-name()='langmaterial']"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="*[local-name()='did']/*[local-name()='langmaterial']/*[local-name()='language']">
									<span property="dcterms:language">
										<xsl:apply-templates select="."/>
									</span>
									<xsl:if test="not(position()=last())">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</dd>
				</xsl:if>
				<!--sponsor; March 2015, moved sponsor to Administration Information -->
				<!--<xsl:if test="/ead/eadheader//sponsor[1]">
						<dt>
							<xsl:value-of select="$sponsor_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="/ead/eadheader//sponsor[1]"/>
						</dd>
					</xsl:if>-->
				<!-- display link to Harvester CHOs if $hasCHOs is 'true' -->
				<xsl:if test="$hasCHOs = 'true'">
					<dt>Digital Objects</dt>
					<dd>
						<!-- call the Harvester API to display thumbnails.-->
						<xsl:apply-templates select="document(concat('http://harvester.orbiscascade.org/apis/get?ark=ark:/', //*[local-name()='eadid']/@identifier,
							'&amp;format=xml&amp;limit=5'))//res:result"/>

						<!-- create link to display the full results, call Harvester Count API -->
						<xsl:variable name="count">
							<xsl:value-of select="document(concat('http://harvester.orbiscascade.org/apis/count?ark=ark:/', //*[local-name()='eadid']/@identifier))//response"/>
						</xsl:variable>
						<br/>
                        <a href="{$serverURL}/do.aspx?ark=ark:/{//*[local-name()='eadid']/@identifier}" target="_blank"><xsl:value-of select="$count"/> total - see all</a>
					</dd>
				</xsl:if>
			</dl>
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
						<xsl:value-of select="*[local-name()='did']/*[local-name()='daogrp']/*[local-name()='daoloc']/@href | *[local-name()='daogrp']/*[local-name()='daoloc']/@href"/>
					</xsl:attribute>
				</xsl:element>
			</div>


			<div>
				<xsl:apply-templates select="*[local-name()='did']/*[local-name()='daogrp']/*[local-name()='daodesc'] | *[local-name()='daogrp']/*[local-name()='daodesc']"/>
			</div>
		</div>

	</xsl:template>
	<!-- ********************* END COLLECTION IMAGE *********************** -->
	<!-- ********************* <ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!--this template generically called by arbitrary groupings: see per eg. relatedinfo template -->
	<xsl:template name="archdesc_minor_children">
		<xsl:param name="withLabel"/>
		<xsl:if test="$withLabel='true'">
			<h4>
				<xsl:if test="@id">
					<a id="{@id}"/>
				</xsl:if>
				<xsl:choose>
					<!--pull in correct label, depending on what is actually matched-->
					<xsl:when test="local-name()='altformavail'">
						<a id="{$altformavail_id}"/>
						<xsl:value-of select="$altformavail_label"/>
					</xsl:when>
					<xsl:when test="local-name()='arrangement'">
						<a id="{$arrangement_label}"/>
						<xsl:value-of select="$arrangement_label"/>
					</xsl:when>
					<xsl:when test="local-name()='bibliography'">
						<a id="{$bibliography_id}"/>
						<xsl:value-of select="$bibliography_label"/>
					</xsl:when>
					<xsl:when test="local-name()='accessrestrict'">
						<a id="{$accessrestrict_id}"/>
						<xsl:value-of select="$accessrestrict_label"/>
					</xsl:when>
					<xsl:when test="local-name()='userestrict'">
						<a id="{$userestrict_id}"/>
						<xsl:value-of select="$userestrict_label"/>
					</xsl:when>
					<xsl:when test="local-name()='prefercite'">
						<a id="{$prefercite_id}"/>
						<xsl:value-of select="$prefercite_label"/>
					</xsl:when>
					<xsl:when test="local-name()='accruals'">
						<a id="{$accruals_id}"/>
						<xsl:value-of select="$accruals_label"/>
					</xsl:when>
					<xsl:when test="local-name()='acqinfo'">
						<a id="{$acqinfo_id}"/>
						<xsl:value-of select="$acqinfo_label"/>
					</xsl:when>
					<xsl:when test="local-name()='appraisal'">
						<a id="{$appraisal_id}"/>
						<xsl:value-of select="$appraisal_label"/>
					</xsl:when>
					<!-- original SY code
						<xsl:when test="local-name()='bibliography' and ./head">

							<a name="{$bibliography_id}"></a>
							<xsl:value-of select="./head/text()"/>
						</xsl:when>
						-->
					<xsl:when test="local-name()='custodhist'">
						<a id="{$custodhist_id}"/>
						<xsl:value-of select="$custodhist_label"/>
					</xsl:when>
					<xsl:when test="local-name()='scopecontent'">
						<a id="{$scopecontent_label}"/>
						<xsl:value-of select="$scopecontent_label"/>
					</xsl:when>
					<xsl:when test="local-name()='separatedmaterial'">
						<a id="{$separatedmaterial_id}"/>
						<xsl:value-of select="$separatedmaterial_label"/>
					</xsl:when>
					<xsl:when test="local-name()='relatedmaterial'">
						<a id="{$relatedmaterial_id}"/>
						<xsl:value-of select="$relatedmaterial_label"/>
					</xsl:when>
					<xsl:when test="local-name()='originalsloc'">
						<a id="{$originalsloc_id}"/>
						<xsl:value-of select="$originalsloc_label"/>
					</xsl:when>
					<xsl:when test="local-name()='origination'">
						<a id="{$origination_id}"/>
						<xsl:value-of select="$origination_label"/>
					</xsl:when>
					<xsl:when test="local-name()='otherfindaid'">
						<a id="{$otherfindaid_id}"/>
						<xsl:value-of select="$otherfindaid_label"/>
					</xsl:when>
					<xsl:when test="local-name()='processinfo'">
						<a id="{$processinfo_id}"/>
						<xsl:value-of select="$processinfo_label"/>
					</xsl:when>
					<xsl:when test="local-name()='odd'">
						<a id="{$odd_id}"/>
						<xsl:value-of select="$odd_label"/>
					</xsl:when>
					<xsl:when test="local-name()='physdesc'">
						<a id="{$physdesc_id}"/>
						<xsl:value-of select="$physdesc_label"/>
					</xsl:when>
					<xsl:when test="local-name()='physloc'">
						<a id="{$physloc_id}"/>
						<xsl:value-of select="$physloc_label"/>
					</xsl:when>
					<xsl:when test="local-name()='phystech'">
						<a id="{$phystech_id}"/>
						<xsl:value-of select="$phystech_label"/>
					</xsl:when>
					<xsl:when test="local-name()='fileplan'">
						<a id="{$fileplan_id}"/>
						<xsl:value-of select="$fileplan_label"/>
					</xsl:when>
					<xsl:when test="local-name()='index'">
						<a id="{$index_id}"/>
						<xsl:value-of select="$index_label"/>
					</xsl:when>
					<xsl:when test="local-name()='sponsor'">
						<xsl:value-of select="$sponsor_label"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</h4>
		</xsl:if>
		<!-- 2004-11-30 Suppress the display of all <head> elements (with exceptions).  Example, Pauling finding aid of OSU SC -->
		<!-- 2004-12-06 Process physdesc separately -->
		<xsl:choose>
			<xsl:when test="self::*[local-name()='physdesc']">
				<div class="{name()}">
					<xsl:apply-templates select="*[local-name()='extent']"/>
					<xsl:if test="string(*[local-name()='physfacet']) and string(*[local-name()='extent'])">
						<xsl:text> : </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="*[local-name()='physfacet']"/>
					<xsl:if test="string(*[local-name()='dimensions']) and string(*[local-name()='physfacet'])">
						<xsl:text> ; </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="*[local-name()='dimensions']"/>
				</div>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates select="self::node()"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="self::*[local-name()='origination'] and child::*/@role"> &#160;( <xsl:value-of select="child::*/@role"/>) </xsl:if>

	</xsl:template>
	<!-- ********************* </ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!-- ********************* <BIOGHIST> *********************** -->
	<xsl:template name="bioghist" match="//*[local-name()='bioghist']">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::*[local-name()='archdesc']">
					<xsl:text>top_bioghist</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>bioghist</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>

		<xsl:choose>
			<xsl:when test="*[local-name()='head']/text()='Biographical Note' and not(ancestor::*[local-name()='dsc'])">
				<a id="{$bioghist_id}"/>
				<h3>
					<xsl:value-of select="$bioghist_head"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-triangle-bottom"> </span>
						</a>
					</small>
					<small>
						<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
					</small>
				</h3>

			</xsl:when>
			<!-- SY Original	<xsl:when test="starts-with(@encodinganalog, '545')"> -->
			<!-- carlson mod 2004-07-09 only use Bioghist head if encodinganalog starts with 5450 as opposed to 5451 -->
			<xsl:when test="starts-with(@encodinganalog, '5450') and not(ancestor::*[local-name()='dsc'])">
				<a id="{$bioghist_id}"/>
				<h3>
					<xsl:value-of select="$bioghist_head"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-triangle-bottom"> </span>
						</a>
					</small>
					<small>
						<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
					</small>
				</h3>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(ancestor::*[local-name()='dsc'])">
					<a id="{$historical_id}"/>
					<h3>
						<xsl:value-of select="$historical_head"/>
						<small>
							<a href="#" class="toggle-button" id="toggle-{$class}">
								<span class="glyphicon glyphicon-triangle-bottom"> </span>
							</a>
						</small>
						<small>
							<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
						</small>
					</h3>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<div>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="name(..) = 'archdesc'">
						<xsl:value-of select="concat($class, ' ', $class, '-content')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$class"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:for-each select="*[local-name()='p']">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </BIOGHIST> *********************** -->
	<!-- ********************* <SCOPECONTENT> *********************** -->
	<xsl:template name="scopecontent" match="*[local-name()='scopecontent'][1]">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::*[local-name()='archdesc']">
					<xsl:text>top_scopecontent</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>scopecontent</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="not(ancestor::*[local-name()='dsc'])">
			<a id="{$scopecontent_id}"/>
			<h3>
				<xsl:value-of select="$scopecontent_head"/>
				<small>
					<a href="#" class="toggle-button" id="toggle-{$class}">
						<span class="glyphicon glyphicon-triangle-bottom"> </span>
					</a>
				</small>
				<small>
					<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				</small>
			</h3>
		</xsl:if>

		<div>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="name(..) = 'archdesc'">
						<xsl:value-of select="concat($class, ' ', $class, '-content')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$class"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:for-each select="*[local-name()='p']">
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
	<xsl:template name="odd" match="//*[local-name()='odd']">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::*[local-name()='archdesc']">
					<xsl:text>top_odd</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>odd</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="@type='hist'  and not(ancestor::*[local-name()='dsc'])">
				<a id="{$odd_id}"/>
				<h3>
					<xsl:value-of select="$odd_head_histbck"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-triangle-bottom"> </span>
						</a>
					</small>
					<small>
						<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
					</small>
				</h3>
			</xsl:when>
			<xsl:otherwise>
				<a id="{$odd_id}"/>
				<h3>
					<xsl:value-of select="$odd_head"/>
					<small>
						<a href="#" class="toggle-button" id="toggle-{$class}">
							<span class="glyphicon glyphicon-triangle-bottom"> </span>
						</a>
					</small>
					<small>
						<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
					</small>
				</h3>
			</xsl:otherwise>
		</xsl:choose>

		<div>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="name(..) = 'archdesc'">
						<xsl:value-of select="concat($class, ' ', $class, '-content')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$class"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:for-each select="*[local-name()='p']">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </ODD> *********************** -->
	<!-- ********************* <USEINFO> *********************** -->
	<xsl:template name="useinfo">
		<!-- removed accessrestrict from this section, moved to Collection Overview, as per March 2015 spec -->
		<xsl:if test="*[local-name()='altformavail'] | *[local-name()='userestrict'] | *[local-name()='prefercite']">
			<h3>
				<xsl:if test="@id">
					<a id="{@id}"/>
				</xsl:if>
				<a id="{$useinfo_id}"/>
				<xsl:value-of select="$useinfo_head"/>
				<small>
					<a href="#" class="toggle-button" id="toggle-usediv">
						<span class="glyphicon glyphicon-triangle-bottom"> </span>
					</a>
				</small>
				<small>
					<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				</small>
			</h3>
			<div class="use usediv-content">
				<xsl:for-each select="*[local-name()='altformavail'] | *[local-name()='userestrict'] | *[local-name()='prefercite']">
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
					<span class="glyphicon glyphicon-triangle-right"> </span>
				</a>
			</small>
			<small>
				<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
			</small>
		</h3>
		<div class="ai ai-content" style="display:none">
			<xsl:apply-templates select="*[local-name()='arrangement']"/>
			<xsl:call-template name="admininfo"/>
			<xsl:if test="string(*[local-name()='index'][not(ancestor::*[local-name()='dsc'])])">
				<xsl:apply-templates select="*[local-name()='index']"/>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ******************** END ADMINISTRATIVE INFO ******************** -->
	<!-- ********************* <ARRANGEMENT> *********************** -->
	<xsl:template name="arrangement" match="//*[local-name()='arrangement']">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::*[local-name()='archdesc']">
					<xsl:text>top_arrangement</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>arrangement</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="not(ancestor::*[local-name()='dsc'])">
			<xsl:if test="@id">
				<a id="{@id}"/>
			</xsl:if>
			<a id="{$arrangement_id}"/>
			<h4>Arrangement</h4>
		</xsl:if>
		<div class="{$class}">
			<xsl:apply-templates select="./*[not(self::*[local-name()='head'])]"/>
		</div>
	</xsl:template>
	<!-- ********************* </ARRANGEMENT> *********************** -->
	<!-- ********************* <ADMININFO> *********************** -->
	<xsl:template name="admininfo">
		<xsl:if test="*[local-name()='acqinfo'] | *[local-name()='accruals'] | *[local-name()='custodhist'] | *[local-name()='processinfo'] | *[local-name()='separatedmaterial'] |
			*[local-name()='bibliography'] | *[local-name()='relatedmaterial'] | *[local-name()='did']/*[local-name()='physloc'] | *[local-name()='originalsloc'] | *[local-name()='appraisal'] |
			//*[local-name()='sponsor']">
			<xsl:if test="not(ancestor::*[local-name()='dsc'])">
				<xsl:choose>
					<xsl:when test="@id">
						<a id="{@id}"/>
					</xsl:when>
					<xsl:otherwise>
						<a id="{$admininfo_id}"/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:if>
			<div class="admininfo">
				<xsl:for-each select="*[local-name()='custodhist'] | *[local-name()='acqinfo'] | *[local-name()='accruals'] | *[local-name()='processinfo'] | *[local-name()='separatedmaterial'] |
					*[local-name()='bibliography'] | *[local-name()='relatedmaterial'] | *[local-name()='appraisal'] | *[local-name()='did']/*[local-name()='physloc'] | *[local-name()='originalsloc'] |
					//*[local-name()='sponsor']">
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
	<xsl:template match="*[local-name()='index']" name="index">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::*[local-name()='archdesc']">
					<xsl:text>top_index</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>index</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="not(ancestor::*[local-name()='dsc'])">
			<xsl:if test="@id">
				<a id="{@id}"/>
			</xsl:if>
			<a id="{$index_id}"/>
		</xsl:if>

		<div class="{$class}">
			<xsl:apply-templates select="*[local-name()='p']"/>
			<xsl:if test="count(*[local-name()='indexentry']) &gt; 0">
				<table class="table table-striped">
					<xsl:apply-templates select="*[local-name()='listhead']" mode="index"/>
					<tbody>
						<xsl:apply-templates select="*[local-name()='indexentry']" mode="index"/>
					</tbody>
				</table>
			</xsl:if>
		</div>
		<xsl:call-template name="sect_separator"/>
	</xsl:template>

	<xsl:template match="*[local-name()='listhead']" mode="index">
		<thead>
			<tr>
				<th style="width:50%">
					<xsl:apply-templates select="*[local-name()='head01']"/>
				</th>
				<th>
					<xsl:apply-templates select="*[local-name()='head02']"/>
				</th>
			</tr>
		</thead>

	</xsl:template>

	<xsl:template match="*[local-name()='indexentry']" mode="index">
		<tr>
			<td>
				<xsl:apply-templates select="*[local-name()='corpname'] | *[local-name()='famname'] | *[local-name()='function'] | *[local-name()='genreform'] | *[local-name()='geogname'] |
					*[local-name()='name'] | *[local-name()='occupation'] | *[local-name()='persname'] | *[local-name()='subject'] | *[local-name()='title']"/>
			</td>
			<td>
				<xsl:for-each select="*[local-name()='ref'] | *[local-name()='ptrgrp']/*[local-name()='ref']">
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
	<xsl:template match="*[local-name()='c01']/*[local-name()='did']/*[local-name()='physloc']">
		<div class="physdesc">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- ********************* </physloc> ********************* -->
<xsl:template match="*[local-name()='c01']//*[local-name()='accessrestrict'] | *[local-name()='c01']//*[local-name()='userestrict'] | *[local-name()='c01']//*[local-name()='note'] | *[local-name()='c01']//*[local-name()='altformavail'] | *[local-name()='c01']//*[local-name()='custodhist'] | *[local-name()='c01']//*[local-name()='processinfo'] | *[local-name()='c01']//*[local-name()='separatedmaterial'] | *[local-name()='c01']//*[local-name()='acqinfo']">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="local-name()='accessrestrict'">
					<xsl:text>accessrestrict</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='userestrict'">
					<xsl:text>userestrict</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='note'">
					<xsl:text>note</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='altformavail'">
					<xsl:text>altformavail</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='custodhist'">
					<xsl:text>custodhist</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='processinfo'">
					<xsl:text>processinfo</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='separatedmaterial'">
					<xsl:text>separatedmaterial</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='acqinfo'">
					<xsl:text>acqinfo</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<div class="{$class}">
			<xsl:for-each select="*[local-name()='p']">
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
				<a href="{foaf:homepage/@rdf:resource}" target="_blank" property="arch:heldBy" resource="{@rdf:about}">
					<xsl:value-of select="foaf:name"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<span property="arch:heldBy" resource="{@rdf:about}">
					<xsl:value-of select="foaf:name"/>
				</span>
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

	<!-- July 2015: render the first 5 images from the Harvester API (SPARQL) -->
	<xsl:template match="res:result">
		<!-- get the image URL in the order of thumbnail, depiction, or default to generic document icon -->
		<xsl:variable name="image">
			<xsl:choose>
				<xsl:when test="res:binding[@name='thumbnail']">
					<xsl:value-of select="res:binding[@name='thumbnail']/res:uri"/>
				</xsl:when>
				<xsl:when test="res:binding[@name='depiction']">
					<xsl:value-of select="res:binding[@name='depiction']/res:uri"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($serverURL, '/fileicon.png')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<div class="thumbnail-minimal" style="background-image: url({$image});" title="{res:binding[@name='title']/res:literal}"/>
	</xsl:template>


</xsl:stylesheet>
