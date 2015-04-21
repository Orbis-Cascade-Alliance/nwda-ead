<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/ewg118/nwda-editor#"
	xmlns:arch="http://purl.org/archival/vocab/arch#" exclude-result-prefixes="arch nwda xsd vcard"
	version="1.0">

	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>

	<xsl:template match="@*|*|processing-instruction()|comment()">
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

	<!-- suppress highlighting template -->
	<xsl:template match="xsl:template[@name='highlight']"/>

	<!-- overwrite HTML page construction with XSL:FO construction -->
	<xsl:template match="xsl:template[@name='html_base']">
		<xsl:element name="xsl:template">
			<xsl:attribute name="name">html_base</xsl:attribute>
			<fo:root font-size="12px" color="#6b6b6b"
				font-family="georgia, 'times new roman', times, serif">
				<!--  -->
				<fo:layout-master-set>
					<fo:simple-page-master margin-right="1in" margin-left="1in" margin-bottom="1in"
						margin-top="1in" page-width="8in" page-height="11in" master-name="content">
						<fo:region-body region-name="body" margin-bottom=".5in"/>
						<fo:region-after region-name="footer" extent=".5in"/>
					</fo:simple-page-master>
				</fo:layout-master-set>
				<fo:page-sequence master-reference="content">
					<fo:title>
						<xsl:element name="xsl:value-of"
							namespace="http://www.w3.org/1999/XSL/Transform">
							<xsl:attribute name="select">$titleproper</xsl:attribute>
						</xsl:element>
					</fo:title>
					<fo:static-content flow-name="footer">
						<fo:block>
							<xsl:element name="xsl:value-of"
								namespace="http://www.w3.org/1999/XSL/Transform">
								<xsl:attribute name="select">
									<xsl:text>concat($serverURL, '/ark:/', $identifier)</xsl:text>
								</xsl:attribute>
							</xsl:element>
						</fo:block>
					</fo:static-content>
					<fo:flow flow-name="body">
						<fo:block font-size="36px" color="#676D38">
							<xsl:element name="xsl:value-of"
								namespace="http://www.w3.org/1999/XSL/Transform">
								<xsl:attribute name="select"
									>normalize-space(archdesc/did/unittitle)</xsl:attribute>
							</xsl:element>
							<xsl:element name="xsl:if"
								namespace="http://www.w3.org/1999/XSL/Transform">
								<xsl:attribute name="test">archdesc/did/unitdate</xsl:attribute>
								<xsl:element name="xsl:text"
									namespace="http://www.w3.org/1999/XSL/Transform">, </xsl:element>
								<xsl:element name="xsl:value-of"
									namespace="http://www.w3.org/1999/XSL/Transform">
									<xsl:attribute name="select"
										>archdesc/did/unitdate</xsl:attribute>
								</xsl:element>
							</xsl:element>
						</fo:block>
						<fo:block>
							<xsl:element name="xsl:apply-templates">
								<xsl:attribute name="select">archdesc</xsl:attribute>
							</xsl:element>
						</fo:block>
					</fo:flow>
				</fo:page-sequence>
			</fo:root>
		</xsl:element>
	</xsl:template>

	<!-- restructure archdesc template to eliminate TOC -->
	<xsl:template match="xsl:template[@match='archdesc']">
		<xsl:element name="xsl:template">
			<xsl:attribute name="match">archdesc</xsl:attribute>

			<xsl:element name="xsl:call-template">
				<xsl:attribute name="name">collection_overview</xsl:attribute>
			</xsl:element>

			<fo:block border-top-style="solid"/>

			<xsl:element name="xsl:apply-templates">
				<xsl:attribute name="select">bioghist | scopecontent | odd</xsl:attribute>
			</xsl:element>

			<xsl:element name="xsl:call-template">
				<xsl:attribute name="name">useinfo</xsl:attribute>
			</xsl:element>
			<xsl:element name="xsl:call-template">
				<xsl:attribute name="name">administrative_info</xsl:attribute>
			</xsl:element>

			<fo:block border-top-style="solid"/>

			<xsl:element name="xsl:apply-templates">
				<xsl:attribute name="select">dsc</xsl:attribute>
			</xsl:element>
			<xsl:element name="xsl:apply-templates">
				<xsl:attribute name="select">controlaccess</xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- suppress dynamic class as an attribute -->
	<xsl:template match="xsl:attribute[@name='class']"/>

	<!-- ************************ TRANSFORMING HTML ELEMENTS INTO FO ************************** -->

	<!-- suppress the following conditions -->
	<xsl:template match="small"/>
	<xsl:template match="span[string-length(normalize-space(.)) = 0 and not(child::*)]"/>

	<!-- headings -->
	<xsl:template match="h3">
		<fo:block font-size="24px" color="#676D38" margin-bottom="10px" margin-top="20px">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="h4">
		<fo:block font-size="18px" color="#6b6b6b" margin-bottom="10px" margin-top="10px">
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
		<fo:block margin-bottom="10px">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="span[string-length(normalize-space(.)) &gt; 0 or child::*]">
		<fo:inline>
			<!-- handle styling -->
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
			<xsl:value-of select="."/>
		</fo:inline>
	</xsl:template>

	<!-- tables -->
	<xsl:template match="table">
		<fo:table width="100%" table-layout="fixed">	
			<xsl:choose>
				<xsl:when test="descendant::td[@class='c0x_container_large']">
					<fo:table-column column-width="20%"/>
					<fo:table-column column-width="70%"/>
					<fo:table-column column-width="10%"/>
				</xsl:when>
				<xsl:when test="descendant::td[@class='c0x_container_small']">
					<fo:table-column column-width="10%"/>
					<fo:table-column column-width="10%"/>
					<fo:table-column column-width="70%"/>
					<fo:table-column column-width="10%"/>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates/>
		</fo:table>
	</xsl:template>

	<xsl:template match="thead">
		<fo:table-header >
			<xsl:apply-templates/>
		</fo:table-header>
	</xsl:template>

	<xsl:template match="tbody">
		<fo:table-body >
			<xsl:apply-templates/>
		</fo:table-body>
	</xsl:template>

	<xsl:template match="tr">
		<fo:table-row width="100%">
			<xsl:apply-templates/>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="td">
		<fo:table-cell border-bottom-color="#ddd" border-bottom-width="1px"
			border-bottom-style="solid">
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

	<xsl:template match="th">
		<fo:table-cell border-bottom-color="#ddd" border-bottom-width="2px"
			border-bottom-style="solid">
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
		<xsl:if test="not(@id) and not(@name)">
			<xsl:choose>
				<xsl:when test="contains(@href, 'http://')">
					<fo:basic-link>
						<xsl:attribute name="external-destination">
							<xsl:value-of select="@href"/>
						</xsl:attribute>
						<xsl:apply-templates/>
					</fo:basic-link>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
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
			<fo:table-cell text-align="right" font-weight="bold" width="160px" padding-after="10px">
				<fo:block>
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


	<!-- temporarily suppress images -->
	<xsl:template match="img|xsl:element[@name='img']">
		<fo:external-graphic src="{@src}"/>
	</xsl:template>

</xsl:stylesheet>
