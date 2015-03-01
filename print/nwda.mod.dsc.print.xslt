<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modications and Revisions by Mark Carlson, 2004

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="lcChars">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="lcCharsHyphen">abcdefghijklmnopqrstuvwxyz-</xsl:variable>
	<xsl:variable name="lcCharsSlash">abcdefghijklmnopqrstuvwxyz/</xsl:variable>
	<xsl:variable name="ucChars">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="repCode" select="translate(//eadid/@mainagencycode,$ucChars,$lcChars)"/>
	<!-- ********************* <DSC> *********************** -->
	<xsl:template name="dsc" match="//dsc">
		<div class="dsc" name="{$dsc_id}" id="{$dsc_id}">
			<h3 class="structhead">
				<xsl:value-of select="$dsc_head"/>
			</h3>
			<xsl:apply-templates select="*[not(self::head)]"/>
		</div>
	</xsl:template>
	<!-- ********************* </DSC> *********************** -->
	<!-- ********************* <SERIES> *************************** -->
	<xsl:template match="c01">
		<div class="c01">
			<xsl:choose>
				<!--inline dates-->
				<xsl:when test="$repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps'">
					<xsl:call-template name="dsc_table_inline_date"/>
				</xsl:when>
				<!--default to columnar dates-->
				<xsl:otherwise>
					<xsl:call-template name="dsc_table_columnar_date"/>
				</xsl:otherwise>
			</xsl:choose>
			<!-- 2005-07-15 carlsonm mod only display link if there are c02s or is last c01 -->
			<xsl:if test="//c02 or position()=last()">
						<hr width="100%" style="height: 1px; color: #000000;" />
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ********************* </SERIES> *************************** -->
	<!-- ********************* <COLUMNAR_DATES> *************************** -->
	<!--columnar dates are the default-->
	<xsl:template name="dsc_table_columnar_date">
		<xsl:variable name="columns">8</xsl:variable>
		<table width="100%" border="0" summary="A listing of materials in {./did/unittitle}.">
			<tbody>
				<!-- 2004-07-15 carlsonm mod insert a single heading for c01 only lists -->
				<!-- This was the test prior to 2004-12-04 
		<xsl:if test="not(//c02) and position()=1">
-->
				<!-- 2004-12-04 taking this whole section out. Now causing problems with columnar finding aids-->
				<!--
		<xsl:if test="descendant::c02">
		<tr>
          <td valign="top">&#160;</td>
-->
				<!-- carlsonm mode 2004-09-26 tracking #4.80 suppress container column heading if no container data -->
				<!--
<xsl:choose>
<xsl:when test="string(descendant::container)">
          <td valign="top" colspan="2" nowrap="nowrap">
            <h5 class="underline">Container(s)</h5>
          </td>
</xsl:when>
<xsl:otherwise>
-->
				<!-- 04-10-05 carlson mod(2), suppress whole container column if no data -->
				<!-- <td valign="top" colspan="2"/> -->
				<!--
</xsl:otherwise>
</xsl:choose>

          <td valign="top">
            <xsl:if test="descendant::unittitle">
              <h5 class="underline">Description1</h5>
            </xsl:if>
          </td>
          <td valign="top">&#160;</td>
			 <xsl:choose>
-->
				<!-- 2004-12-02 carlsonm: This suppresses the date heading if descendant <unitdate> elements are not present.  Because
the current context for this is always <c01>, and the <unitdate> for <c01> is a descendant, it will display a date heading
even if there are not date heading c02+.  This section may need to be put in CONTEXT, instead of statically called. -->
				<!--
			 <xsl:when test="string(descendant::c02) and string(descendant::unitdate)">
          <td width="22%" valign="top">
          <h5 class="underline">Dates</h5>
			 </td>
			 </xsl:when>
			 <xsl:otherwise>
			 <td> </td>
			 </xsl:otherwise>
			 </xsl:choose>
        </tr>		  

		  </xsl:if>
		  
-->
				<!-- temp comment out
<xsl:if test="not(//c02)">
<xsl:call-template name="container_labels_noc02"/> 
</xsl:if>		  
-->
				<!-- end of carlsonm mod -->
				<!-- original MC mod
			 <xsl:if test="//c02">
