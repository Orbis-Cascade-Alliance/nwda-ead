<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>

<xsl:template match="*[local-name(.) = 'ixiahit']">
<span style="font-weight:bold;color:red">
<a name="{@number}" /> 
<xsl:apply-templates /> 
</span>
</xsl:template>

<xsl:strip-space elements="*"/>
<xsl:template match="/ead">


<!-- MAIN TEMPLATE - creates layout of page -->
<html>

<head>
	<xsl:call-template name="header"/>
	<link rel="stylesheet" href="../xsl/support/ead.css" type="text/css"/>
</head>

<body bgcolor="#ffffff" bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">

<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">

	<tr>
		<td bgcolor="#96AF78"><img src="../xsl/support/logo4.gif" WIDTH="299" HEIGHT="60" /></td>
		<td bgcolor="#96AF78" width="100%"></td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" border="0" cellspacing="0" cellpadding="4">
				<tr>
					<td width="20%" valign="top" bgcolor="#96AF78" class="toc"><xsl:call-template name="toc"/></td>
					<td width="80%" valign="top" bgcolor="#FFFFFF" class="body"><xsl:call-template name="body"/></td>
					<!-- bgcolor="#FAFDD5" -->
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>

</xsl:template>
<!-- END OF MAIN TEMPLATE template -->



<!-- HEADER TEMPLATE - creates Title and MetaData -->

<xsl:template name="header">

<title>
<xsl:if test="string(eadheader/filedesc/titlestmt/titleproper)">
	<xsl:text>NWDA&#xa0;&#xa0;</xsl:text>
	<xsl:value-of select="eadheader/filedesc/titlestmt/titleproper/text()"/>
</xsl:if>
</title>

<!-- The content of each META tag uses Dublin Core semantics as demonstrated in Michael Fox's 
semple stylesheets and is drawn from the text of the finding aid.-->
<meta http-equiv="Content-Type" name="dc.title"
		content="{eadheader/filedesc/titlestmt/titleproper&#x20; }{eadheader/filedesc/titlestmt/subtitle}"/>
<xsl:if test="string(eadheader/filedesc/titlestmt/author)">
	<meta http-equiv="Content-Type" name="dc.author" content="{eadheader/filedesc/titlestmt/author}"/>
</xsl:if>
<xsl:if test="string(eadheader/filedesc/titlestmt/author)">
	<meta http-equiv="Content-Type" name="dc.author" content="{eadheader/filedesc/titlestmt/author}"/>
</xsl:if>

<xsl:if test="string(eadheader/filedesc/publicationstmt/publisher)">
	<meta http-equiv="Content-Type" name="dc.publisher" content="{eadheader/filedesc/publicationstmt/publisher}"/>
</xsl:if>

<xsl:for-each select="//controlaccess/persname | //controlaccess/corpname">
	<xsl:choose>
		<xsl:when test="//@encodinganalog='610'">
			<meta http-equiv="Content-Type" name="dc.subject" content="{.}"/>
		</xsl:when>

		<xsl:when test="//@encodinganalog='611'">
			<meta http-equiv="Content-Type" name="dc.subject" content="{.}"/>
		</xsl:when>

		<xsl:when test="//@encodinganalog='700'">
			<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
		</xsl:when>

		<xsl:when test="//@encodinganalog='710'">
			<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
		</xsl:when>

		<xsl:otherwise>
			<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>

<xsl:for-each select="//controlaccess/subject">
	<meta http-equiv="Content-Type" name="dc.subject" content="{.}"/>
</xsl:for-each>
<xsl:for-each select="//controlaccess/geogname">
	<meta http-equiv="Content-Type" name="dc.subject" content="{.}"/>
</xsl:for-each>

</xsl:template>
<!-- END OF HEADER TEMPLATE template -->



<!-- TOC TEMPLATE - creates Table of Contents -->
<xsl:template name="toc">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr><td><xsl:text>   </xsl:text><a name="toc" /></td></tr>

<xsl:if test="archdesc/did">
	<tr><td class="toc1"><a href="#a1" class="ltoc1"> 
	<xsl:text>Overview</xsl:text>
	</a>
	</td></tr>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>



<xsl:if test="string(archdesc/bioghist)">
	<tr><td class="toc1">
	<a href="#a2" class="ltoc1">
	<xsl:choose>
		<xsl:when test="string(archdesc/bioghist/head)='Biographical Note'">
			<xsl:value-of select="archdesc/bioghist/head"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>Historical Note</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	</a>	
	</td></tr>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>


<xsl:if test="string(archdesc/scopecontent)">
	<tr><td class="toc1">
	<a href="#a3" class="ltoc1">
	<xsl:text>Content Description</xsl:text>
	</a>
	</td></tr>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>

<!--Test to see if there is more than one odd element -->
<xsl:if test="string(archdesc/odd/*)">
	<xsl:for-each select="archdesc/odd[not(@audience='internal')]">
		<tr><td class="toc1">
		<a href="#{generate-id()}" class="ltoc1">
		<xsl:choose>
			<xsl:when test="string(archdesc/odd/head)">
				<xsl:value-of select="archdesc/odd/head"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Archdesc Odd</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		</a>	
		</td></tr>
	</xsl:for-each>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>


<xsl:if test="string(archdesc/arrangement)">
	<tr><td class="toc1">
	<a href="#a5" class="ltoc1">
	<xsl:text>Arrangement</xsl:text>
	</a>
	</td></tr>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>


<xsl:if test="(string(archdesc/custodhist)) 
		or (string(archdesc/acqinfo))
		or (string(archdesc/processinfo))
		or (string(archdesc/accruals))
		or (string(archdesc/separatedmaterial))">
	<tr><td class="toc1">
	<a href="#adai" class="ltoc1">
	<xsl:text>Administrative Information</xsl:text>
	</a>
	</td></tr>

	
	<xsl:if test="string(archdesc/custodhist)">
		<tr><td class="toc2">
		<a href="#a16" class="ltoc2">
		<xsl:text>Custodial History</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/acqinfo)">
		<tr><td class="toc2">
		<a href="#a19" class="ltoc2">
		<xsl:text>Acquisition Information</xsl:text>
		</a>
		</td></tr>
	</xsl:if>

	<xsl:if test="string(archdesc/processinfo)">
		<tr><td class="toc2">
		<a href="#a20" class="ltoc2">
		<xsl:text>Processing Note</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/accruals)">
		<tr><td class="toc2">
		<a href="#a10" class="ltoc2">
		<xsl:text>Future Additions</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/separatedmaterial)">
		<tr><td class="toc2">
		<a href="#a7" class="ltoc2">
		<xsl:text>Separated Materials</xsl:text>
		</a>
		</td></tr>
		
	</xsl:if>
