<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modifications and Revisions by Mark Carlson, 2004
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<!-- ********************* <CONTROLACCESS> *********************** -->
	<xsl:template match="controlaccess" name="controlaccess">
		<!-- P.S. Can't just select index [1] controlaccess because it may not be the group with
		the indexing terms. carlsonm -->
		<a id="{$controlaccess_id}"></a>
		<div id="controlaccess">
			<h3>
				<xsl:value-of select="$controlaccess_head"/>
				<small>
					<a href="#" class="toggle-button" id="toggle-controlaccess">
						<span class="glyphicon glyphicon-minus"/>
					</a>
				</small>
			</h3>

			<div class="controlaccess" id="controlaccess-content">
				<xsl:call-template name="group_subject"/>
				<xsl:if
					test="descendant::*[@encodinganalog='700'] or descendant::*[@encodinganalog='710']">
					<xsl:call-template name="group_other"/>
				</xsl:if>
			</div>
			<p class="top">
				<a href="#top" title="Top of finding aid">^ Return to Top</a>
			</p>
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
										<xsl:call-template name="controlaccess_heads"/> :
									</li>
								</xsl:if>


								<li class="ca_li">
									<xsl:apply-templates/>
									<xsl:if test="@role and not(@role='subject')">
										&#160;(
										<xsl:value-of select="@role"/>)
									</xsl:if>
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
								<xsl:if test="@role and not(@role='subject')">
									&#160;(
									<xsl:value-of select="@role"/>)
								</xsl:if>
							</li>
						</xsl:for-each>
					</ul>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:if>
	</xsl:template>
	<xsl:template name="group_other">
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
									>
									&#160;( <xsl:value-of select="@role"/>)
								</xsl:if>
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
								>
								&#160;( <xsl:value-of select="@role"/>)
							</xsl:if>
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
</xsl:stylesheet>
