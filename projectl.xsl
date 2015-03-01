<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>-->
	<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8" indent="no"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

	<xsl:param name="doc"/>

	<!--<xsl:strip-space elements="*"/>-->
	<xsl:template match="processing-instruction()"/>

	<!-- <xsl:template match="text()">
<xsl:value-of select="normalize-space()"/>
</xsl:template>-->


	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="titleproper"
		select="normalize-space(ead/eadheader//titlestmt/titleproper[1])"/>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper"
		select="normalize-space(ead/eadheader//titlestmt/titleproper[@altrender])"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="//revisiondesc/change[position()=last()]/date/@normal"/>
	</xsl:variable>
	<!-- ********************* </XML_VARIABLES> *********************** -->
	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
		<!-- usage prefeerences to go here -->
	<!--USER definided-->
    <xsl:variable name="serverURL">http://nwda-db.orbiscascade.org</xsl:variable>
    <xsl:variable name="pathToFiles">http://nwda-db.orbiscascade.org/xsl/support/</xsl:variable>
	<!-- if 'true', will expand abbr/expan elements and attributes: Autograph Letter Signed (ALS)-->
	<xsl:variable name="expandAbbr">true</xsl:variable>
	<!-- if 'true', will display profiledesc/creation with $creation_label-->
	<xsl:variable name="showCreation">false</xsl:variable>
	<!-- if 'true', will display revisiondesc/creation with $revision_label-->
	<xsl:variable name="showRevision">false</xsl:variable>
	<!-- if 'true', will group controlled access points: all persnames together, for example-->
	<xsl:variable name="groupControlaccess">false</xsl:variable>
	<xsl:variable name="dateToday">2004-05-21</xsl:variable>
	<xsl:variable name="operator">Stephen Yearl</xsl:variable>
	<xsl:variable name="logoName">nwda.logo.gif</xsl:variable>
	<xsl:variable name="logoAlt">NWDA logo</xsl:variable>
	<xsl:variable name="homepage">http://www.nwda.org</xsl:variable>
	<xsl:variable name="repository">Your Repositiory</xsl:variable>
	<xsl:variable name="repositoryParent">Your Repositiory Parent Body</xsl:variable>
	<xsl:variable name="styleFileName">nwda.style.css</xsl:variable>
	<xsl:variable name="file" select="translate(//ead/@id, ' ', '')"/>
	<xsl:variable name="dscOrder">bfu</xsl:variable>
	<!--defunct-->
	<!-- ********************* </PREFERENCES.USAGE> *********************** -->
	<!-- ********************* <SECTION HEADS> *********************** -->
	<!--virtual-->
	<xsl:param name="admininfo_head">Administrative Information</xsl:param>
	<xsl:param name="admininfo_id">admininfoID</xsl:param>
	<xsl:param name="overview_head">Overview of the Collection</xsl:param>
	<xsl:param name="overview_id">overvireID</xsl:param>
	<xsl:param name="relatedinfo_head">Related Information</xsl:param>
	<xsl:param name="relatedinfo_id">relatedinfoID</xsl:param>
	<xsl:param name="useinfo_head">Use of the Collection</xsl:param>
	<xsl:param name="useinfo_id">useinfoID</xsl:param>
	<!--actual-->
	<xsl:param name="arrangement_head">Arrangement</xsl:param>
	<xsl:param name="arrangement_label">Arrangement</xsl:param>
	<xsl:param name="arrangement_id">arrangementID</xsl:param>
	<xsl:param name="bioghist_id">bioghistID</xsl:param>
	<xsl:param name="bioghist_head">Biographical Note</xsl:param>
	<xsl:param name="historical_id">historicalID</xsl:param>
	<xsl:param name="historical_head">Historical Note</xsl:param>
	<xsl:param name="dsc_head">Detailed Description of the Collection</xsl:param>
	<xsl:param name="dsc_id">dscID</xsl:param>
	<xsl:param name="odd_head">Other Descriptive Information</xsl:param>
	<!-- carlsonm mod 2004-07-09 adding a param for the 'Historical Background' heading -->
	<xsl:param name="odd_head_histbck">Historical Background</xsl:param>
	<!-- end carlsonm mod -->
	<xsl:param name="scopecontent_head">Content Description</xsl:param>
	<xsl:param name="scopecontent_label">Content Description</xsl:param>
	<xsl:param name="scopecontent_id">scopecontentID</xsl:param>
	<xsl:param name="controlaccess_head">Subjects</xsl:param>
	<xsl:param name="controlaccess_id">caID</xsl:param>
	<xsl:param name="othercreators_head">Other Creators</xsl:param>
	<xsl:param name="othercreators_id">ocID</xsl:param>
	<xsl:param name="index_head">Index</xsl:param>
	<xsl:template name="section_head">
		<xsl:param name="structhead"/>
		<h3 class="structhead">
			<xsl:value-of select="$structhead"/>
		</h3>
	</xsl:template>
	<!-- ********************* </SECTION HEADS> *********************** -->
	<!-- ********************* <LABELS> *********************** -->
	<!--Section heads and other labels will default to these values if there is no head or labal present in the EAD original-->
	<xsl:param name="label_style">asis</xsl:param>
	<!-- refers to css sheet. current valid values are caps, smcaps, titlecase, asis-->
	<!--misc-->
	<xsl:param name="sponsor_label">Sponsor</xsl:param>
	<xsl:param name="creation_label">Created</xsl:param>
	<xsl:param name="revision_label">Revisions</xsl:param>
	<!--did children-->
	<xsl:param name="abstract_label">Summary</xsl:param>
	<xsl:param name="abstract_id">abstractID</xsl:param>
	<xsl:param name="dates_label">Dates</xsl:param>
	<xsl:param name="dates_id">datesID</xsl:param>
	<xsl:param name="contactinformation_label">Repository</xsl:param>
	<xsl:param name="contactinformation_id">contactinformationID</xsl:param>
	<xsl:param name="collectionNumber_label">Collection Number</xsl:param>
	<xsl:param name="collectionNumber_id">collectionNumberID</xsl:param>
	<xsl:param name="origination_label">Creator</xsl:param>
	<xsl:param name="origination_id">originationID</xsl:param>
	<!--"Collector" is also allowed-->
	<xsl:param name="physdesc_label">Quantity</xsl:param>
	<xsl:param name="physdesc_id">physdescID</xsl:param>
	<xsl:param name="physloc_label">Location of Collection</xsl:param>
	<xsl:param name="physloc_id">physlocID</xsl:param>
	<xsl:param name="phystech_label">Preservation Note</xsl:param>
	<xsl:param name="phystech_id">phystechID</xsl:param>
	<xsl:param name="unittitle_label">Title</xsl:param>
	<xsl:param name="unittitle_id">unittitleID</xsl:param>
	<xsl:param name="unitdate_label">Dates</xsl:param>
	<xsl:param name="unitdate_id">unitdateID</xsl:param>
	<xsl:param name="unitid_label">Unit ID</xsl:param>
	<xsl:param name="unitid_id">unitidID</xsl:param>
	<!--did siblings-->
	<xsl:param name="accessrestrict_label">Restrictions on Access</xsl:param>
	<xsl:param name="accessrestrict_id">accessrestrictID</xsl:param>
	<xsl:param name="accruals_label">Future Additions</xsl:param>
	<xsl:param name="accruals_id">accrualsID</xsl:param>
	<xsl:param name="acqinfo_label">Acquisition Information</xsl:param>
	<xsl:param name="acqinfo_id">acqinfoID</xsl:param>
	<xsl:param name="altformavail_label">Alternative Forms Available</xsl:param>
	<xsl:param name="altformavail_id">altformavailID</xsl:param>
	<xsl:param name="appraisal_label">Appraisal Notes</xsl:param>
	<xsl:param name="appraisal_id">appraisalID</xsl:param>
	<xsl:param name="bibliography_label">Bibliography</xsl:param>
	<xsl:param name="bibliography_id">bibliographyID</xsl:param>
	<xsl:param name="custodhist_label">Custodial History</xsl:param>
	<xsl:param name="custodhist_id">custodhistID</xsl:param>
	<xsl:param name="fileplan_label">Fileplan</xsl:param>
	<xsl:param name="fileplan_id">fileplanID</xsl:param>
	<xsl:param name="index_label">Index</xsl:param>
	<xsl:param name="index_id">indexID</xsl:param>
	<xsl:param name="langmaterial_label">Languages</xsl:param>
	<xsl:param name="langmaterial_id">languagesID</xsl:param>
	<xsl:param name="odd_label">Other Descriptive Information</xsl:param>
	<xsl:param name="odd_id">oddID</xsl:param>
	<xsl:param name="originalsloc_label">Location of Originals</xsl:param>
	<xsl:param name="originalsloc_id">originalslocID</xsl:param>
	<xsl:param name="otherfindaid_label">Additional Reference Guides</xsl:param>
	<xsl:param name="otherfindaid_id">otherfindaidID</xsl:param>
	<xsl:param name="prefercite_label">Preferred Citation</xsl:param>
	<xsl:param name="prefercite_id">preferciteID</xsl:param>
	<xsl:param name="processinfo_label">Processing Note</xsl:param>
	<xsl:param name="processinfo_id">processinfoID</xsl:param>
	<xsl:param name="relatedmaterial_label">Related Materials</xsl:param>
	<xsl:param name="relatedmaterial_id">relatedmaterialID</xsl:param>
	<xsl:param name="separatedmaterial_label">Separated Materials</xsl:param>
	<xsl:param name="separatedmaterial_id">separatedmaterialID</xsl:param>
	<xsl:param name="userestrict_label">Restrictions on Use</xsl:param>
	<xsl:param name="userestrict_id">userestrictID</xsl:param>
	<xsl:param name="generalnote_label">General note</xsl:param>
	<xsl:param name="generalnote_id">generalnoteID</xsl:param>
	<xsl:param name="localnote_label">Local note</xsl:param>
	<xsl:param name="localnote_id">localnoteID</xsl:param>
	<xsl:param name="languagenote_label">Language note</xsl:param>
	<xsl:param name="languagenote_id">languagenoteID</xsl:param>
	<xsl:param name="acknowledgement_label">Acknowledgements</xsl:param>
	<xsl:param name="acknowledgement_id">acknowledgementID</xsl:param>
	<!-- ********************* </LABELS> *********************** -->
	<!-- ********************* <OVERVIEW ENTRIES> *********************** -->
	<xsl:template name="overview_entry">
		<xsl:param name="overview_label"/>
		<xsl:param name="overview_value"/>
		<tr>
			<td valign="top">&#160;</td>
			<td valign="top">
				<h5>
					<xsl:value-of select="$overview_label"/>
				</h5>
			</td>
			<td valign="top">&#160;</td>
			<td valign="top">
				<xsl:value-of select="$overview_value"/>
			</td>
		</tr>
	</xsl:template>
	<!-- ********************* </OVERVIEW ENTRIES> *********************** -->

	<!--HTML header table -->

		<xsl:template name="html.header.table">
		<!--NWDA HEADER DIV-->

        <link href="http://nwda-db.orbiscascade.org/nwda-search/support/header.css" rel="stylesheet" type="text/css" />

