<?xml version="1.0" encoding="UTF-8"?>
<!-- migrated to HTML5/Bootstrap in March 2015, Ethan Gruber --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="urn:isbn:1-931666-22-9"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"
                exclude-result-prefixes="fo ead">
   <xsl:template name="html.header">
      <nav class="navbar navbar-default">
         <fo:block>
            <fo:block>
               <button type="button" class="navbar-toggle" data-toggle="collapse"
                       data-target=".navbar-collapse">
                  <fo:inline>Toggle navigation</fo:inline>
               </button>
               <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="/index.shtml">
                  <fo:external-graphic src="/images/logos/NWDAlogotype.gif"/>
               </fo:basic-link>
            </fo:block>
            <fo:block>
               <fo:list-block provisional-distance-between-starts="15px" provisional-label-separation="5px">
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                           <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="/index.shtml">home</fo:basic-link>
                        </fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                           <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="/search/">search</fo:basic-link>
                        </fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                           <fo:basic-link text-decoration="underline" color="#337ab7" external-destination="/about.shtml">about</fo:basic-link>
                        </fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                           <fo:basic-link text-decoration="underline" color="#337ab7"
                                          external-destination="/dynamicpages/contact.aspx">contact us</fo:basic-link>
                        </fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                     <fo:list-item-label end-indent="label-end()">
                        <fo:block/>
                     </fo:list-item-label>
                     <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                           <fo:basic-link text-decoration="underline" color="#337ab7"
                                          external-destination="https://www.orbiscascade.org/archives-and-manuscript-collections">member tools</fo:basic-link>
                        </fo:block>
                     </fo:list-item-body>
                  </fo:list-item>
               </fo:list-block>
               <!--<div class="col-sm-3 col-md-3 pull-right">
						<form class="navbar-form" role="search" action="{$display_path}results" method="get">
							<div class="input-group">
								<input type="text" class="form-control" placeholder="Search Finding Aid" name="q" id="srch-term"/>
								<div class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<i class="glyphicon glyphicon-search"/>
									</button>
								</div>
							</div>
						</form>
					</div>--></fo:block>
         </fo:block>
      </nav>
      <!--END NWDA HEADER DIV--></xsl:template>
</xsl:stylesheet>