-->
				<xsl:if test="descendant::c02">
					<tr>
						<!-- original SY code
			 <td valign="top">&#160;</td>
			 -->
						<!-- carlsonm mod only put this in if it's not a c01 only list -->
						<td valign="top" id="1A">&#160;</td>
						<td valign="top" colspan="{$columns - 1}" id="1B">
							<xsl:apply-templates select="did"/>
						</td>
					</tr>
				</xsl:if>
				<!-- 2004-07-15 carlsonm mod only repeat column headings when there are c02s -->
				<!-- test as of 2004-12-04
		  <xsl:if test="//c02">
-->
				<xsl:if test="descendant::c02">
					<xsl:if test="string(scopecontent)">
						<tr>
							<td style="font-size: 6pt;">&#160;</td>
						</tr>
					</xsl:if>
					<tr class="line">
						<td valign="top" id="2A">&#160;</td>
						<!-- carlsonm mode 2004-09-26 tracking #4.80 suppress container column heading if no container data -->
						<xsl:choose>
							<xsl:when test="string(descendant::container)">
								<td valign="top" colspan="2" nowrap="nowrap" id="2B">
									<h5 class="underline">Container(s)</h5>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<!-- suppress whole column if no data 
<td valign="top" colspan="2"/>
-->
							</xsl:otherwise>
						</xsl:choose>
						<td width="60%" valign="top" id="2C">
							<xsl:if test="descendant::unittitle">
								<h5 class="underline">Description</h5>
							</xsl:if>
						</td>
						<td width="1%" valign="top" id="2D"></td>
						<!--
          <td width="22%" valign="top">
          <h5 class="underline">Dates</h5>
				
          </td>
			 -->
						<xsl:choose>
							<!-- 2004-12-02 carlsonm: This suppresses the date heading if descendant <unitdate> elements are not present.  Because
the current context for this is always <c01>, and the <unitdate> for <c01> is a descendant, it will display a date heading
even if there are not date heading c02+.  This section may need to be put in CONTEXT, instead of statically called. -->
							<xsl:when test="string(descendant::c02) and string(descendant::unitdate)">
								<td width="22%" valign="top" id="2E">
									<h5 class="underline">Dates</h5>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td width="22%" valign="top" id="2F"></td>
							</xsl:otherwise>
						</xsl:choose>
					</tr>
				</xsl:if>
				<!--END column headings-->
				<xsl:choose>
					<xsl:when test="descendant::c02">
						<xsl:apply-templates select="c02"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="c01_lowest"/>
					</xsl:otherwise>
				</xsl:choose>
				<!--
        <xsl:choose>
          <xsl:when test="//c02">
-->
				<!-- This is for when a finding aid has c02 + -->
				<!-- <xsl:apply-templates select="c02"/>  -->
				<!--
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="c01_lowest"/>
          </xsl:otherwise>
        </xsl:choose>
-->
			</tbody>
		</table>
	</xsl:template>
	<!-- ********************* </COLUMNAR_DATES> *************************** -->
	<!-- ********************* <INLINE_DATES> *************************** -->
	<!--columnar dates are the default-->
	<xsl:template name="dsc_table_inline_date">
		<xsl:variable name="columns">6</xsl:variable>
		<table border="0" summary="A listing of materials in {./did/unittitle}." width="100%">
			<tbody>
				<!-- carlsonm: don't display a single c01 heading in the normal 
