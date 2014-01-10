<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!-- see site-navigation XSLT for notes about how this works -->
    <xsl:template match="/">
        <xsl:apply-templates select="system-index-block//system-folder[@current='true']"/>
    </xsl:template>
    
    <xsl:template match="system-index-block//system-folder[@current='true']">
        <xsl:choose>
            <xsl:when test="system-block/system-data-structure[@definition-path='Site Info']">
                <xsl:apply-templates select="system-block/system-data-structure[@definition-path='Site Info']"/>
            </xsl:when>
            <xsl:when test="preceding-sibling::system-block/system-data-structure[@definition-path='Site Info']">
                <xsl:apply-templates select="preceding-sibling::system-block/system-data-structure[@definition-path='Site Info']"/>
            </xsl:when>
            <xsl:when test="following-sibling::system-block/system-data-structure[@definition-path='Site Info']">
                <xsl:apply-templates select="preceding-sibling::system-block/system-data-structure[@definition-path='Site Info']"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="system-block/system-data-structure[@definition-path='Site Info']">
        <xsl:value-of select="name"/>
        <xsl:for-each select="siteinfo/css">
            <xsl:if test="not(path='/')"><link href="{path}" media="all" rel="stylesheet"/></xsl:if>
        </xsl:for-each> 
    </xsl:template>
    
    
</xsl:stylesheet>