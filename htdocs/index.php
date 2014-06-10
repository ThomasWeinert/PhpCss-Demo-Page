<?php
  error_reporting(E_ALL);
  header("Expires: ".date(DATE_ISO8601, time() + 86400 * 7));
  header("Content-Type: text/html; charset=utf-8");
?>
<!DOCTYPE html>
<html>
<head>
  <title>PhpCSS Demo Page</title>
  <link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<?php
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
  $expression = PhpCss::toXpath($selector, $bitmask);
} catch (Exception $e) {
  $error = $e;
}
?>
<body>
  <section id="form">
    <h1>Convert CSS 3 Selectors to Xpath</h1>
    <p>
      This is a little demonstration for the <a href="https://github.com/ThomasWeinert/PhpCss">PhpCss library</a>.
      It parses CSS 3 selectors and converts them into Xpath expressions. It has full support for CSS 3,
      except for selectors that depend on user interaction (:hover) or do not return a node (:first-line).
    </p>
    <p>
      The target of this library is to create working expressions for any CSS selector.
      The expressions are not optimized in any way. Creating them manually will result
      in expressions that are a lot easier to read.
    </p>
    <p>
      <h3>Examples:</h3>
      <ul>
        <li><a href="?selector=table%23data+tr%3Anth-of-type%282n%2B3%29%3Anot%28.subheader%29&options[1]=1&options[4]=4">table#data tr:nth-of-type(2n+3):not(.subheader)</a></li>
        <li><a href="?selector=atom|entry+>+atom|link[rel%3Dalternate][type%3D&quot;text%2Fhtml&quot;]">atom|entry > atom|link[rel=alternate][type="text/html"]</a></li>
      </ul>
    </p>
    <form action="./" method="get">
      <fieldset>
        <input type="text" name="selector" placeholder="CSS 3 Selector" value="<?php echo htmlspecialchars($selector); ?>">
        <button type="submit">Convert</button>
        <div id="options">
          <?php
            foreach ($checkboxes as $value => $caption) {
              $selected = isset($_GET['options'][$value]) ? ' checked' : '';
              printf(
                '<span>
                  <input type="checkbox" name="options[%1$d]" value="%1$d" id="option%1$d"%3$s>
                  <label for="option%1$d">%2$s</label>
                </span>',
                (int)$value,
                htmlspecialchars($caption),
                $selected
              );
            }
          ?>
        </div>
      </fieldset>
    </form>
  </section>
  <?php
    if (!empty($error)) {
  ?>
  <section id="message">
    <h2><?php echo htmlspecialchars(get_class($error)); ?></h2>
    <p><?php echo htmlspecialchars($error->getMessage()); ?></p>
    <?php
      $showError = FALSE;
      if ($error instanceof PhpCss\Exception\InvalidCharacter) {
        $showError = TRUE;
        $before = substr($error->getBuffer(), 0, $error->getOffset());
        $char = $error->getChar();
        $after = substr($error->getBuffer(), $error->getOffset() + strlen($char));
      } elseif ($error instanceof PhpCss\Exception\Token) {
        $showError = TRUE;
        $token = $error->getToken();
        $before = substr($selector, 0, $token->position);
        $char = $token->content;
        $after = substr($selector, $token->position + $token->length);
      }

      if ($showError) {
        echo '<div class="selector">';
        if (!empty($before)) {
          echo '<span>'.htmlspecialchars($before).'</span>';
        }
        echo '<span class="error">'.htmlspecialchars($char).'</span>';
        if (!empty($after)) {
          echo '<span>'.htmlspecialchars($after).'</span>';
        }
        echo '</div>';
      }
    ?>
  </section>
  <?php
    }
    if (empty($error) && !empty($selector)) {
      $queryString = empty($_SERVER['QUERY_STRING']) ? '' : $_SERVER['QUERY_STRING'];
  ?>
  <section id="expression">
    <a href="xml.php?<?php echo htmlspecialchars($queryString)?>"><button>XML</button></a>
    <h2>Xpath expression</h2>
    <textarea><?php echo htmlspecialchars($expression); ?></textarea>
  </section>
  <?php
    }
  ?>
  <a href="https://github.com/ThomasWeinert/PhpCss"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>
  <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-8203217-3', 'weinert.info');
    ga('send', 'pageview');

  </script>
</body>
</html>