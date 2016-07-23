<?php
	// SIMPLE SYSTEM coded by Vinh Pham (opdo.vn)
	// Login file
	// v1.0
	include 'ss_func.php';
	if (isset($_POST["acc"],$_POST["pass"],$_POST["id"])) {
		$acc = $_POST["acc"]; // account
		$pass = $_POST["pass"]; // password
		$id = $_POST["id"]; // id may
		$login = _Login($acc, $pass, $id, 1);
		$new_Vaild = (float)_Account_Get_Vaild($acc, $pass)-1; // trừ lần dùng
		_Account_Set_Vaild($acc, $pass, $new_Vaild);
		echo $login;
	} else {
		die("ERROR[opdo:]Khong nhan duoc thong tin");
	}
?>