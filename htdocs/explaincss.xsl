<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:css="urn:carica-phpcss-explain-2014"
  exclude-result-prefixes="css">

  <xsl:template match="/">
    <div class="selector-group">
      <xsl:apply-templates select="css:selector-group/node()" />
    </div>
  </xsl:template>

  <xsl:template match="css:type">
    <a
      class="simpleselector type"
      title="Type Selector"
      href="http://www.w3.org/TR/css3-selectors/#type-selectors"
      target="_blank">
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <xsl:template match="css:universal">
    <a
      class="simpleselector universal"
      title="Universal Selector"
      href="http://www.w3.org/TR/css3-selectors/#universal-selector"
      target="_blank">
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <xsl:template match="css:class">
    <a
      title="Class Selector"
      class="simpleselector class"
      href="http://www.w3.org/TR/css3-selectors/#class-html"
      target="_blank">
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <xsl:template match="css:id">
    <a
      title="ID Selector"
      class="simpleselector id"
      href="http://www.w3.org/TR/css3-selectors/#id-selectors"
      target="_blank">
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <xsl:template match="css:attribute">
    <a
      title="Attribute Selector"
      class="pseudoclass"
      href="http://www.w3.org/TR/css3-selectors/#attribute-selectors"
      target="_blank">
      <xsl:apply-templates />
    </a>
  </xsl:template>

  <xsl:template match="css:pseudoclass" name="pseudoclass">
    <xsl:param name="selector" select="."/>
    <xsl:param name="title">Pseudo-Class</xsl:param>
    <xsl:param name="class">pseudolass</xsl:param>
    <xsl:param name="href">http://www.w3.org/TR/css3-selectors/#pseudo-classes</xsl:param>
    <xsl:choose>
      <xsl:when test="$selector/css:parameter">
        <span>
          <a title="{$title}" class="{$class}" href="{$href}" target="_blank">
            <xsl:apply-templates select="$selector/css:name/node()" />
          </a>
          <xsl:text>(</xsl:text>
            <xsl:apply-templates select="$selector/css:parameter/node()" />
          <xsl:text>)</xsl:text>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <a title="{$title}" class="{$class}" href="{$href}" target="_blank">
          <xsl:apply-templates select="$selector/css:name/node()" />
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="css:pseudoclass[css:name = ':not']">
    <xsl:call-template name="pseudoclass">
      <xsl:with-param name="selector" select="."/>
      <xsl:with-param name="title">Negation Pseudo-Class</xsl:with-param>
      <xsl:with-param name="class">pseudoclass negation</xsl:with-param>
      <xsl:with-param name="href">http://www.w3.org/TR/css3-selectors/#negation</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="css:pseudoclass[css:name = ':lang']">
    <xsl:call-template name="pseudoclass">
      <xsl:with-param name="selector" select="."/>
      <xsl:with-param name="title">Language Pseudo-Class</xsl:with-param>
      <xsl:with-param name="class">pseudoclass language</xsl:with-param>
      <xsl:with-param name="href">http://www.w3.org/TR/css3-selectors/#lang-pseudo</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="css:pseudoclass[starts-with(css:name, ':nth-') or starts-with(css:name, ':first-') or starts-with(css:name, ':last-') or starts-with(css:name, ':only-')]">
    <xsl:call-template name="pseudoclass">
      <xsl:with-param name="selector" select="."/>
      <xsl:with-param name="title">Structural Pseudo-Class</xsl:with-param>
      <xsl:with-param name="class">pseudoclass nth</xsl:with-param>
      <xsl:with-param name="href">
        <xsl:text>http://www.w3.org/TR/css3-selectors/#</xsl:text>
        <xsl:value-of select="substring-after(css:name, ':')"/>
        <xsl:text>-pseudo</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="css:pseudoelement">
    <a
      title="Pseudo-Element"
      class="pseudoelement"
      href="http://www.w3.org/TR/css3-selectors/#pseudo-elements"
      target="_blank">
      <xsl:apply-templates select="css:name/node()" />
    </a>
  </xsl:template>

  <xsl:template match="css:child|css:next|css:follower">
    <a
      title="Combinator"
      class="combinator"
      href="http://www.w3.org/TR/css3-selectors/#combinators"
      target="_blank">
      <xsl:value-of select="./css:text"/>
    </a>
    <xsl:apply-templates select="css:selector/node()"/>
  </xsl:template>

</xsl:stylesheet>