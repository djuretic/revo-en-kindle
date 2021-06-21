<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">


<!-- (c) 1999-2020 ĉe Wolfram Diestel 
     laŭ permesilo GPL 2.0

Uzata en la retservilo por ties redaktilo (perllib/revo/xml2html.pm)

Tie ĉi troviĉas nur variabloj por agordo kaj la
importkomandoj por la unuopaj dosieroj, kie enestas la
transform-reguloj.

-->

<xsl:import href="inc/revo_trd.xsl"/>
<xsl:import href="inc/revo_fnt.xsl"/>
<xsl:import href="inc/revo_adm.xsl"/>
<xsl:import href="inc/revo_kap.xsl"/>
<xsl:import href="inc/revo_art.xsl"/>
<xsl:import href="inc/revo_ref.xsl"/>
<xsl:import href="inc/revo_dif.xsl"/>

<xsl:output method="html" version="4.0" encoding="utf-8"/>
<xsl:strip-space elements="trdgrp refgrp kap"/>

<!-- agordo-dosieroj kies enhavo estas uzata en la XSL-reguloj -->
<xsl:variable name="lingvoj_cfg" select="'../../cfg/lingvoj.xml'"/>
<xsl:variable name="klasoj_cfg" select="'../../cfg/klasoj.xml'"/>
<xsl:variable name="fakoj_cfg" select="'../../cfg/fakoj.xml'"/>
<xsl:variable name="permesoj_cfg" select="'../../cfg/permesoj.xml'"/>

<!-- padoj por referencado -->
<xsl:variable name="mathjax-url">https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=AM_CHTML</xsl:variable>
<xsl:variable name="art-css">artikolo-1b.css</xsl:variable>
<xsl:variable name="art-jsc">revo-art-1b.js</xsl:variable>

<xsl:variable name="smbdir">../smb</xsl:variable>
<xsl:variable name="xmldir">../xml</xsl:variable> 
<xsl:variable name="cssdir">/revo/stl</xsl:variable>
<xsl:variable name="jscdir">/revo/jsc</xsl:variable>

<xsl:variable name="redcgi">/cgi-bin/vokomail.pl?art=</xsl:variable>
<xsl:variable name="vivocgi">http://kono.be/cgi-bin/vivo/ViVo.cgi?tradukiReVon=</xsl:variable>
<xsl:variable name="bibliografio">../../../revo/cfg/bibliogr.xml</xsl:variable>
<xsl:variable name="bibliogrhtml">../../../revo/dok/bibliogr.html</xsl:variable>
<xsl:variable name="revo">/home/revo/revo</xsl:variable>

<xsl:variable name="arhhivo" select="'http://www.reta-vortaro.de/cgi-bin/historio.pl?art='"/>

<!-- ilustrite por HTML kun grafikoj ktp.
     simple por HTML tauga por konverto al simpla teksto -->
<xsl:variable name="aspekto" select="'ilustrite'"/>

<xsl:template name="eo-kodigo">
  <xsl:param name="str"/>
  <xsl:value-of select="$str"/> 
</xsl:template>


</xsl:stylesheet>












