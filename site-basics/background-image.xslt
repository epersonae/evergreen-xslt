<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="no" method="html"/>
    
    <!-- 
    /* 
        check for a big background image
        can be set on the page level or the folder level (in the site-nav block)
        if neither is set, use a default image.
    */
-->
    
    <xsl:template match="system-index-block">        
        
        <!-- easier to handle with a variable, then if the class name or whatever needs to be changed, only has to be done once. -->
        <xsl:variable name="hero-location">
            <xsl:choose>
                <xsl:when test="calling-page/system-page/system-data-structure/hero and not(calling-page/system-page/system-data-structure/hero/path = '/')">
                    <xsl:value-of select="calling-page/system-page/system-data-structure/hero/path"/>
                </xsl:when>
                <xsl:when test="system-folder[@current='true']/system-block/system-data-structure[@definition-path='Site Info'] and not(system-folder[@current='true']/system-block/system-data-structure[@definition-path='Site Info']/siteinfo/hero/path='/')">
                    <xsl:value-of select="system-folder[@current='true']/system-block/system-data-structure[@definition-path='Site Info']/siteinfo/hero/path"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>/_inc/images/hero.jpg</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <img class="hero-img" src="{$hero-location}"/>
        
    </xsl:template>
    
</xsl:stylesheet>