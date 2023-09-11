<?php 

if(isset($_FILES['file'])) {
    $file = $_FILES['file'];
    $dest = __DIR__.'/uploads';
    if(!is_dir($dest)) mkdir($dest);
    $dest_file = $dest.'/'.basename($file['name']);
    move_uploaded_file($file['tmp_name'], $dest_file);
    die();
}

?>

<form action="index.php" method="POST" enctype="multipart/form-data">
    <input type="file" name="file" />
    <button type="submit">Submit</button>
</form>