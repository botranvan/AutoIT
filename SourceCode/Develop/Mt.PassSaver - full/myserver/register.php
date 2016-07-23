<?php
require_once("mysql.php");
$date = date(" d m Y");
@$a=mysql_query("INSERT INTO member (username, password,time) VALUES ('{$HTTP_GET_VARS["username"]}','{$HTTP_GET_VARS["password"]}','{$date}')");
?>