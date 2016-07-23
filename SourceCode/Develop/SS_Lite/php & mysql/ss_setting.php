<?php
	// SIMPLE SYSTEM coded by Vinh Pham (opdo.vn)
	// Setting file
	// v1.0
	// thong tin sql
	date_default_timezone_set("Asia/Ho_Chi_Minh");
	$sql_username = "root";
	$sql_password = "";
	$sql_host = "localhost";
	$sql_database = "dblogin";
	$conn = mysqli_connect($sql_host,$sql_username,$sql_password,$sql_database) or die("ERROR[opdo:]Khong ket noi duoc voi database");
	// setting simple system
	$SS_VERSION = '1.0'; // phien ban su dung
	$SS_ONLINE = true; // true: duoc phep su dung, false: ngung su dung
	//$SS_LOGIN_1TIMES = true; // chi co trong full version. lien he http://fb.com/imopdo
	//$SS_LOGIN_OVERWIRTE = true; // chi co trong full version. lien he http://fb.com/imopdologin truoc do
	//$SS_COUNT_BY_DATE = true; // chi co trong full version. lien he http://fb.com/imopdo
	//$SS_GETTRIAL = true; // chi co trong full version. lien he http://fb.com/imopdo
	//$SS_TRIAL_1TIMES = true; // chi co trong full version. lien he http://fb.com/imopdo
?>