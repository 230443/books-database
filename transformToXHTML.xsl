<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

    <xsl:output
            method="xml"
            encoding="utf-8"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes"
            indent="yes" />


    <xsl:template match="/library">


        <xsl:element name="html" xml:lang="pl">
            <xsl:attribute name="lang">pl</xsl:attribute>
            <xsl:element name="head">
                <meta content="text/html; charset=utf-8"/>
                <title>Table of books</title>
                <link rel="stylesheet" href="style.css"/>
            </xsl:element>

            <xsl:element name="body">
                <div id="container">
                    <h1>Library</h1>
                    <xsl:apply-templates select="books"/>
                    <xsl:apply-templates select="statistics"/>
                </div>
            </xsl:element>
        </xsl:element>
    </xsl:template>



    <xsl:template match="books">
        <table id="books" summary="Column one has numbering, other columns show the information about the book.">
            <caption>Table of books</caption>
            <tr id="header">
                <th>Number</th>
                <th>Title</th>
                <th>Author</th>
                <th>Series</th>
                <th>Number in series</th>
                <th>Publisher</th>
                <th>Price</th>
            </tr>
            <xsl:for-each select="book">
                <tr>
                    <td>
                        <xsl:number/>
                    </td>

                    <xsl:element name="td">
                        <xsl:attribute name="class">show</xsl:attribute>
                        <xsl:attribute name="onclick">showInput(this)</xsl:attribute>

                        <xsl:element name="input">
                            <xsl:attribute name="name">title</xsl:attribute>
                            <xsl:attribute name="placeholder">
                                <xsl:value-of select="title"/>
                            </xsl:attribute>
                        </xsl:element>


                        <xsl:element name="span">
                            <xsl:value-of select="title"/>
                        </xsl:element>

                    </xsl:element>




                    <xsl:element name="td">
                        <xsl:attribute name="class">show</xsl:attribute>
                        <xsl:attribute name="onclick">showInput(this)</xsl:attribute>


                        <xsl:element name="input">
                            <xsl:attribute name="name">author</xsl:attribute>
                            <xsl:attribute name="placeholder">
                                <xsl:value-of select="authors/author"/>
                            </xsl:attribute>
                        </xsl:element>


                        <xsl:element name="span">
                        <xsl:for-each select="authors/author">
                            <xsl:value-of select="."/>,
                        </xsl:for-each>
                        </xsl:element>
                        <!-- apply-template match="ItemId"/> -->
                    </xsl:element>




                    <xsl:element name="td">
                        <xsl:attribute name="class">show</xsl:attribute>
                        <xsl:attribute name="onclick">showInput(this)</xsl:attribute>


                        <xsl:element name="input">
                            <xsl:attribute name="name">series</xsl:attribute>
                            <xsl:attribute name="placeholder">
                                <xsl:value-of select="series"/>
                            </xsl:attribute>
                        </xsl:element>

                        <xsl:element name="span">
                            <xsl:value-of select="series"/>
                        </xsl:element>
                    </xsl:element>



                    <xsl:element name="td">

                        <xsl:attribute name="class">show</xsl:attribute>
                        <xsl:attribute name="onclick">showInput(this)</xsl:attribute>
                        <xsl:element name="input">
                            <xsl:attribute name="name">index</xsl:attribute>
                            <xsl:attribute name="type">number</xsl:attribute>
                            <xsl:attribute name="min">1</xsl:attribute>
                            <xsl:attribute name="max">999</xsl:attribute>
                            <xsl:attribute name="value">
                                <xsl:value-of select="series/@index"/>
                            </xsl:attribute>
                        </xsl:element>

                        <xsl:element name="span">
                            <xsl:value-of select="series/@index"/>
                        </xsl:element>

                    </xsl:element>


                    <xsl:element name="td">
                        <xsl:attribute name="class">show</xsl:attribute>
                        <xsl:attribute name="onclick">showInput(this)</xsl:attribute>



                        <select id="publisher" name="publisher">

                            <option value="fnp">Fundacja Nowoczesna Polska</option>
                            <option value="mr">Media Rodzina</option>
                            <option value="s">Solaris</option>

                        </select>

                        <xsl:element name="span">
                        <xsl:value-of select="publisher"/>
                        </xsl:element>


                    </xsl:element>


                    <xsl:element name="td">
                        <xsl:attribute name="class">show</xsl:attribute>
                        <xsl:attribute name="onclick">showInput(this)</xsl:attribute>



                        <xsl:element name="input">
                            <xsl:attribute name="name">index</xsl:attribute>
                            <xsl:attribute name="type">number</xsl:attribute>
                            <xsl:attribute name="step">0.01</xsl:attribute>
                            <xsl:attribute name="min">1</xsl:attribute>
                            <xsl:attribute name="max">999</xsl:attribute>
                            <xsl:attribute name="value">
                                <xsl:value-of select="price"/>
                            </xsl:attribute>
                        </xsl:element>
                    <span>
                        <xsl:value-of select="price"/>
                        <xsl:value-of select="price/@currency"/>
                    </span>
                    </xsl:element>
                </tr>
            </xsl:for-each>
        </table>

    </xsl:template>

    <xsl:template match="statistics">
        <xsl:element name="div">
            <xsl:attribute name="id">stats</xsl:attribute>

            <h3>Statistics:</h3>

            <h4>Total number of books</h4>
            <table>
                <tr>
                    <td>Total</td>
                    <td class="number"><xsl:value-of select="count(//book)"/></td>
                </tr>
            </table>

            <h4>Genres</h4>
                <xsl:apply-templates select="genres"/>

            <h4>Publishers</h4>
                <xsl:apply-templates select="publishers"/>

