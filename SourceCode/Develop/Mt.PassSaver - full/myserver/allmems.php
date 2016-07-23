<?php
require_once("mysql.php");
$result = mysql_query("select * from member") or die (mysql_error()); 
 while ($row = mysql_fetch_array($result)) 
 { 
         echo "Username: "; 
         echo $row["username"];
         echo "<br>Password: ";
         echo $row["password"];	
         echo "<br>Ngay dang ky: ";
         echo $row["time"];
         echo "<br><a href='xoa.php?user={$row['username']}'>Xoa</a>"; 
         echo "<br><br>"; 
 } 
 mysql_free_result($result); 

?>