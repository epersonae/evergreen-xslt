<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!-- 
    //this looks in an index block for the current folder and gets the title and path out of the folder's metadata
    -->
    <xsl:template match="/">
        
        <xsl:choose>
            <!-- if this folder has the metadata title set, use that title and folder path -->
            <xsl:when test="//system-folder[@current='true']/title">
                <xsl:apply-templates mode="hastitle" select="//system-folder[@current='true']"/>
            </xsl:when>
            <!-- otherwise, go up a level -->
            <xsl:when test="not(//system-folder[@current='true']/title)">
                <xsl:apply-templates mode="notitle" select="//system-folder[@current='true']"/>
            </xsl:when>
        </xsl:choose>
    
    </xsl:template>
    
    <!-- probably, you'd want to do the selecting higher up in the tree, but this works... -->
    <xsl:template match="system-folder" mode="notitle">
        <a href="{../path}"><xsl:value-of select="../title"/></a>
    </xsl:template>
    
    <xsl:template match="system-folder" mode="hastitle">
        <a href="{path}"><xsl:value-of select="title"/></a>
    </xsl:template>
    
</xsl:stylesheet>