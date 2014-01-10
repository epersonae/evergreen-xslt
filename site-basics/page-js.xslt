<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="html"/>
    
    <!--
        goes through the index block for the page 
        and prints out any extra/custom JS
        -->
    
    <xsl:template match="system-index-block">
        
        <!-- check for dataTables plugin -->
        <!-- should there also be something here to automatically drop in our CSS overrides? -->
        <xsl:if test="calling-page/system-page/system-data-structure/js/dataTables/value = 'Yes'">
            <script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js" type="text/javascript"></script>
        </xsl:if>
        
        <!-- check for custom JS -->
        <xsl:if test="not(calling-page/system-page/system-data-structure/js/jsfiles/path = '/')">
            <xsl:for-each select="calling-page/system-page/system-data-structure/js/jsfiles">
                <script src="{link}" type="text/javascript"></script>
            </xsl:for-each>
        </xsl:if>
        
    </xsl:template>
        
</xsl:stylesheet>