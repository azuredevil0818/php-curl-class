<?php
require '../src/Curl.class.php';


$content = <<<EOF
<?php
echo 'hello, world';
EOF;

$curl = new Curl();
$curl->post('https://api.github.com/gists', json_encode(array(
    'description' => 'PHP-Curl-Class test.',
    'public' => 'true',
    'files' => array(
        'Untitled.php' => array(
            'content' => $content,
        ),
    ),
)));

echo 'Gist created at ' . $curl->response->html_url . "\n";
