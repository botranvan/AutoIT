<?php
require_once("mysql.php");
$date = date(" d m Y");
$user = $HTTP_GET_VARS["user"];
$pass = $HTTP_GET_VARS["password"];
$sql_query = @mysql_query("SELECT * FROM member WHERE username='{$user}'");
$member = @mysql_fetch_array( $sql_query );
$sql_query1 = @mysql_query("SELECT * FROM psaver WHERE username='{$user}'");
$member1 = @mysql_fetch_array( $sql_query1 );
if ($member['password'] == $pass)
{
if ($pass != "")
{
@$a=mysql_query("INSERT INTO psaver (ptitle, ppass,pdate,puser) VALUES ('{$HTTP_GET_VARS["title"]}','{$HTTP_GET_VARS["pass"]}','{$date}','{$user}')");
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