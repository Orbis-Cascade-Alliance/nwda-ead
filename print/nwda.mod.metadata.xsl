<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">
	  <xsl:template name="md.dc">
		    <xsl:variable name="isoLang" select="//langusage/language/@langcode"/>
		    <xsl:variable name="isoDate" select="//eadheader/@dateencoding"/>
		    <meta name="GENERATOR" content="Transformed from EAD(XML) v2002 using XSLT v1.0"/>
		    <meta lang="{$isoLang}" name="DC.Type" content="text"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#type"/>
		    <meta lang="{$isoLang}" name="DC.Format" content="text/html"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#format"/>
		    <link rel="schema.imt" href="http://sunsite.auc.dk/RFC/rfc/rfc2046.html"/>
		    <meta lang="{$isoLang}" name="DC.Language" scheme="{//eadheader/@langencoding}"
            content="{//langusage/language/@langcode}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#language"/>
		    <meta lang="{$isoLang}" name="DC.Identifier" content="{$file}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#identifier"/>
		    <meta lang="{$isoLang}" name="DC.Publisher"
            content="{$repositoryParent}::{$repository}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#publisher"/>
		    <meta lang="{$isoLang}" name="DC.Title" content="{$titleproper}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#title"/>
		    <meta lang="{$isoLang}" name="DC.Title.Alternative" content="{$filingTitleproper}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#title"/>		
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#date"/>
		    <meta lang="{$isoLang}" name="DC.Date.X-MetadataLastModified" schema="{$isoDate}"
            content="{$dateLastRev}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#date"/>
		    <meta lang="{$isoLang}" name="DC.Creator"
            content="XML Content:{normalize-space(//author)}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#creator"/>
		    <meta lang="{$isoLang}" name="DC.Creator" content="HTML: {$operator}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#creator"/>
		    <meta lang="{$isoLang}" name="DC.CreatorCorporateName"
            content="{normalize-space(//archdesc/did/repository/corpname)}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#creator"/>
		    <meta lang="{$isoLang}" name="DC.Rights" content="{//publicationstmt/p}"/>
		    <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#rights"/>
		    <meta lang="{$isoLang}" name="DC.Description"
            content="{substring(//scopecontent[1]/p,1,200)}"/>
		    <link rel="schema.dc"
            href="http://purl.org/metadata/dublin_core_elements#description"/>
		    <xsl:for-each select="//controlaccess//*[@rules]">
			      <meta lang="{$isoLang}" name="DC.Subject" scheme="{@rules}"
               content="{normalize-space(./text())}"/>
			      <link rel="schema.dc" href="http://purl.org/metadata/dublin_core_elements#subject"/>
		    </xsl:for-each>
	  </xsl:template>
</xsl:stylesheet>