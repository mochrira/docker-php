<?php

require 'vendor/autoload.php';

echo getenv('PRODUCTION');
echo getenv('BASE_URL');

Selvi\Route::get('/rewrite', function () {
    echo 'Rewrite works perfectly'; 
});
Selvi\Framework::run();