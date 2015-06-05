<?xml version="1.0" encoding="UTF-8"?>
<!--
Original coding by stephen.yearl@yale.edu 2003-04-25
Revisions and modifications by Mark Carlson 2004
Major or significant revision history:
2004-07-14 fix daoloc display
2004-07-14 treat <chronitem> separately
2004-07-14 code to treat chronlist differently
2004-09-27 adding test to remove excess space if <p> is in <dsc> 
2004-11-30 add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd>
2004-12-07 put chronlist into a table format instead of a def list
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="ead xs xlink fo" version="1.0">
	<!--links-->
	<xsl:template match="*[local-name()='ref']">
		<a class="xref">
			<xsl:attribute name="href">#<xsl:value-of select="@target"/>
			</xsl:attribute>
			<xsl:value-of select="parent::*[local-name()='p']/text()"/>
			<xsl:value-of select="."/>
		</a>
		<xsl:if test="following-sibling::*[local-name()='ref']">
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*[local-name()='extref'][string(@*[local-name()='href'])]">
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="@*[local-name()='href']"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</a>
	</xsl:template>
	<xsl:template match="*[local-name()='daogrp']">
		<!--    <div class="daogrp"> -->
		<xsl:apply-templates select="*[local-name()='daoloc']"/>
		<!--   </div> -->
	</xsl:template>
	<xsl:template match="*[local-name()='dao']">
		<a target="new">
			<xsl:attribute name="href">
				<xsl:value-of select="@*[local-name()='href']"/>. <xsl:value-of select="@content-role"/>
			</xsl:attribute>
			<xsl:value-of select="*[local-name()='daodesc']"/>
			<span class="glyphicon glyphicon-camera"/>
		</a>
	</xsl:template>
	<!-- 2004-07-14 carlson mod to fix daoloc display -->
	<xsl:template match="*[local-name()='daoloc']">
		<a target="new">
			<xsl:attribute name="href">
				<!--<xsl:value-of disable-output-escaping="yes" select="@*[local-name()='href']"/> removed 7/23/07 by Ethan Gruber-->
				<xsl:value-of select="@*[local-name()='href']"/>
			</xsl:attribute> &#160; <span class="glyphicon glyphicon-camera"/>
		</a>
	</xsl:template>
	<!--expan/abbr-->
	<xsl:template match="*[local-name()='abbr']">
		<xsl:choose>
			<xsl:when test="$expandAbbr='true'">
				<xsl:value-of select="./@expan"/>&#160;( <xsl:value-of select="."/>) </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*[local-name()='expan']">
		<xsl:choose>
			<xsl:when test="$expandAbbr='true'">
				<xsl:value-of select="."/>&#160;( <xsl:value-of select="./@abbr"/>) </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name()='item'] | *[local-name()='indexentry']">
		<li class="{name()}">
			<xsl:apply-templates/>
		</li>
	</xsl:template>

	<xsl:template match="*[local-name()='bibref']">
		<span>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="*[local-name()='eventgrp']" mode="chronlist">
		<xsl:for-each select="*[local-name()='event']">
			<xsl:apply-templates/>
			<br/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="*[local-name()='defitem']">
		<li class="{name()}">
			<xsl:if test="./*[local-name()='label']">
				<b>
					<xsl:value-of select="*[local-name()='label']"/>
				</b>: </xsl:if>
			<xsl:value-of select="*[local-name()='item']"/>
		</li>
	</xsl:template>
	<!-- 2004-07-14 carlsonm mod to treat chronlist differently -->
	<!-- 2004-12-07 carlsonm: put chronlist into a table format instead of a def list -->
	<!-- 2015-06-15 Ethan Gruber: put chronlist back into a bootstrap 3 horizontal def list -->

	<xsl:template match="*[local-name()='chronlist']">
		<xsl:if test="*[local-name()='head']">
			<h5>
				<xsl:apply-templates select="*[local-name()='head']"/>
			</h5>
		</xsl:if>

		<dl class="dl-horizontal">
			<xsl:apply-templates select="./*[not(self::*[local-name()='head'])]"/>
		</dl>

	</xsl:template>

	<xsl:template match="*[local-name()='chronitem']">
		<dt>
			<xsl:apply-templates select="*[local-name()='date']"/>
		</dt>
		<!-- 2004-11-30 Carlson mod add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd> -->
		<dd>
			<xsl:choose>
				<xsl:when test="*[local-name()='event']">
					<xsl:apply-templates select="*[local-name()='event']"/>
				</xsl:when>
				<xsl:when test="*[local-name()='eventgrp']">
					<xsl:apply-templates select="*[local-name()='eventgrp']" mode="chronlist"/>
				</xsl:when>
			</xsl:choose>
		</dd>
	</xsl:template>

	<xsl:template match="*[local-name()='list'] | *[local-name()='index']">
		<xsl:if test="*[local-name()='head']">
			<h5>
				<xsl:apply-templates select="*[local-name()='head']"/>
			</h5>
		</xsl:if>
		<ul>
			
			<xsl:apply-templates select="./*[not(self::*[local-name()='head'])]"/>
		</ul>
	</xsl:template>

	<xsl:template match="*[local-name()='fileplan'] | *[local-name()='bibliography']">
		<xsl:if test="*[local-name()='head']">
			<h5>
				<xsl:apply-templates select="*[local-name()='head']"/>
			</h5>
		</xsl:if>
		<xsl:apply-templates select="./*[not(self::*[local-name()='head'])]"/>
	</xsl:template>

	<!-- where would an archivist be without... "misc"-->
	<xsl:template match="*[local-name()='change']">
		<xsl:apply-templates select="./*[local-name()='item']"/>&#160;( <xsl:apply-templates select="./*[local-name()='date']"/>) </xsl:template>
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

	<xsl:template match="*[local-name()='emph'][not(@render)]">
		<u>
			<xsl:apply-templates/>
		</u>
	</xsl:template>

	<xsl:template match="*[local-name()='lb']">
		<br/>
	</xsl:template>
	<xsl:template match="*[local-name()='unitdate']">
		<xsl:apply-templates/>
		<xsl:text> </xsl:text>
		<!-- original SY code
    <xsl:if test="@type">&#160;<xsl:text></xsl:text>(<xsl:value-of select="@type"/>)</xsl:if>	 
	 -->
		<!-- 2004-07-16 carlsonm mod Do not display @type if c02+ -->
		<xsl:if test="@type and not(ancestor::*[local-name()='c01'])">&#160; <xsl:text/>( <xsl:value-of select="@type"/>) </xsl:if>
	</xsl:template>

	<xsl:template match="*[local-name()='unitid']" mode="archdesc">
		<span property="dcterms:identifier" content="{.}">
			<xsl:value-of select="."/>
			<xsl:if test="@type">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@type"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
			<xsl:if test="not(position() = last())">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</span>
	</xsl:template>

	<xsl:template match="*[local-name()='unitdate']" mode="archdesc">
		<xsl:value-of select="."/>
		<xsl:if test="@type">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="@type"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:if test="@normal">
			<div class="hidden">
				<xsl:choose>
					<xsl:when test="contains(@normal, '/')">
						<xsl:variable name="start" select="substring-before(@normal, '/')"/>
						<xsl:variable name="end" select="substring-after(@normal, '/')"/>


						<xsl:choose>
							<xsl:when test="@type='bulk'">
								<span content="{$start}" property="arch:bulkStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$start"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="$start"/>
								</span>
								<span content="{$end}" property="arch:bulkEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$end"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="$end"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span content="{$start}" property="arch:inclusiveStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$start"/>
										</xsl:call-template>
									</xsl:attribute>

									<xsl:value-of select="$start"/>
								</span>
								<span content="{$end}" property="arch:inclusiveEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$end"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="$end"/>
								</span>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="@type='bulk'">
								<span content="{@normal}" property="arch:bulkStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
								<span content="{@normal}" property="arch:bulkEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span content="{@normal}" property="arch:inclusiveStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
								<span content="{@normal}" property="arch:inclusiveEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:otherwise>
				</xsl:choose>
			</div>

		</xsl:if>
		<xsl:if test="not(position() = last())">
			<br/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="unitdate-datatype">
		<xsl:param name="date"/>
		<xsl:attribute name="datatype">xsd:gYear</xsl:attribute>
		<!--<xsl:choose>
			<xsl:when test="$date castable as xs:date">
				<xsl:attribute name="datatype">xsd:date</xsl:attribute>
			</xsl:when>
			<xsl:when test="$date castable as xs:gYearMonth">
				<xsl:attribute name="datatype">xsd:gYearMonth</xsl:attribute>
			</xsl:when>
			<xsl:when test="$date castable as xs:gYear">
				<xsl:attribute name="datatype">xsd:gYear</xsl:attribute>
			</xsl:when>
		</xsl:choose>-->
	</xsl:template>

	<!-- March 2015: For displaying the container within c01/did. Revision specification 7.1.2 -->
	<xsl:template match="*[local-name()='container']" mode="c01">
		<xsl:if test="@type">
			<xsl:value-of select="concat(translate(substring(@type, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(@type, 2))"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="."/>
		<xsl:if test="not(position()=last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="*[local-name()='extent']">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<span property="dcterms:extent">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, </xsl:text>
				<span property="dcterms:extent" content="{.}">
					<xsl:text>(</xsl:text>
					<xsl:value-of select="."/>
					<xsl:text>)</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name()='p']">
		<!-- 2004-09-27 carlsonm: adding test to remove excess space if <p> is in <dsc> 
