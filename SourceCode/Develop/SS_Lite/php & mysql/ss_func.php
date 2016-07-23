<?php
	// SIMPLE SYSTEM coded by Vinh Pham (opdo.vn)
	// Function file
	// v1.0
	include 'ss_setting.php';

	if ($SS_ONLINE == false) die("ERROR[opdo:]System dang bao tri"); // check thong tin bao tri system
	
	if (isset($_GET["cmd"])) {
		$cmd = $_GET["cmd"];
		if ($cmd=='getinfo') _Get_System_Info();
		if ($cmd=='checkvaild' && isset($_POST["acc"])) _Account_CheckVaild($_POST["acc"]);
		if ($cmd=='changeinfo' && isset($_POST["acc"],$_POST["pass"],$_POST["id"],$_POST["value"],$_POST["info"])) {
			if (_Login($_POST["acc"], $_POST["pass"], $_POST["id"], 0)) _Account_Change_Info($_POST["acc"],$_POST["info"], $_POST["value"]);
		}
		if ($cmd=='addcode' && isset($_POST["acc"],$_POST["pass"],$_POST["id"],$_POST["code"])) {
			if (_Login($_POST["acc"], $_POST["pass"], $_POST["id"], 0)) {
				if (_Account_Add_Code($_POST["acc"], $_POST["pass"], $_POST["code"])) die(_Login($_POST["acc"], $_POST["pass"], $_POST["id"], 1));
				else  die('ERROR[opdo:]Nap code that bai');
			} else die('ERROR[opdo:]Nap code that bai');
		}

		// cách tạo 1 func command
		if ($cmd=='userfunc' && isset($_POST["acc"],$_POST["pass"],$_POST["id"])) { // tạo 1 command func
			if (_Login($_POST["acc"], $_POST["pass"], $_POST["id"], 0)) { // check thông tin user
				// thông tin hợp lệ
				_User_Func_Command($_POST["acc"]);
			}
			else die('0'); // thông tin không hợp lệ
		}
	}

	function _User_Func_Command($acc) { // user func để gọi
		if (_Account_CheckVaild($acc,0)) { // kiểm tra hạn dùng
			if ($acc == 'admin') die('Your are admin.'); 
			else  die('Hi member.'); 
		}
		else die('Tai khoan het han su dung');
	}

	function _Login($acc, $pass, $id, $return) {
		$pass = md5($pass);
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."' and pass = '". $pass ."'");
		if (!$query || mysqli_num_rows($query) == 0) {
			if ($return == 1) return "ERROR[opdo:]Tai khoan hoac mat khau khong chinh xac";
			return false;
		} else {
			$row = mysqli_fetch_array($query,MYSQL_ASSOC);
			if ($return == 1) return "SUCCESS[opdo:]".$row['acc']."|".$row['name']."|".$row['email']."|".$row['type']."|".$row['vaild'];
			return true;
		}
	}

	function _Reg($acc, $pass, $id, $name, $email) {
		$conn = $GLOBALS['conn'];
		if (_Account_Exist($acc) == false) {
			mysqli_query($conn,"INSERT INTO dblogin (acc,pass,id,name,email) VALUES ('".$acc."','".md5($pass)."','".$id."','".$name."','".$email."')");
			return true;
		} else return false;
	}


	function _Account_Add_Code($acc, $pass, $code) {
		$conn = $GLOBALS['conn'];
		$query2 = mysqli_query($conn,"SELECT * FROM dbcode WHERE code='". $code ."'");
		if (!$query2 || mysqli_num_rows($query2) == 0) return false;
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."' and pass='". md5($pass) ."'");
		if (!$query || mysqli_num_rows($query) == 0) return false;
		$row = mysqli_fetch_array($query,MYSQL_ASSOC);
		$row2 = mysqli_fetch_array($query2,MYSQL_ASSOC);
		$add = $row2['vaild'];
		if ($add == '-1' || $add == -1) return false;
		else {
			mysqli_query($conn,"UPDATE dbcode SET vaild='-1' WHERE code='".$code."'");
			$new_Vaild = (float)_Account_Get_Vaild($acc, $pass)+(float)$add;
			_Account_Set_Vaild($acc, $pass, $new_Vaild);
			return true;
		}
	}

	function _Account_Change_Info($acc, $column, $value) {
		if ($column=='name' || $column == 'email') { // chỉ cho phép đổi email và name
			$conn = $GLOBALS['conn'];
			mysqli_query($conn,"UPDATE dblogin SET ".$column."='".$value."' WHERE acc='".$acc."'");
			die('1');
		}
		die('0');
	}

	function _Account_Exist($acc) {
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."'");
		if (!$query || mysqli_num_rows($query) == 0) return false;
		else return true;
	}

	function _Account_Set_Vaild($acc,$pass,$value, $md5pass = 0) {
		if ($md5pass==0) $pass = md5($pass);
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."' and pass='". $pass ."'");
		if (!$query || mysqli_num_rows($query) == 0) return false;
		$row = mysqli_fetch_array($query,MYSQL_ASSOC);
		mysqli_query($conn,"UPDATE dblogin SET vaild='".$value."' WHERE acc='".$acc."'");
		return true;
	}

	function _Account_Get_Vaild($acc,$pass, $md5pass = 0) {
		if ($md5pass==0) $pass = md5($pass);
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."' and pass='". $pass ."'");
		if (!$query || mysqli_num_rows($query) == 0) return false;
		$row = mysqli_fetch_array($query,MYSQL_ASSOC);
		return (float)$row['vaild'];
	}

	function _Account_CheckVaild($acc, $return = 1) {
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."'");
		if (!$query || mysqli_num_rows($query) == 0) {
			if ($return == 1) die('0');
			return false;
		}
		$row = mysqli_fetch_array($query,MYSQL_ASSOC);
		if ((float)$row['vaild'] > 0) {
			if ($return == 1) die('1');
			return true;
		}
		if ($return == 1) die('0');
		return false;
	}

	function _Get_System_Info() {
		$count = 0;
		echo $GLOBALS['SS_VERSION'].'|'. 0;
	}
?>