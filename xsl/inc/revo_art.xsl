<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 1999-2020 ĉe Wolfram Diestel  laŭ GPLv2

reguloj por la prezentado de la artikolostrukturo
uzata kun XSLT1-transformilo

-->

<!-- kruda artikolstrukturo -->

<xsl:template match="/">
  <html lang="eo">
    <head>
      <meta charset="utf-8"/>
      <meta name="viewport" content="width=device-width,initial-scale=1"/>
      <xsl:if test="//frm[@am]">
        <script type="text/javascript" async="async" src="{$mathjax-url}"></script>
      </xsl:if>
      <xsl:if test="$aspekto='ilustrite'">
      	<link title="artikolo-stilo" type="text/css" rel="stylesheet" href="{$cssdir}/{$art-css}" />
      </xsl:if>
      <title><xsl:apply-templates select="//art/kap[1]" mode="titolo"/></title>
      <script type="text/javascript">
	<xsl:text>&lt;!--
	top.document.title = 'Reta Vortaro [</xsl:text>
	<xsl:value-of select="normalize-space(//art/kap[1])"/>
	<xsl:text>]';
	</xsl:text>
	<xsl:text>//--&gt;</xsl:text>
      </script>
      <script src="{$jscdir}/{$art-jsc}"></script> 
     
    </head>
    <body>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

<xsl:template match="art/kap" mode="titolo">
  <xsl:apply-templates select="rad|text()"/>
</xsl:template>


<!-- art, subart -->

<xsl:template match="art">
  <header>
    <!-- flagoj de la tradukoj 
    <xsl:if test="$aspekto='ilustrite'">
      <xsl:call-template name="flagoj"/>
    </xsl:if>
    -->
  </header>

  <article>
      <section id="s_artikolo" class="art">
      <xsl:choose>

        <!-- se enestas subartikoloj aŭ rekte sencoj prezentu per dl-listo -->
        <xsl:when test="subart|snc">
          <xsl:apply-templates select="kap"/>
          <dl>
            <xsl:apply-templates select="node()[not(self::kap)]"/>
          </dl>
        </xsl:when>

        <!-- prezentu la derivaĵojn ktp. -->
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>

      </xsl:choose>

      <!-- fontindikoj, kiuj ne troviĝas ene de drv, t.e. ekz-e en art/kap-->
      <xsl:call-template name="fontoj-art"/>
    </section>

    <!-- prezentu tradukojn en propra alineo 
    <section class="tradukoj">
      <xsl:call-template name="tradukoj"/>
    </section>
    -->

    <!-- prezentu fontoreferencojn en propra alineo - ->
    <section class="fontoj">
      <xsl:call-template name="fontoj"/>
    </section -->

    <!-- administraj notoj -->
    <section class="admin">
      <xsl:call-template name="admin"/>
    </section>

  </article>

  <!-- piedlinio -->
  <footer>
    <hr />
    <xsl:call-template name="redakto"/>
  </footer>
</xsl:template>


<!-- subartikolo -->

<xsl:template match="subart">
  <dt class="subart">
    <xsl:if test="@mrk">
      <xsl:attribute name="id">
        <xsl:value-of select="@mrk"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:number format="I."/>
  </dt>
  <dd>
    <section class="subart">
      <div>
        <xsl:choose>

          <xsl:when test="snc">
            <xsl:apply-templates select="kap"/>
            <div class="subart-enh">
              <dl>
                <xsl:apply-templates select="node()[not(self::kap)]"/>
              </dl>
              <xsl:call-template name="fontoj"/>
            </div>
          </xsl:when>

          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>

        </xsl:choose>

        <!-- KONTROLU: eble tio ne estas tute ĝusta, ĉar se aperas kaj drv/trd(grp) kaj subart/trd(grp)
            ni eble duobligus ilin tiel. Do tiuokaze eble ni havu duan transformregulon
            tradukoj-subart, kiu traktas nur ĉi-lastajn -->
        <xsl:if test="trd|trdgrp|snc/trd|snc/trdgrp">
          <xsl:call-template name="tradukoj"/>
        </xsl:if>
      </div>
    </section>
  </dd>
</xsl:template> 


<!-- derivajhoj -->

<xsl:template match="drv">
  <!-- xsl:apply-templates select="tez" mode="ref"/ -->
  <section class="drv">
    <xsl:apply-templates select="kap"/>
    <div class="kasxebla">
      <div class="drv-enh">
        <xsl:apply-templates select="gra|uzo|fnt|dif|ref[@tip='dif']"/>
        <dl>
          <xsl:apply-templates select="subdrv|snc"/>
        </dl>  
        <xsl:apply-templates
          select="node()[
            not(
              self::subdrv|
              self::snc|
              self::trd|
              self::trdgrp|
              self::gra|
              self::uzo|
              self::fnt|
              self::kap|
              self::dif|
              self::mlg|
              self::ref[@tip='dif'])]"/>
        <xsl:call-template name="fontoj"/>
      </div> <!-- drv-enh -->
      <xsl:call-template name="tradukoj"/>
    </div> <!-- kasxebla -->
  </section>
</xsl:template>  
	

<!-- subderivajho -->

