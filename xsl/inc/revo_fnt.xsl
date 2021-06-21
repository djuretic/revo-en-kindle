<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 199-2003 che Wolfram Diestel

reguloj por la prezentado de la fontindikoj

-->

<!-- nur mallongajn fontindikojn montru rekte en la teksto, che
     strukturitaj skribu nur numeron -->

<xsl:template match="fnt[aut|vrk|lok]" priority="1">

  <!-- la numero de la fontindiko -->
  <xsl:variable name="n">
    <xsl:number level="any" count="fnt[aut|vrk|lok]"/>
  </xsl:variable>

  <!-- la fontindiko kun ligo al la referenco malsupre de la pagxo -->
  <span class="fntref" id="ekz_{$n}">
    <xsl:text>[</xsl:text>
    <a class="{local-name((
                 ancestor::rim|
                 ancestor::ekz|
                 ancestor::bld|
                 self::node())[1])}" 
       href="#fnt_{$n}" title="vidu la fonton"><xsl:value-of select="$n"/>
    </a>
    <xsl:text>]</xsl:text>
  </span>
</xsl:template>

<!--
<xsl:template match="node()[self::ekz or self::rim]/fnt[bib]">
  <span class="fntref">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]</xsl:text>
  </span>
</xsl:template>
-->

<xsl:template match="fnt">
  <sup class="fntref"><xsl:apply-templates/>
    <xsl:if test="ancestor::kap or ancestor::drv or ancestor::snc">
      <xsl:text>&#x0a;</xsl:text>
    </xsl:if>
  </sup>
</xsl:template>

<xsl:template match="bib">
   <a class="fntref" href="{$bibliogrhtml}#{.}" target="indekso"
        title="al la bibliografio">
     <xsl:value-of select="."/> 
   </a>
</xsl:template>

<!-- #######################################
la fontoreferencoj malsupre de la derivaĵoj 
############################################ -->

<xsl:template name="fontoj">
  <!-- se enestas strukturitaj fontoj, prezentu ilin en propra alineo -->
  <xsl:if test=".//fnt[bib|aut|vrk|lok]"> 
    <div class="fontoj kasxita">
      <xsl:apply-templates select=".//fnt[aut|vrk|lok]" mode="fontoj"/>
      <!--
      <p>
        <xsl:call-template name="mankoj"/>
      </p>
      -->
    </div>
  </xsl:if>
</xsl:template>

<!-- fontindikoj ekster drv.. -->
<xsl:template name="fontoj-art">
  <!-- se enestas strukturitaj fontoj, prezentu ilin en propra alineo -->
  <xsl:if test=".//fnt[bib|aut|vrk|lok and not(ancestor::drv)]"> 
    <div class="fontoj kasxita">
      <xsl:apply-templates select=".//fnt[aut|vrk|lok and not(ancestor::drv)]" mode="fontoj"/>
    </div>
  </xsl:if>
</xsl:template>


<xsl:template match="fnt" mode="fontoj">

  <!-- la numero de la fontindiko -->
  <xsl:variable name="n">
    <xsl:number level="any" count="fnt[aut|vrk|lok]"/>
  </xsl:variable>

  <!-- la fontindiko kun ligo al la loko de la fonto en la supra
  teksto -->
  <span class="fontoj" id="fnt_{$n}">
  
    <a class="fnt" href="#ekz_{$n}" title="reiru al la ekzemplo">
      <xsl:value-of select="$n"/>
    </a>.
  
    <xsl:apply-templates mode="fontoj" select="bib|aut|vrk|lok"/>
  
  </span>
  <br />
</xsl:template>


<!-- bibliografia referenco -->

<xsl:template match="bib" mode="fontoj">

  <!-- prenu la informojn pri la bibliografiero el tiu dosiero -->
  <xsl:variable name="mll" select="."/>

  <xsl:choose>
    <xsl:when test="$aspekto='ilustrite'">
      <a class="fnt" href="{$bibliogrhtml}#{$mll}" target="indekso"
        title="al la bibliografio">
        <xsl:apply-templates mode="bibliogr"
        select="document($bibliografio)//vrk[@mll=$mll]"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates mode="bibliogr"
        select="document($bibliografio)//vrk[@mll=$mll]"/>
    </xsl:otherwise>
  </xsl:choose>

  <!-- interpunkcio -->
  <xsl:choose>
    <xsl:when test="following-sibling::lok">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:when test="following-sibling::vrk">
      <xsl:text>, </xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<!-- verko en la bibliografiero -->

<xsl:template match="vrk" mode="bibliogr">
  <xsl:apply-templates mode="bibliogr" select="aut|trd|tit"/>
