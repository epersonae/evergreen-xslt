<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output indent="yes" method="html"/>
    
    <!-- 
    //this looks in an index block for the current folder and gets any navigation links that exist
    -->
    <xsl:template match="/">
        <xsl:apply-templates select="system-index-block//system-folder[@current='true']"/>
    </xsl:template>
    
    <xsl:template match="system-index-block//system-folder[@current='true']">
        
        <!-- 
            I think these are all the possibilities.
        //1. at the top level, doesn't have a navigation block: don't show any navigation
        //2. at the top level, has a navigation block: build the navigation
        //3. in secondary folder, has its own navigation block: build the navigation
        //4. in secondary folder, next level up has navigation block: build the navigation
        //5. in secondary folder, no navigation block: don't show any navigation
        -->
        <!--<xsl:value-of select="name"/>-->
        <xsl:choose>
            <!-- this is the easiest/most obvious option! -->
            <xsl:when test="system-block/system-data-structure[@definition-path='Site Contacts']">
                <xsl:apply-templates select="system-block/system-data-structure[@definition-path='Site Contacts']"/>
            </xsl:when>
            <!-- are these too generous? 
                wondering if they'll accidentally catch instances when a top-level folder doesn't have a nav block 
                & give it the wrong site's nav? -->
            <xsl:when test="preceding-sibling::system-block/system-data-structure[@definition-path='Site Contacts']">
                <xsl:apply-templates select="preceding-sibling::system-block/system-data-structure[@definition-path='Site Contacts']"/>
            </xsl:when>
            <xsl:when test="following-sibling::system-block/system-data-structure[@definition-path='Site Contacts']">
                <xsl:apply-templates select="following-sibling::system-block/system-data-structure[@definition-path='Site Contacts']"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="system-block/system-data-structure[@definition-path='Site Contacts']">
        <section class="site-info">
            <h3>Contact Us</h3>
            <dl>
                <xsl:if test="contact/location/text()">
                    <dt>Location</dt>
                    <dd><xsl:value-of select="contact/location"/></dd>
                </xsl:if>
                <xsl:if test="contact/phone/text()">
                    <dt>Phone</dt>
                    <dd><xsl:value-of select="contact/phone"/></dd>
                </xsl:if>
                <xsl:if test="contact/fax/text()">
                    <dt>Fax</dt>
                    <dd><xsl:value-of select="contact/fax"/></dd>
                </xsl:if>
                
                <xsl:if test="contact/email/text()">
                    <dt>Email</dt>
                    <dd><a href="http://www.evergreen.edu/scripts/contact.php?sm={contact/email}&amp;sub=Email%20from%20{contact/emailname}%20Site&amp;title=">Use our contact form</a></dd>
                    <!--<dd><a href="https://contact.evergreen.edu/?to={contact/email}&amp;to_name={contact/emailname}">Use our contact form</a></dd>-->
                </xsl:if>
                <xsl:if test="contact/staffpage/title">
                    <dt><a href="{contact/staffpage/path}">Our Staff</a></dt>
                </xsl:if>
                <xsl:if test="contact/additional/node()">
                    <dd><xsl:copy-of select="contact/additional"/></dd>
                </xsl:if>
                
                <xsl:if test="contact/hours/node()">
                    <dt>Hours</dt>
                    <dd><xsl:copy-of select="contact/hours/node()"/></dd>
                </xsl:if>
            </dl>
        </section>
    </xsl:template>
    
    
</xsl:stylesheet>