large type if there are no c02+ -->
				<xsl:if test="descendant::c02">
					<tr>
						<td valign="top" id="3A">&#160;</td>
						<td valign="top" colspan="{$columns - 1}" id="3B">
							<xsl:apply-templates select="did"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$dscOrder='bfu'">
					<!--column headings-->
					<!-- SY original code, removing to reduce space. carlsonm 
          <tr class="line">
            <td valign="top">&#160;</td>
          </tr>
			 -->
					<!-- 2004-11-29 This fixes the problem of repeating Container heading for c01 only finding aids such as OSU Archives Yank Collection or Memorabilia Collection.  Do some more checking on this. -->
					<!-- The heading only prints if there are c02's or it's the first c01 -->
					<!-- 2004-12-03 carlsonm: REPORT: There is some type of incompatibility that the following tests produce.  In the UMt Collins Land finding aid, when the test is <xsl:if test="not(//c02) and position()=1">, the display is pretty much as wanted, but when the test is string(//c02) or position()=1, this breaks the above mentioned finding aids from OSU Archives.  This section needs more examination. -->
					<!--		<xsl:if test="not(//c02) or position()=1"> -->
					<!--		<xsl:if test="not(//c02) and position()=1">		-->
					<!-- <xsl:if test="string(//c02) or position()=1"> -->
					<!-- 2004-12-03 carlsonm: I'm adding this line since since has been stripped out after other elements.  This adds a blank line before the container/description header -->
					<!-- 2004-12-07...but if there are no container elements, we don't want this extra
line -->
					<!-- 2004-12-08...and we don't want it if it's a c01 only list either
see: Rufus Coleman finding aid (UMt), so adding //c02
-->
					<xsl:if test="(string(//container) and //c02) or //c02/did/unittitle">
						<tr>
							<td id="4A">&#160;</td>
						</tr>
					</xsl:if>
					<!--===============DECIDE WHETHER TO PRINT A HEADER SECTION AT ALL ==============-->
					<!--=====THIS ONLY PRINTS A HEADING FOR C02 + ===========-->
					<xsl:if test="descendant::c02">
						<tr class="line">
							<!-- 2004-11-30 carlsonm: This mod suppresses the container heading and space it takes up.  See the UMt Great Falls Breweries or Linus Pauling Papers-->
							<!-- <td valign="top" id="4B">&#160;</td> -->
							<!-- Is there any container data at all? -->
							<xsl:if test="string(//container)">
								<td valign="top" id="4B">&#160;</td>
								<!--
moved before test above
            <td valign="top">&#160;</td> -->
								<!-- SY Original code
            <td valign="top" colspan="3">
				-->
								<!-- carlsonm mode 2004-09-26 tracking #4.80 suppress container column heading if no container data -->
								<!-- If there is container data, is there any within this context? -->
								<xsl:choose>
									<xsl:when test="string(descendant::container)">
										<td valign="top" colspan="2" nowrap="nowrap" id="4C">
											<h5 class="underline">Container(s)</h5>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" colspan="2" id="4D"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<!-- This needs to be traced.  If there are no container elements, an extra
column is needed but I'm not sure why at this point -->
							<xsl:if test="not(//container)">
								<td/>
							</xsl:if>
							<td valign="top" id="4E">
								<xsl:if test="descendant::unittitle">
									<h5 class="underline">Description</h5>
								</xsl:if>
							</td>
						</tr>
					</xsl:if>
				</xsl:if>
				<!-- this modified last -->
				<xsl:choose>
					<xsl:when test="descendant::c02">
						<xsl:apply-templates select="c02"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="c01_lowest"/>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<!-- ********************* <INLINE_DATES> *************************** -->
	<!-- ********************* START C0xs *************************** -->
	<xsl:template match="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12">
		<xsl:if test="$dscOrder='bfu'">
			<tr>
				<!-- new section 2004-11-30 -->
				<!-- 2004-12-05 carlsonm: This is another spacing problem that needs to be
traced.  With it in, it breaks the Henry M. Jackson (UW) lineup in the
inventory section.  In that finding aid, there are no containers.
I'll use that test for now.  Another alternative is to use string(//c02)
-->
				<xsl:if test="string(//container)">
					<td width="1%" valign="top" id="AA1">&#160;</td>
				</xsl:if>
				<!-- <td valign="top"> -->
				<!-- 04-10-05 carlsonm mod(2) suppress whole container column if no data at all -->
				<xsl:if test="string(//container)">
					<xsl:choose>
						<xsl:when test="string(did/container)">
							<td width="21%" valign="top" id="AA2">
								<xsl:call-template name="container_labels"/>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td width="21%" valign="top" id="AA3">
								<xsl:text>&#160;</xsl:text>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!--        </td> -->
				<td width="1%" valign="top" id="AA4">
					<!--<xsl:if test="@level">
<xsl:value-of select="@level"/>&#160;<xsl:value-of select="position()"/>:&#160;
				</xsl:if>-->
				</td>
				<!-- original code
        <td width="60%" valign="bottom">
-->
				<td width="60%" valign="bottom" id="AA5">
					<xsl:if test="@id">
						<a>
							<xsl:attribute name="name">
								<xsl:value-of select="@id"/>
							</xsl:attribute>
						</a>
					</xsl:if>
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="generate-id()"/>
						</xsl:attribute>
					</a>
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="name()"/>_
							<xsl:value-of select="position()"/>
						</xsl:attribute>
					</a>
					<div class="{name()}">
						<xsl:apply-templates select="did"/>
					</div>
				</td>
				<xsl:choose>
					<xsl:when test="$repCode!='idu' and $repCode!='ohy' and $repCode!='orcsar' and $repCode!='orcs' and $repCode!='opvt' and $repCode!='mtg' and $repCode!='waps'">
						<td width="1%" valign="top">&#160;</td>
						<td width="22%" valign="bottom" id="AA6">
							<xsl:if test="./did/unitdate">
								<xsl:apply-templates select="did/unitdate"/>
							</xsl:if>
						</td>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</tr>
			<!-- 2004-12-02 carlsonm: CONTEXT DRIVEN ARCHDESC MINOR CHILDREN-->
			<xsl:if test="string(did/origination | did/physdesc | did/physloc | did/note | scopecontent | acqinfo | custodhist | processinfo)">
				<tr>
					<xsl:choose>
						<!-- 2004-12-04 carlsonm: PROBLEM:  There are two conditions: Are there any
container elements at all?  That gets one spacing.
-->
						<!--			<xsl:when test="string(descendant::container)">-->
						<xsl:when test="//container">
							<!-- original test <xsl:if test="string(descendant::container)"> -->
							<td colspan="3" id="AA7">&#160;</td>
							<!--<td colspan="3">&#160;</td> -->
						</xsl:when>
						<xsl:otherwise>
							<!-- Test finding aids:
UMt Paul Hatfield
UMt Rufus Coleman
-->
							<xsl:choose>
								<xsl:when test="self::c02">
									<td id="AA8a">&#160;</td>
								</xsl:when>
								<xsl:otherwise>
									<td colspan="2" id="AA8b">&#160;</td>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<td>
						<div class="{name()}">
							<xsl:for-each select="did">
								<xsl:for-each select="origination | physdesc | physloc | note">
									<xsl:choose>
										<xsl:when test="self::physdesc">
											<xsl:apply-templates select="extent[1]"/>
											<xsl:if test="string(extent[2])">
                              &#160;(
												<xsl:apply-templates select="extent[2]"/>)
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
												<br id="b1"/>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="self::origination and child::*/@role">
