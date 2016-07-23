<?php
require_once("mysql.php");

$user = $HTTP_GET_VARS["username"];
$pass = $HTTP_GET_VARS["password"];
$code = $HTTP_GET_VARS["code"];


$sql_query = @mysql_query("SELECT * FROM member WHERE username='{$user}'");
$member = @mysql_fetch_array( $sql_query );
$sql_query1 = @mysql_query("SELECT * FROM psaver WHERE username='{$user}'");
$member1 = @mysql_fetch_array( $sql_query1 );
if ($member['password'] == $pass)
{
if ($pass != "")
{

 $sql=@mysql_query("UPDATE member SET vip = '$code' WHERE username='{$user}'");

echo "@TruePassword@";
}
else
{
echo "@WrongPassword@";
}
}
else
{
echo "@WrongPassword@";
}
?>