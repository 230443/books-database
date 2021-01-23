<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

    <xsl:key name="publisher" match="/Library/publishers/pub/name" use="../@id"/>

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:element name="library">

            <xsl:element name="books">
                <xsl:for-each select="Library/books/book">
                    <xsl:sort select="authors/@sort" lang="pl"/>
                    <xsl:sort select="series" lang="pl"/>
                    <xsl:sort select="series/@index" data-type="number"/>

                    <xsl:element name="book">
                        <xsl:attribute name="id">
                            <xsl:value-of select="@nr"/>
                        </xsl:attribute>
                        <xsl:copy-of select="title|authors"/>

                        <xsl:if test="series">
                            <xsl:copy-of select="series"/>
                        </xsl:if>
                        <xsl:if test="not(series)">
                            <series inedx=''></series>
                        </xsl:if>

                        <xsl:element name="publisher">
                            <xsl:value-of select="key('publisher',publisher/@idref)"/>
                        </xsl:element>
                        <xsl:element name="pages">
                            <xsl:value-of select="_pages"/>
                        </xsl:element>
                        <xsl:copy-of select="tags"/>
                        <xsl:copy-of select="size"/>
                        <xsl:copy-of select="files"/>
                        <xsl:copy-of select="price"/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>

            <xsl:element name="statistics">

                <booksNumber><xsl:value-of select="count(//book)"/></booksNumber>

                <xsl:element name="genres">
                <xsl:for-each select="//genre[not(.=preceding::genre)]">
                    <xsl:variable name="tmp" select="."/>
                    <xsl:element name="genre">
                        <xsl:attribute name="howMany">
                            <xsl:value-of select="count(//genre[.=$tmp])"/>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
                </xsl:element>

                <xsl:element name="publishers">
                    <xsl:for-each select="//pub[not(name=preceding::name)]">
                        <xsl:variable name="tmp" select="."/>
                        <xsl:element name="publisher">
                            <xsl:attribute name="howMany">
                                <xsl:value-of select="count(//publisher[@idref=$tmp/@id])"/>
                            </xsl:attribute>
                            <xsl:value-of select="name"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>

                <xsl:element name="prices">


                <xsl:element name="sumPrice">
                    <xsl:attribute name="currency">PLN</xsl:attribute>
                    <xsl:value-of select="format-number(sum(//price[@currency='PLN']),'#0.00')"/>
                </xsl:element>


                </xsl:element>

                <xsl:element name="generated"></xsl:element>

            </xsl:element>
        </xsl:element>


    </xsl:template>

</xsl:stylesheet>