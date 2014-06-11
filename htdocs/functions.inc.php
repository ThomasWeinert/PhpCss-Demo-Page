<?php

function getHtml($selector, $options) {
   try {
    $ast = PhpCss::getAst($selector);
    $visitor = new PhpCss\Ast\Visitor\Explain($options);
    $ast->accept($visitor);
    $xml = new DOMDocument();
    $xml->loadXml((string)$visitor);
    $xsl = new DOMDocument();
    $xsl->load(__DIR__.'/explaincss.xsl');
    $xslt = new XSLTProcessor();
    $xslt->importStylesheet($xsl);
    return $xslt->transformToXml($xml);
  } catch (Exception $e) {
    return '';
  }
}