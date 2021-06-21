<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 1999-2020 ĉe Wolfram Diestel laŭ GPLv2

reguloj por prezentado de referencoj/tezauro-ligo

-->

<!--

tio uzas XSLT 2.0 funkcion "replace". Tio kaŭzas ekz. problemon en revotxt.xsl
pro krei DICT-version. Do inkludu tion anstataŭe en la plej supra
transformdosiero, ekz. revohtml.xsl

<xsl:include href="inx_kodigo.inc"/>
-->

<xsl:template match="sncref">
  <!-- Se ne ekzistas la XML-dosiero, la tuta transformado fiaskas cxe
  xt -->
  <xsl:variable name="ref" select="(@ref|ancestor::ref/@cel)[last()]"/>
  <sup><i>
    <xsl:choose>
      <xsl:when test="substring-before($ref,'.') = substring-before(ancestor::node()[@mrk][1]/@mrk,'.')">
        <xsl:apply-templates mode="number-of-ref-snc"
          select="//node()[@mrk=$ref]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="number-of-ref-snc"
          select="document(concat(substring-before(
              $ref,'.'),'.xml'),/)//node()[@mrk=$ref]"/>
      </xsl:otherwise>
    </xsl:choose>
  </i></sup>
</xsl:template>


<xsl:template name="reftip">
  <xsl:choose>
    <xsl:when test="@tip='vid'">
      <xsl:text>VD:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='dif'">
      <xsl:text>=</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='sin'">
      <xsl:text>SIN:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='ant'">
      <xsl:text>ANT:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='super'">
      <xsl:text>SUP:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='sub'">
      <xsl:text>SUB:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='prt'">
      <xsl:text>PRT:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='malprt'">
      <xsl:text>TUT:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='hom'">
      <xsl:text>HOM:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='lst'">
      <xsl:text>LST:</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='ekz'">
      <xsl:text>EKZ:</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template name="reftitle">
  <xsl:choose>
    <xsl:when test="@tip='vid'">
      <xsl:text>vidu</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='dif'">
      <xsl:text>difino ĉe</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='sin'">
      <xsl:text>sinonimo</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='ant'">
      <xsl:text>antonimo</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='super'">
      <xsl:text>supernocio</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='sub'">
      <xsl:text>subnocio</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='prt'">
      <xsl:text>parto</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='malprt'">
      <xsl:text>parto de</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='hom'">
      <xsl:text>homonimo</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='lst'">
      <xsl:text>listo</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='ekz'">
      <xsl:text>ekzemplo</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template match="refgrp">
  <xsl:choose>

    <xsl:when test="$aspekto='ilustrite'">
      <img src="{$smbdir}/{@tip}.gif">
        <xsl:attribute name="alt">
          <xsl:call-template name="reftip"/>
        </xsl:attribute>
        <xsl:attribute name="title">
	  <xsl:call-template name="reftitle"/>
	</xsl:attribute>	
      </img>
    </xsl:when>

    <xsl:otherwise>
      <xsl:call-template name="reftip"/>
    </xsl:otherwise>
 
  </xsl:choose>
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="ref">
  <xsl:choose>

    <xsl:when test="$aspekto='ilustrite'">
      <xsl:if test="@tip">
        <img src="{$smbdir}/{@tip}.gif">
          <xsl:attribute name="alt">
            <xsl:call-template name="reftip"/>
          </xsl:attribute>
          <xsl:attribute name="title">
	    <xsl:call-template name="reftitle"/>
	  </xsl:attribute>
        </img> 
      </xsl:if>
    </xsl:when>

    <xsl:otherwise>
      <xsl:call-template name="reftip"/>
    </xsl:otherwise>

  </xsl:choose>

  <xsl:variable name="file" select="substring-before(@cel,'.')"/>
  <span class="ref">

    <xsl:choose>
 
      <xsl:when test="$file">
        <a class="ref" href="{$file}.html#{$file}.{substring-after(@cel,'.')}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>

      <xsl:otherwise>
        <a class="ref" href="{@cel}.html">
          <xsl:apply-templates/>
        </a>
      </xsl:otherwise>

    </xsl:choose>
  </span>
</xsl:template>


<xsl:template match="lstref">
    <xsl:variable name="kls" select="(document($klasoj_cfg)/klasoj//kls[substring-after(@nom,'#')=substring-after(current()/@lst,':')])[1]"/>

    <xsl:text> </xsl:text>
      <a target="indekso" class="ref">
        <xsl:attribute name="href">
          <xsl:text>../tez/vx_</xsl:text>
          <xsl:choose>
            <xsl:when test="$kls[@prezento='integrita']">
               <xsl:call-template name="eo-kodigo">
                 <xsl:with-param name="str"><xsl:value-of
		 select="substring-after($kls/../@nom,'#')"/></xsl:with-param>
               </xsl:call-template>
               <xsl:text>.html#</xsl:text>
               <xsl:call-template name="eo-kodigo">
                 <xsl:with-param name="str"><xsl:value-of
		 select="substring-after(@lst,':')"/></xsl:with-param>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="eo-kodigo">
                <xsl:with-param name="str"><xsl:value-of select="substring-after(@lst,':')"/></xsl:with-param>
              </xsl:call-template>
              <xsl:text>.html</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <img src="{$smbdir}/listo.gif" border="0"/>
        <xsl:apply-templates/>
      </a>
</xsl:template>

<xsl:template match="
  dif/ref|
  dif/refgrp/ref|
  rim/ref|
  rim/refgrp/ref|
  ekz/ref|
  ekz/refgrp/ref|
  klr/ref|
  klr/refgrp/ref">

  <xsl:variable name="file" select="substring-before(@cel,'.')"/>
  <xsl:choose>
    <xsl:when test="$file">
      <a class="{local-name((ancestor::rim|ancestor::ekz|ancestor::dif)[last()])}" 
         href="{$file}.html#{$file}.{substring-after(@cel,'.')}">
      <xsl:apply-templates/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <a class="{local-name((ancestor::rim|ancestor::ekz|ancestor::dif)[last()])}" href="{@cel}.html">
      <xsl:apply-templates/>
      </a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="
  dif/refgrp|
  rim/refgrp|
  ekz/refgrp|
  klr/refgrp">

  <span class="{local-name((ancestor::rim|ancestor::ekz|ancestor::dif)[last()])}"> 
   <xsl:apply-templates/>
  </span>
</xsl:template>

</xsl:stylesheet>












