<?php
error_reporting(E_ALL);
header("Expires: ".date(DATE_ISO8601, time() + 86400 * 7));
require(__DIR__.'/../vendor/autoload.php');
$selector = empty($_GET['selector']) ? '' : trim($_GET['selector']);
$expression = '';
$checkboxes = [
   PhpCss\Ast\Visitor\Xpath::OPTION_EXPLICT_NAMESPACES => 'Explicit namespaces',
   PhpCss\Ast\Visitor\Xpath::OPTION_DEFAULT_NAMESPACE => 'Default namespace',
   PhpCss\Ast\Visitor\Xpath::OPTION_USE_DOCUMENT_CONTEXT => 'Document context',
   PhpCss\Ast\Visitor\Xpath::OPTION_LOWERCASE_ELEMENTS => 'Lowercase elements',
   PhpCss\Ast\Visitor\Xpath::OPTION_XML_ATTRIBUTES => 'Xml attributes'
];
$bitmask = 0;
if (isset($_GET['options']) && is_array($_GET['options'])) {
  foreach ($_GET['options'] as $bit) {
    $bitmask |= $bit;
  }
}
$error = NULL;
try {
  $ast = PhpCss::getAst($selector);
  $visitor = new PhpCss\Ast\Visitor\Explain($bitmask);
  $ast->accept($visitor);
  $xml = (string)$visitor;
} catch (Exception $e) {
  $error = $e;
}

header("Content-Type: text/xml; charset=utf-8");
echo $xml;

