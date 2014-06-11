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

  <xsl:template match="css:pseudoclass[css:parameter]">
    <span>
      <a
        title="Pseudo-Class"
        class="pseudoclass"
        href="http://www.w3.org/TR/css3-selectors/#pseudo-classes"
        target="_blank">
        <xsl:apply-templates select="css:name/node()" />
      </a>
      <xsl:text>(</xsl:text>
        <xsl:apply-templates select="css:parameter/node()" />
      <xsl:text>)</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="css:pseudoclass[not(css:parameter)]">
    <a
      title="Pseudo-Class"
      class="pseudoclass"
      href="http://www.w3.org/TR/css3-selectors/#pseudo-classes"
      target="_blank">
      <xsl:apply-templates select="css:name/node()" />
    </a>
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


  <xsl:template match="css:pseudoclass[css:name = ':not']">
    <span>
      <a
        title="Negation Pseudo-Class"
        class="pseudoclass negation"
        href="http://www.w3.org/TR/css3-selectors/#negation"
        target="_blank">
        <xsl:apply-templates select="css:name/node()" />
      </a>
      <xsl:text>(</xsl:text>
        <xsl:apply-templates select="css:parameter/node()" />
      <xsl:text>)</xsl:text>
    </span>
  </xsl:template>

</xsl:stylesheet>