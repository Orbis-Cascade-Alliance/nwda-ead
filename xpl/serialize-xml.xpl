<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline xmlns:p="http://www.orbeon.com/oxf/pipeline"
	xmlns:oxf="http://www.orbeon.com/oxf/processors">
	
	<p:param type="input" name="data"/>
	<p:param type="output" name="data"/>
	
	<p:processor name="oxf:xml-converter">
		<p:input name="data" href="#data"/>
		<p:input name="config">
			<config>
				<content-type>application/xml</content-type>
				<encoding>utf-8</encoding>
				<version>1.0</version>
			</config>
		</p:input>
		<p:output name="data" ref="data"/>
	</p:processor>
</p:pipeline>

