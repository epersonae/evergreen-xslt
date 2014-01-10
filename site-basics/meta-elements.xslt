<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!--
    /* 
        this builds the meta elements for social media sites
        starting with just the title and description
    */
-->
    
    <xsl:output indent="yes" method="html"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="//calling-page/system-page"/>
    </xsl:template>
    
    <xsl:template match="/system-index-block/calling-page/system-page">
        
        <meta content="summary" name="twitter:card"/>
        
        <!-- use the page title (the long one, not the nav version) -->
        <meta content="{title}" property="og:title"/>
        <meta content="{title}" name="twitter:title"/>
        <!-- if they've set a description, use that -->
        <xsl:choose>
            <xsl:when test="description">
                <meta content="{description}" property="og:description"/>
                <meta content="{description}" name="twitter:description"/>
            </xsl:when>
            <xsl:when test="summary">
                <meta content="{summary}" property="og:description"/>
                <meta content="{summary}" name="twitter:description"/>
            </xsl:when>
        </xsl:choose>

        
    </xsl:template>
    
</xsl:stylesheet>