<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>

<xsl:if test="(string(archdesc/accessrestrict)) 
		or (string(archdesc/userestrict)) 
		or (string(archdesc/prefercite)) 
		or (string(archdesc/altformavail))">
		
	<tr><td class="toc1">
	<a href="#aduoc" class="ltoc1">
	<xsl:text>Use of Collection</xsl:text>
	</a>
	</td></tr>


	<xsl:if test="string(archdesc/accessrestrict)">
		<tr><td class="toc2">
		<a href="#a14" class="ltoc2">
		<xsl:text>Restrictions on Access</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/userestrict)">
		<tr><td class="toc2">
		<a href="#a15" class="ltoc2c">
		<xsl:text>Restrictions on Use</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/prefercite)">
		<tr><td class="toc2">
		<a href="#a18" class="ltoc2">
		<xsl:text>Preferred Citation</xsl:text>
		</a>
		</td></tr>
	</xsl:if>

	<xsl:if test="string(archdesc/altformavail)">
		<tr><td class="toc2">
		<a href="#a9" class="ltoc2">
		<xsl:text>Alternate Forms Available</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>


<xsl:if test="(string(archdesc/bibliography)) 
		or (string(archdesc/otherfindaid)) 
		or (string(archdesc/relatedmaterial))">
	<tr><td class="toc1">
	<a href="#adrm" class="ltoc1">
	<xsl:text>Related Information</xsl:text>
	</a>
	</td></tr>


	<xsl:if test="string(archdesc/bibliography)">
		<tr><td class="toc2">
		<a href="#a11" class="ltoc2">
		<xsl:text>Bibliography</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/otherfindaid)">
		<tr><td class="toc2">
		<a href="#a8" class="ltoc2">
		<xsl:text>Additional Reference Guides</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/relatedmaterial)">
		<tr><td class="toc2">
		<a href="#a6" class="ltoc2">
		<xsl:text>Related Materials</xsl:text>
		</a>
		</td></tr>
	</xsl:if>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>

<xsl:if test="string(archdesc/controlaccess)">
	<tr><td class="toc1">
	<a href="#a12" class="ltoc1">
	<xsl:text>Subjects</xsl:text>
	</a>
	</td></tr>

	<xsl:if test="string(archdesc/controlaccess/persname)">
		<tr><td class="toc2">
		<a href="#persname" class="ltoc2">
		<xsl:text>Personal Names</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/famname)">
		<tr><td class="toc2" >
		<a href="#famname" class="ltoc2">
		<xsl:text>Family Names</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/corpname)">
		<tr><td class="toc2">
		<a href="#corpname" class="ltoc2">
		<xsl:text>Organization Names</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	
	<xsl:if test="string(archdesc/controlaccess/geogname)">
		<tr><td class="toc2">
		<a href="#geogname" class="ltoc2">
		<xsl:text>Geographical Names</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/subject)">
		<tr><td class="toc2">
		<a href="#subject" class="ltoc2">
		<xsl:text>Subject Terms</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/formgenre)">
		<tr><td class="toc2">
		<a href="#genreform" class="ltoc2"> 
		<xsl:text>Form or Genre Terms</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/occupation)">
		<tr><td class="toc2">
		<a href="#occupation" class="ltoc2">
		<xsl:text>Occupation</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/function)">
		<tr><td class="toc2">
		<a href="#function" class="ltoc2">
		<xsl:text>Function</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	
	<xsl:if test="string(archdesc/controlaccess/title)">
		<tr><td class="toc2">
		<a href="#title" class="ltoc2">
		<xsl:text>Titles</xsl:text>
		</a>	
		</td></tr>
	</xsl:if>
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>

<xsl:if test="string(archdesc/dsc)">
	<tr><td class="toc1">
	<a href="#a23" class="ltoc1">
	<xsl:choose>
			<xsl:when test="string(archdesc/dsc/head)">
				<xsl:value-of select="archdesc/dsc/head"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Detailed Description of the Collection</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</a>
	</td></tr>
	
	
	<xsl:for-each select="archdesc/dsc/c01[child::c02]">
		<tr><td class="toc2">
		<a class="ltoc2">
			<xsl:attribute name="href">
				<xsl:text>#toc</xsl:text>
				<xsl:number count="c01" from="dsc"/>
			</xsl:attribute>
			<xsl:apply-templates select="did/unittitle"/>			
			
			<xsl:for-each select="did/unittitle/unitdate">
				<xsl:text>,&#xa0;</xsl:text>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
			
			<xsl:for-each select="did/unitdate">
				<xsl:text>,&#xa0;</xsl:text>
				<xsl:apply-templates select="."/>
			</xsl:for-each>

		</a>
	</td></tr>
	</xsl:for-each>
	
	<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
</xsl:if>
</table>
</xsl:template>
<!-- END OF TOC TEMPLATE template -->


<!-- BODY TEMPLATES - creates Body of document -->
<xsl:template name="body">
	

	<xsl:call-template name="eadtitle"/>
	<xsl:call-template name="archdesc-did"/>
	<xsl:call-template name="archdesc-bioghist"/>
	<xsl:call-template name="archdesc-scopecontent"/>
	<xsl:call-template name="archdesc-odd"/>
	<xsl:call-template name="archdesc-arrangement"/>
	<xsl:call-template name="archdesc-admininfo"/>
	<xsl:call-template name="archdesc-useofcollection"/>
	<xsl:call-template name="archdesc-relatedinfo"/>
	<xsl:call-template name="archdesc-subjects"/>
	<xsl:call-template name="inventory"/>
	
</xsl:template>
<!-- END OF BODY TEMPLATES  -->


