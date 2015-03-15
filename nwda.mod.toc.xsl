<?xml version="1.0" encoding="UTF-8"?>

<!-- This stylesheet is for generating the table of contents sidebar	
	Edited September 2007 by Ethan Gruber, 
	Rewritten into HTML5/Bootstrap in 2015 by Ethan Gruber -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- ********************* <TABLE OF CONTENTS> *********************** -->
	<!-- TOC TEMPLATE - creates Table of Contents -->
	<xsl:template name="toc">
		<h3 id="toc">Table of Contents</h3>
		<ul class="list-unstyled">
			<xsl:if test="did">
				<li>
					<a href="#overview" id="showoverview">
						<xsl:value-of select="$overview_head"/>
					</a>
				</li>
			</xsl:if>
			<xsl:if test="string(bioghist)">
				<li>
					<xsl:for-each select="bioghist">
						<xsl:choose>
							<xsl:when test="./head/text()='Biographical Note'">
								<a href="#{$bioghist_id}" class="showbioghist">
									<xsl:value-of select="$bioghist_head"/>
								</a>
							</xsl:when>
							<!--SY original code	<xsl:when test="starts-with(@encodinganalog, '545')"> -->
							<!--carlsonm mod 2004-07-09 only use bio head when encodinganalog is 5450 as opposed to 5451 -->
							<xsl:when test="starts-with(@encodinganalog, '5450')">
								<a href="#{$bioghist_id}" class="showbioghist">
									<xsl:value-of select="$bioghist_head"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="#{$historical_id}" class="showbioghist">
									<xsl:value-of select="$historical_head"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
						<br/>
					</xsl:for-each>
				</li>
			</xsl:if>
			<xsl:if test="string(odd/*)">
				<xsl:for-each select="odd[not(@audience='internal')]">
					<li>
						<a href="#{$odd_id}" class="ltoc1">
							<xsl:choose>
								<xsl:when test="@type='hist'">
									<xsl:value-of select="$odd_head_histbck"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$odd_label"/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</li>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="string(scopecontent)">
				<li>
					<a href="#{$scopecontent_id}" class="showscopecontent">
						<xsl:value-of select="$scopecontent_head"/>
					</a>
				</li>
			</xsl:if>
			<xsl:if test="(string(accessrestrict)) or (string(userestrict)) or (string(altformavail))">
				<li>		
					<a href="#" class="toggle-button" id="toggle-use">
						<span class="glyphicon glyphicon-plus"> </span>
					</a>
					<a href="#{$useinfo_id}" class="showuseinfo">
						<xsl:value-of select="$useinfo_head"/>
					</a>					
					<ul style="display:none" class="list-unstyled use-content">
						<xsl:if test="string(altformavail)">
							<li>
								<a href="#{$altformavail_id}" class="showuseinfo">
									<xsl:value-of select="$altformavail_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(accessrestrict)">
							<li>
								<a href="#{$accessrestrict_id}" class="showuseinfo">
									<xsl:value-of select="$accessrestrict_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(userestrict)">
							<li>
								<a href="#{$userestrict_id}" class="showuseinfo">
									<xsl:value-of select="$userestrict_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(prefercite)">
							<li>
								<a href="#{$prefercite_id}" class="showuseinfo">
									<xsl:value-of select="$prefercite_label"/>
								</a>
							</li>
						</xsl:if>
					</ul>
				</li>
			</xsl:if>

			<!-- ADMINISTRATIVE INFO -->
			<xsl:if test="string(arrangement) or string(custodhist) or string(acqinfo)       or string(processinfo) or string(accruals) or
				string(separatedmaterial) or string(originalsloc)      or string(bibliography) or string(otherfindaid) or string(relatedmaterial) or
				string(index)">
				<li>			
					<a href="#" class="toggle-button" id="toggle-admin">
						<span class="glyphicon glyphicon-plus"> </span>
					</a>
					<a href="#administrative_info">
						<xsl:text>Administrative Information</xsl:text>
					</a>					
					<ul style="display:none" class="list-unstyled admin-content">
						<xsl:if test="string(arrangement)">
							<li>
								<a href="#{$arrangement_id}" class="showai">
									<xsl:value-of select="$arrangement_head"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(custodhist)">
							<li>
								<a href="#{$custodhist_id}" class="showai">
									<xsl:value-of select="$custodhist_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(acqinfo)">
							<li>
								<a href="#{$acqinfo_id}" class="showai">
									<xsl:value-of select="$acqinfo_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(accruals)">
							<li>
								<a href="#{$accruals_id}" class="showai">
									<xsl:value-of select="$accruals_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(processinfo)">
							<li>
								<a href="#{$processinfo_id}" class="showai">
									<xsl:value-of select="$processinfo_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(separatedmaterial)">
							<li>
								<a href="#{$separatedmaterial_id}" class="showai">
									<xsl:value-of select="$separatedmaterial_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(bibliography)">
							<li>
								<a href="#{$bibliography_id}" class="showai">
									<xsl:value-of select="$bibliography_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(otherfindaid)">
							<li>
								<a href="#{$otherfindaid_id}" class="showai">
									<xsl:value-of select="$otherfindaid_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(relatedmaterial)">
							<li>
								<a href="#{$relatedmaterial_id}" class="showai">
									<xsl:value-of select="$relatedmaterial_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(appraisal)">
							<li>
								<a href="#{appraisal_id}" class="showai">
									<xsl:value-of select="$appraisal_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(originalsloc)">
							<li>
								<a href="#{$originalsloc_id}" class="showai">
									<xsl:value-of select="$originalsloc_label"/>
								</a>
							</li>
						</xsl:if>
					</ul>
				</li>
			</xsl:if>
			<xsl:if test="string(dsc)">
				<li>			
					<xsl:if test="//c02">
						<a href="#" class="toggle-button" id="toggle-dsc">
							<span class="glyphicon glyphicon-minus"> </span>
						</a>
					</xsl:if>
					<a href="#{$dsc_id}" class="showdsc">
						<xsl:value-of select="$dsc_head"/>
					</a>					
					<xsl:if test="//dsc[not(@type='in-depth')]">
						<xsl:call-template name="dsc_links"/>
					</xsl:if>
				</li>
			</xsl:if>
			<xsl:if test="string(controlaccess/*/subject) or string(controlaccess/subject)">
				<li>
					<a href="#{$controlaccess_id}" class="showcontrolaccess">
						<xsl:text>Subjects</xsl:text>
					</a>
				</li>
			</xsl:if>
		</ul>
	</xsl:template>
	<xsl:template name="dsc_links">
		<!-- if there are c02's anywhere in the dsc, then display the c01 headings
			if there are no c02's, all of the c01's are an in-depth type of dsc -->
		<xsl:if test="//c02">
			<ul class="list-unstyled dsc-content">
				<xsl:for-each select="//c01">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:choose>
									<xsl:when test="@id">
										<xsl:value-of select="concat('#', @id)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat('#', generate-id())"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<!-- what if no unitititle-->
							<xsl:choose>
								<xsl:when test="./did/unittitle">
									<!--<xsl:value-of select="position()"/>.&#160;-->
									<xsl:value-of select="./did/unittitle"/>
								</xsl:when>
								<!-- 2004-07-14 carlsonm mod: select unitid no matter encodinganalog if no unittitle -->
								<xsl:when test="./did/unitid/text() and not(./did/unittitle)">
									<xsl:if test="did/unitid/@type='accession'"> Accession No.&#160; </xsl:if>
									<xsl:value-of select="./did/unitid"/>
								</xsl:when>
								<xsl:otherwise>
									<!--<xsl:value-of select="position()"/>.&#160;-->Subordinate Component # <xsl:value-of select="position()"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- END what if no unitititle-->
						</a>
					</li>
				</xsl:for-each>
			</ul>
		</xsl:if>
	</xsl:template>
	<!-- ********************* </TABLE OF CONTENTS> *********************** -->
</xsl:stylesheet>
