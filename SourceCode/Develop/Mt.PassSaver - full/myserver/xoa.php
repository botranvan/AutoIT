<?php
require_once("mysql.php");
@$a=mysql_query("DELETE From member where username='{$HTTP_GET_VARS["user"]}'");
echo "Da xoa: {$HTTP_GET_VARS['user']}";
?>