<!-- EADTITLE TEMPLATE -->
<xsl:template name="eadtitle">
	<table border="0" cellspacing="0" cellpadding="0" width="96%">
	<tr>
		<tr><td colspan="2"><xsl:text>   </xsl:text></td></tr>
	</tr>
	<tr>
		<td valign="top" class="heading1" colspan="2">
			<a name="a0">
				<xsl:for-each select="eadheader/filedesc/titlestmt">
					<a name="a0"></a>
					<xsl:for-each select="titleproper">
					<xsl:apply-templates select="text() |* [not(self::date)]"/>
					<br />
					<xsl:apply-templates select="date"/>
					</xsl:for-each>
					<br />
					<xsl:value-of select="subtitle"/>
				</xsl:for-each>	
			</a>
		</td>
	</tr>	
	<tr><td colspan="2"><xsl:text>   </xsl:text></td></tr>
	<tr><td colspan="2"><xsl:text>   </xsl:text></td></tr>
	</table>	
	
</xsl:template>
<!-- END OF EADTITLE TEMPLATE  -->


<!-- DID TEMPLATE -->
<xsl:template name="archdesc-did">
	<table border="0" cellspacing="0" cellpadding="0" width="96%">

		<tr>
			<td colspan="2" valign="top" class="heading2">
				<a name="a1">
					<xsl:text>Overview of Collection</xsl:text>
				</a>
			</td>
		</tr>	
		<tr><td colspan="2"><xsl:text>   </xsl:text></td></tr>


		<tr><td>
			<table border="0" cellspacing="0" cellpadding="4" width="100%">
				<tr><td width="20%" align="left"></td><td width="80%" align="left"></td></tr>
				<xsl:if test="string(archdesc/did/repository)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:text>Repository:</xsl:text>
					</td>
					<td valign="top" class="bodytext">
						<xsl:if test="string(archdesc/did/repository/text())">
							<xsl:value-of select="archdesc/did/repository/text()"/><br />
						</xsl:if>
						
						<xsl:for-each select="archdesc/did/repository/name[not(@audience='internal')]">
							<xsl:for-each select="node()[not(@audience='internal')] ">
								<xsl:apply-templates select="."/><br />
							</xsl:for-each>
						</xsl:for-each>
						
					
						<xsl:for-each select="archdesc/did/repository/corpname[not(@audience='internal')]">
							<xsl:for-each select="node()[not(@audience='internal')] ">
								<xsl:apply-templates select="."/><br />
							</xsl:for-each>							
						</xsl:for-each>
						
						<xsl:for-each select="archdesc/did/repository/subarea[not(@audience='internal')]">
							<xsl:for-each select="node()[not(@audience='internal')] ">
								<xsl:apply-templates select="."/><br />
							</xsl:for-each>							
						</xsl:for-each>
						
						<xsl:for-each select="archdesc/did/repository/title[not(@audience='internal')]">
						<xsl:for-each select="node()[not(@audience='internal')] ">
							<xsl:apply-templates select="."/><br />
						</xsl:for-each>
						</xsl:for-each>
						
						<xsl:for-each select="archdesc/did/repository/address[not(@audience='internal')] ">
							<xsl:for-each select="./addressline[not(@audience='internal')] ">
								<xsl:value-of select="text()"/><br />
							</xsl:for-each>
						</xsl:for-each>
						
					</td>
				</tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/did/unitid)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:choose>
							<xsl:when test="string(archdesc/did/unitid/label) = 'Collection Number'">
								<xsl:apply-templates select="archdesc/did/unitid/label"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Collection Number:</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td valign="top" class="bodytext">
						<xsl:apply-templates select="archdesc/did/unitid"/>
					</td>
				</tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/did/origination)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:choose>
							<xsl:when test="string(archdesc/did/origination/label) = 'Creator'">
								<xsl:text>Creator:</xsl:text>
							</xsl:when>
							<xsl:when test="string(archdesc/did/origination/label) = 'Collector'">
								<xsl:text>Collector:</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Creator:</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td valign="top" class="bodytext">
						<xsl:apply-templates select="archdesc/did/origination[not(@audience='internal')]"/>
					</td>
				</tr>
				</xsl:if>
					
				<xsl:if test="string(archdesc/did/unittitle)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:text>Title:</xsl:text>
					</td>
					<td valign="top" class="bodytext">
						<xsl:apply-templates select="archdesc/did/unittitle"/>
					</td>
				</tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/did/unitdate)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:text>Dates:</xsl:text>
					</td>
					<td valign="top" class="bodytext">
						<xsl:apply-templates select="archdesc/did/unitdate"/>
					</td>
				</tr>
				</xsl:if>
				

				<xsl:if test="string(archdesc/did/physdesc)">
				<tr>				
						<td valign="top" class="bodytextbold">
							<xsl:text>Quantity:</xsl:text>
						</td>
						
						<td valign="top" class="bodytext">
						<xsl:if test="not(archdesc/did/physdesc/extent)">
							<xsl:choose>
								<xsl:when test="string(archdesc/did/physdesc/@unit)">
									<xsl:apply-templates select="./@unit"/>
									<xsl:text>&#xa0;&#xa0;</xsl:text>
									<xsl:apply-templates select="./text()[not(@audience='internal')]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="./text()[not(@audience='internal')]"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
							
						<xsl:for-each select="archdesc/did/physdesc/extent[not(@audience='internal')]">
							<xsl:choose>
								<xsl:when test="string(@unit)">
									<xsl:apply-templates select="./@unit"/>
									<xsl:text>&#xa0;&#xa0;</xsl:text>
									<xsl:apply-templates select="text()"/><br />
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="text()"/><br />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						</td>
						</tr>	
					</xsl:if>
					

			
				
				<xsl:if test="string(archdesc/did/abstract)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:text>Summary:</xsl:text>
					</td>
					<td valign="top" class="bodytext">
						<xsl:apply-templates select="archdesc/did/abstract[not(@audience='internal')]"/>
					</td>
				</tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/did/physloc)">
				<tr>
					<td valign="top" class="bodytextbold">
						<xsl:text>Location of collection:</xsl:text>
					</td>
					<td valign="top" class="bodytext">
						<xsl:apply-templates select="archdesc/did/physloc[not(@audience='internal')]"/>
					</td>
				</tr>
				</xsl:if>
					
				<xsl:if test="string(archdesc/did/originalsloc)">
				<tr>
					<xsl:if test="not(@audience='internal')">
						<td valign="top" class="bodytextbold">
							<xsl:text>Location of Originals:</xsl:text>
						</td>
						<td valign="top" class="bodytext">
							<xsl:apply-templates select="archdesc/did/originalsloc[not(@audience='internal')]"/>
						</td>
					</xsl:if>
				</tr>
				</xsl:if>
				
			</table>
		</td>
		<td valign="top" class="bodytext">
		<xsl:choose>
			<xsl:when test="archdesc/did/daogrp/daoloc">
				<xsl:call-template name="collection-image" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>&#xa0;&#xa0;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		</td></tr>
		<tr><td colspan="2"><hr /></td></tr>
	</table>

