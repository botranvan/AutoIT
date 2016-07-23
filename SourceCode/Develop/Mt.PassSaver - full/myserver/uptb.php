<?php
require_once("mysql.php");

$user = $HTTP_GET_VARS["username"];
$pass = $HTTP_GET_VARS["password"];

$pid = $HTTP_GET_VARS["pid"];
$ptitle = $HTTP_GET_VARS["title"];
$ppass = $HTTP_GET_VARS["pass"];
$pdate = date(" d m Y");


$sql_query = @mysql_query("SELECT * FROM member WHERE username='{$user}'");
$member = @mysql_fetch_array( $sql_query );
$sql_query1 = @mysql_query("SELECT * FROM psaver WHERE username='{$user}'");
$member1 = @mysql_fetch_array( $sql_query1 );
if ($member['password'] == $pass)
{
if ($pass != "")
{

 $sql=@mysql_query("UPDATE psaver SET ptitle = '$ptitle' WHERE pid='{$pid}'");
 $sql1=@mysql_query("UPDATE psaver SET ppass = '$ppass' WHERE pid='{$pid}'");
 $sql2=@mysql_query("UPDATE psaver SET pdate = '$pdate' WHERE pid='{$pid}'");

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