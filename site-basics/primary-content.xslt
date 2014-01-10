<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!--
    /* this stylesheet displays the first part of the "Page" content.
        if this isn't a "home" page, also show the page's title.
    */
-->
    
    <xsl:include href="site://evergreen.edu - old design/_internal/stylesheets/hh-format-date"/>
    
    <xsl:template match="system-index-block">
        
        <xsl:choose>
            <!-- individual profile pages -->
            <xsl:when test="calling-page/system-page/system-data-structure/@definition-path='Page - Profile'">
                <h1>
                    Profile: <xsl:value-of select="calling-page/system-page/system-data-structure/person/name"/>
                    <xsl:choose>
                        <xsl:when test="calling-page/system-page/system-data-structure/person/type/value='Alumnus'">
                            ’<xsl:value-of select="substring(calling-page/system-page/system-data-structure/person/alumni/gradyear,3)"/>
                        </xsl:when>
                    </xsl:choose>
                </h1>
            </xsl:when>
            <!-- any other page that's not a home page -->
            <xsl:when test="not(calling-page/system-page/name = 'home') and not(calling-page/system-page/name = 'index') and not(calling-page/system-page/name = 'home-new')">
                <h1><xsl:value-of select="calling-page/system-page/title"/></h1>
            </xsl:when>
            <xsl:otherwise>
                <!--<h2><xsl:value-of select="calling-page/system-page/title"/></h2>-->
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:if test="calling-page/system-page/system-data-structure/@definition-path='Page - Profile'">
            <p class="intro"><xsl:value-of select="calling-page/system-page/system-data-structure/person/alumni/notable"/></p>
        </xsl:if>
        
        <!-- these two elements are from the previous structured content type
            with a preface and a maincontent section -->
        <xsl:copy-of select="calling-page/system-page/system-data-structure/preface/node()"/>
        <xsl:copy-of select="calling-page/system-page/system-data-structure/maincontent1/node()"/>
        
        <!-- news stories -->
        <xsl:if test="calling-page/system-page/system-data-structure/@definition-path = 'Story'">
            <p><small>Published: 
                <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="calling-page/system-page/start-date"/>
                    <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param>
                </xsl:call-template></small></p>
            <xsl:if test="calling-page/system-page/system-data-structure/feature-image/link">
                <div class="box caption-box supplement-1-2"><img class="illus-full" src="{calling-page/system-page/system-data-structure/feature-image/link}"/> 
                    <p class="caption"><xsl:value-of select="calling-page/system-page/system-data-structure/feature-image/summary"/></p>
                </div>
            </xsl:if>
            <xsl:copy-of select="calling-page/system-page/system-data-structure/content/node()"/>
        </xsl:if>
        
        
        <!-- this one is from the Admissions content type -->
        <xsl:copy-of select="calling-page/system-page/system-data-structure/item/content/node()"/>
        
        <!-- this is the new one, where there's only one maincontent element -->
        <xsl:copy-of select="calling-page/system-page/system-data-structure/maincontent/node()"/>
    </xsl:template>
    
</xsl:stylesheet>