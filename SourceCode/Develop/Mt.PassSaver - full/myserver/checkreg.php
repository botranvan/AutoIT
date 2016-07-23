<?php
require_once("mysql.php");
$user = $HTTP_GET_VARS["username"];
$pass = $HTTP_GET_VARS["password"];
$sql_query = @mysql_query("SELECT * FROM member WHERE username='{$user}'");
$member = @mysql_fetch_array( $sql_query );
if ($member['password'] == $pass)
{
if ($pass != "")
{
echo "@TruePassword@";
echo $member['time'];
echo "@";
$i = 0;
$result = mysql_query("select * from psaver WHERE puser='{$user}'") or die (mysql_error()); 
 while ($row = mysql_fetch_array($result)) 
 { 
         $i = ($i+1);
         echo $row["pid"];
         echo "@";
         echo $row["ptitle"];	
         echo "@";
         echo $row["ppass"];
         echo "@";
         echo $row["pdate"];
         echo "@";
 } 
 echo "#NUMBPID$i#";
if ($member['vip'] == 1)
{
 echo "!VIP$";
}
 mysql_free_result($result); 
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