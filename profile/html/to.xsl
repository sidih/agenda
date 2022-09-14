<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
  
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>
   
   <!--<xsl:param name="graphicsPrefix">../</xsl:param>-->
   
   <xsl:param name="homeLabel">SI-DIH</xsl:param>
   <xsl:param name="homeURL">https://sidih.si/20.500.12325/120</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <xsl:param name="documentationLanguage">en</xsl:param>
   
   <xsl:param name="languages-locale">true</xsl:param>
   <xsl:param name="languages-locale-primary">en</xsl:param>
   
   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"></xsl:param>
   <xsl:param name="numberFrontTables"></xsl:param>
   <xsl:param name="numberHeadings"></xsl:param>
   <xsl:param name="numberParagraphs">true</xsl:param>
   <xsl:param name="numberTables"></xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description"></xsl:param>
   <xsl:param name="keywords"></xsl:param>
   <xsl:param name="title"></xsl:param>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css Hook dodam še nokaj projektno specifičnih CSS</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"  rel="stylesheet" type="text/css" />
      <!-- dodan imageViewer -->
      <link href="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.css')}"  rel="stylesheet" type="text/css" />
      <!-- dodam za povezave na same sebe -->
      <style>
         .selflink:hover { opacity: 0.5;}
         .keywordlink:hover { opacity: 0.5;}
         .numberParagraphLink {text-decoration: none;}
         .numberParagraph:hover {color: black;}
      </style>
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"></script>
      <!-- za highcharts -->
      <xsl:if test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile" select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"></script>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan imageViewer -->
      <script src="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.js')}"></script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Slike, ki imajo vključeno možnost povečanja slike z imageviewer</desc>
   </doc>
   <xsl:template match="tei:figure">
      <xsl:variable name="image-file-name" select="tokenize(tei:graphic/@url,'/')[last()]"/>
      <xsl:variable name="height" select="if (tei:graphic/@height) then 'max' else ',600'"/>
      <figure id="{@xml:id}">
         <img class="imageviewer" src="{concat('https://sidih.si/iiif/2/entity|2001-3000|2177|',$image-file-name,'/full/',$height,'/0/default.jpg')}" data-high-res-src="{concat('https://sidih.si/cdn/2177/',$image-file-name)}" alt="{normalize-space(tei:head)}"/>
         <figcaption>
            <xsl:apply-templates select="tei:head"/>
         </figcaption>
      </figure>
      <br/>
      <br/>
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>Dodam zaključni javascript za ImageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="bodyEndHook">
      <script type="text/javascript">
         
         $(function () {
         var viewer = ImageViewer();
         $('.imageviewer').click(function () {
         var imgSrc = this.src,
         highResolutionImage = $(this).data('high-res-src');
         viewer.show(imgSrc, highResolutionImage);
         });
         });
      </script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/what-input.js')}"></script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/foundation.min.js')}"></script>
      <script src="{concat($path-general,'themes/foundation/6/js/app.js')}"></script>
      <!-- back-to-top -->
      <script src="{concat($path-general,'themes/js/plugin/back-to-top/back-to-top.js')}"></script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiranje specifilnih vsebinskih sklopov</desc>
   </doc>
   <xsl:template match="tei:note[@rend='bluebox']">
      <div id="{@xml:id}" class="callout warning">
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>How to number paragraphs: ga bom predrogačil na način, da bo omogočil linke na samega sebe</desc>
   </doc>
   <xsl:template name="numberParagraph">
      <xsl:choose>
         <xsl:when test="@xml:id and $numberParagraphs='true'">
            <!-- dodam zunanji span in nato a -->
            <span>
               <a href="#{@xml:id}" title="number paragraph link" class="numberParagraphLink">
                  <span class="numberParagraph">
                     <xsl:number/>
                  </span>
               </a>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="numberParagraph">
               <xsl:number/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>video prikaz</desc>
   </doc>
   <xsl:template match="tei:graphic[@mimeType='video/mp4']">
      <video width="420" height="345" controls="">
         <source src="{@url}" type="video/mp4"/>
         Your browser does not support the video tag.
      </video>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:quote">
      <xsl:choose>
         <!-- Če ni znotraj odstavka -->
         <xsl:when test="not(ancestor::tei:p)">
            <blockquote>
               <xsl:choose>
                  <xsl:when test="@xml:id and not(parent::tei:cit[@xml:id])">
                     <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                     </xsl:attribute>
                  </xsl:when>
                  <xsl:when test="parent::tei:cit[@xml:id]">
                     <xsl:attribute name="id">
                        <xsl:value-of select="parent::tei:cit/@xml:id"/>
                     </xsl:attribute>
                  </xsl:when>
               </xsl:choose>
               <xsl:apply-templates/>
               <!-- glej spodaj obrazložitev pri procesiranju elementov cit -->
               <!-- sem preuredil originalno pretvorbo in odstranil pogoj parent::tei:cit/tei:bibl/tei:author -->
               <xsl:if test="parent::tei:cit/tei:bibl">
                  <!-- odstranil na koncu parent::tei:cit/tei:bibl/tei:author -->
                  <xsl:for-each select="parent::tei:cit/tei:bibl">
                     <cite>
                        <xsl:apply-templates/>
                     </cite>
                  </xsl:for-each>
               </xsl:if>
            </blockquote>
         </xsl:when>
         <!-- Če pa je znotraj odstavka, ga damo samo v element q, se pravi v narekovaje. -->
         <xsl:otherwise>
            <q>
               <xsl:apply-templates/>
            </q>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!-- Če je naveden tudi avtor citata, damo predhodno element quote v parent element cit
         in mu dodamo še sibling element bibl
    -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Preuredim template iz tei:bibl[tei:author] v tei:cit/tei:bibl</desc>
   </doc>
   <xsl:template match="tei:cit/tei:bibl">
      <!-- ta element pustimo prazen,ker ga procesiroma zgoraj v okviru elementa quote -->
   </xsl:template>
   
   <!-- KAZALO SLIK -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Odstranil procesiranje tei:figure[@type='table']</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="images">
      <xsl:param name="thisLanguage"/>
      <!-- izpiše vse slike -->
      <ul class="circel">
         <xsl:for-each select="//tei:figure[if ($languages-locale='true') then ancestor::tei:div[@xml:id][@xml:lang=$thisLanguage] else @xml:id][tei:graphic][not(@type='chart')][not(@type='table')]">
            <xsl:variable name="figure-id" select="@xml:id"/>
            <xsl:variable name="image-chapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>
            <xsl:variable name="sistoryPath">
               <xsl:if test="$chapterAsSIstoryPublications='true'">
                  <xsl:call-template name="sistoryPath">
                     <xsl:with-param name="chapterID" select="$image-chapter-id"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:variable>
            <li>
               <a href="{concat($sistoryPath,$image-chapter-id,'.html#',$figure-id)}">
                  <!-- V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe -->
                  <xsl:apply-templates select="tei:head" mode="slika"/>
               </a>
            </li>
         </xsl:for-each>
      </ul><!-- konec procesiranja slik -->
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe</desc>
   </doc>
   <xsl:template match="tei:head" mode="slika">
      <xsl:apply-templates mode="slika"/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe</desc>
   </doc>
   <xsl:template match="tei:note" mode="slika">
      
   </xsl:template>
   
   <!-- KAZALO TABEL -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Namesto tei:table procesira tei:figure[@type='table']</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="tables">
      <xsl:param name="thisLanguage"/>
      <!-- izpiše vse tabele, ki imajo naslov (s tem filtriramo tiste tabele, ki so v okviru grafikonov) -->
      <ul class="circel">
         <xsl:for-each select="//tei:figure[@type='table'][if ($languages-locale='true') then ancestor::tei:div[@xml:id][@xml:lang=$thisLanguage] else @xml:id][tei:head]">
            <xsl:variable name="table-id" select="@xml:id"/>
            <xsl:variable name="table-chapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>
            <xsl:variable name="sistoryPath">
               <xsl:if test="$chapterAsSIstoryPublications='true'">
                  <xsl:call-template name="sistoryPath">
                     <xsl:with-param name="chapterID" select="$table-chapter-id"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:variable>
            <li>
               <a href="{concat($sistoryPath,$table-chapter-id,'.html#',$table-id)}">
                  <!-- V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe -->
                  <xsl:apply-templates select="tei:head" mode="slika"/>
               </a>
            </li>
         </xsl:for-each>
      </ul><!-- konec procesiranja slik -->
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> NASLOVNA STRAN </xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <!-- avtor -->
      <!--<p  class="naslovnicaAvtor">
         <xsl:for-each select="tei:docAuthor">
            <xsl:choose>
               <xsl:when test="tei:forename or tei:surname">
                  <xsl:for-each select="tei:forename">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="tei:surname">
                     <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:for-each select="tei:surname">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>
      <br/>
      <!-\- naslov: spremenjeno procesiranje naslovov -\->
      <xsl:for-each select="tei:docTitle/tei:titlePart[@xml:lang='en']">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
      </xsl:for-each>
      <hr/>
      <xsl:for-each select="tei:docTitle/tei:titlePart[@xml:lang='sl']">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
      </xsl:for-each>
      <br/>
      <xsl:if test="tei:figure">
         <div class="text-center">
            <p>
               <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
            </p>
         </div>
      </xsl:if>-->
      <xsl:if test="tei:graphic">
         <div class="text-center">
            <p>
               <img src="{tei:graphic/@url}" alt="naslovna slika" style="max-height: 800px;"/>
            </p>
         </div>
      </xsl:if>
      <!--<br/>
      <p class="text-center">
         <!-\- založnik -\->
         <xsl:for-each select="tei:docImprint/tei:publisher">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-\- kraj izdaje -\->
         <xsl:for-each select="tei:docImprint/tei:pubPlace">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-\- leto izdaje -\->
         <xsl:for-each select="tei:docImprint/tei:docDate">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
      </p>-->
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodatno za kolofon: procesiranje idno</desc>
   </doc>
   <xsl:template match="tei:publicationStmt" mode="kolofon">
      <xsl:apply-templates select="tei:publisher" mode="kolofon"/>
      <xsl:apply-templates select="tei:date" mode="kolofon"/>
      <xsl:apply-templates select="tei:pubPlace" mode="kolofon"/>
      <xsl:apply-templates select="tei:availability" mode="kolofon"/>
      <xsl:apply-templates select="tei:idno" mode="kolofon"/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:idno" mode="kolofon">
      <p>
         <xsl:choose>
            <xsl:when test="matches(.,'https?://')">
               <a href="{.}">
                  <xsl:value-of select="."/>
               </a>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(@type,' ',.)"/>
            </xsl:otherwise>
         </xsl:choose>
      </p>
   </xsl:template>
   
</xsl:stylesheet>
