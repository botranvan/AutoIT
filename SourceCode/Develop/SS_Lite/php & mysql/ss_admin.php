<?php
	// SIMPLE SYSTEM coded by Vinh Pham (opdo.vn)
	// Admin function file
	// v1.0
	include 'ss_setting.php';
	if (isset($_GET["admin"])) {
		$cmd = $_GET["admin"];
		if (isset($_POST["acc"],$_POST["pass"])) {
			if ($cmd == 'isadmin') {
				if (_Account_Is_Admin($_POST["acc"],$_POST["pass"])) die('1');
				die('0');
			}
			if (_Account_Is_Admin($_POST["acc"],$_POST["pass"])) {
				if ($cmd == 'listmember') _Admin_Get_List_Member();
				if ($cmd == 'changeinfo' && isset($_POST["uacc"],$_POST["uinfo"],$_POST["uvalue"])) {
					if (_Admin_Change_User_Info($_POST["uacc"] ,$_POST["uinfo"], $_POST["uvalue"])) die('1');
					die('0');
				}
			} else die("ERROR[opdo:]Tai khoan khong hop le");
		} else die("ERROR[opdo:]Tai khoan khong hop le");
	} else die("ERROR[opdo:]Lenh khong hop le");

	function _Account_Is_Admin($acc, $pass) {
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."' and pass='". md5($pass) ."' and type='admin'");
		if (!$query || mysqli_num_rows($query) == 0) return false;
		return true;
	}
	function _Admin_Get_List_Member() {
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin");
		if (!$query || mysqli_num_rows($query) == 0) die();
		while($row = mysqli_fetch_array($query, MYSQL_ASSOC)) {
			echo $row['acc'].'|'.$row['name'].'|'.$row['email'].'|'.$row['vaild'].'|'.$row['status'].'|'.$row['type']. "\n";
		}
	}
	function _Admin_Change_User_Info($acc ,$info, $value) {
		if ($info == "acc") return false;
		if ($info == "pass") $value = md5($value);
		$conn = $GLOBALS['conn'];
		$query = mysqli_query($conn,"SELECT * FROM dblogin WHERE acc='". $acc ."'");
		if (!$query || mysqli_num_rows($query) == 0) return false;
		mysqli_query($conn,"UPDATE dblogin SET ".$info."='".$value."' WHERE acc='".$acc."'");
		return true;
	}

?>