&#160;(
										<xsl:value-of select="child::*/@role"/>)
									</xsl:if>
									<!-- 2004-12-07 carlsonm: attempting to reduce space in <dsc>.  This originally had
no test, just a <br/>
-->
									<xsl:if test="not(position()=last())">
										<br id="b2"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
							<xsl:for-each select="acqinfo | accruals | custodhist | processinfo | separatedmaterial | scopecontent">
								<xsl:apply-templates/>
							</xsl:for-each>
						</div>
					</td>
				</tr>
			</xsl:if>
		</xsl:if>
		<xsl:apply-templates select="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12"/>
	</xsl:template>
	<!-- ********************* END C0xs *************************** -->
	<!-- ********************* START CONTAINER LABELS *************************** -->
	<xsl:template name="container_labels">
		<table width="100%" border="0" cellspacing="2" cellpadding="0">
			<!-- 2004-12-03 original table code; attempting to reduce space
	 <table width="100%" border="0" cellspacing="1" cellpadding="1">
	 -->
			<tr>
				<!-- Container column 1 formatting -->
				<!-- Container heading -->
				<!--
<td width="4%" nowrap="true" valign="top" class="componenttext" align="left">
-->
				<td width="7%" nowrap="true" valign="top" class="componenttext" align="left" id="BB1">
					<xsl:choose>
						<!-- 2004-12-06 Test prior to this date was not(../c01).  Inserting this new test to remove repeating