</xsl:template>


<!-- autoro en la bibliografiero -->

<xsl:template match="aut" mode="bibliogr">
  <xsl:apply-templates mode="bibliogr"/>
  <xsl:choose>
    <xsl:when test="following-sibling::trd">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:when test="following-sibling::tit">
      <xsl:text>: </xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<!-- tradukinto en la bibliografiero -->

<xsl:template match="trd" mode="bibliogr">
  <xsl:text>trad. </xsl:text>
  <xsl:apply-templates mode="bibliogr"/>
  <xsl:if test="following-sibling::tit">
      <xsl:text>: </xsl:text>
  </xsl:if>
</xsl:template>


<!-- titolo en la bibliografiero -->

<xsl:template match="tit" mode="bibliogr">
  <xsl:apply-templates mode="bibliogr"/>
</xsl:template>


<!-- autoro de la fonto -->

<xsl:template match="aut" mode="fontoj">
  <xsl:apply-templates mode="fontoj"/>
  <xsl:if test="following-sibling::vrk|following-sibling::lok">
    <xsl:text>: </xsl:text>
  </xsl:if>
</xsl:template>

<!-- verko -->

<xsl:template match="vrk" mode="fontoj">
  <xsl:apply-templates mode="fontoj"/>
  <xsl:if test="following-sibling::lok">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>  


<!-- loko en la verko -->

<xsl:template match="lok" mode="fontoj">
  <xsl:apply-templates mode="fontoj"/>
</xsl:template>


<!-- referenco al la verko -->

<xsl:template match="url" mode="fontoj">
  <a class="fnturl" href="{@ref}" target="_new"
     title="al la verko">
  <xsl:apply-templates/>
  </a>
</xsl:template>


<!-- kvalito-kontrolo pri fontindikoj -->

<xsl:template name="mankoj">
  <!-- nombro da fontoj / nombro da vortaraj fontoj en art/kap -->
  <xsl:variable name="art-fnt" select="count(kap/fnt)"/>
  <xsl:variable name="art-vrtaraj">
    <xsl:for-each select="kap/fnt">
      <xsl:if test="document($bibliografio)//vrk[@mll=current()/bib
          and (@tip='vortaro' or @tip='terminaro')]">
        <xsl:text>1</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="art-vrtr" select="string-length($art-vrtaraj)"/>

  <xsl:for-each select="//drv">
    <!-- nombro da fontoj / nombro da vortaraj fontoj / nombro da
    vrk-indikoj en drv -->
    <xsl:variable name="drv-ofc" select="count(./kap/ofc)"/>
    <xsl:variable name="drv-fnt" select="count(.//fnt)"/>
    <xsl:variable name="drv-vrtaraj">
      <xsl:for-each select=".//fnt">
<!--          <xsl:variable name="tip"
			select="document($bibliografio)//vrk[@mll=current()/bib]/@tip"/> -->
        <xsl:if test="document($bibliografio)//vrk[@mll=current()/bib
                and (@tip='vortaro' or @tip='terminaro')]">
          <xsl:text>1</xsl:text>
        </xsl:if>
	    </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="drv-vrtr" select="string-length($drv-vrtaraj)"/>

    <xsl:variable name="drv-vrkaj">
      <xsl:for-each select=".//fnt">
        <xsl:if test="bib|vrk">
          <xsl:text>1</xsl:text>
        </xsl:if>
	    </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="drv-vrk" select="string-length($drv-vrkaj)"/>

      <xsl:if test="$art-fnt + $drv-fnt + $drv-ofc &lt; 1">
        <xsl:call-template name="mesagho">
          <xsl:with-param name="mesagho">
             Mankas fontindiko.
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$art-fnt + $drv-fnt + $drv-ofc = 1">
        <xsl:call-template name="mesagho">
          <xsl:with-param name="mesagho">
             Mankas dua fontindiko.
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="($art-fnt + $drv-fnt) = ($art-vrtr + $drv-vrtr)">
        <xsl:call-template name="mesagho">
          <xsl:with-param name="mesagho">
             Mankas fonto, kiu estas nek vortaro nek terminaro.
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$drv-fnt &gt; $drv-vrk">
        <xsl:call-template name="mesagho">
          <xsl:with-param name="mesagho">
             Mankas verkindiko en fonto.
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

    </xsl:for-each>

</xsl:template>

<xsl:template name="mesagho">
  <xsl:param name="mesagho"/>

  <span class="mankoj"> 
    <a href="#{@mrk}">
      <xsl:apply-templates select="." mode="kapvorto"/>
    </a>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$mesagho"/>
  </span>
  <br/>
</xsl:template>

</xsl:stylesheet>












