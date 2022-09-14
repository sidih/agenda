<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Odstranim odvečne hi elemente, ki so brez atributov -->
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:hi[not(@*)]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:anchor">
        
    </xsl:template>
    
    <xsl:template match="tei:graphic">
        <graphic url="{@url}"/>
    </xsl:template>
    
</xsl:stylesheet>