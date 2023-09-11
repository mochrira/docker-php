<?php 

require('vendor/autoload.php');
Selvi\Uri::setBaseUrl('http://localhost:9000/selvi-framework/');

Selvi\Route::get('/rewrite', function () {
    echo '<h1>rewrite works !</h1>';
});

Selvi\Framework::run();