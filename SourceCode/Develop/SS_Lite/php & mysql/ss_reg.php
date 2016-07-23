<?php
	// SIMPLE SYSTEM coded by Vinh Pham (opdo.vn)
	// Reg file
	// v1.0
	include 'ss_func.php';
	if (isset($_POST["acc"],$_POST["pass"],$_POST["id"],$_POST["name"],$_POST["email"])) {
		$acc = $_POST["acc"]; // account
		$pass = $_POST["pass"]; // password
		$id = $_POST["id"]; // id may
		$name = $_POST["name"]; 
		$email = $_POST["email"]; 
		if (_Account_Exist($acc) == false) {
			if (_Reg($acc, $pass, $id, $name, $email)) die("SUCCESS[opdo:]Dang ky thanh cong");
			else die("ERROR[opdo:]Co loi xay ra, dang ky that bai");
		} else die("ERROR[opdo:]Tai khoan da ton tai");
	} else {
		die("ERROR[opdo:]Khong nhan duoc thong tin");
	}
?>