<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!--
    /* this just displays the secondary content, which appears in a sidebar on big screens, at the bottom on small ones. */
    //also, naming things is hard. :\
-->
    
    <xsl:template match="system-index-block">
        
        <!-- old element name -->
        <xsl:copy-of select="calling-page/system-page/system-data-structure/secondarycontent/node()"/>
        <!-- old Admissions site element name -->
        <xsl:copy-of select="calling-page/system-page/system-data-structure/item/images/node()"/>
        <!-- new element name -->
        <xsl:copy-of select="calling-page/system-page/system-data-structure/secondary/node()"/>
    </xsl:template>
    
</xsl:stylesheet>