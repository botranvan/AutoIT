<?php
require_once("mysql.php");
$result = mysql_query("select * from psaver") or die (mysql_error()); 
 while ($row = mysql_fetch_array($result)) 
 { 
         echo "PID: "; 
         echo $row["pid"];
         echo "<br>Title: ";
         echo $row["ptitle"];	
         echo "<br>Pass: ";
         echo $row["ppass"];
         echo "<br>Time: ";
         echo $row["pdate"];
         echo "<br>User: ";
         echo $row["puser"];
         echo "<br><br>"; 
 } 
 mysql_free_result($result); 

?>