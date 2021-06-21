<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 199-2003 che Wolfram Diestel

reguloj por prezentado de kapvorto kun numeroj de sencoj, subsencoj ktp.

-->

<!-- la kapvorto de la artikolo -->

<xsl:template match="art/kap">
  <h1><xsl:apply-templates/></h1>
</xsl:template>

<!-- tildoj referencas al la radiko de la artikola kapvorto -->

<xsl:template match="tld">
  <xsl:variable name="rad">
    <xsl:choose>
      <xsl:when test="@var">
        <xsl:value-of select="ancestor::art/kap/var/kap/rad[@var=current()/@var]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="ancestor::art/kap/rad"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="@lit">
      <xsl:value-of select="concat(@lit,substring($rad,2))"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$rad"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- moduso "kapvorto" - kunmetu la kapvorton por traduko au administra noto -->

<xsl:template match="art|drv" mode="kapvorto">
  <xsl:apply-templates select="kap" mode="kapvorto"/>
</xsl:template>


<xsl:template match="snc" mode="kapvorto">

  <xsl:apply-templates select="ancestor::node()
    [self::drv or self::art][1]/kap" mode="kapvorto"/>
    <xsl:text> </xsl:text>

    <xsl:choose>

      <xsl:when test="@ref">
        <xsl:apply-templates mode="number-of-ref-snc" select="id(@ref)"/>:
      </xsl:when>

      <xsl:when test="count(ancestor::node()
        [self::drv or self::subart][1]//snc)>1">
        <xsl:number from="drv|subart" level="any" count="snc" format="1."/>
      </xsl:when>

    </xsl:choose>

</xsl:template>


<xsl:template match="subsnc" mode="kapvorto">
  <xsl:apply-templates select="ancestor::node()
    [self::drv or self::art][1]/kap" mode="kapvorto"/>
  <xsl:text> </xsl:text>
  <xsl:number from="drv|subart" level="multiple" count="snc|subsnc"
      format="1.a"/>
</xsl:template>


<xsl:template match="subart" mode="kapvorto">
  <xsl:apply-templates select="ancestor::art/kap" mode="kapvorto"/>
  <xsl:text> </xsl:text>
  <xsl:number format="I"/>
</xsl:template>

<xsl:template match="subdrv" mode="kapvorto">
  <xsl:apply-templates select="ancestor::drv/kap" mode="kapvorto"/>
  <xsl:text> </xsl:text>
  <xsl:number format="A"/>
</xsl:template>

<xsl:template match="kap" mode="kapvorto">
  <xsl:apply-templates select="var|tld|rad|text()" mode="kapvorto"/>
</xsl:template>

<xsl:template match="tld" mode="kapvorto">
  <xsl:value-of select="@lit"/>
  <xsl:text>~</xsl:text>
</xsl:template>



</xsl:stylesheet>












