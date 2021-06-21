<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 1999-2018 ĉe Wolfram Diestel

reguloj por prezentado de la administraj notoj 

-->

<!-- vokata por prezenti la administrajn notojn fine de la artikolo -->

<xsl:template name="admin">
  <!-- xsl:if test="//adm" -->
    <hr />
    <div class="notoj">
      <h2>administraj notoj</h2>
      <div class="kasxebla">
        <xsl:apply-templates select="//adm" mode="admin"/>
        <xsl:call-template name="mankoj"/>
      </div>
    </div>
  <!-- /xsl:if -->

</xsl:template>

<!-- ne montru administrajn notojn rekte en la teksto -->

<xsl:template match="adm"/>

<!-- administraj notoj -->

<xsl:template match="adm" mode="admin">

  <!-- eltrovu la kapvorton de la administra noto -->
  <b>pri 
  <a href="#{ancestor::node()[@mrk][1]/@mrk}">
    <xsl:apply-templates 
      select="ancestor::node()[
        self::drv or 
        self::snc or 
        self::subsnc or
        self::subdrv or 
        self::subart or 
        self::art][1]"
      mode="kapvorto"/>
  </a>
  <xsl:text>: </xsl:text>
  </b>

  <!-- la administra noto mem -->
  <pre>
    <xsl:apply-templates mode="admin"/>
  </pre>
</xsl:template>


<!-- la autoro de la redakta noto -->

<xsl:template match="aut" mode="admin">
  <xsl:text>[</xsl:text>
    <xsl:apply-templates/>
  <xsl:text>]</xsl:text>
</xsl:template>

<!-- redakto-ligo fine de la pagxo  -->

<xsl:template name="redakto">
  <span class="redakto">

    <xsl:choose>
      <xsl:when test="$aspekto='ilustrite'">
        <xsl:variable name="xml"
          select="substring-before(substring-after(@mrk,'$Id: '),',v')"/>

	        <a class="redakto" title="al la enirpaĝo" 
  	          href="../index.html" target="_top">&#x211B;evo</a> |
	        <a class="redakto" title="Datumprotekta deklaro" 
              href="../dok/datumprotekto.html">datumprotekto</a> |	  
          <a class="redakto" target="_new" title="fontoteksto de la artikolo"
              href="{$xmldir}/{$xml}"><xsl:value-of select="$xml"/></a> |
          <a class="redakto" title="al la redaktilo"
              href="{$redcgi}{substring-before($xml,'.xml')}">redakti...</a> |
          <a class="redakto" target="_new" title="ViVo-tradukilo" 
              href="{$vivocgi}{substring-before($xml,'.xml')}.html">traduki...</a> |
          <a class="redakto" target="_new" title="al la artikolohistorio"
              href="../hst/{substring-before($xml,'.xml')}.html">artikolversio</a>:
      </xsl:when>
      <xsl:otherwise>
        <a href="../index.html">Revo</a> | artikolversio:
      </xsl:otherwise>
    </xsl:choose>
  
    <xsl:value-of 
      select="concat(
        substring-before(substring-after(@mrk,',v'),'revo'),
        substring-before(substring-after(@mrk,',v'),'afido'))"/>
  </span>
  <br />
</xsl:template>

</xsl:stylesheet>