<div id="header">
	<h1 class="topbar"><a href="http://nwda.orbiscascade.org/index.shtml"><img height="54" src="/nwda-search/images/logos/NWDAlogotype.gif" width="129" alt="NWDA" /></a></h1>
    <ul>
      <li id="nav_home"><a class="header" href="http://nwda.orbiscascade.org/index.shtml">home</a></li>
      <li id="nav_search"><a class="header" href="/nwda-search/">search</a></li>
      <li id="nav_about"><a class="header" href="http://nwda.orbiscascade.org/about.shtml">about</a></li>
      <li id="nav_contact"><a class="header" href="http://nwda.orbiscascade.org/contact.shtml">contact us</a></li>
 	 <li id="nav_member"><a class="header" href="http://www.orbiscascade.org/index/northwest-digital-archives/">member tools</a></li>
    </ul>
</div>
		<!--END NWDA HEADER DIV-->
	</xsl:template>
	<!-- Dublin Core MD -->
		<xsl:template name="md.dc">
		<xsl:variable name="isoLang" select="//langusage/language/@langcode" />
		<xsl:variable name="isoDate" select="//eadheader/@dateencoding" />
		<meta name="GENERATOR" content="Transformed from EAD(XML) v2002 using XSLT v1.0"/>
		<meta lang="{$isoLang}" name="DC.Type" content="text" />
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#type"/>
		<meta lang="{$isoLang}" name="DC.Format" content="text/html" />
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#format"/>
		<link rel="schema.imt" href="http://sunsite.auc.dk/RFC/rfc/rfc2046.html" />
		<meta lang="{$isoLang}" name="DC.Language" scheme="{//eadheader/@langencoding}" content="{//langusage/language/@langcode}" />
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#language"/>
		<meta lang="{$isoLang}" name="DC.Identifier" content="{$file}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#identifier"/>
		<meta lang="{$isoLang}" name="DC.Publisher" content="{$repositoryParent}::{$repository}" />
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#publisher"/>
		<meta lang="{$isoLang}" name="DC.Title" content="{$titleproper}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#title" />
		<meta lang="{$isoLang}" name="DC.Title.Alternative" content="{$filingTitleproper}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#title"/>
		<meta lang="{$isoLang}" name="DC.Date" schema="{$isoDate}" content="{$dateToday}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#date"/>
		<meta lang="{$isoLang}" name="DC.Date.X-MetadataLastModified" schema="{$isoDate}" content="{$dateLastRev}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#date"/>
		<meta lang="{$isoLang}" name="DC.Creator" content="XML Content:{normalize-space(//author)}" />
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#creator"/>
		<meta lang="{$isoLang}" name="DC.Creator" content="HTML: {$operator}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#creator"/>
		<meta lang="{$isoLang}" name="DC.CreatorCorporateName" content="{normalize-space(//archdesc/did/repository/corpname)}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#creator"/>
		<meta lang="{$isoLang}" name="DC.Rights" content="{//publicationstmt/p}" />
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#rights"/>
		<meta lang="{$isoLang}" name="DC.Description" content="{substring(//scopecontent[1]/p,1,200)}"/>
		<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#description"/>
		<xsl:for-each select="//controlaccess//*[@rules]">
			<meta lang="{$isoLang}" name="DC.Subject" scheme="{@rules}" content="{normalize-space(./text())}"/>
			<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#subject"/>
		</xsl:for-each>
	</xsl:template>
	<!--





<META NAME="DC.Subject" SCHEME="LCSH" CONTENT="dd">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#subject">


<META NAME="DC.Publisher" CONTENT="dd">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#publisher">

<META NAME="DC.Publisher.Address" CONTENT="dd">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#publisher">

<META NAME="DC.Contributor" CONTENT="ddd">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#contributor">

<META NAME="DC.Source" CONTENT="source">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#source">

<META NAME="DC.Language" SCHEME="ISO639-1" CONTENT="en">


<META NAME="DC.Relation" CONTENT="oether materials">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#relation">

<META NAME="DC.Coverage" CONTENT="coverage">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#coverage">



<META NAME="DC.Date.X-MetadataLastModified" SCHEME="ISO8601" CONTENT="2003-04-17">
<link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#date">

-->
	
        
        <!--Major finding aid structures: bioghist, scopecontent, controlaccess, dsc etc.-->
	<!--<xsl:include href="nwda.mod.structures_0.1.xslt"/>-->
	<!--classes of generic elements... e.g. P class="abstract"
	nice idea, didn't run with it.
	

	<xsl:include href="nwda.mod.classes.xslt"/>-->
	<!--line breaks, lists and such-->
	<xsl:template match="ref">
		<a class="xref">
			<xsl:attribute name="href"># <xsl:value-of select="@target"/>
			</xsl:attribute>
			<xsl:value-of select="parent::p/text()"/>
			<xsl:value-of select="."/>
		</a>
		<xsl:if test="following-sibling::ref">
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="extref">
		<a class="extptr">
			<xsl:attribute name="href">
				<xsl:value-of select="@href"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</a>
	</xsl:template>
	<xsl:template match="daogrp">
		<!--    <div class="daogrp"> -->
		<xsl:apply-templates select="daoloc"/>
		<!--   </div> -->
	</xsl:template>
	<xsl:template match="dao">
		<a target="new">
			<xsl:attribute name="href">
				<xsl:value-of select="@href"/>. <xsl:value-of select="@content-role"/>
			</xsl:attribute>
			<xsl:value-of select="daodesc"/>
			<img src="{$pathToFiles}camicon.gif" alt="digital content available" width="17"
				height="14" border="0"/>
		</a>
	</xsl:template>
	<!-- 2004-07-14 carlson mod to fix daoloc display -->
	<xsl:template match="daoloc">
		<a target="new">
			<xsl:attribute name="href">
				<!--<xsl:value-of disable-output-escaping="yes" select="@href"/> removed 7/23/07 by Ethan Gruber-->
				<xsl:value-of select="@href"/>
			</xsl:attribute> &#160; <img src="{$pathToFiles}camicon.gif"
				alt="digital content available" width="17" height="14" border="0"/>
		</a>
	</xsl:template>
	<!--expan/abbr-->
	<xsl:template match="abbr">
		<xsl:choose>
			<xsl:when test="$expandAbbr='true'">
				<xsl:value-of select="./@expan"/>&#160;( <xsl:value-of select="."/>) </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="expan">
		<xsl:choose>
			<xsl:when test="$expandAbbr='true'">
				<xsl:value-of select="."/>&#160;( <xsl:value-of select="./@abbr"/>) </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--lists-->
	<xsl:template match="item | indexentry | bibref">
		<li class="{name()}">
			<xsl:apply-templates/>
		</li>
	</xsl:template>
	<!-- 2004-07-14 carlsonm mod to treat <chronitem> separately -->
	<xsl:template match="chronitem">
		<tr valign="top">
			<td valign="top">
				<xsl:apply-templates select="date"/>
			</td>
			<!-- 2004-11-30 Carlson mod add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd> -->
			<td valign="top">
				<xsl:choose>
					<xsl:when test="event">
						<span class="{name()}">
							<xsl:apply-templates select="event"/>
						</span>
						<br/>
					</xsl:when>
					<xsl:when test="eventgrp">
						<xsl:apply-templates select="eventgrp" mode="chronlist"/>
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="eventgrp" mode="chronlist">
		<xsl:for-each select="event">
			<span class="{name()}">
				<xsl:apply-templates/>
			</span>
			<br/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="defitem">
		<li class="{name()}">
			<xsl:if test="./label">
				<b>
					<xsl:value-of select="label"/>
				</b>: </xsl:if>
			<xsl:value-of select="item"/>
		</li>
	</xsl:template>
	<!-- 2004-07-14 carlsonm mod to treat chronlist differently -->
	<!-- 2004-12-07 carlsonm: put chronlist into a table format instead of a def list -->
	<xsl:template match="chronlist">
		<span class="tableHead">
			<xsl:apply-templates select="head"/>
		</span>
		<table class="{name()}" border="0" cellspacing="10">
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</table>
	</xsl:template>
	<xsl:template match="list | index | fileplan | bibliography">
		<span class="tableHead">
			<xsl:apply-templates select="head"/>
		</span>
		<ul>
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</ul>
	</xsl:template>
	<!-- where would an archivist be without... "misc"-->
	<xsl:template match="change">
		<xsl:apply-templates select="./item"/>&#160;( <xsl:apply-templates select="./date"/>) </xsl:template>
	<xsl:template match="*[@altrender='nodisplay']"/>
	<!--
	<xsl:template match="*[@role][not(parent::origination)][not(self::daogrp)]">

		<xsl:value-of select="."/>&#160;(
		<xsl:value-of select="./@role"/>)&#160;
	</xsl:template>
	-->
	<!--<xsl:template match="*[@type='bulk']">
    <xsl:value-of select="."/>(<xsl:value-of select="./@type"/>)</xsl:template>
  <xsl:template match="*[@type='inclusive']">
    <xsl:value-of select="."/>(<xsl:value-of select="./@type"/>)</xsl:template>-->
	<xsl:template match="ixiahit">
		<xsl:apply-templates/>
	</xsl:template>
	<!--ultra generics-->
	<xsl:template match="emph | title">
		<xsl:choose>
			<xsl:when test="@render">
				<xsl:apply-templates select="*[@render]"/>
			</xsl:when>
			<xsl:otherwise>
				<u>
					<xsl:apply-templates/>
				</u>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="lb">
		<br/>
	</xsl:template>
	<xsl:template match="unitdate">
		<xsl:apply-templates/>
		<xsl:text> </xsl:text>
		<!-- original SY code
    <xsl:if test="@type">&#160;<xsl:text></xsl:text>(<xsl:value-of select="@type"/>)</xsl:if>	 
	 -->
		<!-- 2004-07-16 carlsonm mod Do not display @type if c02+ -->
		<xsl:if test="@type and not(ancestor::c01)">&#160; <xsl:text/>( <xsl:value-of
				select="@type"/>) </xsl:if>
	</xsl:template>
	<xsl:template match="p">
		<!-- 2004-09-27 carlsonm: adding test to remove excess space if <p> is in <dsc> 