container heading from c01 only lists -->
						<xsl:when test="not(../c01) or not(//c02)">
							<xsl:choose>
								<xsl:when test="string(preceding::did[1]/container[1])">
									<xsl:choose>
										<xsl:when test="did/container[1]/@type=preceding::did[1]/container[1]/@type or did/container[1]/@label=preceding::did[1]/container[1]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column1_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[2]/container[1]) and not(../../c01)">
									<xsl:choose>
										<xsl:when test="did/container[1]/@type=preceding::did[2]/container[1]/@type or did/container[1]/@label=preceding::did[2]/container[1]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column1_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[3]/container[1]) and descendant-or-self::c04">
									<xsl:choose>
										<xsl:when test="did/container[1]/@type=preceding::did[3]/container[1]/@type or did/container[1]/@label=preceding::did[3]/container[1]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column1_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="container_column1_heading"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="container_column1_heading"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- End container heading 1 -->
					<!-- 2004-11-30 Carlson: All container data sections modified to suppress container data only when preceding container value and preceding container attribute type are equal.  See OSU Archives Fisheries and Wildlife Department Records -->
					<!-- Container data 1-->
					<xsl:choose>
						<!-- 2004-12-06 Container data should always display at the c01 level, unless there are no c02+ in the whole
finding aid not(//c02) -->
						<xsl:when test="not(../c01) or not(//c02)">
							<xsl:choose>
								<xsl:when test="string(preceding::did[1]/container[1])">
									<xsl:choose>
										<xsl:when test="did/container[1]=preceding::did[1]/container[1] and did/container[1]/@type=preceding::did[1]/container[1]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[1]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[2]/container[1]) and not(../../c01)">
									<xsl:choose>
										<xsl:when test="did/container[1]=preceding::did[2]/container[1] and did/container[1]/@type=preceding::did[2]/container[1]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[1]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[3]/container[1]) and descendant-or-self::c04">
									<xsl:choose>
										<xsl:when test="did/container[1]=preceding::did[3]/container[1] and did/container[1]/@type=preceding::did[3]/container[1]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[1]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="did/container[1]"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="did/container[1]"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- End container 1 data -->
				<!-- Container heading 2 begin -->
				<td width="7%" nowrap="true" valign="top" class="componenttext" align="left" id="BB2">
					<xsl:choose>
						<xsl:when test="not(../c01) and string(did/container[2]) or not(//c02)">
							<xsl:choose>
								<xsl:when test="string(preceding::did[1]/container[2])">
									<xsl:choose>
										<xsl:when test="did/container[2]/@type=preceding::did[1]/container[2]/@type or did/container[2]/@label=preceding::did[1]/container[2]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column2_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[2]/container[2]) and not(../../c01)">
									<xsl:choose>
										<xsl:when test="did/container[2]/@type=preceding::did[2]/container[2]/@type or did/container[2]/@label=preceding::did[2]/container[2]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column2_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="container_column2_heading"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="container_column2_heading"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- container heading 2 end -->
					<!-- Container 2 data  begin -->
					<xsl:choose>
						<xsl:when test="not(../c01) and string(did/container[2]) or not(//c02)">
							<xsl:choose>
								<xsl:when test="string(preceding::did[1]/container[2])">
									<xsl:choose>
										<xsl:when test="did/container[2]=preceding::did[1]/container[2] and did/container[2]/@type=preceding::did[1]/container[2]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[2]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[2]/container[2]) and not(../../c01)">
									<xsl:choose>
										<xsl:when test="did/container[2]=preceding::did[2]/container[2] and did/container[2]/@type=preceding::did[2]/container[2]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[2]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="did/container[2]"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="did/container[2]"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- new column 3 formatting -->
				<td width="7%" nowrap="true" valign="top" class="componenttext" align="left" id="BB3">
					<xsl:choose>
						<xsl:when test="not(../c01) and string(did/container[3]) or not(//c02)">
							<xsl:choose>
								<xsl:when test="string(preceding::did[1]/container[3])">
									<xsl:choose>
										<xsl:when test="did/container[3]/@type=preceding::did[1]/container[3]/@type or did/container[3]/@label=preceding::did[1]/container[3]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column3_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[2]/container[3]) and not(../../c01)">
									<xsl:choose>
										<xsl:when test="did/container[3]/@type=preceding::did[2]/container[3]/@type or did/container[3]/@label=preceding::did[2]/container[3]/@label"></xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="container_column3_heading"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="container_column3_heading"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="container_column3_heading"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- Container 3 data -->
					<xsl:choose>
						<xsl:when test="not(../c01) and string(did/container[3]) or not(//c02)">
							<xsl:choose>
								<xsl:when test="string(preceding::did[1]/container[3])">
									<xsl:choose>
										<xsl:when test="did/container[3]=preceding::did[1]/container[3] and did/container[3]/@type=preceding::did[1]/container[3]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[3]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="string(preceding::did[2]/container[3]) and not(../../c01)">
									<xsl:choose>
										<xsl:when test="did/container[3]=preceding::did[2]/container[3] and did/container[3]/@type=preceding::did[2]/container[3]/@type"></xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="did/container[3]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="did/container[3]"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="did/container[3]"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- end of new column 3 formatting -->
			</tr>
		</table>
	</xsl:template>
	<!-- new container heading templates carlsonm 04-10-05 -->
	<xsl:template name="container_column1_heading">
		<span class="containerLabel">
			<xsl:choose>
				<xsl:when test="did/container[1]/@type">
					<xsl:choose>
						<xsl:when test="did/container[1]/@type='audiocassette-side'">
                  Cassette/Side
						</xsl:when>
						<xsl:when test="did/container[1]/@type='audiocassette'">
                  Cassette
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="translate(did/container[1]/@type, $lcCharsHyphen, $lcCharsSlash)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="did/container[1]/@label">
					<xsl:value-of select="did/container[1]/@label"/>
				</xsl:when>
			</xsl:choose>
		</span>
		<br id="b3"/>
	</xsl:template>
	<xsl:template name="container_column2_heading">
		<span class="containerLabel">
			<xsl:choose>
				<xsl:when test="did/container[2]/@type">
					<xsl:value-of select="translate(did/container[2]/@type, $lcCharsHyphen, $lcCharsSlash)"/>
				</xsl:when>
				<xsl:when test="did/container[2]/@label">
					<xsl:value-of select="did/container[2]/@label"/>
				</xsl:when>
			</xsl:choose>
		</span>
		<br id="b4"/>
	</xsl:template>
	<xsl:template name="container_column3_heading">
		<span class="containerLabel">
			<xsl:choose>
				<xsl:when test="did/container[3]/@type">
					<xsl:value-of select="translate(did/container[3]/@type, $lcCharsHyphen, $lcCharsSlash)"/>
				</xsl:when>
				<xsl:when test="did/container[3]/@label">
					<xsl:value-of select="did/container[3]/@label"/>
				</xsl:when>
			</xsl:choose>
		</span>
		<br id="b5"/>
	</xsl:template>
	<!-- 2004-07-15 carlsonm addition to process c01 lists differently -->
	<xsl:template name="container_labels_noc02">
		<tr>
			<td nowrap="true" valign="top" class="componenttext" align="left">
				<span class="containerLabel">
					<xsl:choose>
						<xsl:when test="did/container[1]/@type">
							<xsl:value-of select="did/container[1]/@type"/>
						</xsl:when>
						<xsl:when test="did/container[1]/@label">
							<xsl:value-of select="did/container[1]/@label"/>
						</xsl:when>
					</xsl:choose>
				</span>
				<br id="b6"/>
				<xsl:value-of select="did/container[1]"/>
				<xsl:text> </xsl:text>
			</td>
			<td nowrap="true" valign="top" class="componenttext" align="left">
				<span class="containerLabel">
					<xsl:choose>
						<xsl:when test="did/container[2]/@type">
							<xsl:value-of select="did/container[2]/@type"/>
						</xsl:when>
						<xsl:when test="did/container[2]/@label">
							<xsl:value-of select="did/container[2]/@label"/>
						</xsl:when>
					</xsl:choose>
				</span>
				<br id="b7"/>
				<xsl:value-of select="did/container[2]"/>
				<xsl:text> </xsl:text>
			</td>
			<td nowrap="true" valign="top" class="componenttext" align="left">
				<span class="containerLabel">
					<xsl:choose>
						<xsl:when test="did/container[3]/@type">
							<xsl:value-of select="did/container[3]/@type"/>
						</xsl:when>
						<xsl:when test="did/container[3]/@label">
							<xsl:value-of select="did/container[3]/@label"/>
						</xsl:when>
					</xsl:choose>
				</span>
				<br id="b8"/>
				<xsl:value-of select="did/container[3]"/>
				<xsl:text> </xsl:text>
			</td>
		</tr>
	</xsl:template>
	<!-- end of carlsonm addition -->
	<!-- ********************* END CONTAINER LABELS *************************** -->
	<xsl:template match="c01//did">
		<!-- c01 only -->
		<xsl:choose>
			<!-- original SY code
      <xsl:when test="parent::c01 or parent::*[@level='subseries']">
		-->
			<xsl:when test="parent::c01 and //c02">
				<xsl:if test="count(parent::c01/preceding-sibling::c01)!='0'">
					<br id="b9"/>
				</xsl:if>
				<h3 class="structhead">
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
										<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'">
Cassette Counter&#160;
										</xsl:if>
									</span></xsl:if>
								<xsl:if test="$repCode='wau-ar' and unitid[@type='accession']">
Accession No.&#160;
								</xsl:if>
								<xsl:value-of select="unitid"/>:
								<xsl:text>&#160;</xsl:text>
							</xsl:if>
							<xsl:apply-templates select="unittitle"/>
							<xsl:if test="string(unitdate) and string(unittitle)">,&#160;</xsl:if>
							<xsl:if test="string(unitdate)">
								<xsl:for-each select="unitdate">
									<xsl:choose>
										<xsl:when test="not(@type='bulk')">
											<xsl:apply-templates/>
											<xsl:if test="not(position()=last())">,&#160;</xsl:if>
										</xsl:when>
										<xsl:when test="@type='bulk'">
&#160;(bulk 
											<xsl:apply-templates/>)
										</xsl:when>
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
									<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'">