<!--

            <h4>Prices</h4>
                <xsl:apply-templates select="prices"/>

-->

            <h4>Generated</h4>
            <xsl:value-of select="//generated"/>
        </xsl:element>

    </xsl:template>

   <!-- <xsl:template match="prices">
        <table>
            <caption>Statistics about prices</caption>
            <tr>
                <td>average</td>
                <td class="number"><xsl:value-of select="avgPrice"/><xsl:value-of select="avgPrice/@currency"/></td>
            </tr>
            <tr>
                <td>sum</td>
                <td class="number"><xsl:value-of select="sumPrice"/><xsl:value-of select="sumPrice/@currency"/></td>
            </tr>
            <tr>
                <td>maximum</td>
                <td class="number"><xsl:value-of select="maxPrice"/><xsl:value-of select="maxPrice/@currency"/></td>
            </tr>
            <tr>
                <td>minimum</td>
                <td class="number"><xsl:value-of select="minPrice"/><xsl:value-of select="minPrice/@currency"/></td>
            </tr>
        </table>
    </xsl:template>-->

    <xsl:template match="publishers">

<!--

        <table>
            <caption>Number of books from different publishers</caption>
            <xsl:for-each select="publisher">
                <tr>
                    <td><xsl:value-of select="."/></td>
                    <td class="number"><xsl:value-of select="@howMany"/></td>
                </tr>
            </xsl:for-each>
        </table>

-->

        <xsl:element name="table">
            <caption>Number of books from different publishers</caption>
            <xsl:for-each select="//publisher[not(.=preceding::publisher)]">
                <xsl:variable name="tmp" select="."/>
                <xsl:element name="tr">
                    <xsl:element name="td">
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <xsl:element name="td">
                        <xsl:value-of select="count(//publisher[.=$tmp])"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>



    </xsl:template>

    <xsl:template match="genres">
        <!--
        <table>
            <caption>Number of books of different genres</caption>
            <xsl:for-each select="genre">
                <tr>
                    <td><xsl:value-of select="."/></td>
                    <td class="number"><xsl:value-of select="@howMany"/></td>
                </tr>
            </xsl:for-each>
        </table>
-->

        <xsl:element name="table">
            <caption>Number of books of different genres</caption>
            <xsl:for-each select="//genre[not(.=preceding::genre)]">
                <xsl:variable name="tmp" select="."/>
                <xsl:element name="tr">
                    <xsl:element name="td">
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <xsl:element name="td">
                        <xsl:value-of select="count(//genre[.=$tmp])"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>




    </xsl:template>

</xsl:stylesheet>