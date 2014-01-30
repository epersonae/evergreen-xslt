<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!-- 
    //this looks in an index block for the current folder and gets the section out of the folder's metadata
    -->
    <xsl:template match="/">
        <xsl:apply-templates select="//system-folder[@current='true']"/>
        <xsl:apply-templates select="system-index-block/system-page[@current='true']"/>
    </xsl:template>
    
    <xsl:template match="system-index-block/system-page[@current='true']">
        <!-- this one should only show up if the page is at the very top level! -->
        <nav class="top-nav" role="navigation">
            <ul class="top-nav-list">
                <li class="is-current-section"><a class="top-nav-link" href="site://evergreen.edu - old design/home">Home</a></li>
                <li><a class="top-nav-link" href="/academics/home">Academics</a></li>
                <li><a class="top-nav-link" href="/campuslife/home">Campus Life</a></li>
                <li><a class="top-nav-link" href="/costs/home">Costs &amp; Aid</a></li>
                <li><a class="top-nav-link" href="site://Admissions/admissions/index">Admission<span class="gt32">s</span></a></li>
                
            </ul>
        </nav>
        
    </xsl:template>
    
    
    <xsl:template match="system-folder">
        <!-- get which section out of the folder's metadata -->
        <!-- if the metadata isn't in the folder, go up one -->
        <!-- this MAY break on top-level folders -->
        <xsl:variable name="section">
            <xsl:choose>
                <xsl:when test="dynamic-metadata[name='section']/value">
                    <xsl:value-of select="dynamic-metadata[name='section']/value"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../dynamic-metadata[name='section']/value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- set up the class names for all the list items -->
        <xsl:variable name="academics">
            <xsl:if test="$section = 'Academics'">is-current-section</xsl:if>
        </xsl:variable>
        <xsl:variable name="campus-life">
            <xsl:if test="$section = 'Campus Life'">is-current-section</xsl:if>
        </xsl:variable>
        <xsl:variable name="costs-aid">
            <xsl:if test="$section = 'Costs/Aid'">is-current-section</xsl:if>
        </xsl:variable>
        <xsl:variable name="admissions">
            <xsl:if test="$section = 'Admissions'">is-current-section</xsl:if>
        </xsl:variable>
        
        <!-- then build the HTML. class will be empty if the item isn't in that section. -->
        <nav class="top-nav" role="navigation">
            <ul class="top-nav-list">
                <li><a class="top-nav-link" href="site://evergreen.edu - old design/home">Home</a></li>
                <li class="{$academics}"><a class="top-nav-link" href="/academics/home">Academics</a></li>
                <li class="{$campus-life}"><a class="top-nav-link" href="/campuslife/home">Campus Life</a></li>
                <li class="{$costs-aid}"><a class="top-nav-link" href="/costs/home">Costs &amp; Aid</a></li>
                <li class="{$admissions}"><a class="top-nav-link" href="site://Admissions/admissions/index">Admission<span class="gt32">s</span></a></li>
                
            </ul>
        </nav>
        
        
    </xsl:template>
    
</xsl:stylesheet>