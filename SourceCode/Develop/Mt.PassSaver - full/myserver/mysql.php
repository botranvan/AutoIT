<?php
$db_host = "localhost"; // co the thay doi hoac giu~ nguyen
$db_name    = 'your_database_name';// Can thay doi
$db_username    = 'your_database_username'; //Can thay doi
$db_password    = 'your_database_password';//Can thay doi
@mysql_connect("{$db_host}", "{$db_username}", "{$db_password}") or die("yes");
@mysql_select_db("{$db_name}") or die("no");
?>