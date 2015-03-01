<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modications and Revisions by Mark Carlson, 2004

and by Ethan Gruber, July/August 2007

Most of this stylesheet was rewritten in July/August 2007 to fix display issues, but more importantly, to 
reduce the post-transformation filesize to be comparable to the size of the XML file.

Changes:

03/01/13    KEF     The "c01//did" template was counting <head /> and <p /> elements as
                    siblings when generating the "ppos" variable, leading to "off-by-one" errors
                    for "Detailed descripton" sidelinks to internal anchors.  I fixed this
                    as noted at the point of change.

01/27/14    KEF     The <extref/> element was being turned into a URL for elements with
                    a path of /ead/archdesc/dsc/c01/c02/did/unitid/extref.  Used a
                    "apply-templates" rather than "value-of" to resolve this.  (Migrated
                    from Utah pilot site XSLT with original note date of 08/18/11.)

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Set this variable to the server/folder path that points to the icon image file on your server.  
		This should end with a forward /, e.g. http://myserver.com/images/ -->
    <xsl:variable name="pathToIcon">http://nwda-db.orbiscascade.org/xsl/support/</xsl:variable>
	<!-- Set this variable to the filename of the icon image, e.g. icon.jpg -->
	<xsl:variable name="iconFilename">camicon.gif</xsl:variable>

	<xsl:variable name="lcChars">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="lcCharsHyphen">abcdefghijklmnopqrstuvwxyz-</xsl:variable>
	<xsl:variable name="lcCharsSlash">abcdefghijklmnopqrstuvwxyz/</xsl:variable>
	<xsl:variable name="ucChars">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="repCode" select="translate(//eadid/@mainagencycode,$ucChars,$lcChars)"/>


	<!-- ********************* <DSC> *********************** -->
	<xsl:template name="dsc" match="dsc">
		<xsl:if test ="@id">
			<a id="{@id}"></a>
		</xsl:if>
		<a id="{$dsc_id}"></a>
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
		<div class="dsc" id="h_dsc">
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
		<xsl:if test ="@id">
			<a id="{@id}"></a>
		</xsl:if>
		<xsl:for-each select=" *[@id] | did/*[@id]">
			<a id="{@id}"></a>
		</xsl:for-each>
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
								<td class="c0x_container_small c0x_container_left">
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
				<xsl:otherwise>
					<xsl:text>c0x_container_large</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable select="count(../../preceding-sibling::*)+1" name="pppos"/>
		<xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/>
		<xsl:variable select="count(preceding-sibling::*)+1" name="cpos"/>			
		<div id="id{$pppos}_{name(..)}_{$ppos}_{name()}_{$cpos}">
			<xsl:apply-templates select="did"/>
		</div>

		<table border="0" summary="A listing of materials in {./did/unittitle}." width="100%">
			<!-- calls the labels for the table -->
			<xsl:call-template name="table_label"/>

			<xsl:if test="@level='item' or @level='file'">
				<tr>
					<td class="c0x_container_small c0x_container_left">
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
					<td class="c0x_container_small c0x_container_left">
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
		<xsl:if test ="@id">
			<a id="{@id}"></a>
		</xsl:if>
		
		<xsl:variable name="c0x_container">
			<xsl:choose>
				<xsl:when test="did/container[2]">
					<xsl:text>c0x_container_small</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>c0x_container_large</xsl:text>
				</xsl:otherwise>
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
					<td class="{$c0x_container} c0x_container_left">
						<xsl:value-of select="did/container[1]"/>
					</td>
					<td class="{$c0x_container}">
						<xsl:value-of select="did/container[2]"/>
					</td>
				</xsl:when>
			</xsl:choose>

			<!-- this id is used for indentation; replaces nested tables -->
			<!-- TOO BAD name() WORKS BETTER AND IDs MUST BE UNIQUE!. Excellent example of NIH.  - Enrico 10-18-07  -->
			<!-- <xsl:variable name="c0x_content_indent">
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
			</xsl:variable> -->

			<xsl:variable select="count(../../preceding-sibling::*)+1" name="pppos"/>
			<xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/>
			<xsl:variable select="count(preceding-sibling::*)+1" name="cpos"/>			
			<td class="c0x_content {name()}" id="id{$pppos}_{name(..)}_{$ppos}_{name()}_{$cpos}">
				<xsl:for-each select=" *[@id] | did/*[@id]">
					<a id="{@id}"></a>
				</xsl:for-each>
				<xsl:if test="did/unittitle">
					<xsl:choose>
						<!-- series, subseries, etc are bold -->
						<xsl:when
							test="(@level='series' or @level='subseries' or @otherlevel='sub-subseries' or @level='otherlevel') and child::node()/did">
							<b>
								<xsl:if test="string(did/unitid)">
                                    <!--
                                         When this was a "value-of", <extref/> elements were
                                         not being turned into URL's.  "apply-templates" makes this
                                         happen, as well as just outputting the value of the <unitid/>
                                         element if it's just text.
                                    -->
                                    <!-- <xsl:value-of select="did/unitid"/> -->
								    <xsl:apply-templates select="did/unitid"/>
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
				<xsl:otherwise>
					<xsl:text>c0x_container_large</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- variables are created to grab container type data.
		this logic basically only creates the row and its table cells if there is firstor second container
		data returned from the template call.  this logic cuts back on processing time for the server
		and download time for the user - Ethan Gruber 7/29/07 -->

		<xsl:variable name="first_container">
			<xsl:call-template name="container_type1"/>
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
					<!-- for two containers -->
					<xsl:when test="did/container[2]">
						<td class="{$c0x_container} c0x_container_left">
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
					
					<!-- for one container -->
					<xsl:otherwise>
						<xsl:variable name="container_colspan">
							<xsl:choose>
								<xsl:when test="/ead/dsc[@type='in-depth'] | /ead/archdesc/dsc[@type='in-depth']">
									<xsl:choose>
										<xsl:when
											test="ancestor-or-self::dsc/descendant-or-self::container[2]"
											>2</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when
											test="ancestor-or-self::c01/descendant-or-self::container[2]"
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
					</xsl:otherwise>
				</xsl:choose>
			</tr>
		</xsl:if>
	</xsl:template>

	<!-- ******************** DISPLAYS TYPE OF CONTAINER ****************** -->

	<xsl:template name="container_type1">

		<xsl:variable name="current_val">
			<xsl:value-of select="did/container/@type"/>
		</xsl:variable>
		
		<xsl:variable name="last_val">
			<xsl:if test="$current_val"> 
				<xsl:value-of
					select="preceding-sibling::node()/did/container/@type"
				/>
			</xsl:if>
		</xsl:variable>
		
		<!-- if the last value is not equal to the first value, then the regularize_container template is called.  -->
		
		<xsl:if test="$last_val != $current_val">
			<xsl:call-template name="regularize_container">
				<xsl:with-param name="current_val">
					<xsl:value-of select="$current_val"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="container_type">
		<xsl:param name="container_number"/>
	
		<xsl:variable name="current_val">
			<xsl:value-of select="did/container[$container_number]/@type"/>
		</xsl:variable>
		
		<xsl:variable name="last_val">
			<xsl:if test="$current_val"> 
					<xsl:value-of
						select="preceding-sibling::node()/did/container[$container_number]/@type"
					/>
			</xsl:if>
		</xsl:variable>
		
		<!-- if the last value is not equal to the first value, then the regularize_container template is called.  -->
		
		<xsl:if test="$last_val != $current_val">
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
                <!-- 
                     KEF:  Line below was introducing "off-by-one" problems.  Replaced it
                     with explicit check for c01 siblings. 
                -->
                <!-- <xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/> -->
                <xsl:variable select="count(../preceding-sibling::c01)+1" name="ppos"/>
					<div class="c01_did_head" id="c01_{$ppos}">
					<!--<a id="c01_{count(parent::c01/preceding-sibling::c01)+1}"></a>-->
					<xsl:if test="@id">
						<a id="{@id}"></a>
					</xsl:if>
					<a id="{generate-id()}"></a>
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
										<xsl:when test="@type='bulk'"> &#160;(bulk
											<xsl:apply-templates/>) </xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates/>
											<xsl:if test="not(position()=last())"
											>,&#160;</xsl:if>
										</xsl:otherwise>
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
							<xsl:when test="@type='bulk'">
								&#160;(bulk <xsl:apply-templates/>)
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates/>
								<xsl:if test="not(position()=last())">,&#160;</xsl:if>
							</xsl:otherwise>
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

</xsl:stylesheet>