<xsl:template match="subdrv">
  <dt>
    <xsl:if test="@mrk">
      <xsl:attribute name="id">
        <xsl:value-of select="@mrk"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:number format="A."/>

    <!-- tezauroligo 
    <xsl:comment>[[
      ref="<xsl:value-of select="ancestor::drv/@mrk"/><xsl:number format="A"/>"
    ]]</xsl:comment> -->

  </dt>

  <dd>
    <xsl:apply-templates select="dif|gra|uzo|fnt|ref[@tip='dif']"/>

    <dl>
      <xsl:apply-templates select="snc"/>
    </dl>

    <xsl:apply-templates
      select="node()[
       not(
         self::snc|
         self::trd|
         self::trdgrp|
         self::gra|
         self::uzo|
         self::fnt|
         self::dif|
         self::ref[@tip='dif'])]"/>   
  </dd>
</xsl:template>


<!-- kapvorto de derivajho -->

<xsl:template match="drv/kap">
  <h2 id="{ancestor::drv/@mrk}">
    <xsl:apply-templates/>
    <xsl:apply-templates select="../mlg"/>

    <!-- tezauroligo 
    <xsl:comment>[[
      ref="<xsl:value-of select="ancestor::drv/@mrk"/>"
    ]]</xsl:comment> -->
  </h2>  
</xsl:template>

<!-- sencoj/subsencoj -->

<xsl:template match="subart" mode="number-of-ref-snc">
  <xsl:number from="subart" count="subart" format="I"/>
</xsl:template>

<xsl:template match="snc" mode="number-of-ref-snc">
  <xsl:number from="drv|subart" level="any" count="snc"/>
</xsl:template>

<xsl:template match="subsnc" mode="number-of-ref-snc">
  <xsl:number from="drv|subart" level="multiple" count="snc|subsnc"
    format="1.a"/>
</xsl:template>

<xsl:template match="rim" mode="number-of-ref-snc">
  rim. <xsl:value-of select="@num"/>
</xsl:template>


<xsl:template match="snc">
  <!-- xsl:apply-templates select="tez" mode="ref"/ -->

  <dt>
    <xsl:if test="@mrk">
      <xsl:attribute name="id">
        <xsl:value-of select="@mrk"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:choose>

      <xsl:when test="@ref">
        <xsl:apply-templates mode="number-of-ref-snc" select="id(@ref)"/>:
      </xsl:when>

      <xsl:when test="count(ancestor::node()[self::drv or self::subart][1]//snc)>1">
        <xsl:number from="drv|subart" level="any" count="snc" format="1."/>


    <!-- tezauroligo 
        <xsl:choose>

          <xsl:when test="@mrk">			       
            <xsl:comment>[[ref="<xsl:value-of select="@mrk"/>"]]</xsl:comment>
          </xsl:when>

          <xsl:otherwise>
            <xsl:comment>[[
              ref="<xsl:value-of select="ancestor::drv/@mrk"/>
              <xsl:number from="drv|subart" level="any" count="snc" format=".1"/>"
            ]]</xsl:comment>

          </xsl:otherwise>
        </xsl:choose> -->

      </xsl:when>

    </xsl:choose>
  </dt>

  <dd>
    <xsl:apply-templates select="gra|uzo|fnt|dif|ref[@tip='dif']"/>

    <xsl:if test="subsnc">
      <dl>
        <xsl:apply-templates select="subsnc"/>
      </dl>
    </xsl:if>

    <xsl:apply-templates
        select="node()[
          not(
           self::gra|
           self::uzo|
           self::fnt|
           self::dif|
           self::subsnc|
           self::trd|
           self::trdgrp|
           self::ref[@tip='dif'])]"/>
  </dd>
</xsl:template>  


<xsl:template match="subsnc">
  <!-- xsl:apply-templates select="tez" mode="ref"/ -->

  <dt>
    <xsl:if test="@mrk">
      <xsl:attribute name="id">
        <xsl:value-of select="@mrk"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:choose>
       <xsl:when test="@ref">
          <xsl:apply-templates mode="number-of-ref-snc" select="id(@ref)"/>:
       </xsl:when>
       <xsl:otherwise>
         <xsl:number format="a)"/>
       </xsl:otherwise>
    </xsl:choose>

    <!-- tezauroligo 
    <xsl:choose>
      <xsl:when test="@mrk">			       
        <xsl:comment>[[ref="<xsl:value-of select="@mrk"/>"]]</xsl:comment>
      </xsl:when>

      <xsl:otherwise>
        <xsl:comment>[[
          ref="<xsl:value-of select="ancestor::drv/@mrk"/>
          <xsl:number format="a"/>"
        ]]</xsl:comment>
      </xsl:otherwise>

    </xsl:choose> -->
  </dt>
  <dd>
  <xsl:apply-templates/>
  </dd>
</xsl:template>

<!--
<xsl:template name="tezauro">
  <xsl:if test="@tez">
    &#xa0;<a href="{@tez}" class="tez-ref" target="indekso" title="al la teza&#x016d;ro">&#x219D;</a>

  </xsl:if>
</xsl:template>
-->

<xsl:template match="text()">
  <xsl:value-of select="."/>
</xsl:template>


</xsl:stylesheet>