Tracking # 4.20
-->
		<xsl:choose>
			<xsl:when test="not(ancestor::dsc) or parent::dsc">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:if test="not(position()=last()) and c01">
					<br/>
					<br/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="controlaccess[@type='lower']">
		<xsl:value-of select="name()"/>
		<xsl:apply-templates>
			<xsl:sort order="ascending" data-type="text"/>
		</xsl:apply-templates>
		<br/>
		<!--

						<xsl:apply-templates>
						ddd<xsl:sort order="ascending" data-type="text"/>ddd
					</xsl:apply-templates><br />	-->
	</xsl:template>
	<xsl:template match="address">
		<p class="address">
			<!-- the following code distinguishes between a text-only address line and a url or email address -->
			<xsl:for-each select="addressline">
				<xsl:choose>
					<!-- if the addressline contains http://, a href is created -->
					<xsl:when test="contains(normalize-space(.), 'http://')">
						<xsl:choose>
							<xsl:when test="substring-before(normalize-space(.), 'http://')">
								<xsl:value-of
									select="substring-before(normalize-space(.), 'http://')"/>
								<a href="http://{substring-after(normalize-space(.), 'http://')}"
									target="_blank">
									<xsl:text>http://</xsl:text>
									<xsl:value-of
										select="substring-after(normalize-space(.), 'http://')"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="{normalize-space(.)}" target="_blank">
									<xsl:value-of select="normalize-space(.)"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="not(position() = last())">
							<br/>
						</xsl:if>
					</xsl:when>
					<!-- if the @ symbol is contained, it is assumed to be an email address -->
					<xsl:when test="contains(normalize-space(.), '@')">
						<xsl:choose>
							<!-- if email address is preceded by a space, i. e. "Email: foo@bar.com", only the foo@bar.com is made a mailto link -->
							<xsl:when test="contains(normalize-space(.), ' ')">
								<xsl:value-of select="substring-before(normalize-space(.), ' ')"/>
								<xsl:text> </xsl:text>
								<a href="mailto:{substring-after(normalize-space(.), ' ')}">
									<xsl:value-of select="substring-after(normalize-space(.), ' ')"
									/>
								</a>
								<!-- insert break only if it's not the last line.  this will cut back on unnecessary whitespace -->
								<xsl:if test="not(position() = last())">
									<br/>
								</xsl:if>
							</xsl:when>
							<!-- otherwise, the whole line is.  this is assuming these are the only two options seen.  standards in email and http 
								address lines should be further developed -->
							<xsl:otherwise>
								<a href="mailto:{normalize-space(.)}">
									<xsl:value-of select="normalize-space(.)"/>
								</a>
								<xsl:if test="not(position() = last())">
									<br/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:if test="not(position() = last())">
							<br/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:for-each>
		</p>
	</xsl:template>
	<xsl:template match="div">
		<p class="div">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<!-- suppress all heads
  <xsl:template match="head">
     <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
-->
	<xsl:template match="title">
		<i>
			<xsl:value-of select="."/>
		</i>
	</xsl:template>
	<xsl:template match="*[@type='restricted']">
		<span class="restricted">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>
	<!-- ********************* <* @render> *********************** -->
	<xsl:template match="*[@render]">
		<xsl:choose>
			<xsl:when test="@render='bold'">
				<b>
					<xsl:apply-templates/>
				</b>
			</xsl:when>
			<xsl:when test="@render='italic'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@render='bolditalic'">
				<b>
					<i>
						<xsl:apply-templates/>
					</i>
				</b>
			</xsl:when>
			<xsl:when test="@render='underline'">
				<u>
					<xsl:apply-templates/>
				</u>
			</xsl:when>
			<xsl:when test="@render='boldunderline'">
				<b>
					<u>
						<xsl:apply-templates/>
					</u>
				</b>
			</xsl:when>
			<xsl:when test="@render='quoted'">&quot; <xsl:apply-templates/>&quot; </xsl:when>
			<xsl:when test="@render='doublequote'">&quot; <xsl:apply-templates/>&quot; </xsl:when>
			<xsl:when test="@render='bolddoublequote'">
				<b>&quot; <xsl:apply-templates/>&quot; </b>
			</xsl:when>
			<xsl:when test="@render='nonproport'">
				<font style="font-family: 'Courier New', Cumberland ">
					<xsl:apply-templates/>
				</font>
			</xsl:when>
			<xsl:when test="@render='singlequote'">&apos; <xsl:apply-templates/>&apos; </xsl:when>
			<xsl:when test="@render='boldsinglequote'">
				<b>&quot; <xsl:apply-templates/>&apos; </b>
			</xsl:when>
			<xsl:when test="@render='sub'">
				<sub>
					<xsl:apply-templates/>
				</sub>
			</xsl:when>
			<xsl:when test="@render='super'">
				<sup>
					<xsl:apply-templates/>
				</sup>
			</xsl:when>
			<xsl:when test="@render='smcaps'">
				<font style="font-variant: small-caps">
					<xsl:apply-templates/>
				</font>
			</xsl:when>
			<xsl:when test="@render='boldsmcaps'">
				<b>
					<font style="font-variant: small-caps">
						<xsl:apply-templates/>
					</font>
				</b>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--table of contents-->
 <!-- ********************* <TABLE OF CONTENTS> *********************** -->
  <!-- TOC TEMPLATE - creates Table of Contents -->
  <xsl:template name="toc">
    <div class="navHead">Table of Contents</div>
    <div class="navBody">
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td>
            <xsl:text/>
            <a name="toc"/>
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
	<!--controlled access points-->
		<!-- ********************* <CONTROLACCESS> *********************** -->
	<xsl:template match="controlaccess" name="controlaccess">
		<!-- P.S. Can't just select index [1] controlaccess because it may not be the group with
		the indexing terms. carlsonm -->
		<a name="{$controlaccess_id}"/>
		<h3 class="structhead">
			<xsl:value-of select="$controlaccess_head"/>
			<input type="button" id="toggle_controlaccess" class="togglebutton" onclick="fade('h_controlaccess')" value="+/-"/>
		</h3>

		<div class="controlaccess" id="h_controlaccess" >
			<xsl:call-template name="group_subject"/>
			<xsl:if
				test="descendant::*[@encodinganalog='700'] or descendant::*[@encodinganalog='710']">
				<xsl:call-template name="group_other"/>
			</xsl:if>
		</div>
    <p class="top">
      <a href="#top" title="Top of finding aid">^ Return to Top</a>
    </p>
	</xsl:template>
	<xsl:template name="group_subject">
		<!-- The following test checks for any <controlaccess> elements that have child elements
not encoded altrender="nodisplay".  This test is necessary because sometimes
the NWDA browse terms that are suppressed are encoded within a single <controlaccess>
element and sometimes in a separate <controlaccess> element: see William H. Carlson
papers and John Ainsworth papers. The style sheet expects one of three scenarios:
1) a single <controlaccess> element with controlaccess elements and NWDA browse terms 
within that single element. (single list display)
2) a single <controlaccess> element with nested <controlaccess> elements (i.e. grouped display)
3) two <controlaccess> elements, one as either a single list or nested <controlaccess> elements and a separate <controlaccess> element that contains the NWDA browse terms
Other FA's to check: James F. Bishop (OSU Archives)
-->
		<!-- This excludes any separate group <controlaccess> for NWDA browse terms -->
		<xsl:if test="position()=1">
			

		</xsl:if>
		<xsl:if test="descendant::*[not(@altrender='nodisplay')]">
			<!-- i.e. we don't want to print a "Subject" heading if there are more
