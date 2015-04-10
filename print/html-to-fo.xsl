<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/ewg118/nwda-editor#"
    xmlns:arch="http://purl.org/archival/vocab/arch#" version="1.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>

    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="xsl:output">
        <xsl:element name="xsl:output">
            <xsl:attribute name="method">xml</xsl:attribute>
            <xsl:attribute name="encoding">UTF-8</xsl:attribute>
            <xsl:attribute name="indent">yes</xsl:attribute>
        </xsl:element>
    </xsl:template>

    <!-- suppress TOC -->
    <xsl:template match="xsl:include[@href='nwda.mod.toc.xsl']"/>

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
            <fo:root font-size="14px" color="#6b6b6b"
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

</xsl:stylesheet>
