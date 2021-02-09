<?xml version="1.0" standalone="no"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0"
                xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml"
                encoding="UTF-8"
                indent="yes"
                doctype-public="-//W3C//DTD SVG 1.1//EN"
                doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"/>
    <xsl:template match="/library">
        <svg width="1080px"
             height="1000px"
             viewBox="-320 -50 1080 1000">


            <defs>
                <xsl:for-each select="statistics/child::*">
                    <xsl:if test="name()='publishers' or name()='genres' ">
                        template:<xsl:value-of select="name(.)"/>
                        <xsl:apply-templates select="."/>
                    </xsl:if>
                </xsl:for-each>
            </defs>

            <use xlink:href="#publishers" x="0" y="0"/>
            <use xlink:href="#genres" x="0" y="350"/>
        <!--<use xlink:href="#prices" x="300" y="0"/>-->


            <script type="text/ecmascript"><![CDATA[

function changeColor(evt) {
    var rect = evt.target;

    if (rect.getAttribute("class")=="blue"){
        rect.setAttribute("class", "red");
        rect.nextElementSibling.setAttribute("display","inline");

    }
    else{
        rect.setAttribute("class", "blue");
        rect.nextElementSibling.setAttribute("display","none");
    }
}

             ]]></script>
            <style>
                .blue{
                fill: #6FAED6;
                }
                .blue:hover{
                fill: #8DD2FF;
                cursor: pointer;
                }
                .red{
                fill: #DC0000;
                }
                .red:hover{
                fill: #F00;
                cursor: pointer;
                }
            </style>
        </svg>

    </xsl:template>

    <xsl:template match="statistics/child::*">
        <xsl:element name="g">
            <xsl:attribute name="class">graph</xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="name(.)"/>
            </xsl:attribute>

            <text x="-10" y="55" text-anchor="end"
                  font-family="sans-serif" font-size="35" fill="#000000">
                <xsl:value-of select="name(.)"/>
            </text>

            <xsl:for-each select="child::*">
                <xsl:variable name="no" select="(position()-1) * 70"/>
                <xsl:variable name="name" select="."/>
                <xsl:variable name="howMany" select="@howMany"/>


                <g class="column">
                    <text x="{10 + $howMany * 10}"
                          y="{$no + 120}" font-family="sans-serif" font-size="20">
                        <xsl:value-of select="$howMany"/>
                        <animate attributeType="XML"
                                 attributeName="x"
                                 from="10"
                                 to="{10 + $howMany * 10}"
                                 dur="1s"
                                 fill="freeze"
                        />
                    </text>

                    <rect onclick="changeColor(evt)"
                          class="blue"
                          id=""
                          y="{$no + 100}"
                          x="0"
                          height="30"
                          width="{$howMany * 10}"
                          fill="#6FAED6"
                          style="stroke:black; stroke-width:2">
                        <animateTransform attributeType="XML"
                                          attributeName="transform"
                                          type="scale"
                                          from="0 1"
                                          to="1 1"
                                          dur="1s"
                        />
                    </rect>

                    <text x="270" y="{$no + 100}"
                          font-family="sans-serif"
                          font-size="15"
                          display="none"
                          fill="#000000"
                    >
                        <xsl:for-each select="//book[descendant::* = $name]">

                            <xsl:if test="position() mod 3 = 1">
                                <xsl:text disable-output-escaping="yes">&#xa;&lt;tspan x="250" dy="20"&gt;</xsl:text>
                            </xsl:if>

                            <xsl:value-of select="title"/>

                            <xsl:if test="not(position()=last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>

                            <xsl:if test="position() mod 3 = 0">
                                <xsl:text disable-output-escaping="yes">&lt;/tspan&gt;</xsl:text>
                            </xsl:if>
                            <xsl:if test="position()=last() and not(position() mod 3 = 0)">
                                <xsl:text disable-output-escaping="yes">&lt;/tspan&gt;</xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </text>

                    <text x="-15" y="{$no + 120}" text-anchor="end"
                          font-family="sans-serif" font-size="20"
                          fill="#000000">
                        <xsl:value-of select="$name"/>
                    </text>

                </g>
            </xsl:for-each>

        </xsl:element>
    </xsl:template>


</xsl:stylesheet>