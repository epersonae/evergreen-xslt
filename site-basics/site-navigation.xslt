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
            <xsl:when test="system-block/system-data-structure[@definition-path='Site Info']">
                <xsl:apply-templates select="system-block/system-data-structure[@definition-path='Site Info']"/>
            </xsl:when>
            <!-- are these too generous? 
                wondering if they'll accidentally catch instances when a top-level folder doesn't have a nav block 
                & give it the wrong site's nav? -->
            <xsl:when test="preceding-sibling::system-block/system-data-structure[@definition-path='Site Info']">
                <xsl:apply-templates select="preceding-sibling::system-block/system-data-structure[@definition-path='Site Info']"/>
            </xsl:when>
            <xsl:when test="following-sibling::system-block/system-data-structure[@definition-path='Site Info']">
                <xsl:apply-templates select="preceding-sibling::system-block/system-data-structure[@definition-path='Site Info']"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="system-block/system-data-structure[@definition-path='Site Info']">
        <!-- I think it's requiring that there be at least two items in the list. this might be totally the wrong thing. -->
        <xsl:if test="not(navigation/navgroup/pages/path='/') or not(count(navigation/navgroup/pages)=1)">
            <nav class="box" id="tertiary-nav">
                <dl>
                    <xsl:for-each select="navigation/navgroup">
                        <!-- if there isn't a heading set, then it will use the site name set on the folder as the header. -->
                        <!-- this may go strangely on multi-level folder sites. -->
                        <dt class="tertiary-nav-h">
                            <xsl:choose>
                                <xsl:when test="heading/text()"><xsl:value-of select="heading"/></xsl:when>
                                <xsl:otherwise><xsl:value-of select="ancestor::system-folder/title"/></xsl:otherwise>
                            </xsl:choose>
                        </dt>
                        <dd><ul class="tertiary-nav-list" id="tertiary-nav-list">
                            <!-- if this group has a home page in it, put it at the top. 
                            this actually doesn't work, especially with multi-level folder sites.
                            -->
                            <!--<xsl:if test="pages[name='home' or name='index']">
                                <li><a href="{pages/path}">
                                    <xsl:choose>
                                        <xsl:when test="pages/dynamic-metadata/name='navtitle' and pages/dynamic-metadata[name='navtitle']/value">
                                            <xsl:value-of select="pages/dynamic-metadata[name='navtitle']/value"/>
                                        </xsl:when>
                                        <xsl:otherwise><xsl:value-of select="pages/title"/></xsl:otherwise>
                                    </xsl:choose>
                                    
                                </a></li>
                            </xsl:if>-->
                            <!-- list all the pages that are NOT a home page
                            doesn't work. 
                            <xsl:for-each select="pages[not(name='home')]">
                                <xsl:sort select="dynamic-metadata[name='navtitle']/value"/>
                                <xsl:sort select="title"/>
                                --><!-- I'm not 100% confident about this sorting, maybe need something more sophisticated. -->
                            <!-- every page that has a "real" path -->
                            <xsl:for-each select="pages[not(path='/')]">    
                                <li><a href="{path}">
                                    <xsl:choose>
                                        <xsl:when test="dynamic-metadata/name='navtitle' and dynamic-metadata[name='navtitle']/value">
                                            <xsl:value-of select="dynamic-metadata[name='navtitle']/value"/>
                                        </xsl:when>
                                        <xsl:otherwise><xsl:value-of select="title"/></xsl:otherwise>
                                    </xsl:choose>
                                    
                                </a></li>
                            </xsl:for-each>
                        </ul></dd>
                    </xsl:for-each>
                    <xsl:if test="navigation/related/node()">
                        <dt class="tertiary-nav-h">Related Links</dt>
                        <dd>
                            <xsl:copy-of select="navigation/related/node()"/>
                        </dd>
                    </xsl:if>
                    <xsl:if test="navigation/socialmedia/node()/text()">
                        <dt class="tertiary-nav-h">Social Media Connections</dt>
                        <dd>
                            <ul class="tertiary-nav-list">
                                <xsl:if test="navigation/socialmedia/wordpress/text()">
                                    <li>
                                        <a href="http://blogs.evergreen.edu/{navigation/socialmedia/wordpress}">Blog</a>
                                    </li>
                                </xsl:if>
                                <xsl:if test="navigation/socialmedia/twitter/text()">
                                    <li>
                                        <a href="http://twitter.com/{navigation/socialmedia/twitter}">Twitter</a>
                                    </li>
                                </xsl:if>
                                <xsl:if test="navigation/socialmedia/facebook/text()">
                                    <li>
                                        <a href="{navigation/socialmedia/facebook}">Facebook</a>
                                    </li>
                                </xsl:if>
                                <xsl:if test="navigation/socialmedia/youtube/text()">
                                    <li>
                                        <a href="{navigation/socialmedia/youtube}">YouTube</a>
                                    </li>
                                </xsl:if>
                                <xsl:if test="navigation/socialmedia/other/node()">
                                    <li>
                                        <xsl:copy-of select="navigation/socialmedia/other/node()"/>
                                    </li>
                                </xsl:if>
                            </ul>
                        </dd>
                    </xsl:if>
                </dl>
            </nav>
        </xsl:if> 
    </xsl:template>
    
    
</xsl:stylesheet>