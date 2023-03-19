<?php

require 'vendor/autoload.php';

Selvi\Route::get('/rewrite', function () {
    echo 'Rewrite works perfectly'; 
});
Selvi\Framework::run();