Cassette Counter&#160;
									</xsl:if>
								</span></xsl:if>
							<xsl:if test="$repCode='wau-ar' and unitid[@type='accession']">
								<!--  and ../c01[@otherlevel='accession'] -->
Accession No.&#160;

							</xsl:if>
							<xsl:value-of select="unitid"/>
						</xsl:when>
						<xsl:when test="./unitdate/text() and not(./unittitle)">
							<xsl:value-of select="./unitdate"/>
						</xsl:when>
						<xsl:otherwise>Subordinate Component # 
							<xsl:value-of select="count(parent::c01/preceding-sibling::c01)+1"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END what if no unitititle-->
				</h3>
			</xsl:when>
			<xsl:when test="$repCode='idu' or $repCode='ohy' or $repCode='orcsar' or $repCode='orcs' or $repCode='opvt' or $repCode='mtg' or $repCode='waps'">
				<!-- 2004-09-26 carlsonm mod to add display for <unitid> -->
				<!-- Tracking # 4.10 Collins Land Company display -->
				<xsl:if test="string(unitid)">
					<xsl:if test="unitid/@label">
						<span class="containerLabel">
							<xsl:value-of select="unitid/@label"/>
							<xsl:text>&#160;</xsl:text>
						</span>
					</xsl:if>
					<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'">
