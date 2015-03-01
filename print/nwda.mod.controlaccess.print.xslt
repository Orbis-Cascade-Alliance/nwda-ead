<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<!-- ********************* <CONTROLACCESS> *********************** -->
	
<xsl:template match="controlaccess" name="controlaccess">
<!-- P.S. Can't just select index [1] controlaccess because it may not be the group with
the indexing terms -->

		<div class="controlaccess">

				<xsl:call-template name="group_subject"/>
<xsl:if test="descendant::*[@encodinganalog='700'] or descendant::*[@encodinganalog='710']">
				<xsl:call-template name="group_other"/>
</xsl:if>
		</div>

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
<a id="{$controlaccess_id}"></a>
				<h3 class="structhead">
					<xsl:value-of select="$controlaccess_head" />
				</h3>
</xsl:if>

<xsl:if test="descendant::*[not(@altrender='nodisplay')]">
<!-- i.e. we don't want to print a select "Subject" heading if there are more
<controlaccess> elements that need to be selected -->




<table>
<xsl:choose>
<xsl:when test="child::controlaccess">
<xsl:if test="child::p">
<tr><td><xsl:apply-templates select="p"/></td></tr>
<tr><td>&#160;</td></tr>
</xsl:if>
<xsl:for-each select="controlaccess">
<xsl:for-each select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | subject[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | genreform[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | geogname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | occupation[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | function[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | title[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]">
<xsl:sort select="normalize-space(.)"/>
<!--
<xsl:if test="position()=1">
<tr><td style="font-weight: bold;"><xsl:call-template name="controlaccess_heads"/> :</td></tr>
</xsl:if>
-->
<tr><td><xsl:apply-templates /><xsl:if test="@role and not(@role='subject')">&#160;(<xsl:value-of select="@role"/>)</xsl:if></td></tr>
<!--
<xsl:if test="position()=last()">
<tr><td>&#160;</td></tr>
</xsl:if>
-->
</xsl:for-each>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:for-each select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))] | subject[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | genreform[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | geogname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | occupation[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | function[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0] | title[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0]">
<xsl:sort/>

<tr><td><xsl:apply-templates /><xsl:if test="@role and not(@role='subject')">&#160;(<xsl:value-of select="@role"/>)</xsl:if></td></tr>


</xsl:for-each>
</xsl:otherwise>
</xsl:choose>
</table>

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
<table>
<xsl:if test="not(child::controlaccess)">
<tr><td>&#160;</td></tr>
</xsl:if>
<tr><td style="font-weight: bold;">Other Creators :</td></tr>
<xsl:choose>
<xsl:when test="child::controlaccess and controlaccess/*/@encodinganalog='700' or controlaccess/*/@encodinganalog='710'">

<xsl:for-each select="controlaccess">
<xsl:for-each select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
<xsl:sort select="normalize-space(.)"/>
<!-- PER EN, DON'T SUBDIVIDE OTHER CREATORS 
<xsl:if test="position()=1">
<tr><td style="font-weight: bold;"><xsl:call-template name="controlaccess_heads"/> :</td></tr>
</xsl:if>
-->
<tr><td><xsl:apply-templates /><xsl:if test="@role and not(@role='creator') and not(@role='subject')">&#160;(<xsl:value-of select="@role"/>)</xsl:if></td></tr>
<!-- 
<xsl:if test="position()=last()">
<tr><td>&#160;</td></tr>
</xsl:if>
-->
</xsl:for-each>
</xsl:for-each>

</xsl:when>
<xsl:otherwise>

<xsl:for-each select="name[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | persname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | corpname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')] | famname[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')]">
<xsl:sort/>

<tr><td><xsl:apply-templates /><xsl:if test="@role and not(@role='creator') and not(@role='subject')">&#160;(<xsl:value-of select="@role"/>)</xsl:if></td></tr>


</xsl:for-each>

</xsl:otherwise>
</xsl:choose>

</table>
<!--
</xsl:if>
-->
</xsl:template>
	

<!--
	<xsl:template name="group" match="controlaccess//corpname | controlaccess//famname | controlaccess//geogname | controlaccess//genreform | controlaccess//name | controlaccess//occupation | controlaccess//persname | controlaccess//subject | controlaccess//title">
		<xsl:choose>

			<xsl:when test="$groupControlaccess='true'">
				<xsl:if test="not(@altrender='nodisplay')">
					<xsl:choose>
						<xsl:when test="name()!=name((preceding-sibling::*)[last()])">
							<br/>
							<b class="subjectHead">
								<xsl:call-template name="controlaccess_heads">
									<xsl:with-param name="node_name">
										<xsl:value-of select="name()"/>
									</xsl:with-param>
								</xsl:call-template>
							</b>
							<span class="subject">
								<xsl:apply-templates/>
							</span>
						</xsl:when>
	
						<xsl:otherwise>
							<br/>
							<span class="subject">
								<xsl:apply-templates/>
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
-->

	<!-- ********************* <CONTROLACCESS HEADINGS> *********************** -->
	<!--
	<xsl:template name="controlaccess_heads">
		<xsl:param name="node_name"/>
		<xsl:choose>
			<xsl:when test="$node_name='corpname'">
				<a name="{$node_name}" id="{$node_name}">Corporate Names</a>
			</xsl:when>
			<xsl:when test="$node_name='famname'">
				<a name="{$node_name}" id="{$node_name}">Family Names</a>
			</xsl:when>
			<xsl:when test="$node_name='function'">
				<a name="{$node_name}" id="{$node_name}">Functions</a>
			</xsl:when>
			<xsl:when test="$node_name='geogname'">
				<a name="{$node_name}" id="{$node_name}">Geographical Names</a>
			</xsl:when>
			<xsl:when test="$node_name='genreform'">
				<a name="{$node_name}" id="{$node_name}">Form or Genre Terms</a>
			</xsl:when>
			<xsl:when test="$node_name='name'">
				<a name="{$node_name}" id="{$node_name}">Other Names</a>
			</xsl:when>
			<xsl:when test="$node_name='occupation'">
				<a name="{$node_name}" id="{$node_name}">Occupations</a>
			</xsl:when>
			<xsl:when test="$node_name='persname'">
				<a name="{$node_name}" id="{$node_name}">Personal Names</a>
			</xsl:when>
			<xsl:when test="$node_name='subject'">
				<a name="{$node_name}" id="{$node_name}">Subject Terms</a>
			</xsl:when>
			<xsl:when test="$node_name='title'">
				<a name="{$node_name}" id="{$node_name}">Titles</a>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	-->
<xsl:template name="controlaccess_heads">
<xsl:param name="node_name"/>
		<xsl:choose>
			<xsl:when test="self::corpname">
				<a name="{$node_name}" id="{$node_name}">Corporate Names</a>
			</xsl:when>
			<xsl:when test="self::famname">
				<a name="{$node_name}" id="{$node_name}">Family Names</a>
			</xsl:when>
			<xsl:when test="self::function">
				<a name="{$node_name}" id="{$node_name}">Functions</a>
			</xsl:when>
			<xsl:when test="self::geogname">
				<a name="{$node_name}" id="{$node_name}">Geographical Names</a>
			</xsl:when>
			<xsl:when test="self::genreform">
				<a name="{$node_name}" id="{$node_name}">Form or Genre Terms</a>
			</xsl:when>
			<xsl:when test="self::name">
				<a name="{$node_name}" id="{$node_name}">Other Names</a>
			</xsl:when>
			<xsl:when test="self::occupation">
				<a name="{$node_name}" id="{$node_name}">Occupations</a>
			</xsl:when>
			<xsl:when test="self::persname">
				<a name="{$node_name}" id="{$node_name}">Personal Names</a>
			</xsl:when>
			<xsl:when test="self::subject">
				<a name="{$node_name}" id="{$node_name}">Subject Terms</a>
			</xsl:when>
			<xsl:when test="self::title">
				<a name="{$node_name}" id="{$node_name}">Titles within the Collection</a>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>	
	
	<!-- ********************* </CONTROLACCESS HEADINGS> *********************** -->
	<!-- ********************* </CONTROLACCESS> *********************** -->
</xsl:stylesheet>