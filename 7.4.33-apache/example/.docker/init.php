<?php 
$output = shell_exec('php index.php migrate main up');
echo $output;
?>