<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:param name="lastSIDIHfileNumber">15644</xsl:param>
    <xsl:param name="pathStart">/Users/andrejp/Repo/ZalozbaINZ/agenda/</xsl:param>
    <xsl:param name="path2entity">/sidih/menuTop/menu1/menu5/</xsl:param>
    <xsl:param name="entity-num">2177</xsl:param>
    
    <xsl:template match="root">
        <xsl:result-document href="../import/move-image.txt">
            <xsl:for-each select="figure">
                <xsl:variable name="fileNumber" select="position() + $lastSIDIHfileNumber"/>
                <xsl:variable name="fileName" select="graphic"/>
                
                <xsl:text>mv </xsl:text>
                <xsl:value-of select="concat($pathStart,'media/',$fileName)"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="concat($pathStart,'import/images',$path2entity,$entity-num,'/file',$fileNumber,'/',$fileName)"/>
                <xsl:if test="position() != last()">
                    <xsl:text> ; </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>