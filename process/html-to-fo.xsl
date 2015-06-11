<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#" exclude-result-prefixes="arch
	nwda xsd vcard" version="1.0">
	<xsl:strip-space elements="*"/>
	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
		</xsl:copy>
	</xsl:template>

	<!-- ************************ XSLT TRANSFORMATION TEMPLATES ************************** -->
	<xsl:template match="xsl:output">
		<xsl:element name="xsl:output">
			<xsl:attribute name="method">xml</xsl:attribute>
			<xsl:attribute name="encoding">UTF-8</xsl:attribute>
			<xsl:attribute name="indent">yes</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<!-- suppress TOC -->
	<xsl:template match="xsl:include[@href='nwda.mod.toc.xsl']"/>

	<!-- suppress header -->
	<xsl:template match="xsl:include[@href='nwda.mod.html.header.xsl']"/>

	<!-- point preferences up a level -->
	<xsl:template match="xsl:include[@href='nwda.mod.preferences.xsl']">
		<xsl:element name="xsl:include" namespace="http://www.w3.org/1999/XSL/Transform">
			<xsl:attribute name="href">../nwda.mod.preferences.xsl</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<!-- suppress empty for-each -->
	<xsl:template match="xsl:for-each[contains(@select, '*[@id]')]"/>

	<!-- replace the xsl:choose with the @xml:id='process-rdf' with templates that execute exsl:node-set only (supressing msxsl:node-set) -->
	<!-- 2015-05-14: commented the template below out because the transformations are conducted with Xalan -->
	<!--<xsl:template match="xsl:choose[@xml:id='process-rdf']">
		<xsl:element name="xsl:apply-templates">
			<xsl:attribute name="select">exsl:node-set($rdf)//arch:Archive</xsl:attribute>
			<xsl:attribute name="mode">repository</xsl:attribute>
		</xsl:element>
		<xsl:element name="xsl:apply-templates">
			<xsl:attribute name="select">exsl:node-set($rdf)//arch:Archive</xsl:attribute>
			<xsl:attribute name="mode">contact</xsl:attribute>
		</xsl:element>
	</xsl:template>-->

	<!-- suppress highlighting template -->
	<xsl:template match="xsl:template[@name='highlight']"/>

	<!-- overwrite HTML page construction with XSL:FO construction -->
	<xsl:template match="xsl:template[@name='html_base']">
		<xsl:element name="xsl:template">
			<xsl:attribute name="name">html_base</xsl:attribute>
			<fo:root font-size="12px" color="#6b6b6b" font-family="georgia, 'times new roman', times, serif">
				<!--  -->
				<fo:layout-master-set>
					<fo:simple-page-master margin-right=".5in" margin-left=".5in" margin-bottom=".5in" margin-top=".5in" page-width="8in" page-height="11in" master-name="content">
						<fo:region-body region-name="body" margin-bottom=".5in"/>
						<fo:region-after region-name="footer" extent=".5in"/>
					</fo:simple-page-master>
				</fo:layout-master-set>
				<fo:page-sequence master-reference="content">
					<fo:title>
						<xsl:element name="xsl:value-of" namespace="http://www.w3.org/1999/XSL/Transform">
							<xsl:attribute name="select">$titleproper</xsl:attribute>
						</xsl:element>
					</fo:title>
					<fo:static-content flow-name="footer">
						<fo:block color="#676D38" font-size="85%" intrusion-displace="line">
							<fo:table>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:element name="xsl:value-of">
													<xsl:attribute name="select">
														<xsl:text>$titleproper</xsl:text>
													</xsl:attribute>
												</xsl:element>
											</fo:block>
											<fo:block>
												<fo:basic-link show-destination="new">
													<xsl:attribute name="external-destination">
														<xsl:text>{concat($serverURL, '/ark:/', $identifier)}</xsl:text>
													</xsl:attribute>
													<xsl:element name="xsl:value-of" namespace="http://www.w3.org/1999/XSL/Transform">
														<xsl:attribute name="select">
															<xsl:text>concat($serverURL, '/ark:/', $identifier)</xsl:text>
														</xsl:attribute>
													</xsl:element>
												</fo:basic-link>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block text-align="right">
												<fo:page-number/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:static-content>
					<fo:flow flow-name="body">
						<fo:block font-size="24px" color="#676D38">
							<xsl:element name="xsl:value-of" namespace="http://www.w3.org/1999/XSL/Transform">
								<xsl:attribute name="select">normalize-space(*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unittitle'])</xsl:attribute>
							</xsl:element>
							<xsl:element name="xsl:if" namespace="http://www.w3.org/1999/XSL/Transform">
								<xsl:attribute name="test">*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']</xsl:attribute>
								<xsl:element name="xsl:text" namespace="http://www.w3.org/1999/XSL/Transform">, </xsl:element>
								<xsl:element name="xsl:value-of" namespace="http://www.w3.org/1999/XSL/Transform">
									<xsl:attribute name="select">*[local-name()='archdesc']/*[local-name()='did']/*[local-name()='unitdate']</xsl:attribute>
								</xsl:element>
							</xsl:element>
						</fo:block>
						<fo:block>
							<xsl:element name="xsl:apply-templates">
								<xsl:attribute name="select">*[local-name()='archdesc']</xsl:attribute>
								<xsl:attribute name="mode">flag</xsl:attribute>
							</xsl:element>
						</fo:block>
					</fo:flow>
				</fo:page-sequence>
			</fo:root>
		</xsl:element>
	</xsl:template>

	<!-- restructure archdesc template to eliminate TOC -->
	<xsl:template match="xsl:template[contains(@match, 'archdesc')][@mode='flag']">
		<xsl:element name="xsl:template">
			<xsl:attribute name="match">*[local-name()='archdesc']</xsl:attribute>
			<xsl:attribute name="mode">flag</xsl:attribute>

			<xsl:element name="xsl:call-template">
				<xsl:attribute name="name">collection_overview</xsl:attribute>
			</xsl:element>

			<fo:block border-top-style="solid"/>

			<xsl:element name="xsl:apply-templates">
				<xsl:attribute name="select">*[local-name()='bioghist'] | *[local-name()='scopecontent'] | *[local-name()='odd']</xsl:attribute>
			</xsl:element>

			<xsl:element name="xsl:call-template">
				<xsl:attribute name="name">useinfo</xsl:attribute>
			</xsl:element>
			<xsl:element name="xsl:call-template">
				<xsl:attribute name="name">administrative_info</xsl:attribute>
			</xsl:element>

			<fo:block border-top-style="solid"/>

			<xsl:element name="xsl:apply-templates">
				<xsl:attribute name="select">*[local-name()='dsc']</xsl:attribute>
			</xsl:element>
			<xsl:element name="xsl:apply-templates">
				<xsl:attribute name="select">*[local-name()='controlaccess']</xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- specific HTML attributes -->
	<xsl:template match="xsl:attribute[@name='class']"/>
	<xsl:template match="xsl:attribute[@name='datatype']"/>
	<xsl:template match="xsl:attribute[@name='id']"/>
	<xsl:template match="xsl:attribute[@name='target']"/>
	<xsl:template match="xsl:attribute[@name='title']"/>
	<xsl:template match="xsl:attribute[@name='alt']"/>


	<!-- ************************ TRANSFORMING HTML ELEMENTS INTO FO ************************** -->

	<!-- suppress the following conditions -->
	<xsl:template match="small"/>
	<xsl:template match="span">
		<xsl:choose>
			<xsl:when test="@class='glyphicon glyphicon-camera'">
				<xsl:text>[view]</xsl:text>
			</xsl:when>
			<xsl:when test="string-length(normalize-space(.)) = 0 and not(child::*)"/>
			<xsl:otherwise>
				<fo:inline>
					<xsl:choose>
						<xsl:when test="@class='containerLabel'">
							<xsl:attribute name="color">#676d38</xsl:attribute>
							<xsl:attribute name="font-size">85%</xsl:attribute>
							<xsl:attribute name="text-decoration">none</xsl:attribute>
							<xsl:attribute name="text-transform">capitalize</xsl:attribute>
						</xsl:when>
						<xsl:when test="@class='c0x_header'">
							<xsl:attribute name="font-size">85%</xsl:attribute>
							<xsl:attribute name="font-weight">bold</xsl:attribute>
						</xsl:when>
					</xsl:choose>
					<xsl:apply-templates/>
				</fo:inline>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<!-- headings -->
	<xsl:template match="h3">
		<fo:block font-size="20px" color="#676D38" margin-bottom="10px" margin-top="20px">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="h4">
		<fo:block font-size="14px" color="#6b6b6b" margin-bottom="10px" margin-top="10px" font-weight="bold">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="h5">
		<fo:block font-size="12px" color="#6b6b6b" margin-bottom="10px" margin-top="10px" font-style="italic" font-weight="bold">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<!-- block and in-line elements -->
	<xsl:template match="div">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="p">
		<xsl:element name="xsl:choose">
			<xsl:element name="xsl:when">
				<xsl:attribute name="test">*[local-name()='table']</xsl:attribute>
				<xsl:element name="xsl:apply-templates">
					<xsl:attribute name="select">*[local-name()='table']</xsl:attribute>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:otherwise">
				<fo:block margin-bottom="10px">
					<xsl:apply-templates/>
				</fo:block>
			</xsl:element>
		</xsl:element>
		
	</xsl:template>

	<!-- tables -->
	<xsl:template match="table">
		<fo:table>
			<xsl:attribute name="table-layout">fixed</xsl:attribute>
			<!-- create conditional for dsc tables -->
			<xsl:choose>
				<xsl:when test="ancestor::xsl:template[@name='dsc_table'] or ancestor::xsl:template[@name='dsc']">					
					<!-- construct an xsl:if within the XSL:FO to test for container[2] -->
					<xsl:element name="xsl:choose">
						<!-- when there are two containers -->
						<xsl:element name="xsl:when">
							<xsl:attribute name="test">descendant::*[local-name()='did']/*[local-name()='container'][2]</xsl:attribute>
							<!-- when there is a unitdate, include column for unitdate -->
							<xsl:element name="xsl:choose">
								<xsl:element name="xsl:when">
									<xsl:attribute name="test">descendant::*[local-name()='did']/*[local-name()='unitdate']</xsl:attribute>
									<fo:table-column column-width="10%"/>
									<fo:table-column column-width="10%"/>
									<fo:table-column column-width="60%"/>
									<fo:table-column column-width="20%"/>
								</xsl:element>
								<xsl:element name="xsl:otherwise">
									<fo:table-column column-width="10%"/>
									<fo:table-column column-width="10%"/>
									<fo:table-column column-width="80%"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<!-- when there are not containers -->
						<xsl:element name="xsl:when">
							<xsl:attribute name="test">not(descendant::*[local-name()='did']/*[local-name()='container'])</xsl:attribute>
							<!-- when there is a unitdate, include column for unitdate -->
							<xsl:element name="xsl:choose">
								<xsl:element name="xsl:when">
									<xsl:attribute name="test">descendant::*[local-name()='did']/*[local-name()='unitdate']</xsl:attribute>
									<fo:table-column column-width="80%"/>
									<fo:table-column column-width="20%"/>
								</xsl:element>
								<xsl:element name="xsl:otherwise">
									<fo:table-column column-width="100%"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<!-- when there is one container -->
						<xsl:element name="xsl:otherwise">
							<!-- when there is a unitdate, include column for unitdate -->
							<xsl:element name="xsl:choose">
								<xsl:element name="xsl:when">
									<xsl:attribute name="test">descendant::*[local-name()='did']/*[local-name()='unitdate']</xsl:attribute>
									<fo:table-column column-width="15%"/>
									<fo:table-column column-width="65%"/>
									<fo:table-column column-width="20%"/>
								</xsl:element>
								<xsl:element name="xsl:otherwise">
									<fo:table-column column-width="20%"/>
									<fo:table-column column-width="80%"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="xsl:choose">
						<!-- when there is a colspec -->
						<xsl:element name="xsl:when">
							<xsl:attribute name="test">count(descendant::*[local-name()='colspec']) &gt; 0</xsl:attribute>
							<xsl:element name="xsl:variable">
								<xsl:attribute name="name">count</xsl:attribute>
								<xsl:element name="xsl:value-of">
									<xsl:attribute name="select">count(descendant::*[local-name()='colspec'])</xsl:attribute>
								</xsl:element>
							</xsl:element>
							<xsl:element name="xsl:for-each">
								<xsl:attribute name="select">descendant::*[local-name()='colspec']</xsl:attribute>
								<fo:table-column>
									<xsl:attribute name="column-width">{floor(100 div $count)}%</xsl:attribute>
								</fo:table-column>
							</xsl:element>
						</xsl:element>
						<xsl:element name="xsl:otherwise">
							
						</xsl:element>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
			

			<xsl:apply-templates/>
		</fo:table>
	</xsl:template>

	<xsl:template match="thead">
		<fo:table-header>
			<xsl:apply-templates/>
		</fo:table-header>
	</xsl:template>

	<xsl:template match="tbody">
		<fo:table-body>
			<xsl:apply-templates/>
		</fo:table-body>
	</xsl:template>

	<xsl:template match="tr">
		<fo:table-row>
			<xsl:apply-templates/>
		</fo:table-row>
	</xsl:template>



	<xsl:template match="td">
		<fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px" border-bottom-style="solid" padding="8px">
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned">
					<xsl:value-of select="@colspan"/>
				</xsl:attribute>
			</xsl:if>
			<fo:block>
				<!-- enforce left-indent for c0x -->
				<xsl:if test="contains(@class, 'c0x_content') and ancestor::xsl:template[contains(@match, 'c02')]">
					<xsl:element name="xsl:variable">
						<xsl:attribute name="name">indent</xsl:attribute>
						<xsl:element name="xsl:value-of">
							<xsl:attribute name="select">(number(substring-after(local-name(), 'c')) - 2) * 2</xsl:attribute>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name">padding-left</xsl:attribute>
						<xsl:element name="xsl:value-of">
							<xsl:attribute name="select">concat($indent, 'em')</xsl:attribute>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template match="th">
		<fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px" border-bottom-style="solid" padding="8px">
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned">
					<xsl:value-of select="@colspan"/>
				</xsl:attribute>
			</xsl:if>
			<fo:block>
				<xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<!-- line break -->
	<xsl:template match="br">
		<fo:block/>
	</xsl:template>

	<!-- links -->
	<xsl:template match="a">
		<!-- ignore a tags which are not for anchor positioning -->
		<xsl:if test="child::* or string(@*[local-name()='href'])">
			<fo:basic-link text-decoration="underline" color="#47371f">
				<xsl:choose>
					<xsl:when test="string(@*[local-name()='href'])">
						<xsl:attribute name="external-destination">
							<xsl:value-of select="@*[local-name()='href']"/>
						</xsl:attribute>
						<xsl:apply-templates/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>
			</fo:basic-link>
		</xsl:if>
	</xsl:template>

	<!-- convert @href attribute into exernal-destination -->
	<xsl:template match="xsl:attribute[@name='href']">
		<xsl:element name="xsl:attribute">
			<xsl:attribute name="name">external-destination</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<!-- definition list (Collection Overview) -->
	<xsl:template match="dl">
		<fo:table>
			<fo:table-body>
				<xsl:apply-templates/>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<xsl:template match="dt">
		<fo:table-row>
			<fo:table-cell text-align="right" font-weight="bold" width="160px">
				<fo:block margin-right="10px">
					<xsl:apply-templates/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:apply-templates select="parent::node()/dd/*"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- suppress dd, called from dt -->
	<xsl:template match="dd"/>

	<!-- list -->
	<xsl:template match="ul">
		<fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
			<xsl:apply-templates/>
		</fo:list-block>
	</xsl:template>

	<xsl:template match="li">
		<fo:list-item>
			<fo:list-item-label end-indent="label-end()">
				<fo:block/>
			</fo:list-item-label>
			<fo:list-item-body start-indent="body-start()">
				<fo:block>
					<xsl:if test="@class='ca_head'">
						<xsl:attribute name="font-weight">bold</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>

	<!-- in-line, style -->
	<xsl:template match="b">
		<fo:inline font-weight="bold">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="i">
		<fo:inline font-style="italic">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="sub">
		<fo:inline font-size="smaller" vertical-align="sub">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="sup">
		<fo:inline font-size="smaller" vertical-align="super">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="u">
		<fo:inline text-decoration="underline">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<!-- strip font element -->
	<xsl:template match="font">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- handle images -->
	<xsl:template match="img">
		<fo:external-graphic src="{@src}"/>
	</xsl:template>

	<xsl:template match="xsl:element[@name='img']">
		<fo:external-graphic>
			<xsl:apply-templates/>
		</fo:external-graphic>
	</xsl:template>

	<xsl:template match="xsl:attribute[@name='src']">
		<xsl:element name="xsl:attribute">
			<xsl:attribute name="name">src</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