<controlaccess> elements that need to be selected -->

			<xsl:choose>
				<xsl:when test="child::controlaccess">
					<xsl:if test="child::p">
						<xsl:apply-templates select="p"/>
					</xsl:if>
					<xsl:for-each select="controlaccess">
						<ul class="ca_list">
							<xsl:for-each
								select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | subject[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | genreform[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | geogname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | occupation[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | function[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | title[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]">
								<xsl:sort select="normalize-space(.)"/>

								<xsl:if test="position()=1">
									<li class="ca_head">
										<xsl:call-template name="controlaccess_heads"/> : </li>
								</xsl:if>


								<li class="ca_li">
									<xsl:apply-templates/>
									<xsl:if test="@role and not(@role='subject')">&#160;(
											<xsl:value-of select="@role"/>) </xsl:if>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<ul class="ca_list">
						<xsl:for-each
							select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | subject[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | genreform[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | geogname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | occupation[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | function[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | title[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]">
							<xsl:sort/>

							<li class="ca_li">
								<xsl:apply-templates/>
								<xsl:if test="@role and not(@role='subject')">&#160;(
										<xsl:value-of select="@role"/>) </xsl:if>
							</li>
						</xsl:for-each>
					</ul>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:if>
	</xsl:template>
	<xsl:template name="group_other">
		<!-- not needed because we don't need a link from the TOC 
<a name="{$othercreators_id}"></a>
-->
		<!-- wrong head type
<h3 class="structhead">
<xsl:value-of select="$othercreators_head" />
</h3>
-->
		<ul class="ca_list">
			<li class="ca_head">Other Creators :</li>
			<xsl:choose>
				<xsl:when
					test="child::controlaccess and controlaccess/*/@encodinganalog='700' or controlaccess/*/@encodinganalog='710'">
					<xsl:for-each select="controlaccess">

						<xsl:for-each
							select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">

							<xsl:sort select="normalize-space(.)"/>
							<li class="ca_li">
								<!-- PER EN, DON'T SUBDIVIDE OTHER CREATORS 
								<xsl:if test="position()=1">
							<tr><td style="font-weight: bold;"><xsl:call-template name="controlaccess_heads"/> :</td></tr>
							</xsl:if>
										-->
								<xsl:apply-templates/>
								<xsl:if
									test="@role and not(@role='creator') and not(@role='subject')"
									>&#160;( <xsl:value-of select="@role"/>) </xsl:if>
							</li>
						</xsl:for-each>

					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>

					<xsl:for-each
						select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
						<xsl:sort/>
						<li class="ca_li">
							<xsl:apply-templates/>
							<xsl:if test="@role and not(@role='creator') and not(@role='subject')"
								>&#160;( <xsl:value-of select="@role"/>) </xsl:if>
						</li>
					</xsl:for-each>

				</xsl:otherwise>
			</xsl:choose>
		</ul>

		<!--
</xsl:if>
-->
	</xsl:template>
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
	<!-- ********************* </CONTROLACCESS HEADINGS> *********************** -->
	<!-- ********************* </CONTROLACCESS> *********************** -->
	<!--description of subordinate components-->
		<!-- Set this variable to the server/folder path that points to the icon image file on your server.
		This should end with a forward /, e.g. http://myserver.com/images/ -->
	<xsl:variable name="pathToIcon">/xsl/support/</xsl:variable>
	<!-- Set this variable to the filename of the icon image, e.g. icon.jpg -->
	<xsl:variable name="iconFilename">camicon.gif</xsl:variable>

	<xsl:variable name="lcChars">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="lcCharsHyphen">abcdefghijklmnopqrstuvwxyz-</xsl:variable>
	<xsl:variable name="lcCharsSlash">abcdefghijklmnopqrstuvwxyz/</xsl:variable>
	<xsl:variable name="ucChars">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="repCode" select="translate(//eadid/@mainagencycode,$ucChars,$lcChars)"/>


	<!-- ********************* <DSC> *********************** -->
	<xsl:template name="dsc" match="//dsc">
		<a name="{$dsc_id}"/>
		<h3 class="structhead">
			<xsl:value-of select="$dsc_head"/>
			<input type="button" id="toggle_dsc" class="togglebutton" onclick="fadeFast('h_dsc')" value="+/-"/>
		</h3>
		<!-- this section was commented out for now due to some inconsistencies in the encoding of the dsc type throughout varies collections. 
	since analyticover and combined dsc's would have a very different type of display, different templates were called to deal with the issue. -EG 2007-08-27
	<xsl:choose>
			<xsl:when test="not(@type='in-depth')">
				<div class="dsc" name="{$dsc_id}">
					<xsl:apply-templates select="*[not(self::head)]"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="dsc" name="{$dsc_id}">
					<table border="0" summary="A listing of materials in {./did/unittitle}."
						width="100%">
						<xsl:call-template name="table_label"/>
						<xsl:call-template name="indepth"/>
					</table>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		-->
		<div class="dsc" name="{$dsc_id}" id="h_dsc">
			<xsl:choose>
				<!-- if there are c02's apply normal templates -->
				<xsl:when test="descendant::c02">
					<xsl:apply-templates select="*[not(self::head)]"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- if there are no c02's then all of the c01s are displayed as rows in a table, like an in-depth finding aid -->
					<table border="0" summary="A listing of materials in {./did/unittitle}."
						width="100%">
						<xsl:call-template name="indepth"/>
					</table>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<!-- ********************* </DSC> *********************** -->
	<!-- ********************* <SERIES> *************************** -->
	<xsl:template match="c01">
		<div class="c01">
			<xsl:call-template name="dsc_table"/>

			<xsl:if test="//c02 or position()=last()">
				<p class="top">
					<a href="#top" title="Top of finding aid">^ Return to Top</a>
				</p>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ********************* </SERIES> *************************** -->
	<!-- ********************* In-Depth DSC Type ********************* -->
	<xsl:template name="indepth">

		<xsl:apply-templates select="p"/>

		<xsl:for-each select="c01">
			<xsl:if test="did/container">
				<xsl:call-template name="container_row"/>
			</xsl:if>
			<xsl:variable name="current_pos" select="position()"/>
			<tr>
				<xsl:choose>
					<xsl:when test="parent::node()/descendant::container">
						<xsl:choose>
							<xsl:when test="not(parent::node()/descendant::did/container[2])">
								<td class="c0x_container_large">
									<xsl:value-of select="did/container[1]"/>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td class="c0x_container_small" id="c0x_container_left">
									<xsl:value-of select="did/container[1]"/>
								</td>
								<td class="c0x_container_small">
									<xsl:value-of select="did/container[2]"/>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<!-- no table cell -->
					</xsl:otherwise>
				</xsl:choose>

				<td class="c0x_content">
					<xsl:if test="string(did/unitid)">
						<xsl:value-of select="did/unitid"/>
						<xsl:if test="did/unittitle">
							<xsl:text>: </xsl:text>
						</xsl:if>
					</xsl:if>
					<xsl:apply-templates select="did/unittitle"/>

					<xsl:if
						test="($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')
					and string(descendant::unitdate)">
						<xsl:text>, </xsl:text>
						<xsl:for-each select="did/unitdate">
							<xsl:value-of select="."/>
							<xsl:if test="not(position() = last())">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:call-template name="c0x_children"/>
				</td>

				<xsl:if
					test="not($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')">

					<td class="c0x_date">
						<xsl:for-each select="did/unitdate">
							<xsl:value-of select="."/>
							<xsl:if test="not(position() = last())">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</td>
				</xsl:if>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<!-- ********************* ANALYTICOVER/COMBINED DSC TYPE *************************** -->
	<!--columnar dates are the default-->
	<xsl:template name="dsc_table">
		<xsl:variable name="c0x_container">
			<xsl:choose>
				<xsl:when test="did/container[2]">
					<xsl:text>c0x_container_small</xsl:text>
				</xsl:when>
				<xsl:when test="not(did/container[2])">
					<xsl:text>c0x_container_large</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates select="did"/>

		<table border="0" summary="A listing of materials in {./did/unittitle}." width="100%">
			<!-- calls the labels for the table -->
			<xsl:call-template name="table_label"/>

			<xsl:if test="@level='item' or @level='file'">
				<tr>
					<td class="c0x_container_small" id="c0x_container_left">
						<div class="containerLabel">
							<xsl:value-of select="did/container[1]/@type"/>
						</div>
					</td>
					<td class="c0x_container_small">
						<div class="containerLabel">
							<xsl:value-of select="did/container[2]/@type"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="c0x_container_small" id="c0x_container_left">
						<xsl:value-of select="did/container[1]"/>
					</td>
					<td class="c0x_container_small">
						<xsl:value-of select="did/container[2]"/>
					</td>
					<td class="c0x_content"/>
				</tr>
			</xsl:if>

			<xsl:apply-templates select="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12"/>

		</table>

	</xsl:template>
	<!-- ********************* </DSC TABLE> *************************** -->
	<!-- ********************* LABELS FOR TABLE ********************* -->
	<xsl:template name="table_label">
		<tr>
			<xsl:choose>
				<xsl:when test="descendant::container">
					<xsl:choose>
						<xsl:when
							test="not(descendant::container[2]) and not(descendant::container[3])">
							<td>
								<div class="c0x_header">Container(s)</div>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td colspan="2">
								<div class="c0x_header">Container(s)</div>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<td class="c0x_container_large"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="string(descendant::unittitle) and string(descendant::c02)">
				<td class="c0x_content">
					<div class="c0x_header">Description</div>
				</td>
			</xsl:if>

			<xsl:if
				test="not($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')">
				<xsl:if test="string(descendant::c02) and string(descendant::unitdate)">
					<td class="c0x_date">
						<div class="c0x_header">Dates</div>
					</td>
				</xsl:if>
			</xsl:if>

		</tr>
	</xsl:template>
	<!-- ********************* END LABELS FOR TABLE ************************** -->
	<!-- ********************* START c0xs *************************** -->
	<xsl:template match="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12">

		<!-- this determines the number of containers (max of 2) so that when the template is called to display the text in the container
			field, a paramer is passed to display the data of did/container[$container_number].  this has replaced slews of conditionals that 
			nested tables -->

		<xsl:variable name="c0x_container">
			<xsl:choose>
				<xsl:when test="did/container[2]">
					<xsl:text>c0x_container_small</xsl:text>
				</xsl:when>
				<xsl:when test="not(did/container[2])">
					<xsl:text>c0x_container_large</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- ********* ROW FOR DISPLAYING CONTAINER TYPES ********* -->

		<xsl:if test="did/container">
			<xsl:call-template name="container_row"/>
		</xsl:if>

		<!-- *********** ROW FOR DISPLAYING CONTAINER, CONTENT, AND DATE DATA **************-->

		<!--all c0x level items are their own row; indentation created by css only-->

		<tr>
			<!-- if there is only one container, the td is 170 pixels wide, otherwise 85 for two containers -->

			<xsl:choose>
				<xsl:when test="not(did/container[2])">
					<xsl:choose>
						<!-- a colspan of 2 is assigned to a c0x that does not have 2 containers if any descendants of its c01 parent
							have 2 containers -->
						<xsl:when test="ancestor-or-self::c01/descendant-or-self::container[2]">
							<td class="{$c0x_container}" colspan="2">
								<xsl:value-of select="did/container[1]"/>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="{$c0x_container}">
								<xsl:value-of select="did/container[1]"/>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="did/container[2]">
					<td class="{$c0x_container}" id="c0x_container_left">
						<xsl:value-of select="did/container[1]"/>
					</td>
					<td class="{$c0x_container}">
						<xsl:value-of select="did/container[2]"/>
					</td>
				</xsl:when>
			</xsl:choose>

			<!-- this id is used for indentation; replaces nested tables -->
			<xsl:variable name="c0x_content_indent">
				<xsl:choose>
					<xsl:when test="self::c02">
						<xsl:text>c02</xsl:text>
					</xsl:when>
					<xsl:when test="self::c03">
						<xsl:text>c03</xsl:text>
					</xsl:when>
					<xsl:when test="self::c04">
						<xsl:text>c04</xsl:text>
					</xsl:when>
					<xsl:when test="self::c05">
						<xsl:text>c05</xsl:text>
					</xsl:when>
					<xsl:when test="self::c06">
						<xsl:text>c06</xsl:text>
					</xsl:when>
					<xsl:when test="self::c07">
						<xsl:text>c07</xsl:text>
					</xsl:when>
					<xsl:when test="self::c08">
						<xsl:text>c08</xsl:text>
					</xsl:when>
					<xsl:when test="self::c09">
						<xsl:text>c09</xsl:text>
					</xsl:when>
					<xsl:when test="self::c10">
						<xsl:text>c10</xsl:text>
					</xsl:when>
					<xsl:when test="self::c11">
						<xsl:text>c11</xsl:text>
					</xsl:when>
					<xsl:when test="self::c12">
						<xsl:text>c12</xsl:text>
					</xsl:when>

				</xsl:choose>
			</xsl:variable>

			<td class="c0x_content" id="{$c0x_content_indent}">
				<xsl:if test="did/unittitle">
					<xsl:choose>
						<!-- series, subseries, etc are bold -->
						<xsl:when
							test="(@level='series' or @level='subseries' or @otherlevel='sub-subseries' or @level='otherlevel') and child::node()/did">
							<b>
								<xsl:if test="string(did/unitid)">
									<xsl:value-of select="did/unitid"/>
									<xsl:text>: </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="did/unittitle"/>
							</b>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="string(did/unitid)">
								<xsl:value-of select="did/unitid"/>
								<xsl:text>: </xsl:text>
							</xsl:if>
							<xsl:apply-templates select="did/unittitle"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- if the layout for the date is inline instead of columnar, address that issue -->
				<xsl:if
					test="$repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps'">

					<xsl:for-each select="did/unitdate">
						<!-- only insert comma if it comes after a unittitle - on occasion there is a unitdate but no unittitle -->
						<xsl:if test="parent::node()/unittitle">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:value-of select="."/>
						<!-- place a semicolon between multiple unitdates -->
						<xsl:if test="not(position() = last())">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>

				</xsl:if>

				<xsl:call-template name="c0x_children"/>

			</td>
			<!-- if the date layout is columnar, then the column is displayed -->
			<xsl:if
				test="not($repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps')">
				<td class="c0x_date">
					<xsl:for-each select="did/unitdate">
						<xsl:choose>
							<xsl:when
								test="(parent::node()/parent::node()[@level='series'] or parent::node()/parent::node()[@level='subseries']
								or parent::node()/parent::node()[@otherlevel='sub-subseries'] or parent::node()/parent::node()[@level='otherlevel'])">
								<b>
									<xsl:value-of select="."/>
								</b>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
						<!-- place a semicolon and a space between dates -->
						<xsl:if test="not(position() = last())">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</td>
			</xsl:if>
		</tr>


		<xsl:apply-templates select="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12"/>
	</xsl:template>

	<!-- APPLY TEMPLATES FOR UNITTITLE -->

	<xsl:template match="unittitle">
		<xsl:apply-templates/>
		<xsl:if test="parent::node()/daogrp">
			<xsl:apply-templates select="parent::node()/daogrp"/>
		</xsl:if>
	</xsl:template>

	<!-- ********************* END c0xs *************************** -->

	<!-- *** CONTAINER ROW ** -->

	<xsl:template name="container_row">

		<xsl:variable name="c0x_container">
			<xsl:choose>
				<xsl:when test="did/container[2]">
					<xsl:text>c0x_container_small</xsl:text>
				</xsl:when>
				<xsl:when test="not(did/container[2])">
					<xsl:text>c0x_container_large</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- variables are created to grab container type data.
		this logic basically only creates the row and its table cells if there is firstor second container
		data returned from the template call.  this logic cuts back on processing time for the server
		and download time for the user - Ethan Gruber 7/29/07 -->

		<xsl:variable name="first_container">
			<xsl:call-template name="container_type">
				<xsl:with-param name="container_number" select="1"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="second_container">
			<xsl:call-template name="container_type">
				<xsl:with-param name="container_number" select="2"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- if none of the container variables contains any data, the row will not be created -->

		<xsl:if test="string($first_container) or string($second_container)">
			<tr>
				<xsl:choose>
					<!-- for one container -->
					<xsl:when test="not(did/container[2])">
						<xsl:variable name="container_colspan">
							<xsl:choose>
								<xsl:when test="//dsc[not(@type='in-depth')]">
									<xsl:choose>
										<xsl:when
											test="ancestor-or-self::c01/descendant-or-self::container[2]"
											>2</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when
											test="ancestor-or-self::dsc/descendant-or-self::container[2]"
											>2</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<td class="{$c0x_container}" colspan="{$container_colspan}">
							<div class="containerLabel">
								<xsl:value-of select="$first_container"/>
							</div>
						</td>
					</xsl:when>
					<!-- for two containers -->
					<xsl:when test="did/container[2]">
						<td class="{$c0x_container}" id="c0x_container_left">
							<div class="containerLabel">
								<xsl:value-of select="$first_container"/>
							</div>
						</td>
						<td class="{$c0x_container}">
							<div class="containerLabel">
								<xsl:value-of select="$second_container"/>
							</div>
						</td>
					</xsl:when>
				</xsl:choose>
			</tr>
		</xsl:if>
	</xsl:template>

	<!-- ******************** DISPLAYS TYPE OF CONTAINER ****************** -->

	<xsl:template name="container_type">
		<xsl:param name="container_number"/>

		<xsl:param name="current_pos" select="position()"/>
		<!-- the last value is determined; basically the previous type value from the same c0x -->

		<xsl:variable name="last_val">
			<xsl:choose>
				<xsl:when test="//dsc[not(@type='in-depth')]">
					<xsl:if test="did/container[$container_number]/@type">
						<xsl:choose>
							<xsl:when test="not(parent::node()/*[position() = $current_pos - 1])">
								<xsl:text>no_val</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of
									select="parent::node()/*[position() = $current_pos]/did/container[$container_number]/@type"
								/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="parent::node()/c01[position() = $current_pos - 1]/did/container[$container_number]/@type"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="current_val">
			<xsl:value-of select="did/container[$container_number]/@type"/>
		</xsl:variable>

		<!-- if the last value is not equal to the first value, then the regularize_container template is called.  -->

		<xsl:if test="not($last_val = $current_val)">
			<xsl:call-template name="regularize_container">
				<xsl:with-param name="current_val">
					<xsl:value-of select="$current_val"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- ******************** END TYPE OF CONTAINER ****************** -->

	<!-- ******************** CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** -->

	<xsl:template name="regularize_container">

		<!-- this is for converting container/@type to a regularized phrase.  The list can be expanded as needed.  The otherwise
			statement outputs the @type if no matches are found (it is capitalized by the CSS file) -->

		<xsl:param name="current_val"/>

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

	<!-- ******************** END CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** -->

	<xsl:template name="c0x_children">
		<!-- for displaying extent, physloc, etc.  this is brought over from the original mod.dsc -->

		<!-- added note in addition to did/note for item 2F on revision specifications-->
		<xsl:if
			test="string(did/origination | did/physdesc | did/physloc | did/note | arrangement | odd| scopecontent | acqinfo | custodhist | processinfo | note | bioghist | accessrestrict | userestrict | index | altformavail)">


			<xsl:for-each select="did">
				<xsl:for-each select="origination | physdesc | physloc | note">

					<xsl:choose>
						<xsl:when test="self::physdesc">
							<div class="{name()}">
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
								<xsl:if test="string(physfacet) and string(extent)">
									<xsl:text> : </xsl:text>
								</xsl:if>
								<xsl:for-each select="physfacet">
									<xsl:apply-templates select="."/>
									<xsl:if test="not(position() = last())">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
								<xsl:if test="string(dimensions) and string(physfacet)">
									<xsl:text>;</xsl:text>
								</xsl:if>
								<xsl:for-each select="dimensions">
									<xsl:apply-templates select="."/>
									<xsl:if test="not(position() = last())">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
								<!-- if genreform exists, insert a line break and then display genreforms separated by semicolons -->
								<xsl:if test="genreform">
									<br/>
								</xsl:if>
								<xsl:for-each select="genreform">
									<xsl:apply-templates select="."/>
									<xsl:if test="not(position() = last())">
										<xsl:text>.  </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="{name()}">
								<xsl:apply-templates/>
								<xsl:if test="self::origination and child::*/@role"> (<xsl:value-of
										select="child::*/@role"/>) </xsl:if>
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each
				select="arrangement | odd | acqinfo | accruals | custodhist | processinfo | separatedmaterial | scopecontent | note | origination | physdesc | physloc | bioghist | accessrestrict | userestrict | altformavail">
				<div class="{name()}">
					<xsl:apply-templates/>
				</div>
			</xsl:for-each>
			<xsl:if test="index">
				<xsl:apply-templates select="index"/>
			</xsl:if>
		</xsl:if>

	</xsl:template>
	<!-- kept from original mod.dsc -->

	<xsl:template match="c01//did">
		<!-- c01 only -->
		<xsl:choose>
			<!-- original SY code
				<xsl:when test="parent::c01 or parent::*[@level='subseries']">
			-->
			<xsl:when test="parent::c01 and //c02">
				<xsl:if test="count(parent::c01/preceding-sibling::c01)!='0'"/>
				<div class="c01_did_head">
					<!--<a name="{parent::c01/@id}{@id}"/>-->
					<a name="c01_{count(parent::c01/preceding-sibling::c01)+1}"/>
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="generate-id()"/>
						</xsl:attribute>
					</a>
					<!-- what if no unitititle-->
					<xsl:choose>
						<xsl:when test="./unittitle">
							<xsl:if test="string(unitid)">
								<xsl:if test="unitid/@label">
									<span class="containerLabel">
										<xsl:value-of select="unitid/@label"/>
										<xsl:text>&#160;</xsl:text>
										<xsl:if
											test="unitid/@type='counter' or unitid/@type='counternumber'"
											> Cassette Counter&#160; </xsl:if>
									</span>
								</xsl:if>
								<xsl:if test="$repCode='wau-ar' and unitid[@type='accession']">
									Accession No.&#160; </xsl:if>
								<xsl:value-of select="unitid"/>: <xsl:text>&#160;</xsl:text>
							</xsl:if>
							<xsl:apply-templates select="unittitle"/>
							<xsl:if test="string(unitdate) and string(unittitle)">,&#160;</xsl:if>
							<xsl:if test="string(unitdate)">
								<xsl:for-each select="unitdate">
									<xsl:choose>
										<xsl:when test="not(@type='bulk')">
											<xsl:apply-templates/>
											<xsl:if test="not(position()=last())"
											>,&#160;</xsl:if>
										</xsl:when>
										<xsl:when test="@type='bulk'"> &#160;(bulk
											<xsl:apply-templates/>) </xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</xsl:when>
						<!-- SY Original Code
							<xsl:when test="./unitid[@encodinganalog='245$a']/text() and not(./unittitle)">
						-->
						<xsl:when test="./unitid/text() and not(./unittitle)">
							<xsl:if test="unitid/@label">
								<span class="containerLabel">
									<xsl:value-of select="unitid/@label"/>
									<xsl:text>&#160;</xsl:text>
									<xsl:if
										test="unitid/@type='counter' or unitid/@type='counternumber'"
										> Cassette Counter&#160; </xsl:if>
								</span>
							</xsl:if>
							<xsl:if test="$repCode='wau-ar' and unitid[@type='accession']">
								<!--  and ../c01[@otherlevel='accession'] --> Accession
								No.&#160; </xsl:if>
							<xsl:value-of select="unitid"/>
						</xsl:when>
						<xsl:when test="./unitdate/text() and not(./unittitle)">
							<xsl:value-of select="./unitdate"/>
						</xsl:when>
						<xsl:otherwise>Subordinate Component # <xsl:value-of
								select="count(parent::c01/preceding-sibling::c01)+1"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END what if no unitititle-->
				</div>
			</xsl:when>
			<xsl:when
				test="$repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps'">
				<!-- 2004-09-26 carlsonm mod to add display for <unitid> -->
				<!-- Tracking # 4.10 Collins Land Company display -->
				<xsl:if test="string(unitid)">
					<xsl:if test="unitid/@label">
						<span class="containerLabel">
							<xsl:value-of select="unitid/@label"/>
							<xsl:text>&#160;</xsl:text>
						</span>
					</xsl:if>
					<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'"> Cassette
						Counter&#160; </xsl:if>
					<xsl:apply-templates select="unitid"/>:
					<xsl:text>&#160;&#160;</xsl:text>
				</xsl:if>
				<xsl:apply-templates select="unittitle"/>
				<!-- carlsonm 2004-09-26 not sure what the original intent was for this.  The <unitdate> element is not displaying in UMt Great Falls Breweries, Tracking #4.80 -->
				<!--
					<xsl:if test="unittitle and unitdate and not(parent::c01)">,&#160;</xsl:if>
					
					<xsl:if test="not(parent::c01)">
					
					carlsonm mod 2004-09-26 adding comma before date OBSOLETE, REVISED
					<xsl:if test="string(unitdate) and string(unittitle)">,&#160;</xsl:if>
					
					<xsl:apply-templates select="./unitdate"/>
					
					</xsl:if>
				-->
				<!-- 2004-10-02 new mod for date so that empty elements will be ignored -->
				<xsl:if test="string(unitdate) and string(unittitle)">,&#160;</xsl:if>
				<xsl:if test="string(unitdate)">
					<xsl:for-each select="unitdate">
						<xsl:choose>
							<xsl:when test="not(@type='bulk')">
								<xsl:apply-templates/>
								<xsl:if test="not(position()=last())">,&#160;</xsl:if>
							</xsl:when>
							<xsl:when test="@type='bulk'"> &#160;(bulk <xsl:apply-templates/>)
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
			</xsl:when>
			<!-- carlsonm This is where the unittitle info is output when it is a c01 list only -->
			<xsl:otherwise>
				<xsl:if test="unittitle/@label">
					<xsl:value-of select="unittitle/@label"/>&#160; </xsl:if>
				<!-- what if no unitititle-->
				<xsl:choose>
					<xsl:when test="./unittitle">
						<xsl:if test="string(unitid)">
							<xsl:if test="unitid/@label">
								<span class="containerLabel">
									<xsl:value-of select="unitid/@label"/>
									<xsl:text>&#160;</xsl:text>
								</span>
							</xsl:if>
							<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'">
								Cassette Counter&#160; </xsl:if>
							<xsl:value-of select="unitid"/>: <xsl:text> &#160;</xsl:text>
						</xsl:if>
						<xsl:apply-templates select="./unittitle"/>
						<xsl:apply-templates select="daogrp"/>
						<!-- carlsonm add -->
						<!--
							<xsl:if test="./unitdate">,&#160;<xsl:value-of select="./unitdate"/>
							</xsl:if>
						-->
						<!-- end add -->
					</xsl:when>
					<xsl:when test="./unitid/text() and not(./unittitle)">
						<xsl:if test="unitid/@label">
							<span class="containerLabel">
								<xsl:value-of select="unitid/@label"/>
								<xsl:text>&#160;</xsl:text>
							</span>
						</xsl:if>
						<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'">
							Cassette Counter&#160; </xsl:if>
						<xsl:value-of select="unitid"/>
					</xsl:when>
					<xsl:when test="./unitdate/text() and not(./unittitle)">
						<xsl:value-of select="./unitdate"/>
					</xsl:when>
					<!-- carlsonm 2004-07-15 the following test governs whether a second unittitle should display when there is only a single c01 -->
					<!-- commented out, it doesn't display -->
					<!-- SY original code
						<xsl:when test="./unitid[@encodinganalog='245$a']/text() and not(./unittitle)">
						<xsl:value-of select="./unitid"/>
						</xsl:when>
					-->
					<xsl:otherwise>Subordinate Component</xsl:otherwise>
				</xsl:choose>
				<!-- END what if no unitititle-->
			</xsl:otherwise>
		</xsl:choose>
		<!--non-unittitle,unitdate,unitid descriptive information-->
		<!-- This now only processes the following elements within <c01>.  The context at this
			point is <c01><did>.  Lower components are processed in a separate section -->
		<xsl:if
			test="string(acqinfo | accruals | custodhist | processinfo | separatedmaterial | physdesc | physloc | origination | note | following-sibling::odd | following-sibling::scopecontent | following-sibling::arrangement | following-sibling::bioghist  | following-sibling::accessrestrict  | following-sibling::userestrict  | following-sibling::note) and parent::c01">

			<xsl:for-each
				select="acqinfo | accruals | custodhist | processinfo | separatedmaterial | physdesc | physloc | origination | note | following-sibling::odd | following-sibling::scopecontent | following-sibling::arrangement | following-sibling::bioghist  | following-sibling::accessrestrict  | following-sibling::userestrict  | following-sibling::note">
				<xsl:call-template name="archdesc_minor_children">
					<xsl:with-param name="withLabel">false</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			<!-- 2004-12-02 carlsonm: This inserts a blank line when there are c02 + 
					See UMt McGowan Commercial Company, first <c01> as an example
				-->
			<!--
					<xsl:if test="string(descendant::c02)">
					<br/>
					</xsl:if>
				-->

		</xsl:if>
	</xsl:template>


	<xsl:template match="daogrp">

		<xsl:choose>
			<!-- First, check whether we are dealing with one or two <arc> elements -->
			<xsl:when test="arc[2]">
				<a>
					<xsl:if test="arc[2]/@show='new'">
						<xsl:attribute name="target">_blank</xsl:attribute>
					</xsl:if>

					<xsl:for-each select="daoloc">
						<!-- This selects the <daoloc> element that matches the @label attribute from <daoloc> and the @to attribute
							from the second <arc> element -->
						<xsl:if test="@label = following::arc[2]/@to">
							<xsl:attribute name="href">
								<xsl:value-of select="@href"/>
							</xsl:attribute>
						</xsl:if>
					</xsl:for-each>

					<xsl:for-each select="daoloc">
						<xsl:if test="@label = following::arc[1]/@to">
							<img src="{@href}" class="daoimage" bolder="0">
								<xsl:if test="following::arc[1]/@title">
									<xsl:attribute name="title">
										<xsl:value-of select="following::arc[1]/@title"/>
									</xsl:attribute>
									<xsl:attribute name="alt">
										<xsl:value-of select="following::arc[1]/@title"/>
									</xsl:attribute>
								</xsl:if>
							</img>
							<xsl:if test="string(daodesc)">
								<br/>
								<span class="daodesc">
									<xsl:apply-templates/>
								</span>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</a>

			</xsl:when>
			<!-- i.e. no second <arc> element -->
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="arc[1][@show='embed'] and arc[1][@actuate='onload']">
						<xsl:for-each select="daoloc">
							<xsl:if test="@label = following-sibling::arc[1]/@to">
								<img src="{@href}" class="daoimage" border="0">
									<xsl:if test="following::arc[1]/@title">
										<xsl:attribute name="title">
											<xsl:value-of select="following::arc[1]/@title"/>
										</xsl:attribute>
										<xsl:attribute name="alt">
											<xsl:value-of select="following::arc[1]/@title"/>
										</xsl:attribute>
									</xsl:if>
								</img>
								<xsl:if test="string(daodesc)">
									<br/>
									<span class="daodesc">
										<xsl:apply-templates/>
									</span>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:when
						test="(arc[1][@show='replace'] or arc[1][@show='new']) and arc[1][@actuate='onrequest']">
						<a>
							<xsl:choose>
								<!-- when a textual hyperlink is desired, i.e. <resource> element contains data -->
								<xsl:when test="string(resource)">
									<xsl:for-each select="daoloc">
										<xsl:if test="@label = following::arc[1]/@to">
											<xsl:attribute name="href">
												<xsl:value-of select="@href"/>
											</xsl:attribute>
											<xsl:if test="following::arc[1]/@show='new'">
												<xsl:attribute name="target">_blank</xsl:attribute>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
									<xsl:apply-templates/>
								</xsl:when>
								<xsl:otherwise>
									<!-- if <resource> element is empty, produce an icon that can be used to traverse the link -->
									<xsl:for-each select="daoloc">
										<xsl:if test="@label = following::arc[1]/@to">
											<xsl:attribute name="href">
												<xsl:value-of select="@href"/>
											</xsl:attribute>
											<xsl:if test="following::arc[1]/@show='new'">
												<xsl:attribute name="target">_blank</xsl:attribute>
											</xsl:if>
										</xsl:if>
										<img src="{$pathToIcon}{$iconFilename}" border="0">
											<xsl:if test="following::arc[1]/@title">
												<xsl:attribute name="title">
												<xsl:value-of select="following::arc[1]/@title"
												/>
												</xsl:attribute>
												<xsl:attribute name="alt">
												<xsl:value-of select="following::arc[1]/@title"
												/>
												</xsl:attribute>
											</xsl:if>
										</img>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!--tables-->
		<xsl:template match="table">
		<table bodrder="0" cellpadding="1" cellspacing="2" width="90%" align="center">
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="thead">
		<thead align="top">
			<tr>
				<xsl:for-each select=".//entry">
					<td>
						<p class="table_head">
							<b>
								<xsl:apply-templates/>
							</b>
						</p>
					</td>
					<td>
						<p>&#160;</p>
					</td>
				</xsl:for-each>
			</tr>
		</thead>
		<tr>
			<td>
				<p>&#160;</p>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="row">
		<tr align="top">
			<xsl:for-each select="./entry">
				<td>
					<p class="table_entry">
						<xsl:apply-templates/>
					</p>
				</td>
				<td>
					<p>&#160;</p>
				</td>
			</xsl:for-each>
		</tr>
	</xsl:template>


	<!--loose archdesc-->
		<xsl:template match="profiledesc | revisiondesc | filedesc | eadheader | frontmatter"/>
	<!-- ********************* <FRONTMATTER> *********************** -->
	<xsl:template name="frontmatter">
		<h1 align="left" class="findaidtitles">
			<xsl:for-each select="//titleproper[1]">
				<xsl:apply-templates select="./text() | ./*[not(self::date)]"/>
				<xsl:if test="//titlestmt//subtitle">: <xsl:value-of select="//titlestmt//subtitle"
					/>
				</xsl:if>
				<br/>
				<xsl:apply-templates select="./date"/>
			</xsl:for-each>
		</h1>
		<p style="text-align:center;">
			<a target="_blank"
				href="/print/ark:/{normalize-space(/ead/eadheader/eadid/@identifier)}"
				>Print this Finding Aid</a>
			<xsl:text> | </xsl:text>


			<a target="_blank"
                href="mailto:?subject={//titleproper[1]}&amp;body=http://nwda-db.orbiscascade.org/findaid/ark:/{normalize-space(/ead/eadheader/eadid[1]/@identifier)}"
				>Email this Finding Aid</a>
		</p>

	</xsl:template>
	<!-- ********************* <END FRONTMATTER> *********************** -->
	<!-- ********************* <FOOTER> *********************** -->

	<xsl:template name="footer">
		<h4>
			<xsl:value-of select="//titlestmt//author"/>
			<br/>
			<xsl:value-of select="//publicationstmt/date"/>
		</h4>
		<xsl:if
			test="contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg')">
			<img alt="institutional logo" style="max-height:101px"
				src="{//publicationstmt//extptr/@href}"/>
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

		<h3 class="structhead">
			<a name="overview" id="overview"/>
			<xsl:value-of select="$overview_head"/>
			<input type="button" id="toggle_overview" class="togglebutton" onclick="fade('h_overview')" value="+/-"/>
		</h3>

		<div class="archdesc">
			<div class="overview" id="h_overview">
				<table border="0" summary="Collection level overview of the {//unitname[1]}">
          <!--origination-->
          <xsl:if test="string(did/origination)">
            <tr>
              <td class="overview_label">
                <xsl:choose>
                  <xsl:when test="did/origination/*/@role">
                    <xsl:variable name="orig1"
											select="substring(did/origination/*/@role, 1, 1)"/>
                    <xsl:value-of
											select="translate($orig1, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                    <xsl:value-of select="substring(did/origination/*/@role, 2)"
										/>:
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$origination_label"/>:
                  </xsl:otherwise>
                </xsl:choose>

              </td>
              <td class="overview_entry">
                <xsl:apply-templates select="did/origination"/>
              </td>
            </tr>
          </xsl:if>
          <!--collection title-->
          <xsl:if test="did/unittitle">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$unittitle_label"/>:
              </td>
              <td class="overview_entry">
                <xsl:apply-templates select="did/unittitle[1]"/>
              </td>
            </tr>
          </xsl:if>
          <!--collection dates-->
          <xsl:if test="did/unitdate">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$dates_label"/>:
              </td>
              <td class="overview_entry">
                <xsl:for-each select="did/unitdate">
                  <!--ought to pull in unitdate template-->
                  <xsl:apply-templates/>
                  <xsl:if test="@type">
                    <xsl:text> </xsl:text>( <xsl:value-of select="@type"/>)
                  </xsl:if>
                  <xsl:if test="position() != last()">
                    <br/>
                  </xsl:if>

                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
          <!--collection physdesc-->
          <xsl:if test="did/physdesc">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$physdesc_label"/>:
              </td>
              <td class="overview_entry">
                <!-- 2004-11-30 carlsonm revising physdesc as per instructions -->
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
                  <xsl:if test="string(physfacet) and string(extent)">
                    &#160;:&#160;
                  </xsl:if>
                  <xsl:apply-templates select="physfacet"/>
                  <xsl:if test="string(dimensions) and string(physfacet)">
                    &#160;;&#160;
                  </xsl:if>
                  <xsl:apply-templates select="dimensions"/>
                  <xsl:if test="not(position()=last())">
                    <br/>
                  </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
          <!--collection physloc-->
          <xsl:if test="did/physloc">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$physloc_label"/>:
              </td>
              <td class="overview_entry">
                <xsl:for-each select="did/physloc">
                  <xsl:apply-templates/>
                  <xsl:if test="not(position()=last())">
                    <br/>
                  </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
          <!--collection #-->
          <xsl:if test="did/unitid">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$collectionNumber_label"/>:
              </td>
              <td class="overview_entry">
                <xsl:apply-templates select="did/unitid[1]"/>
                <xsl:if test="did/unitid[2]">
                  ( <xsl:value-of
										select="did/unitid[1]/@type"/>), <xsl:apply-templates
										select="did/unitid[2]"/> ( <xsl:value-of
										select="did/unitid[2]/@type"/>)
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
          <!--collection abstract/summary-->
          <xsl:if test="did/abstract">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$abstract_label"/>:
              </td>
              <td class="overview_entry">
                <xsl:apply-templates select="did/abstract"/>
              </td>
            </tr>
          </xsl:if>
          <!--contact information-->
					<xsl:if test="did/repository">
						<tr>
							<td class="overview_label">
								<xsl:value-of select="$contactinformation_label"/>: </td>
							<td class="overview_entry">

								<!-- carlsonm mod 2004-09-25 select every possible element and display in order encoded -->
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
											<xsl:if
												test="string-length(.)&gt;string-length(subarea)">
												<xsl:apply-templates
												select="text()|*[not(self::subarea)]"/>
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
							</td>
							<!--Collection image-->
							<!-- Ethan Gruber - collection images have been commented out as of 2007-08-27, as per working group discussions-->
							<!--<xsl:choose>-->
							<!-- when there an institutional logo and no collection image: do this -->
							<!--<xsl:when
									test="(contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg')) and not(did/daogrp/daoloc or daogrp/daoloc) ">
										<td rowspan="{$overview_children}"
										style="vertical-align:top; text-align:right;">-->
							<!-- max-height set to 101 pixels because that is the height of the Alaska State Library logo -->
							<!--<img alt="institutional logo"
											style="max-height:101px; margin-bottom:100%"
											src="{//publicationstmt//extptr/@href}"/>
									</td>								
								</xsl:when>-->
							<!-- Ethan Gruber - collection images have been commented out as of 2007-08-27, as per working group discussions-->
							<!-- when there is a logo and a collection image, create a table within the cell, with a row for each image.
										vertically align the first to the top and second row to the bottom.
										this was done in favor of a CSS-only method because IE is not standards compliant and doesn't treat margin-top:100% correctly -->
							<!--<xsl:when
										test="(contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg')) and (did/daogrp/daoloc or daogrp/daoloc)">
										<td rowspan="{$overview_children}"
											style="vertical-align:bottom; height:100%">


											<table style="width:100%; height:100%">
												<tr>
												<td
												style="text-align:right; vertical-align:top;height:200px;">
												<img alt="institutional logo"
												style="max-height:101px"
												src="{//publicationstmt//extptr/@href}"
												/>
												</td>
												</tr>
												<tr>
												<td
												style="text-align:right; vertical-align:bottom">
												<xsl:if
												test="did/daogrp/daoloc or daogrp/daoloc and contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg')">
												<xsl:call-template
												name="collection_image"/>
												</xsl:if>
												</td>
												</tr>
											</table>
										</td>
									</xsl:when>-->

							<!-- Ethan Gruber - collection images have been commented out as of 2007-08-27, as per working group discussions-->
							<!-- when there is no institutional logo, but there is a daogroup, place it on bottom, justified right -->
							<!--									<xsl:when
										test="did/daogrp/daoloc or daogrp/daoloc and not(contains(//publicationstmt//extptr/@href, 'gif') or contains(//publicationstmt//extptr/@href, 'jpg'))">
										<td rowspan="{$overview_children}"
											style="vertical-align:bottom; text-align:right;">
											<xsl:call-template name="collection_image"/>
										</td>
									</xsl:when>-->
							<!--</xsl:choose>-->

						</tr>
					</xsl:if>
					<!--finding aid creation information-->
					<xsl:if test="//profiledesc/creation and $showCreation='true'">
						<tr>
							<td class="overview_label">
								<xsl:value-of select="$creation_label"/>: </td>
							<td class="overview_entry">
								<xsl:apply-templates select="//profiledesc/creation"/>
							</td>
						</tr>
					</xsl:if>
					<!--finding aid revision information-->
					<xsl:if test="//profiledesc/creation and $showRevision='true'">
						<tr>
							<td class="overview_label">
								<xsl:value-of select="$revision_label"/>: </td>
							<td class="overview_entry">
								<xsl:apply-templates select="//revisiondesc/change"/>
							</td>
						</tr>
					</xsl:if>
					<!--language note-->
					<xsl:if test="did/langmaterial">
						<tr>
							<td class="overview_label">
								<xsl:value-of select="$langmaterial_label"/>: </td>
							<td class="overview_entry">
								<xsl:value-of select="did/langmaterial"/>
								<xsl:choose>
									<xsl:when test="langmaterial/text()">
										<xsl:apply-templates select="did/langmaterial"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="did/langmaterial/language">
											<!--<xsl:if test="not(position()='1') or not(position()=last()-1)">,</xsl:if>
													<xsl:if test="position()=last()">and</xsl:if>-->
											<xsl:apply-templates select="did/langmaterial/language"
											/>&#160; </xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:if>
          <!--sponsor-->
          <xsl:if test="//sponsor[1]">
            <tr>
              <td class="overview_label">
                <xsl:value-of select="$sponsor_label"/>:
              </td>
              <td class="overview_entry">
                <xsl:apply-templates select="//sponsor[1]"/>
              </td>
            </tr>
          </xsl:if>

        </table>
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
				<xsl:choose>
					<!--pull in correct label, depending on what is actually matched-->
					<xsl:when test="name()='altformavail'">
						<a name="{$altformavail_id}"/>
						<xsl:value-of select="$altformavail_label"/>
					</xsl:when>
					<xsl:when test="name()='arrangement'">
						<a name="{$arrangement_label}"/>
						<xsl:value-of select="$arrangement_label"/>
					</xsl:when>
					<xsl:when test="name()='bibliography'">
						<a name="{$bibliography_id}"/>
						<xsl:value-of select="$bibliography_label"/>
					</xsl:when>
					<xsl:when test="name()='accessrestrict'">
						<a name="{$accessrestrict_id}"/>
						<xsl:value-of select="$accessrestrict_label"/>
					</xsl:when>
					<xsl:when test="name()='userestrict'">
						<a name="{$userestrict_id}"/>
						<xsl:value-of select="$userestrict_label"/>
					</xsl:when>
					<xsl:when test="name()='prefercite'">
						<a name="{$prefercite_id}"/>
						<xsl:value-of select="$prefercite_label"/>
					</xsl:when>
					<xsl:when test="name()='accruals'">
						<a name="{$accruals_id}"/>
						<xsl:value-of select="$accruals_label"/>
					</xsl:when>
					<xsl:when test="name()='acqinfo'">
						<a name="{$acqinfo_id}"/>
						<xsl:value-of select="$acqinfo_label"/>
					</xsl:when>
					<xsl:when test="name()='appraisal'">
						<a name="{$appraisal_id}"/>
						<xsl:value-of select="$appraisal_label"/>
					</xsl:when>
					<!-- original SY code
						<xsl:when test="name()='bibliography' and ./head">

							<a name="{$bibliography_id}"></a>
							<xsl:value-of select="./head/text()"/>
						</xsl:when>
						-->
					<xsl:when test="name()='custodhist'">
						<a name="{$custodhist_id}"/>
						<xsl:value-of select="$custodhist_label"/>
					</xsl:when>
					<xsl:when test="name()='scopecontent'">
						<a name="{$scopecontent_label}"/>
						<xsl:value-of select="$scopecontent_label"/>
					</xsl:when>
					<xsl:when test="name()='separatedmaterial'">
						<a name="{$separatedmaterial_id}"/>
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
			</b> : <xsl:text>&#160;</xsl:text>
		</xsl:if>
		<!-- 2004-11-30 Suppress the display of all <head> elements (with exceptions).  Example, Pauling finding aid of OSU SC -->
		<!-- 2004-12-06 Process physdesc separately -->
		<xsl:choose>
			<xsl:when test="self::physdesc">
				<div class="{name()}">
					<xsl:apply-templates select="extent[1]"/>
					<xsl:if test="string(extent[2])"> &#160;( <xsl:apply-templates
							select="extent[2]"/>) </xsl:if>
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
		<xsl:if test="self::origination and child::*/@role"> &#160;( <xsl:value-of
				select="child::*/@role"/>) </xsl:if>

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
				<a name="{$bioghist_id}"/>
				<h3 class="structhead">
					<xsl:value-of select="$bioghist_head"/>
					<input type="button" id="toggle_bioghist" class="togglebutton" onclick="fade('h_{$class}')" value="+/-"/>
				</h3>
			</xsl:when>
			<!-- SY Original	<xsl:when test="starts-with(@encodinganalog, '545')"> -->
			<!-- carlson mod 2004-07-09 only use Bioghist head if encodinganalog starts with 5450 as opposed to 5451 -->
			<xsl:when test="starts-with(@encodinganalog, '5450') and not(ancestor::dsc)">
				<a name="{$bioghist_id}"/>
				<h3 class="structhead">
					<xsl:value-of select="$bioghist_head"/>
					<input type="button" id="toggle_bioghist" class="togglebutton" onclick="fade('h_{$class}')" value="+/-"/>
        </h3>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="not(ancestor::dsc)">
          <a name="{$historical_id}"/>
          <h3 class="structhead">
            <xsl:value-of select="$historical_head"/>
            <input type="button" id="toggle_bioghist" class="togglebutton" onclick="fade('h_{$class}')" value="+/-"/>
					</h3>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<div class="{$class}" id="h_{$class}">
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
			<a name="{$scopecontent_id}"/>
			<h3 class="structhead">
				<xsl:value-of select="$scopecontent_head"/>
				<input type="button" id="toggle_scopecontent" class="togglebutton" onclick="fade('h_{$class}')" value="+/-"/>
			</h3>
		</xsl:if>

		<div class="{$class}" id="h_{$class}">


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
				<a name="{$odd_id}"/>
				<h3 class="structhead">
					<xsl:value-of select="$odd_head_histbck"/>
					<input type="button" id="toggle_odd" class="togglebutton"  onclick="fade('h_{$class}')" value="+/-"/>
				</h3>
			</xsl:when>
			<xsl:otherwise>
				<a name="{$odd_id}"/>
				<h3 class="structhead  and not(ancestor::dsc)">
					<xsl:value-of select="$odd_head"/>
					<input type="button" id="toggle_odd" class="togglebutton"  onclick="fade('h_{$class}')" value="+/-"/>
				</h3>
			</xsl:otherwise>
		</xsl:choose>

		<div class="{$class}" id="h_{$class}">
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
			<h3 class="structhead">
				<a name="{$useinfo_id}"/>
				<xsl:value-of select="$useinfo_head"/>
				<input type="button" id="toggle_use" class="togglebutton"  onclick="fade('h_use')" value="+/-"/>
			</h3>
			<div class="use" id="h_use">
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
		<a name="administrative_info"/>
		<h3 class="structhead">
			<xsl:text>Administrative Information</xsl:text>
			<input type="button" id="ai" class="togglebutton" onclick="fade('h_ai')" value="+/-"/>
		</h3>
		<div class="ai" id="h_ai">
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
			<a name="{$arrangement_id}"/>
			<b>Arrangement :</b>
		</xsl:if>
		<div class="{$class}">
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
	</xsl:template>
	<!-- ********************* </ARRANGEMENT> *********************** -->
	<!-- ********************* <ADMININFO> *********************** -->
	<xsl:template name="admininfo">
		<xsl:if
			test="acqinfo | accruals | custodhist | processinfo | separatedmaterial | bibliography | otherfindaid | relatedmaterial | originalsloc | appraisal">
			<xsl:if test="not(ancestor::dsc)">
				<a name="{$admininfo_id}"/>
			</xsl:if>
			<div class="admininfo">
				<xsl:for-each
					select="custodhist | acqinfo | accruals | processinfo | separatedmaterial | bibliography | otherfindaid | relatedmaterial | appraisal | originalsloc">
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
			<a name="{$index_id}"/>
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
				<xsl:apply-templates
					select="corpname | famname | function | genreform | geogname | name | occupation | persname | subject | title"
				/>
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

	<!-- ********************* </MODULES> *********************** -->
	<!-- Hide elements with altrender nodisplay and internal audience attributes-->
	<xsl:template match="*[@altrender='nodisplay']"/>
	<xsl:template match="*[@audience='internal']"/>
	<!-- Hide elements not matched in-toto elsewhere-->
	<xsl:template match="profiledesc"/>
	<xsl:template match="eadheader/eadid | eadheader/revisiondesc | archdesc/did"/>
	<xsl:template match="ead">
		<xsl:call-template name="html_base"/>
	</xsl:template>


  <xsl:template name="highlight" match="//ixiahit">
    <span style="font-weight:bold;color:black;background-color:#FFFF33;">
      <a name="{@number}"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>


  <xsl:template name="html_base">
    <html>
      <head>
        <xsl:comment>WARNING!! THIS FILE MACHINE GENERATED: DO NOT EDIT!!</xsl:comment>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <!-- Dublin Core metadata-->
        <xsl:call-template name="md.dc"/>
        <style type="text/css" media="all">
          @import "<xsl:value-of select="$pathToFiles"
						/><xsl:value-of select="$styleFileName"/> ";
        </style>
        <!-- this so safari on mac osx can get it -->
        <link href="{$pathToFiles}{$styleFileName}" rel="stylesheet"/>
        <script language="javascript" type="text/javascript"
					src="{$pathToFiles}jqs.js"></script>
        <title>
          <xsl:value-of select="$titleproper"/>
          <xsl:value-of select="normalize-space(//subtitle[1])"/>
        </title>
      </head>
      <body bgcolor="#ffffff" bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0" onload="hide('h_ai');">
        <a name="top"></a>
        <xsl:call-template name="html.header.table"/>
        <div class="frontmatter">
          <xsl:call-template name="frontmatter"/>
        </div>

        <table width="952" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td class="toc" style="height:100%; width:180px; vertical-align:top; background-color:#edede8; text-align:right;">
              <xsl:call-template name="toc"/>
            </td>
            <td class="body" style="vertical-align:top; height:100%" id="docBody">
              <xsl:apply-templates select="archdesc"/>
              <div class="footer">
                <xsl:call-template name="footer"/>
              </div>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