</xsl:template>
<!-- END OF DID TEMPLATE -->		


<!-- ARCHDESC-BIOGHIST TEMPLATE -->
<xsl:template name="archdesc-bioghist">
	<xsl:if test="string(archdesc/bioghist)">
		<table border="0" cellspacing="0" cellpadding="0" width="96%">
		
			<tr>
				<td class="bodytext">
				<xsl:apply-templates select="archdesc/bioghist[not(@audience='internal')]"/>
				</td>
			</tr>
			<tr>
				<td align="right">
					<xsl:call-template name="rtop"/>
				</td>
			</tr>
			<tr><td><hr /></td></tr>
		</table>

	</xsl:if>
</xsl:template>

<xsl:template match="archdesc/bioghist">
	<tr><td class="heading2">
		<a name="a2"></a>
		<xsl:choose>
			<xsl:when test="string(./head)='Biographical Note'">
				<xsl:value-of select="./head"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Historical Note</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>

	<tr><td class="bodytext">
		<xsl:apply-templates select="* [not(self::head)]"/>
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>
</xsl:template>

<!-- END OF BIOGHIST TEMPLATE -->


<!-- ARCHDESC-SCOPECONTENT TEMPLATE -->
<xsl:template name="archdesc-scopecontent">
	<xsl:if test="string(archdesc/scopecontent)">
		<table border="0" cellspacing="0" cellpadding="0" width="96%">
		
		<tr><td><xsl:text>   </xsl:text></td></tr>
		<xsl:apply-templates select="archdesc/scopecontent[not(@audience='internal')]"/>
		<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
		<tr><td><hr /></td></tr>
		</table>

	</xsl:if>
</xsl:template>

<xsl:template match="archdesc/scopecontent">
	<tr><td class="heading2">
	<a name="a3"></a>
		<xsl:text>Content Description</xsl:text>
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>

	<tr><td class="bodytext">
	<xsl:apply-templates select="* [not(self::head)]" />
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>
</xsl:template>

<!-- END OF SCOPECONTENT TEMPLATE -->

<!-- ARCHDESC-ODD TEMPLATE -->
<xsl:template name="archdesc-odd">
	<xsl:if test="string(archdesc/odd)">
		<table border="0" cellspacing="0" cellpadding="0" width="96%">
		
		<tr><td><xsl:text>   </xsl:text></td></tr>
		<xsl:for-each select="archdesc/odd[not(@audience='internal')]">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
		<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
		<tr><td><hr /></td></tr>
		</table>

	</xsl:if>
</xsl:template>

<xsl:template match="archdesc/odd[not(@audience='internal')]">

	<tr><td class="heading2">
		<a name="{generate-id(head)}" class="ltoc1">
		<xsl:choose>
			<xsl:when test="string(archdesc/odd/head)">
				<xsl:value-of select="archdesc/odd/head"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Archdesc Odd</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="archdesc/odd/text()" />
		</a>	
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>

	<tr><td class="bodytext">
	<xsl:apply-templates select="* [not(self::head)]" />
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>
</xsl:template>

<!-- END OF ARCHDESC-ODD TEMPLATE -->

<!-- ARCHDESC-ARRANGEMENT TEMPLATE -->
<xsl:template name="archdesc-arrangement">
	<xsl:if test="string(archdesc/arrangement)">
		<table border="0" cellspacing="0" cellpadding="0" width="96%">
		
		<tr><td><xsl:text>   </xsl:text></td></tr>
		<xsl:apply-templates select="archdesc/arrangement[not(@audience='internal')]"/>
		<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
		<tr><td><hr /></td></tr>
		</table>

	</xsl:if>
</xsl:template>

<xsl:template match="archdesc/arrangement">
	<tr><td class="heading2">
	<a name="a5"></a>
		<xsl:text>Arrangement</xsl:text>
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>

	<tr><td class="bodytext">
	<xsl:apply-templates select="* [not(self::head)]" />
	</td></tr>
	<tr><td><xsl:text>   </xsl:text></td></tr>
</xsl:template>

<!-- END OF ARRANGEMENT TEMPLATE -->