Cassette Counter&#160;
					</xsl:if>
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
							<xsl:when test="@type='bulk'">
&#160;(bulk 
								<xsl:apply-templates/>)
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
			</xsl:when>
			<!-- carlsonm This is where the unittitle info is output when it is a c01 list only -->
			<xsl:otherwise>
				<xsl:if test="unittitle/@label">
					<xsl:value-of select="unittitle/@label"/>&#160;
				</xsl:if>
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
Cassette Counter&#160;
							</xsl:if>
							<xsl:value-of select="unitid"/>:
							<xsl:text> &#160;</xsl:text>
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
Cassette Counter&#160;
						</xsl:if>
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
		<xsl:if test="string(acqinfo | accruals | custodhist | processinfo | separatedmaterial | physdesc | physloc | origination | note | following-sibling::odd | following-sibling::scopecontent | following-sibling::arrangement) and parent::c01">
			<div class="c_odd">
				<xsl:for-each select="acqinfo | accruals | custodhist | processinfo | separatedmaterial | physdesc | physloc | origination | note | following-sibling::odd | following-sibling::scopecontent | following-sibling::arrangement">
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
			</div>
		</xsl:if>
	</xsl:template>
	<xsl:template name="c01_lowest">
		<!-- 2004-12-04 carlsonm: Adding a section to print container heading at this level -->
		<xsl:if test="position()=1">
			<tr class="line">
				<!-- 2004-11-30 carlsonm: This mod suppresses the container heading and space it takes up.  See the UMt Great Falls Breweries or Linus Pauling Papers-->
				<xsl:if test="string(//container)">
					<td valign="top" id="XX1">&#160;</td>
					<!-- SY Original code
            <td valign="top" colspan="3">
				-->
					<!-- carlsonm mode 2004-09-26 tracking #4.80 suppress container column heading if no container data -->
					<xsl:choose>
						<!-- original string
