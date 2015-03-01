<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <!--links-->
  <xsl:template match="ref">
    <a class="xref">
      <xsl:attribute name="href">#<xsl:value-of select="@target"/></xsl:attribute>
      <xsl:value-of select="parent::p/text()"/>
      <xsl:value-of select="."/>
    </a>
    <xsl:if test="following-sibling::ref">
      <br/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="extref">
    <a class="extptr">
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  <!-- original SY code
  <xsl:template match="daogrp[@*]">
    <div class="daogrp">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  -->

  <xsl:template match="daogrp">
    <div class="daogrp">
      <xsl:apply-templates/>
    </div>
  </xsl:template>  
  
  
  <xsl:template match="dao">
    <a target="new">
      <xsl:attribute name="href"><xsl:value-of select="@href"/>.<xsl:value-of select="@content-role"/></xsl:attribute>
      <xsl:value-of select="daodesc"/>
            <img src="{$pathToFiles}camicon.gif" alt="digital content available" width="17" height="14" border="0" />
    </a>
  </xsl:template>
<!-- original SY code   
    <xsl:template match="daoloc">
		&lt;daoloc&gt;
    <a target="new"> 
      <xsl:attribute name="href"><xsl:value-of select="@href"/>.<xsl:value-of select="@content-role"/></xsl:attribute>
            &#160;<img src="{$pathToFiles}camicon.gif" alt="digital content available" width="17" height="14" border="0"/>
    </a>
		&lt;daoloc&gt;
  </xsl:template>
-->
<!-- 2004-07-14 carlson mod to fix daoloc display -->
 <xsl:template match="daoloc">
    <a target="new"> 
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
            &#160;image<img src="{$pathToFiles}camicon.gif" alt="digital content available" width="17" height="14" border="0"/>
    </a>
  </xsl:template>
  
  
  <!--expan/abbr-->
  <xsl:template match="abbr">
    <xsl:choose>
      <xsl:when test="$expandAbbr='true'">
        <xsl:value-of select="./@expan"/>&#160;(<xsl:value-of select="."/>)</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="expan">
    <xsl:choose>
      <xsl:when test="$expandAbbr='true'">
        <xsl:value-of select="."/>&#160;(<xsl:value-of select="./@abbr"/>)</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--lists-->
  <!-- Oringal SY code
  <xsl:template match="item | chronitem | entry | indexentry | bibref">
    <li class="{name()}">
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  -->
  <xsl:template match="item | indexentry | bibref">
    <li class="{name()}">
      <xsl:apply-templates/>
    </li>
  </xsl:template>  
  
  <!-- 2004-07-14 carlsonm mod to treat <chronitem> separately -->
  <xsl:template match="chronitem">
  <dt class="{name()}"><xsl:apply-templates select="date"/></dt>
  <dd class="{name()}"><xsl:apply-templates select="event"/></dd>
  </xsl:template>
  
    <xsl:template match="defitem">
    <li class="{name()}">
      <xsl:if test="./label"><b><xsl:value-of select="label" /></b>: </xsl:if><xsl:value-of select="item" />
    </li>
  </xsl:template>
  
  <!-- Original SY template rule 
  <xsl:template match="list | chronlist | index | fileplan | bibliography">
    <span class="tableHead">
      <xsl:apply-templates select="head"/>
    </span>
    <ul>
      <xsl:apply-templates select="./*[not(self::head)]"/>
    </ul>
  </xsl:template>
  
  -->
  
  <!-- 2004-07-14 carlsonm mod to treat chronlist differently -->
  <xsl:template match="chronlist">
<span class="tableHead">
      <xsl:apply-templates select="head"/>
    </span>  
  <dl class="{name()}">
<xsl:apply-templates select="./*[not(self::head)]"/>
	</dl>
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
    <xsl:apply-templates select="./item"/>&#160;(<xsl:apply-templates select="./date"/>)</xsl:template>
  <xsl:template match="*[@altrender='nodisplay']"/>
  <xsl:template match="*[@role][not(parent::origination)]">
    <xsl:value-of select="."/>&#160;(<xsl:value-of select="./@role"/>)&#160;</xsl:template>
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
    <xsl:if test="@type and not(ancestor::c01)">&#160;<xsl:text></xsl:text>(<xsl:value-of select="@type"/>)</xsl:if>

  </xsl:template>
  <xsl:template match="p">
<!-- 2004-09-27 carlsonm adding test to remove excess space if <p> is in <dsc> 
Tracking # 4.20
-->

<xsl:choose>
<xsl:when test="not(ancestor::dsc)">
    <p class="para">
      <xsl:apply-templates/>
    </p>
</xsl:when>
<xsl:otherwise>
<div style="padding-left: 20px;">
<xsl:apply-templates/>
</div>
<xsl:if test="not(position()=last())">
<br/><br/>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
  </xsl:template>
  
  

	
			<xsl:template match="controlaccess[@type='lower']" >
		
		<xsl:value-of select="name()" />
      <xsl:apply-templates>
						<xsl:sort order="ascending" data-type="text"/>
					</xsl:apply-templates><br />

		<!--

						<xsl:apply-templates>
						ddd<xsl:sort order="ascending" data-type="text"/>ddd
					</xsl:apply-templates><br />	-->
					
					
	</xsl:template>
  
  
  
  <xsl:template match="address">
    <address class="address">
      <xsl:for-each select="addressline">
        <xsl:value-of select="normalize-space(.)"/>
        <br/>
      </xsl:for-each>
    </address>
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
      <xsl:when test="@render='quoted'">&quot;
				<xsl:apply-templates/>&quot;</xsl:when>
      <xsl:when test="@render='doublequote'">&quot;
				<xsl:apply-templates/>&quot;</xsl:when>
      <xsl:when test="@render='bolddoublequote'">
        <b>&quot;<xsl:apply-templates/>&quot;</b>
      </xsl:when>
      <xsl:when test="@render='nonproport'">
        <font style="font-family: 'Courier New', Cumberland ">
          <xsl:apply-templates/>
        </font>
      </xsl:when>
      <xsl:when test="@render='singlequote'">&apos;
				<xsl:apply-templates/>&apos;</xsl:when>
      <xsl:when test="@render='boldsinglequote'">
        <b>&quot;<xsl:apply-templates/>&apos;</b>
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
