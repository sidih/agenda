<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- izhodiščni je voices.xml -->
    <xsl:output method="xml" indent="yes"/>
    
    <!-- na roko dodaj še tei:div/@facs -->
    <xsl:template match="/">
        <xsl:result-document href="import/list-image.xml">
            <root>
                <xsl:for-each-group select="//tei:figure" group-by="tei:graphic/@url">
                    <xsl:sort select="current-grouping-key()"/>
                    <figure n="{tokenize(current-grouping-key(),'/')[last()]}">
                        <xsl:for-each select="current-group()">
                            <xsl:variable name="language">
                                <xsl:choose>
                                    <xsl:when test="contains(tei:graphic/@url,'-sl')">sl</xsl:when>
                                    <xsl:otherwise>en</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:if test="tei:head">
                                <title xml:lang="{$language}">
                                    <xsl:value-of select="normalize-space(tei:head/text())"/>
                                </title>
                            </xsl:if>
                            <graphic>
                                <xsl:value-of select="tokenize(tei:graphic/@url,'/')[last()]"/>
                            </graphic>
                        </xsl:for-each>
                    </figure>
                </xsl:for-each-group>
            </root>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>