Tracking # 4.20
-->
		<xsl:choose>
			<xsl:when test="not(ancestor::*[local-name()='dsc']) or parent::*[local-name()='dsc']">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:if test="not(position()=last()) and *[local-name()='c01']">
					<br/>
					<br/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*[local-name()='controlaccess'][@type='lower']">
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
	<xsl:template match="*[local-name()='address']">
		<p class="address">
			<!-- the following code distinguishes between a text-only address line and a url or email address -->
			<xsl:for-each select="*[local-name()='addressline']">
				<xsl:choose>
					<!-- if the addressline contains http://, a href is created -->
					<xsl:when test="contains(normalize-space(.), 'http://')">
						<xsl:choose>
							<xsl:when test="substring-before(normalize-space(.), 'http://')">
								<xsl:value-of select="substring-before(normalize-space(.), 'http://')"/>
								<a href="http://{substring-after(normalize-space(.), 'http://')}" target="_blank">
									<xsl:text>http://</xsl:text>
									<xsl:value-of select="substring-after(normalize-space(.), 'http://')"/>
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
									<xsl:value-of select="substring-after(normalize-space(.), ' ')"/>
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
	<xsl:template match="*[local-name()='div']">
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
	<xsl:template match="*[local-name()='title']">
		<i>
			<xsl:apply-templates/>
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
	<!-- ********************* </* @render> *********************** -->
</xsl:stylesheet>
