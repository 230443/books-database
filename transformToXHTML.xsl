<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

    <xsl:output
            method="xml"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes"
            indent="yes" />


    <xsl:template match="/">

        <xsl:element name="html" xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
            <xsl:attribute name="lang">pl</xsl:attribute>


            <xsl:element name="head">
                <title>Table of books</title>

            </xsl:element>


            <xsl:element name="body">
                <table>
                    <tr id="header">
                        <th>Title</th>
                        <th>Author</th>
                        <th>Series</th>
                        <th>No in series</th>
                        <th>Publisher</th>
                        <th>Price</th>
                    </tr>
                    <xsl:for-each select="/books/book">
                        <xsl:sort select="authors/@sort" lang="pl" />
                        <tr>
                            <td>
                                <xsl:value-of select="title"/>
                            </td>
                            <td>
                                <xsl:for-each select="authors/author">
                                    <xsl:value-of select="."/>,
                                </xsl:for-each>
                                <!-- apply-template match="ItemId"/> -->
                            </td>
                            <td>
                                <xsl:if test="child::series">
                                    <xsl:value-of select="series/@index"/>
                                    in
                                    <xsl:value-of select="series"/>
                                </xsl:if>
                                <xsl:if test="not(child::series)">
                                    none
                                </xsl:if>
                            </td>
                            <td class="publisher">
                                <xsl:value-of select="publisher"/>
                            </td>
                            <td class="price">
                                <xsl:value-of select="price"/>
                                <xsl:value-of select="price/@currency"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>

            </xsl:element>

        </xsl:element>
    </xsl:template>

</xsl:stylesheet>