<xsl:when test="string(//container)">
-->
						<xsl:when test="string(descendant::container)">
							<td valign="top" colspan="2" nowrap="nowrap" id="XX2">
								<h5 class="underline">Container(s)</h5>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td valign="top" colspan="2" id="XX3"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<td valign="top" id="XX4">
					<xsl:if test="descendant::unittitle">
						<h5 class="underline">Description</h5>
					</xsl:if>
				</td>
			</tr>
		</xsl:if>
		<!-- </xsl:if> -->
		<!-- 2004-12-04 end added section -->
		<tr>
			<!-- 2004-11-30 carlsonm: This mod suppresses the space that the container section takes up.  See Great Falls Breweries finding aid, UMt or Linus Pauling Papers, OSU SC-->
			<xsl:if test="string(//container)">
				<td width="1%" valign="top" id="XX5">&#160;</td>
				<!-- SY Original <td valign="top"> -->
				<xsl:choose>
					<!-- old <xsl:when test="did/container"> -->
					<xsl:when test="string(did/container)">
						<!-- carlsonm mod 04-10-05 change from 21% to 10% for alignment -->
						<td width="11%" valign="top" id="XX6">
							<xsl:call-template name="container_labels"/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td width="11%" valign="top" id="XX7">
							<xsl:text>&#160;</xsl:text>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<!-- SY original </td> -->
				<td width="1%" valign="top" id="XX8">
					<!--<xsl:if test="@level">
<xsl:value-of select="@level"/>&#160;<xsl:value-of select="position()"/>:&#160;
				</xsl:if>-->
				</td>
				<!-- original code
        <td width="60%" valign="bottom">
-->
			</xsl:if>
			<td width="60%" valign="bottom" id="XX9">
				<xsl:if test="@id">
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="@id"/>
						</xsl:attribute>
					</a>
				</xsl:if>
				<a>
					<xsl:attribute name="name">
						<xsl:value-of select="generate-id()"/>
					</xsl:attribute>
				</a>
				<a>
					<xsl:attribute name="name">
						<xsl:value-of select="name()"/>_
						<xsl:value-of select="position()"/>
					</xsl:attribute>
				</a>
				<div class="{name()}">
					<!-- 2004-12-07
<p> -->
					<xsl:apply-templates select="did"/>
					<!-- </p> -->
				</div>
			</td>
			<xsl:choose>
				<xsl:when test="$repCode!='idu' and $repCode!='ohy' and $repCode!='orcsar' and $repCode!='opvt' and $repCode!='mtg' and $repCode!='waps'">
					<td width="1%" valign="top" id="YY1">&#160;</td>
					<td width="22%" valign="bottom" id="YY2">
						<!-- carlsonm: what was the subseries level restriction for?
              <xsl:if test="./did/unitdate and ./did/unittitle and @level!='subseries'">
-->
						<!-- 04-10-07 carlsonm, this is creating a problem when c01 is lowest, dates printing twice
              <xsl:if test="./did/unitdate">
				  -->
						<xsl:if test="./did/unitdate and string(descendant::c02)">
							<!-- original SY code
                <p class="box">
-->
							<xsl:apply-templates select="did/unitdate"/>
							<!--
                </p>
-->
						</xsl:if>
					</td>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</tr>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
</metaInformation>
-->