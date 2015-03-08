<?xml version="1.0"?>

<!-- migrated to HTML5/Bootstrap in March 2015, Ethan Gruber -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="html.header.table">

		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/index.shtml">
						<img src="/images/logos/NWDAlogotype.gif" alt="NWDA" style="height:24"/>
					</a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li>
							<a href="/index.shtml" class="nav-home">home</a>
						</li>
						<li>
							<a href="/search/" class="nav-search">search</a>
						</li>
						<li>
							<a href="/about.shtml" class="nav-about">about</a>
						</li>
						<li>
							<a href="/dynamicpages/contact.aspx" class="nav-contact">contact us</a>
						</li>
						<li>
							<a href="https://www.orbiscascade.org/northwest-digital-archives-program/" class="nav-tools">member tools</a>
						</li>
					</ul>
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
					</div>-->
				</div>
			</div>
		</nav>
		<!--END NWDA HEADER DIV-->
	</xsl:template>
</xsl:stylesheet>