<?php
	$sqlconnect= mysql_connect("localhost","172305","1234567");
		if (!$sqlconnect){
			 die('Could not connect: ' . mysql_error());
		}
	mysql_select_db("172305",$sqlconnect);
	function usercheck(){
		$result= mysql_query("SELECT * FROM user");
		$i= 0;
		echo "<table border=0 cellpadding=3 cellspacing=0><th>Tài Khoản<th>NetIP";
		while($row = mysql_fetch_array($result)) {
			$i+= 1;
			echo "<tr><td class=userstyle>$i. $row[name]<td>$row[NetIP]";
		}
		echo "</table>";
	}
	function register(){
		if (isset($_POST['submit'])){
			$result= mysql_query("SELECT * FROM user");
			while($row = mysql_fetch_array($result)) {
				if ($row['name'] == $_POST['name']){
					echo "Tài Khoản này đã được đăng ký. Vui lòng kiểm tra lại";
					$error= True;
				} elseif (($row['email']) == $_POST['email']){
					echo "Email này đã được đăng ký. Vui lòng kiểm tra lại";
					$error= True;
				}
			}
			if ($error == true){
				include "./include/signup.inc";
			} else {
				if (isset($_POST['name'])){
					if (strlen($_POST['name']) == 0){
						echo "Bạn chưa nhập tên Đăng Nhập<br>";
						$namecheck=false;
					} else {
						$namecheck=true;
					}
				} if (isset($_POST['pass'])){
					if (strlen($_POST['pass']) > 16){
						echo "Mật khẩu không quá 16 ký tự<br>";
						$passcheck=false;
					} elseif (strlen($_POST['pass']) < 4){
						echo "Mật khẩu không dưới 4 ký tự<br>";
						$passcheck=false;
					} elseif(strlen($_POST['pass']) == 0){
						echo "Bạn chưa nhập mật khẩu<br>";
						$passcheck=false;
					} else {
						if (isset($_POST['repass'])){
							if (strlen($_POST['repass']) == 0) {
								echo "Bạn chưa nhập lại mật khẩu<br>";
								$passcheck=false;
							} elseif ($_POST['repass'] != $_POST['pass']){
								echo "Mật khẩu nhập lại không giống mật khẩu chính<br>";
								$passhceck=false;
							} elseif ($_POST['repass'] == $_POST['pass']){
								$passcheck=true;
							}
						}
					}
				} if (isset($_POST['email'])){
					if (strlen($_POST['email']) == 0 ){
						echo "Bạn chưa nhập email<br>";
						$emailcheck=false;
					} else {
						$emailcheck=true;
					}
				}
				if ($namecheck && $passcheck && $emailcheck){
					mysql_query("INSERT INTO user (name,pass,email,netip,win,lose,exp,level)
					VALUES ('$_POST[name]','$_POST[pass]','$_POST[email]',0,0,0,0,0)");
					echo "Bạn đã đăng ký thành công.<br>";
					echo "<a href='./index.php'>Quay lại trang chủ</a>";
				} else {
					include "./include/signup.inc";
				}
			}
		} else {
			include "./include/signup.inc";
		}
	}
	if (isset($_GET['mode'])){
		Switch ($_GET['mode']){
			case "register": $page_title= "Đăng Ký";include "./include/header.inc";register();break;
			case "user": $page_title= "Thành Viên";include "./include/header.inc";usercheck();break;
			default: $page_title= "Thành Viên";include "./include/header.inc";usercheck();break;
		}
	} else { $page_title= "Thành Viên"; include "./include/header.inc"; usercheck();}
	include "./include/footer.inc";
	mysql_close($sqlconnect);
?>