<!-- ADMINISTRATIVE INFORMATION TEMPLATE -->	
<xsl:template name="archdesc-admininfo">
		<xsl:if test="string(archdesc/custodhist)
		or string(archdesc/acqinfo)
		or string(archdesc/processinfo)
		or string(archdesc/accruals)
		or string(archdesc/*/separatedmaterial)">
		
		
			<table border="0" cellspacing="0" cellpadding="0" width="96%">
				<tr><td class="heading2">
				<a name="adai"></a>
					<xsl:text>Administrative Information</xsl:text>
				</td></tr>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
				<xsl:if test="string(archdesc/custodhist)">
					<tr><td class="heading3"><a name="a16" />Custodial History</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/custodhist/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/acqinfo)">
					<tr><td class="heading3"><a name="a19" />Acquisition Information</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/acqinfo/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/processinfo)">
					<tr><td class="heading3"><a name="a20" />Processing Note</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/processinfo/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/accruals)">
					<tr><td class="heading3"><a name="a10" />Future Additions</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/accruals/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/separatedmaterial)">
					<tr><td class="heading3"><a name="a7" />Separated Materials</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/separatedmaterial/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
			
			<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
			<tr><td><hr /></td></tr>
		</table>
		</xsl:if>
	</xsl:template>
	
<!-- END OF ADMINISTRATIVE INFORMATION TEMPLATE -->	



<!-- USE OF COLLECTION TEMPLATE -->	
<xsl:template name="archdesc-useofcollection">
		<xsl:if test="string(archdesc/accessrestrict)
		or string(archdesc/userestrict)
		or string(archdesc/processinfo)
		or string(archdesc/altformavailable)">
			
		
			<table border="0" cellspacing="0" cellpadding="0" width="96%">
				<tr><td class="heading2">
				<a name="aduoc"></a>
					<xsl:text>Use of Collection</xsl:text>
				</td></tr>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
								
				<xsl:if test="string(archdesc/accessrestrict)">
					<tr><td class="heading3"><a name="a14" />Restrictions on Access</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/accessrestrict/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/userestrict)">
					<tr><td class="heading3"><a name="a15" />Restrictions on Use</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/userestrict/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/prefercite)">
					<tr><td class="heading3"><a name="a18" />Preferred Citation</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/prefercite/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/altformavail)">
					<tr><td class="heading3"><a name="a9" />Alternate Forms Available</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/altformavail/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				

			<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
			<tr><td><hr /></td></tr>
		</table>
		</xsl:if>
	</xsl:template>
	
<!-- END OF USE OF COLLECTION TEMPLATE -->	


	
<!-- RELATED INFORMATION TEMPLATE -->	
<xsl:template name="archdesc-relatedinfo">
		<xsl:if test="string(archdesc/bibliography)
		or string(archdesc/otherfindaid)
		or string(archdesc/relatedmaterial)">
			
			<table border="0" cellspacing="0" cellpadding="0" width="96%">
				<tr><td class="heading2">
				<a name="adrm"></a>
					<xsl:text>Related Information</xsl:text>
				</td></tr>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
				<xsl:if test="string(archdesc/bibliography)">
					<tr><td class="heading3"><a name="a11" />Bibliography</td></tr>
					<tr><td class="bodytext">
					<xsl:for-each select="archdesc/bibliography/bibref">
						<xsl:for-each select="node()[not(@audience='internal')] ">
							<xsl:apply-templates select="."/><xsl:text></xsl:text>
							<xsl:text>&#xa0;</xsl:text>
						</xsl:for-each>
						<br />
					</xsl:for-each>
					<xsl:for-each select="archdesc/bibliography[not(self::bibref) and not(@audience='internal')] ">
						<p><xsl:apply-templates select="."/></p>
					</xsl:for-each>
					</td></tr>
					<tr><td><xsl:text>&#xa0;</xsl:text></td></tr>
				</xsl:if>	
				<xsl:if test="string(archdesc/otherfindaid)">
					<tr><td class="heading3"><a name="a8" />Additional Reference Guides</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/otherfindaid/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
				<xsl:if test="string(archdesc/relatedmaterial)">
					<tr><td class="heading3"><a name="a6" />Related Materials</td></tr>
					<tr><td class="bodytext"><xsl:apply-templates select="archdesc/relatedmaterial/*[not(self::head)][not(@audience='internal')]"/></td></tr>
					<tr><td><xsl:text>   </xsl:text></td></tr>
				</xsl:if>
				
			<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
			<tr><td><hr /></td></tr>
		</table>
		</xsl:if>
	</xsl:template>

<!-- END OF RELATED INFORMATION TEMPLATE -->

	

<!-- SUBJECTS TEMPLATE -->
<xsl:template name="archdesc-subjects">
	<xsl:if test="string(archdesc/controlaccess)">
		<table border="0" cellspacing="0" cellpadding="0" width="96%">
			<tr><td class="heading2">
			<a name="a12"></a>
				<xsl:text>Subjects</xsl:text>
				<xsl:text>&#xa0;</xsl:text>
			</td></tr>
			<tr><td><xsl:text>   </xsl:text></td></tr>

			<xsl:if test="string(archdesc/controlaccess/persname) or string(archdesc/controlaccess/controlaccess/persname)">
				<tr><td class="heading3"><a name="persname" />Personal Names</td></tr>
				<xsl:for-each select="archdesc/controlaccess/persname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				<xsl:for-each select="archdesc/controlaccess/controlaccess/persname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/famname) or string(archdesc/controlaccess/controlaccess/famname)">
				<tr><td class="heading3"><a name="famname" />Family Names</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/famname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/famname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/corpname) or string(archdesc/controlaccess/controlaccess/corpname)">
				<tr><td class="heading3"><a name="corpname" />Organization Names</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/corpname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/corpname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/geogname) or string(archdesc/controlaccess/controlaccess/geogname)">
				<tr><td class="heading3"><a name="geogname" />Geographic Terms</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/geogname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/geogname[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/subject) or string(archdesc/controlaccess/controlaccess/subject)">
				<tr><td class="heading3"><a name="subject" />Subject Terms</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/subject[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/subject[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/genreform) or string(archdesc/controlaccess/controlaccess/genreform)">
				<tr><td class="heading3"><a name="formgenre" />Form or Genre Terms</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/genreform[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/genreform[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/occupation) or string(archdesc/controlaccess/controlaccess/occupation)">
				<tr><td class="heading3"><a name="occupation" />Occupation</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/occupation[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/occupation[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/function) or string(archdesc/controlaccess/controlaccess/function)">
				<tr><td class="heading3"><a name="function" />Function</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/function[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
				<xsl:for-each select="archdesc/controlaccess/controlaccess/function[not(@audience='internal')]">
					<tr><td class="bodytext"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
				
			</xsl:if>
			
			<xsl:if test="string(archdesc/controlaccess/title) or string(archdesc/controlaccess/controlaccess/title)">
				<tr><td class="heading3"><a name="title" />Title</td></tr>
			
				<xsl:for-each select="archdesc/controlaccess/title[not(@audience='internal')]">
					<tr><td class="bodytext" style="font-style:italic;"><xsl:apply-templates select="."/></td></tr>
				</xsl:for-each>
				
			<xsl:for-each select="archdesc/controlaccess/controlaccess/title[not(@audience='internal')]">
					<tr><td class="bodytext" style="font-style:italic;"><xsl:apply-templates select="."/><br /></td></tr>
				</xsl:for-each>
				<tr><td><xsl:text>   </xsl:text></td></tr>
			</xsl:if>
			<tr><td align="right"><xsl:call-template name="rtop"/></td></tr>
			<tr><td><hr /></td></tr>

		</table>
	</xsl:if>
</xsl:template>
	
<!-- END OF SUBJECTS TEMPLATE -->

<!-- INVENTORY TEMPLATE -->
<xsl:template name="inventory">
	<xsl:apply-templates select="archdesc/dsc" />	
</xsl:template>

<!-- Formats the dsc portion of a finding aid. -->
	<xsl:template match="archdesc/dsc">
		<table border="0" cellspacing="0" cellpadding="0" width="96%">
			<tr><td colspan="3" class="heading2">
			<a name="a23">
			<xsl:choose>
				<xsl:when test="string(./head)">
					<xsl:value-of select="./head"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Detailed Description of the Collection</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			</a>
			</td></tr>
			<tr><td colspan="3" ><xsl:text>&#xa0;</xsl:text></td></tr>
			<tr><td colspan="3" class="componenttext">
				<xsl:apply-templates select="./p" />
			</td></tr>
			<tr><td colspan="3" ><xsl:text>&#xa0;</xsl:text></td></tr>
			<tr>
				<td width="15%" class="componentbold">
					<xsl:text>Container</xsl:text>
				</td>
				<td width="70%">
					<xsl:text>&#xa0;</xsl:text>
				</td>
				<td width="15%" class="componentbold">
					<xsl:text>Date</xsl:text>
				</td>
			</tr>
			<xsl:apply-templates select="c01" />
		</table>
	</xsl:template>
	


	
	
	<!--Formats the container, unitid, unittitle, unitdate, and
	physdesc elements of components at all levels.-->



	<xsl:template name="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<xsl:if test="(not(did/container[1]/@type=preceding::container[1]/@type)) and (not(did/container[2]/@type=preceding::container[2]/@type)) and (not(did/container[3]/@type=preceding::container[3]/@type))">
 		<tr>
			<td nowrap="true" valign="top" class="componenttext">
				<xsl:if test="not(did/container[1]/@type=preceding::container[1]/@type)">
					<u><xsl:value-of select="did/container[1]/@type"/></u>
				</xsl:if>
				<xsl:text>&#xa0;</xsl:text>
			</td>
			<td nowrap="true" valign="top" class="componenttext">
				<xsl:if test="not(did/container[1]/@type=preceding::container[2]/@type)">
					<u><xsl:value-of select="did/container[2]/@type"/></u>
				</xsl:if>
				<xsl:text>&#xa0;</xsl:text>
			</td>
			<td nowrap="true" valign="top" class="componenttext">
				<xsl:if test="not(did/container[1]/@type=preceding::container[3]/@type)">
					<u><xsl:value-of select="did/container[3]/@type"/></u>
				</xsl:if>
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
		</xsl:if>
		<tr>
			<td nowrap="true" valign="top" class="componenttext">
				<xsl:value-of select="did/container[1]"/> 
				<xsl:text>&#xa0;</xsl:text>
			</td>
			<td nowrap="true" valign="top" class="componenttext">
				<xsl:value-of select="did/container[2]"/> 
				<xsl:text>&#xa0;</xsl:text>
			</td>
			<td nowrap="true" valign="top" class="componenttext">
				<xsl:value-of select="did/container[3]"/> 
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	</table>
	</xsl:template> 
	
	<xsl:template name="did-unitid">
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="./@level='series' or ./@level='subgrp'">
						<xsl:text>componentbold</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>componenttext</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="did/unitid" />
			<xsl:text>&#xa0;</xsl:text>
		</span>
		
	</xsl:template>
	
	<xsl:template name="did-unittitle">
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="./@level='series' or ./@level='subgrp'">
						<xsl:text>componentbold</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>componenttext</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="did/unittitle" />
		</span>
		
	</xsl:template>
	
	<xsl:template name="did-unitdate">
		<xsl:for-each select="unittitle/unitdate">
				<xsl:text>&#xa0;</xsl:text>
				<xsl:value-of select="text()"/>
		</xsl:for-each>
			
		<xsl:for-each select="unitdate">
				<xsl:text>&#xa0;</xsl:text>
				<xsl:value-of select="text()"/>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template name="dsc-other">
		<xsl:for-each select="abstract[not(@audience='internal')] | langmaterial[not(@audience='internal')] | materialspec[not(@audience='internal')] | scopecontent[not(@audience='internal')] | bioghist[not(@audience='internal')] | organization[not(@audience='internal')] |arrangement[not(@audience='internal')] | admininfo[not(@audience='internal')] | add[not(@audience='internal')] | odd[not(@audience='internal')]">
			<p><xsl:apply-templates/></p>
		</xsl:for-each>
							
		<xsl:for-each select="note[not(@audience='internal')]">
			<blockquote><i><xsl:apply-templates /></i></blockquote>
		</xsl:for-each>
							
		<xsl:for-each select="did/physdesc[not(@audience='internal')]">
			<xsl:call-template name="did-physdesc"/>
		</xsl:for-each> 
	</xsl:template>							

	<xsl:template name="did-physdesc">
	
		<xsl:if test="not(extent)">
		<xsl:choose>
			<xsl:when test="string(@label)">
				<xsl:apply-templates select="./@label"/>
				<p><xsl:text>&#xa0;&#xa0;</xsl:text>
				<xsl:apply-templates select="text()"/></p>
			</xsl:when>
			<xsl:otherwise>
				<p><xsl:text>Quantity &#xa0;&#xa0;</xsl:text>
				<xsl:apply-templates select="text()"/></p>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
		
		<xsl:for-each select="extent">
			<xsl:choose>
				<xsl:when test="string(@label)">
					<xsl:apply-templates select="./@label"/>
					<br /><xsl:text>&#xa0;&#xa0;</xsl:text>
					<xsl:apply-templates select="text()"/>
				</xsl:when>
				<xsl:otherwise>
					<br /><xsl:text>Quantity: &#xa0;&#xa0;</xsl:text>
					<xsl:apply-templates select="text()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template> 

	
	<!--Process c01 elements -->
	<xsl:template match="c01">
		<xsl:if test="c02" > 
		<tr>
			<td colspan="3">
				<a class="tochc">
					<xsl:attribute name="name">
						<xsl:text>toc</xsl:text>
						<xsl:number from="dsc" count="c01"/>
					</xsl:attribute>
				</a>
			</td>
		</tr>
		</xsl:if> 
		
		<tr>
			<xsl:choose>
				<xsl:when test="did/container">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="componenttext">
							
								
							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 
							
							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:if test="string(did/unittitle/unitdate)">
								<xsl:text>,&#xa0;</xsl:text>
								<span class="componentbold">
								<xsl:for-each select="did/unittitle/unitdate">
									<xsl:value-of select="text()"/>
								</xsl:for-each>	
								</span>
							</xsl:if> 
							<xsl:if test="string(did/unitdate)">
								<span class="componentbold">
								<xsl:text>,&#xa0;</xsl:text>						
								<xsl:for-each select="did/unitdate">
									<xsl:value-of select="text()"/>
								</xsl:for-each>
								</span>	
							</xsl:if> 
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componenttext">
				<xsl:text>&#xa0;</xsl:text>	
			</td>
		</tr>
	<xsl:apply-templates select="c02" />
	<xsl:if test="c02" > 
		<tr>
			<td valign="top" align="right" class="componenttext" colspan="3">
				<xsl:call-template name="rtop"/>
			</td>
	<!--		<td>
				<xsl:text>&#xa0;</xsl:text>
			</td>
	 -->	</tr>
 	</xsl:if>
	</xsl:template>
	

	<!--Process c02 elements -->
	<xsl:template match="c02">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c03" />
	</xsl:template>
	<!--End Process C02 Elements -->
	
	
	<!--Process c03 elements -->
	<xsl:template match="c03">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c04" />
	</xsl:template>
	<!--End Process C03 Elements -->
	
	
	<!--Process c04 elements -->
	<xsl:template match="c04">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c05" />
	</xsl:template>
	<!--End Process C04 Elements -->
	
	<!--Process c05 elements -->
	<xsl:template match="c05">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c06" />
	</xsl:template>
	<!--End Process C05 Elements -->
	
	<!--Process c06 elements -->
	<xsl:template match="c06">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c07" />
	</xsl:template>
	<!--End Process C06 Elements -->
	
	<!--Process c07 elements -->
	<xsl:template match="c07">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c08" />
	</xsl:template>
	<!--End Process C07 Elements -->
	
	<!--Process c08 elements -->
	<xsl:template match="c08">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c09" />
	</xsl:template>
	<!--End Process C08 Elements -->
	
	<!--Process c09 elements -->
	<xsl:template match="c09">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c10" />
	</xsl:template>
	<!--End Process C09 Elements -->
	
	<!--Process c10 elements -->
	<xsl:template match="c10">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c11" />
	</xsl:template>
	<!--End Process C10 Elements -->
	
	<!--Process c11 elements -->
	<xsl:template match="c11">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	<xsl:apply-templates select="c12" />
	</xsl:template>
	<!--End Process C11 Elements -->
	

	<!--Process c12 elements -->
	<xsl:template match="c12">
			
		<tr>
			<xsl:choose>
				<xsl:when test="string(did/container)">
					<td width="15%" valign="top">
						<xsl:call-template name="container"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td width="15%" valign="top">
						<xsl:text>&#xa0;</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<td valign="top" width="70%" class="componenttext">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" width="3%" ><xsl:text>&#xa0;</xsl:text></td>
						<td valign="top" class="componenttext">

							<xsl:if test="string(did/unitid)">
								<xsl:call-template name="did-unitid"/>
							</xsl:if> 

							<xsl:if test="string(did/unittitle)">
								<xsl:call-template name="did-unittitle"/>
							</xsl:if>
							
							<xsl:call-template name="dsc-other"/>				
						</td>
					</tr>
				</table>
			</td>

			<td valign="top" width="15%" class="componentpad">
				<xsl:for-each select="did/unittitle/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>							
				<xsl:for-each select="did/unitdate">
					<xsl:value-of select="text()"/>
					<xsl:text>&#xa0;</xsl:text>
				</xsl:for-each>	
				<xsl:text>&#xa0;</xsl:text>
			</td>
		</tr>
	
	</xsl:template>
	<!--End Process C12 Elements -->



<!--END OF INVENTORY TEMPLATE -->

<!-- RENDER ATTRIBUTES -->
<!-- The following general templates format the display of various RENDER
 attributes.-->
 <xsl:template match="emph[@render='']">
	<b>
		<xsl:apply-templates/>
	</b>
</xsl:template>
<xsl:template match="emph[@render='bold']">
	<b>
		<xsl:apply-templates/>
	</b>
</xsl:template>
<xsl:template match="emph[@render='italic']">
	<i>
		<xsl:apply-templates/>
	</i>
</xsl:template>
<xsl:template match="emph[@render='underline']">
	<u>
		<xsl:apply-templates/>
	</u>
</xsl:template>
<xsl:template match="emph[@render='sub']">
	<sub>
		<xsl:apply-templates/>
	</sub>
</xsl:template>
<xsl:template match="emph[@render='super']">
	<super>
		<xsl:apply-templates/>
	</super>
</xsl:template>

<xsl:template match="emph[@render='quoted']">
	<xsl:text>"</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>"</xsl:text>
</xsl:template>

<xsl:template match="emph[@render='doublequote']">
	<xsl:text>"</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>"</xsl:text>
</xsl:template>
<xsl:template match="emph[@render='singlequote']">
	<xsl:text>'</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>'</xsl:text>
</xsl:template>
<xsl:template match="emph[@render='bolddoublequote']">
	<b>
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</b>
</xsl:template>
<xsl:template match="emph[@render='boldsinglequote']">
	<b>
		<xsl:text>'</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>'</xsl:text>
	</b>
</xsl:template>
<xsl:template match="emph[@render='boldunderline']">
	<b>
		<u>
			<xsl:apply-templates/>
		</u>
	</b>
</xsl:template>
<xsl:template match="emph[@render='bolditalic']">
	<b>
		<i>
			<xsl:apply-templates/>
		</i>
	</b>
</xsl:template>
<xsl:template match="emph[@render='boldsmcaps']">
	<font style="font-variant: small-caps">
		<b>
			<xsl:apply-templates/>
		</b>
	</font>
</xsl:template>
<xsl:template match="emph[@render='smcaps']">
	<font style="font-variant: small-caps">
		<xsl:apply-templates/>
	</font>
</xsl:template>
<xsl:template match="p">
	<p>
		<xsl:apply-templates/>
	</p>
</xsl:template>
<xsl:template match="title[not(string(@render))]">
	<i>
		<xsl:apply-templates/>
	</i>
</xsl:template>
<xsl:template match="title[@render='bold']">
	<b>
		<xsl:apply-templates/>
	</b>
</xsl:template>
<xsl:template match="title[@render='italic']">
	<i>
		<xsl:apply-templates/>
	</i>
</xsl:template>
<xsl:template match="title[@render='underline']">
	<u>
		<xsl:apply-templates/>
	</u>
</xsl:template>
<xsl:template match="title[@render='sub']">
	<sub>
		<xsl:apply-templates/>
	</sub>
</xsl:template>
<xsl:template match="title[@render='super']">
	<super>
		<xsl:apply-templates/>
	</super>
</xsl:template>
	<xsl:template match="title[@render='quoted']">
	<xsl:text>"</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>"</xsl:text>
</xsl:template>
	<xsl:template match="title[@render='doublequote']">
	<xsl:text>"</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>"</xsl:text>
</xsl:template>

<xsl:template match="title[@render='singlequote']">
	<xsl:text>'</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>'</xsl:text>
</xsl:template>
<xsl:template match="title[@render='bolddoublequote']">
	<b>
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</b>
</xsl:template>
<xsl:template match="title[@render='boldsinglequote']">
	<b>
		<xsl:text>'</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>'</xsl:text>
	</b>
</xsl:template>
	<xsl:template match="title[@render='boldunderline']">
	<b>
		<u>
			<xsl:apply-templates/>
		</u>
	</b>
</xsl:template>
<xsl:template match="title[@render='bolditalic']">
	<b>
		<i>
			<xsl:apply-templates/>
		</i>
	</b>
</xsl:template>
<xsl:template match="title[@render='boldsmcaps']">
	<font style="font-variant: small-caps">
		<b>
			<xsl:apply-templates/>
		</b>
	</font>
</xsl:template>
<xsl:template match="title[@render='smcaps']">
	<font style="font-variant: small-caps">
		<xsl:apply-templates/>
	</font>
</xsl:template>
<!-- END OF RENDER ATTRIBUTES -->


<!-- This template converts a Ref element into an HTML anchor.-->
<xsl:template match="ref">
	<a href="#{@target}">
		<xsl:apply-templates/>
	</a>
</xsl:template>

<!--This template rule formats a list element.-->
	<xsl:template match="//list">
		<xsl:for-each select="item">
			<p class="bodytextpad"><xsl:apply-templates/></p>
		</xsl:for-each>
	</xsl:template>
	
	<!--Formats a simple table. The width of each column is defined by the colwidth attribute in a colspec element.-->
	<xsl:template match="table">
		<h3>
			<xsl:apply-templates select="head"/>
		</h3>
		<table width="100%">
			<xsl:for-each select="tgroup">
				<tr>
					<xsl:for-each select="colspec">
						<td width="{@colwidth}"></td>
					</xsl:for-each>
				</tr>
				<xsl:for-each select="thead">
					<xsl:for-each select="row">
						<tr>
							<xsl:for-each select="entry">
								<td valign="top">
									<b>
										<xsl:apply-templates/>
									</b>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</xsl:for-each>

				<xsl:for-each select="tbody">
					<xsl:for-each select="row">
						<tr>
							<xsl:for-each select="entry">
								<td valign="top">
									<xsl:apply-templates/>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!--This template rule formats a chronlist element.-->
	<xsl:template match="chronlist">
		<table width="100%">
			<tr>
				<td width="30%"> </td>
				<td width="65%"> </td>
			</tr>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	
	<xsl:template match="chronlist/listhead">
		<tr>
			<td>
				<b>
					<xsl:apply-templates select="head01"/>
				</b>
			</td>
			<td>
				<b>
					<xsl:apply-templates select="head02"/>
				</b>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="chronlist/chronitem">
		<!--Determine if there are event groups.-->
		<xsl:choose>
			<xsl:when test="eventgrp">
				<!--Put the date and first event on the first line.-->
					<tr>
						<td valign="top">
							<xsl:apply-templates select="date"/>
						</td>
						<td valign="top">
							<xsl:apply-templates select="eventgrp/event[position()=1]"/>
						</td>
					</tr>
				<!--Put each successive event on another line.-->
				<xsl:for-each select="eventgrp/event[not(position()=1)]">
					<tr>
						<td> </td>
						<td valign="top">
							<xsl:apply-templates select="."/>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:when>
			<!--Put the date and event on a single line.-->
			<xsl:otherwise>
				<tr>
					<td valign="top">
						<xsl:apply-templates select="date"/>
					</td>
					<td valign="top">
						<xsl:apply-templates select="event"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<xsl:template match="extref">
	<a>
		<xsl:attribute name="href">
		<xsl:value-of select="@href"/>
		</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
	</xsl:template>
	
	<xsl:template match="extrefloc">
	<a>
		<xsl:attribute name="href">
		<xsl:value-of select="@href"/>
		</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
	</xsl:template>

		<xsl:template name="collection-image">
		<table align="center" border="0" cellspacing="0" cellpadding="4">
			<tr valign="top" align="center">
				<td>
					<xsl:element name="img">
						<xsl:attribute name="src">
							<xsl:value-of select="archdesc/did/daogrp/daoloc/@href"/>
						</xsl:attribute>
					</xsl:element>
				</td>
			</tr>
			<tr align="center">
				<td class="img2">
					<xsl:apply-templates select="daodesc/p"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="rtop">
		<a href="#toc" class="itoc" >[Return to Top]</a>
	</xsl:template>


</xsl:stylesheet>

