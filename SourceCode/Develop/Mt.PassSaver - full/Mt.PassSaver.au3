#NoTrayIcon
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=mt.pass.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Lưu trữ thông tin, mật khẩu của bạn với PassSaver v1.2. Kể từ phiên bản 1.2  trở đi thông tin của bạn được bảo mật tốt hơn!
#AutoIt3Wrapper_Res_Description=M.T Group - PassSaver v1.2
#AutoIt3Wrapper_Res_Fileversion=1.2.0.014
#AutoIt3Wrapper_Res_LegalCopyright=M.T Group
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****


#include "VietCode.au3"
#include <INet.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include  <Crypt.au3>


$urlfile = "D:\Bon\AUIT-profile\Mt.PassSaver\mtSignal.sigi"
$thisver = "1.2.0.014"
$myserver = "http://mtmodz.2kool4u.net"
$next = 0


If @ScriptName <> "Mt.PassSaver.exe" And $next = 1 Then
	MsgBox(16, "Thông báo", "Có lỗi khi bật PassSaver!" & @CRLF & "ERROR: Sai tên chương trình!")
	Exit
EndIf


FileInstall($urlfile & "\mtSignal.sigi", @ScriptDir & "\mtSignal.sig", 1)
FileInstall($urlfile & "\Sconnect.sigi", @ScriptDir & "\Sconnect.sig", 1)

;################ Kiểm tra kết nối tới server ##########################
$Form1 = GUICreate("PassSaver - Loading...", 0, 0, -100, -100)
GUISetState(@SW_SHOW)
$getstr = _INetGetSource($myserver&"/server2.php")

If StringInStr($getstr, "[SERVER ONLINE]") Then

	For $i = 1 To 100000000
		If StringMid($getstr, $i, 1) = "@" Then
			ExitLoop
		EndIf
	Next
	For $x = 1 To 100000000
		If StringMid($getstr, $x, 1) = "#" Then
			ExitLoop
		EndIf
	Next

	$version = StringMid($getstr, $i + 1, $x - $i - 1)
	$thongbao = StringMid($getstr, $x + 1, StringLen($getstr))
	_CODE2VIET($thongbao)
	$mk = ""
	$seltext = ""
	$lseltext = ""
Else
	MsgBox(16, "Thông báo", "Không có kết nối tới server, vui lòng thử lại sau!")
	Exit
EndIf

GUIDelete($Form1)
;#######################################################


Local $login, $vip, $y[1000], $pid[1000], $title[1000], $pass[1000], $date[1000], $pid1[1000], $title1[1000], $pass1[1000], $date1[1000], $Formx[1000], $rand[5]


#region ### FORM SOFT
$Form1 = GUICreate("PassSaver - Version " & $thisver, 308, 635, -1, -1)
$Label1 = GUICtrlCreateLabel(" Đăng nhập", 16, 1, 70, 19)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$Label2 = GUICtrlCreateLabel("Tài khoản:", 11, 24, 59, 17)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Label3 = GUICtrlCreateLabel("Mật khẩu:", 14, 48, 56, 17)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Label5 = GUICtrlCreateLabel($thongbao, 16, 509 + 100, 273, 16, $SS_CENTER)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFF0000)
$Label6 = GUICtrlCreateLabel(" Thông tin tài khoản", 16, 384 + 100, 112, 19)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$Label7 = GUICtrlCreateLabel("Tên tài khoản:  [Unknown]", 16, 402 + 100, 250, 19)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Label8 = GUICtrlCreateLabel("Ngày đăng ký:  [Unknown]", 17, 418 + 100, 250, 19)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Label9 = GUICtrlCreateLabel("Số Password:  [Unknown]", 16, 434 + 100, 250, 19)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Label10 = GUICtrlCreateLabel("Loại tài khoản: [Unknown]", 16, 450 + 100, 250, 19)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Label11 = GUICtrlCreateLabel("[Nâng cấp lên VIP]", 84, 72, 104, 19)
GUICtrlSetCursor(-1, 0)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
$Checkbox1 = GUICtrlCreateCheckbox("Lưu tài khoản", 200, 70, 95, 20)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Input1 = GUICtrlCreateInput("", 72, 22, 127, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL))
$Input2 = GUICtrlCreateInput("", 72, 46, 127, 21, BitOR($ES_CENTER, $ES_PASSWORD, $ES_AUTOHSCROLL))
$Button1 = GUICtrlCreateButton("Đăng nhập", 202, 20, 91, 25, 0)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Button2 = GUICtrlCreateButton("Đăng ký", 202, 44, 91, 25, 0)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")

;##################### Lưu tài khoản ################
If RegRead("HKEY_CURRENT_USER\Software\Mt.PassSaver", "Username") = "" Then
	GUICtrlSetState($Input1, $GUI_FOCUS)
Else
	GUICtrlSetData($Input1, RegRead("HKEY_CURRENT_USER\Software\Mt.PassSaver", "Username"))
	GUICtrlSetState($Checkbox1, $GUI_CHECKED)
	GUICtrlSetState($Input2, $GUI_FOCUS)
EndIf
;####################################################


$Label12 = GUICtrlCreateLabel("M.T Group - Copyright @2011", 78, 570, 200, 17)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$Label20 = GUICtrlCreateLabel("Current Version: " & $thisver, 50, 90, 240, 17, $ES_CENTER)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
If StringReplace($thisver, ".", "") = StringReplace($version, ".", "") Then
	$Label13 = GUICtrlCreateLabel("Lastest Version: " & $version & " (không cần update)", 50, 108, 245, 17)
	GUICtrlSetFont(-1, 9, 800, 0, "Arial")
Else
	$Label13 = GUICtrlCreateLabel("Lastest Version: " & $version & " (cần update)", 75, 110, 220, 17)
	GUICtrlSetFont(-1, 9, 800, 0, "Arial")
EndIf
$Signal = GUICtrlCreatePic(@ScriptDir & "\mtSignal.sig", 12, 80, 30, 30)
$ConSig = GUICtrlCreatePic(@ScriptDir & "\Sconnect.sig", 50, 72, 16, 16)
GUICtrlSetState(-1, $GUI_HIDE)
$Label4 = GUICtrlCreateLabel(" Quản lý Password", 16, 132, 108, 16)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")

$Label15 = GUICtrlCreateLabel("Tiêu đề:", 17, 153, 150, 17)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$Label16 = GUICtrlCreateLabel("ID:", 17, 403 - 7 - 17, 150, 17)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$Label17 = GUICtrlCreateLabel("Ngày tạo:", 120, 403 - 7 - 17, 150, 17)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$List1 = GUICtrlCreateList("", 17, 170, 274, 210, BitOR($WS_HSCROLL, $WS_VSCROLL))
GUICtrlSetState(-1, $GUI_DISABLE)
$Input3 = GUICtrlCreateInput("", 17, 322 + 100, 205, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $ES_READONLY))
$Input4 = GUICtrlCreateInput("", 17, 403 - 7, 100, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $ES_READONLY))
$Input5 = GUICtrlCreateInput("", 120, 403 - 7, 171, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $ES_READONLY))

$Button3 = GUICtrlCreateButton("Thêm", 17, 350 + 100, 68, 25, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button4 = GUICtrlCreateButton("Xem", 87, 350 + 100, 67, 25, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button5 = GUICtrlCreateButton("Sửa", 156, 350 + 100, 67, 25, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button6 = GUICtrlCreateButton("Xóa", 225, 350 + 100, 67, 25, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button7 = GUICtrlCreateButton("Copy", 225, 320 + 100, 67, 25, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$Graphic1 = GUICtrlCreateGraphic(8, 8, 292, 124)
GUICtrlSetColor(-1, 0x989481)
$Graphic2 = GUICtrlCreateGraphic(8, 139, 292, 344)
GUICtrlSetColor(-1, 0x989481)
$Graphic3 = GUICtrlCreateGraphic(8, 504 + 100, 292, 25)
GUICtrlSetColor(-1, 0x989481)
$Graphic3 = GUICtrlCreateGraphic(6, 502 + 100, 296, 29)
GUICtrlSetColor(-1, 0x989481)
$Graphic4 = GUICtrlCreateGraphic(8, 392 + 100, 292, 100)
GUICtrlSetColor(-1, 0x989481)
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###


$1secnow = ""
$1sec = 0


While 1
	$nMsg = GUIGetMsg()

	If $login <> 0 Then
		$seltext = _GUICtrlListBox_GetCurSel($List1)
		If $seltext <> $lseltext Then
			GUICtrlSetData($Input4, "" & $pid[$seltext + 1])
			GUICtrlSetData($Input5, "" & $date[$seltext + 1])
			$lseltext = $seltext
		EndIf
	EndIf

	If WinExists("Đã Copy thông tin!", "") Then
		If @SEC <> $1secnow Then
			$1secnow = @SEC
			$1sec = $1sec + 1
			If $1sec = 2 Then
				ToolTip("")
				$1sec = 0
			EndIf
		EndIf
	EndIf

	Switch $nMsg
		Case $GUI_EVENT_PRIMARYUP
			$pos = GUIGetCursorInfo($Form1)
			If $pos[4] = $Button7 Then
				If $login <> 0 And GUICtrlRead($Input3) <> "" Then
					ClipPut(GUICtrlRead($Input3))
					ToolTip("Đã Copy thông tin!", MouseGetPos(0), MouseGetPos(1), "Mt.PassSaver", 1)
				EndIf
			EndIf
			If $pos[4] = $Label11 Then
				If $login = 0 Then
					MsgBox(16, "Thông báo", "Vui lòng đăng nhập trước khi nâng cấp lên VIP")
				ElseIf $vip <> 0 Then
					MsgBox(0, "Thông báo", "Tài khoản này hiện đang là tài khoản VIP, không thể nâng cấp lên được nữa")
				Else
					GUICtrlSetState($ConSig, $GUI_SHOW)
					$code = BinaryToString(InetRead($myserver&"/code.php", 1))
					GUICtrlSetState($ConSig, $GUI_HIDE)
					$codeme = InputBox("Code VIP", "Điền code để nâng cấp VIP", "", "", 300, 150, -1, -1)
					If $codeme = "" Then

					ElseIf StringReplace(_Crypt_HashData($codeme, $CALG_MD5), "0x", "") = $code Then
						GUICtrlSetState($ConSig, $GUI_SHOW)
						$getupvip = BinaryToString(InetRead($myserver&"/upvip.php?username=" & $tk & "&code=1&password=" & $mk, 1))
						GUICtrlSetState($ConSig, $GUI_HIDE)
						If StringInStr($getupvip, "@TruePassword@") Then
							MsgBox(0, "Thông báo", "Đã nâng cấp lên tài khoản VIP thành công!")
							$vip = Random(10000, 1000000, 1)
							$maxpw = 100
							GUICtrlSetData($Label10, "Loại tài khoản: VIP")
							GUICtrlSetData($Label9, "Số Password:  " & $sopass & "/" & $maxpw)
							GUICtrlSetColor($Label10, 0xFF0000)
						Else
							MsgBox(0, "Thông báo", "Phát sinh lỗi trong quá trình nâng cấp, vui lòng thử lại sau!")
						EndIf
					Else
						MsgBox(16, "Thông báo", "Sai CODE!!!")
					EndIf
				EndIf
			EndIf
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			If $login = 0 Then

				$tk = GUICtrlRead($Input1)
				$mk = _Crypt_HashData(GUICtrlRead($Input2), $CALG_MD5)
				If $tk = "" Or $mk = _Crypt_HashData("", $CALG_MD5) Then
					MsgBox(16, "Thông báo", "Vui lòng nhập đầy đủ thông tin!")
				Else
					GUICtrlSetState($ConSig, $GUI_SHOW)
					$code = BinaryToString(InetRead($myserver&"/checkreg.php?username=" & $tk & "&password=" & $mk, 1))
					GUICtrlSetState($ConSig, $GUI_HIDE)
					If StringInStr($code, "@TruePassword@") Then
						$login = Random(1000, 100000, 1)
						If StringInStr($code, "!VIP$") Then
							$vip = Random(10000, 1000000, 1)
						EndIf
						GUICtrlSetState($Input1, $GUI_DISABLE)
						GUICtrlSetState($Input2, $GUI_DISABLE)
						GUICtrlSetState($Button3, $GUI_ENABLE)
						GUICtrlSetState($Button4, $GUI_ENABLE)
						GUICtrlSetState($Button5, $GUI_ENABLE)
						GUICtrlSetState($Button6, $GUI_ENABLE)
						GUICtrlSetState($Button7, $GUI_ENABLE)
						GUICtrlSetState($List1, $GUI_ENABLE)
						GUICtrlSetState($Input3, $GUI_ENABLE)
						GUICtrlSetData($Button1, "Đăng xuất")
						$md5mk = $mk
						$md5key = _Crypt_DeriveKey($md5mk, $CALG_RC4)
						For $sopass = 0 To 100000
							If StringInStr($code, "#NUMBPID" & $sopass & "#") Then
								ExitLoop
							EndIf
						Next
						For $y[0] = 2 To 100000000
							If StringMid($code, $y[0], 1) = "@" Then ExitLoop
						Next
						For $y[1] = $y[0] + 1 To 100000000
							If StringMid($code, $y[1], 1) = "@" Then ExitLoop
						Next
						$time = StringMid($code, $y[0] + 1, $y[1] - 1)
						$time = StringReplace($time, " ", "")
						$time = StringMid($time, 1, 2) & "/" & StringMid($time, 3, 2) & "/" & StringMid($time, 5, 4)
						GUICtrlSetData($Label7, "Tên tài khoản: " & $tk)
						GUICtrlSetData($Label8, "Ngày đăng ký: " & $time)
						GUICtrlSetData($Label9, "Số Password: " & $sopass)
						If $vip = 0 Then
							$maxpw = 5
							GUICtrlSetData($Label10, "Loại tài khoản: Bình thường")
							GUICtrlSetData($Label9, GUICtrlRead($Label9) & "/" & $maxpw)
						ElseIf $vip > 0 Then
							$maxpw = 100
							GUICtrlSetData($Label10, "Loại tài khoản: VIP")
							GUICtrlSetData($Label9, GUICtrlRead($Label9) & "/" & $maxpw)
							GUICtrlSetColor($Label10, 0xFF0000)
						EndIf
						For $i = 1 To $sopass

							For $y[2] = $y[1] + 1 To 100000000
								If StringMid($code, $y[2], 1) = "@" Then ExitLoop
							Next
							For $y[3] = $y[2] + 1 To 100000000
								If StringMid($code, $y[3], 1) = "@" Then ExitLoop
							Next
							For $y[4] = $y[3] + 1 To 100000000
								If StringMid($code, $y[4], 1) = "@" Then ExitLoop
							Next
							For $y[5] = $y[4] + 1 To 100000000
								If StringMid($code, $y[5], 1) = "@" Then ExitLoop
							Next
							$pid[$i] = StringMid($code, $y[1] + 1, $y[2] - $y[1] - 1)
							$title[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[2] + 1, $y[3] - $y[2] - 1), $md5key, $CALG_USERKEY))
							$pass[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[3] + 1, $y[4] - $y[3] - 1), $md5key, $CALG_USERKEY))
							$date[$i] = StringMid($code, $y[4] + 1, $y[5] - $y[4] - 1)
							$date[$i] = StringReplace($date[$i], " ", "")
							$date[$i] = StringMid($date[$i], 1, 2) & "/" & StringMid($date[$i], 3, 2) & "/" & StringMid($date[$i], 5, 4)
							$y[1] = $y[5]
							;55 21 95 46 58 95 108 14 36 128
						Next
						$pid1 = ""
						For $i = 1 To $sopass
							For $z = $sopass To 2 Step -1
								If $pid[$z - 1] < $pid[$z] Then
									$pid1 = $pid[$z]
									$pid[$z] = $pid[$z - 1]
									$pid[$z - 1] = $pid1

									$pid1 = $title[$z]
									$title[$z] = $title[$z - 1]
									$title[$z - 1] = $pid1

									$pid1 = $pass[$z]
									$pass[$z] = $pass[$z - 1]
									$pass[$z - 1] = $pid1

									$pid1 = $date[$z]
									$date[$z] = $date[$z - 1]
									$date[$z - 1] = $pid1
								EndIf
							Next
						Next
						For $i = 1 To $sopass;$List1, "["&$pid[$i]&"]: "&$date[$i]&"  "&
							_GUICtrlListBox_InsertString($List1, _CODE2VIET($title[$i]) & "", $i - 1)
							;GUICtrlSetData($List1,"["&$pid[$i]&"]: "&$date[$i]&"  "&$title[$i]&"|")
						Next
						If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
							RegWrite("HKEY_CURRENT_USER\Software\Mt.PassSaver", "Username", "REG_SZ", $tk)
						Else
							RegDelete("HKEY_CURRENT_USER\Software\Mt.PassSaver", "Username")
						EndIf
						MsgBox(0, "Thông báo", "Đăng nhập tài khoản " & $tk & " thành công!")
					Else
						MsgBox(0, "Thông báo", "Sai tài khoản hoặc mật khẩu!")
					EndIf
				EndIf

			Else

				$login = 0
				$vip = 0
				GUICtrlSetState($Input1, $GUI_ENABLE)
				GUICtrlSetState($Input2, $GUI_ENABLE)
				GUICtrlSetState($Button3, $GUI_DISABLE)
				GUICtrlSetState($Button4, $GUI_DISABLE)
				GUICtrlSetState($Button5, $GUI_DISABLE)
				GUICtrlSetState($Button6, $GUI_DISABLE)
				GUICtrlSetState($Button7, $GUI_DISABLE)
				GUICtrlSetState($List1, $GUI_DISABLE)
				GUICtrlSetState($Input3, $GUI_DISABLE)
				GUICtrlSetColor($Label10, 0x000000)
				GUICtrlSetData($Button1, "Đăng nhập")
				GUICtrlSetData($Label7, "Tên tài khoản: [Unknown]")
				GUICtrlSetData($Label8, "Ngày đăng ký: [Unknown]")
				GUICtrlSetData($Label9, "Số Password: [Unknown]")
				GUICtrlSetData($Label10, "Loại tài khoản: [Unknown]")
				For $i = 0 To 999
					$pid[$i] = ""
					$title[$i] = ""
					$pass[$i] = ""
					$date[$i] = ""
					$y[$i] = ""
					$sopass = 0
					GUICtrlSetData($List1, "")
					GUICtrlSetData($Input3, "")
				Next
				$code = ""
				GUICtrlSetData($Input4, "")
				GUICtrlSetData($Input5, "")
				$md5mk = Random(10000000000000, 10000000000000000000, 1)
				MsgBox(0, "Thông báo", "Đã thoát khỏi tài khoản " & $tk)

			EndIf
		Case $Button4

			If $login <> 0 And $sopass > 0 Then
				$seltext = _GUICtrlListBox_GetCurSel($List1)
				GUICtrlSetData($Input3, _CODE2VIET($pass[$seltext + 1]))
			EndIf

		Case $Button6

			If $login <> 0 And $sopass > 0 Then
				$seltext = _GUICtrlListBox_GetCurSel($List1)
				$ask = MsgBox(4, "Xóa Password?", "Bạn có chắc chắn muốn xóa password này!")
				If $ask = 6 Then
					GUICtrlSetState($ConSig, $GUI_SHOW)
					$code = BinaryToString(InetRead($myserver&"/delete.php?pid=" & $pid[$seltext + 1] & "&username=" & $tk & "&password=" & $mk, 1))
					GUICtrlSetState($ConSig, $GUI_HIDE)
					For $sopass = 0 To 100000
						If StringInStr($code, "#NUMBPID" & $sopass & "#") Then
							ExitLoop
						EndIf
					Next
					For $y[0] = 2 To 100000000
						If StringMid($code, $y[0], 1) = "@" Then ExitLoop
					Next
					For $y[1] = $y[0] + 1 To 100000000
						If StringMid($code, $y[1], 1) = "@" Then ExitLoop
					Next
					For $i = 1 To $sopass

						For $y[2] = $y[1] + 1 To 100000000
							If StringMid($code, $y[2], 1) = "@" Then ExitLoop
						Next
						For $y[3] = $y[2] + 1 To 100000000
							If StringMid($code, $y[3], 1) = "@" Then ExitLoop
						Next
						For $y[4] = $y[3] + 1 To 100000000
							If StringMid($code, $y[4], 1) = "@" Then ExitLoop
						Next
						For $y[5] = $y[4] + 1 To 100000000
							If StringMid($code, $y[5], 1) = "@" Then ExitLoop
						Next
						$pid[$i] = StringMid($code, $y[1] + 1, $y[2] - $y[1] - 1)
						$title[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[2] + 1, $y[3] - $y[2] - 1), $md5key, $CALG_USERKEY))
						$pass[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[3] + 1, $y[4] - $y[3] - 1), $md5key, $CALG_USERKEY))
						$date[$i] = StringMid($code, $y[4] + 1, $y[5] - $y[4] - 1)
						$date[$i] = StringReplace($date[$i], " ", "")
						$date[$i] = StringMid($date[$i], 1, 2) & "/" & StringMid($date[$i], 3, 2) & "/" & StringMid($date[$i], 5, 4)
						$y[1] = $y[5]

					Next
					$pid1 = ""
					For $i = 1 To $sopass
						For $z = $sopass To 2 Step -1
							If $pid[$z - 1] < $pid[$z] Then
								$pid1 = $pid[$z]
								$pid[$z] = $pid[$z - 1]
								$pid[$z - 1] = $pid1

								$pid1 = $title[$z]
								$title[$z] = $title[$z - 1]
								$title[$z - 1] = $pid1

								$pid1 = $pass[$z]
								$pass[$z] = $pass[$z - 1]
								$pass[$z - 1] = $pid1

								$pid1 = $date[$z]
								$date[$z] = $date[$z - 1]
								$date[$z - 1] = $pid1
							EndIf
						Next
					Next
					GUICtrlSetData($Label9, "Số Password: " & $sopass & "/" & $maxpw)
					GUICtrlSetData($List1, "")
					For $i = 1 To $sopass
						_GUICtrlListBox_InsertString($List1, _CODE2VIET($title[$i]) & "", $i - 1)
						;GUICtrlSetData($List1,"["&$pid[$i]&"]: "&$date[$i]&"  "&$title[$i]&"|")
					Next
				EndIf
			EndIf

		Case $Button3

			If $login <> 0 Then
				$Formx = GUICreate("Mt.PassSaver (Add) " & $thisver, 275, 122, 347, 296)
				$Labelx1 = GUICtrlCreateLabel("Option:", 16, 1, 44, 19)
				GUICtrlSetFont(-1, 9, 800, 0, "Arial")
				GUICtrlSetColor(-1, 0xFF0000)
				$Labelx2 = GUICtrlCreateLabel("Tiêu đề:", 22, 26, 48, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$Labelx3 = GUICtrlCreateLabel("Thông tin:", 22, 50, 58, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$Inputx1 = GUICtrlCreateInput("", 80, 24, 177, 21)
				$Inputx2 = GUICtrlCreateInput("", 80, 48, 177, 21)
				$Buttonx1 = GUICtrlCreateButton("Xác nhận", 80, 80, 115, 25, 0)
				$Buttonx2 = GUICtrlCreateButton("Thoát", 200, 80, 59, 25, 0)
				$Graphicx = GUICtrlCreateGraphic(8, 8, 257, 105)
				GUICtrlSetColor(-1, 0x808080)
				GUISetState(@SW_SHOW)
				While 1
					$nMsg = GUIGetMsg()
					Switch $nMsg
						Case $Buttonx2
							GUIDelete($Formx)
							ExitLoop
						Case $GUI_EVENT_CLOSE
							GUIDelete($Formx)
							ExitLoop
						Case $Buttonx1
							If $vip = 0 And $sopass >= 5 Then
								MsgBox(16, "Thông báo", "Tài khoản thường chỉ được lưu tối đa 5 password!")
							ElseIf $vip <> 0 And $sopass >= 100 Then
								MsgBox(16, "Thông báo", "Tài khoản VIP chỉ được lưu tối đa 100 password!")
							Else
								$tde = GUICtrlRead($Inputx1)
								$pwo = GUICtrlRead($Inputx2)
								If $tde <> "" And $pwo <> "" Then
									GUICtrlSetState($ConSig, $GUI_SHOW)
									$md5key = _Crypt_DeriveKey($md5mk, $CALG_RC4)
									$code = BinaryToString(InetRead($myserver&"/create.php?user=" & $tk & "&title=" & _Crypt_EncryptData(_VIET2CODE($tde), $md5key, $CALG_USERKEY) & "&pass=" & _Crypt_EncryptData(_VIET2CODE($pwo), $md5key, $CALG_USERKEY) & "&password=" & $mk, 1))
									GUICtrlSetState($ConSig, $GUI_HIDE)
									For $sopass = 0 To 100000
										If StringInStr($code, "#NUMBPID" & $sopass & "#") Then
											ExitLoop
										EndIf
									Next
									For $y[0] = 2 To 100000000
										If StringMid($code, $y[0], 1) = "@" Then ExitLoop
									Next
									For $y[1] = $y[0] + 1 To 100000000
										If StringMid($code, $y[1], 1) = "@" Then ExitLoop
									Next
									For $i = 1 To $sopass

										For $y[2] = $y[1] + 1 To 100000000
											If StringMid($code, $y[2], 1) = "@" Then ExitLoop
										Next
										For $y[3] = $y[2] + 1 To 100000000
											If StringMid($code, $y[3], 1) = "@" Then ExitLoop
										Next
										For $y[4] = $y[3] + 1 To 100000000
											If StringMid($code, $y[4], 1) = "@" Then ExitLoop
										Next
										For $y[5] = $y[4] + 1 To 100000000
											If StringMid($code, $y[5], 1) = "@" Then ExitLoop
										Next
										$pid[$i] = StringMid($code, $y[1] + 1, $y[2] - $y[1] - 1)
										$title[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[2] + 1, $y[3] - $y[2] - 1), $md5key, $CALG_USERKEY))
										$pass[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[3] + 1, $y[4] - $y[3] - 1), $md5key, $CALG_USERKEY))
										$date[$i] = StringMid($code, $y[4] + 1, $y[5] - $y[4] - 1)
										$date[$i] = StringReplace($date[$i], " ", "")
										$date[$i] = StringMid($date[$i], 1, 2) & "/" & StringMid($date[$i], 3, 2) & "/" & StringMid($date[$i], 5, 4)
										$y[1] = $y[5]

									Next
									$pid1 = ""
									For $i = 1 To $sopass
										For $z = $sopass To 2 Step -1
											If $pid[$z - 1] < $pid[$z] Then
												$pid1 = $pid[$z]
												$pid[$z] = $pid[$z - 1]
												$pid[$z - 1] = $pid1

												$pid1 = $title[$z]
												$title[$z] = $title[$z - 1]
												$title[$z - 1] = $pid1

												$pid1 = $pass[$z]
												$pass[$z] = $pass[$z - 1]
												$pass[$z - 1] = $pid1

												$pid1 = $date[$z]
												$date[$z] = $date[$z - 1]
												$date[$z - 1] = $pid1
											EndIf
										Next
									Next
									GUICtrlSetData($Label9, "Số Password: " & $sopass & "/" & $maxpw)
									GUICtrlSetData($List1, "")
									For $i = 1 To $sopass
										_GUICtrlListBox_InsertString($List1, _CODE2VIET($title[$i]) & "", $i - 1)
										;GUICtrlSetData($List1,"["&$pid[$i]&"]: "&$date[$i]&"  "&$title[$i]&"|")
									Next
									GUIDelete($Formx)
									ExitLoop
								Else
									MsgBox(16, "Thông báo", "Vui lòng nhập đầy đủ thông tin!")
								EndIf
							EndIf
					EndSwitch
				WEnd
			EndIf

		Case $Button5
			$seltext = _GUICtrlListBox_GetCurSel($List1)

			If $login <> 0 Then
				$Formz = GUICreate("Mt.PassSaver (Edit) " & $thisver, 275, 122, 347, 296)
				$Labelz1 = GUICtrlCreateLabel("Option:", 16, 1, 44, 19)
				GUICtrlSetFont(-1, 9, 800, 0, "Arial")
				GUICtrlSetColor(-1, 0xFF0000)
				$Labelz2 = GUICtrlCreateLabel("Tiêu đề:", 22, 26, 48, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$Labelz3 = GUICtrlCreateLabel("Thông tin:", 22, 50, 58, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$Inputz1 = GUICtrlCreateInput(_CODE2VIET($title[$seltext + 1]), 80, 24, 177, 21)
				$Inputz2 = GUICtrlCreateInput(_CODE2VIET($pass[$seltext + 1]), 80, 48, 177, 21)
				$Buttonz1 = GUICtrlCreateButton("Xác nhận", 80, 80, 115, 25, 0)
				$Buttonz2 = GUICtrlCreateButton("Thoát", 200, 80, 59, 25, 0)
				$Graphicz = GUICtrlCreateGraphic(8, 8, 257, 105)
				GUICtrlSetColor(-1, 0x808080)
				GUISetState(@SW_SHOW)
				While 1
					$nMsg = GUIGetMsg()
					Switch $nMsg
						Case $Buttonz2
							GUIDelete($Formz)
							ExitLoop
						Case $GUI_EVENT_CLOSE
							GUIDelete($Formz)
							ExitLoop
						Case $Buttonz1
							$tde = GUICtrlRead($Inputz1)
							$pwo = GUICtrlRead($Inputz2)
							If $tde <> "" And $pwo <> "" Then
								GUICtrlSetState($ConSig, $GUI_SHOW)
								$md5key = _Crypt_DeriveKey($md5mk, $CALG_RC4)
								$code = BinaryToString(InetRead($myserver&"/uptb.php?username=" & $tk & "&title=" & _Crypt_EncryptData(_VIET2CODE($tde), $md5key, $CALG_USERKEY) & "&pass=" & _Crypt_EncryptData(_VIET2CODE($pwo), $md5key, $CALG_USERKEY) & "&password=" & $mk & "&pid=" & $pid[$seltext + 1], 1))
								GUICtrlSetState($ConSig, $GUI_HIDE)
								For $sopass = 0 To 100000
									If StringInStr($code, "#NUMBPID" & $sopass & "#") Then
										ExitLoop
									EndIf
								Next
								For $y[0] = 2 To 100000000
									If StringMid($code, $y[0], 1) = "@" Then ExitLoop
								Next
								For $y[1] = $y[0] + 1 To 100000000
									If StringMid($code, $y[1], 1) = "@" Then ExitLoop
								Next
								For $i = 1 To $sopass

									For $y[2] = $y[1] + 1 To 100000000
										If StringMid($code, $y[2], 1) = "@" Then ExitLoop
									Next
									For $y[3] = $y[2] + 1 To 100000000
										If StringMid($code, $y[3], 1) = "@" Then ExitLoop
									Next
									For $y[4] = $y[3] + 1 To 100000000
										If StringMid($code, $y[4], 1) = "@" Then ExitLoop
									Next
									For $y[5] = $y[4] + 1 To 100000000
										If StringMid($code, $y[5], 1) = "@" Then ExitLoop
									Next
									$pid[$i] = StringMid($code, $y[1] + 1, $y[2] - $y[1] - 1)
									$title[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[2] + 1, $y[3] - $y[2] - 1), $md5key, $CALG_USERKEY))
									$pass[$i] = BinaryToString(_Crypt_DecryptData(StringMid($code, $y[3] + 1, $y[4] - $y[3] - 1), $md5key, $CALG_USERKEY))
									$date[$i] = StringMid($code, $y[4] + 1, $y[5] - $y[4] - 1)
									$date[$i] = StringReplace($date[$i], " ", "")
									$date[$i] = StringMid($date[$i], 1, 2) & "/" & StringMid($date[$i], 3, 2) & "/" & StringMid($date[$i], 5, 4)
									$y[1] = $y[5]

								Next
								$pid1 = ""
								For $i = 1 To $sopass
									For $z = $sopass To 2 Step -1
										If $pid[$z - 1] < $pid[$z] Then
											$pid1 = $pid[$z]
											$pid[$z] = $pid[$z - 1]
											$pid[$z - 1] = $pid1

											$pid1 = $title[$z]
											$title[$z] = $title[$z - 1]
											$title[$z - 1] = $pid1

											$pid1 = $pass[$z]
											$pass[$z] = $pass[$z - 1]
											$pass[$z - 1] = $pid1

											$pid1 = $date[$z]
											$date[$z] = $date[$z - 1]
											$date[$z - 1] = $pid1
										EndIf
									Next
								Next
								GUICtrlSetData($Label9, "Số Password: " & $sopass & "/" & $maxpw)
								GUICtrlSetData($List1, "")
								For $i = 1 To $sopass
									_GUICtrlListBox_InsertString($List1, _CODE2VIET($title[$i]) & "", $i - 1)
									;GUICtrlSetData($List1,"["&$pid[$i]&"]: "&$date[$i]&"  "&$title[$i]&"|")
								Next
								GUIDelete($Formz)
								ExitLoop
							Else
								MsgBox(16, "Thông báo", "Vui lòng nhập đầy đủ thông tin!")
							EndIf
					EndSwitch
				WEnd
			EndIf
		Case $Button2
			If $login = 0 Then
				#region ### FORM REGISTER
				$Form2 = GUICreate("M.T Group - Register", 321, 160, 340, 145)
				$2Label1 = GUICtrlCreateLabel("Đăng ký", 16, 0, 49, 19)
				GUICtrlSetFont(-1, 9, 800, 0, "Arial")
				GUICtrlSetColor(-1, 0xFF0000)
				$2Label2 = GUICtrlCreateLabel("Tài khoản", 24, 24, 61, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$2Label3 = GUICtrlCreateLabel("Mật khẩu", 24, 48, 53, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$2Input1 = GUICtrlCreateInput("", 88, 24, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL))
				$2Input2 = GUICtrlCreateInput("", 88, 48, 217, 21, BitOR($ES_CENTER, $ES_PASSWORD, $ES_AUTOHSCROLL))
				$2Button1 = GUICtrlCreateButton("Đăng ký", 64, 100, 219, 25, 0)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$2Label8 = GUICtrlCreateLabel("M.T Group - Copyright @2011", 88, 130, 168, 19)
				GUICtrlSetFont(-1, 9, 800, 0, "Arial")
				$2Input3 = GUICtrlCreateInput("", 88, 72, 145, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL))
				$2Label9 = GUICtrlCreateLabel("Mã xác nhận", 11, 72, 72, 19)
				GUICtrlSetFont(-1, 9, 400, 0, "Arial")
				$rand[1] = _HexToString(Random(61, 79, 1))
				$2Label4 = GUICtrlCreateLabel($rand[1], 240, 72, 14, 20)
				GUICtrlSetFont(-1, 10, 800, 0, "Arial")
				GUICtrlSetColor(-1, 0x0000FF)
				$rand[2] = _HexToString(Random(41, 59, 1))
				$2Label6 = GUICtrlCreateLabel($rand[2], 256, 78, 14, 20)
				GUICtrlSetFont(-1, 10, 800, 0, "Tahoma")
				GUICtrlSetColor(-1, 0x0000FF)
				$rand[3] = _HexToString(Random(31, 39, 1))
				$2Label5 = GUICtrlCreateLabel($rand[3], 272, 74, 14, 20)
				GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
				GUICtrlSetColor(-1, 0x0000FF)
				$rand[4] = _HexToString(Random(61, 79, 1))
				$2Label7 = GUICtrlCreateLabel($rand[4], 288, 72, 14, 20)
				GUICtrlSetFont(-1, 10, 800, 0, "System")
				GUICtrlSetColor(-1, 0x0000FF)
				$2Graphic1 = GUICtrlCreateGraphic(8, 8, 305, 145)
				GUICtrlSetColor(-1, 0x808080)
				GUISetState(@SW_SHOW)
				While 1
					$nMsg = GUIGetMsg()
					Switch $nMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($Form2)
							ExitLoop
						Case $2Button1
							$rtk = GUICtrlRead($2Input1)
							$rmk = _Crypt_HashData(GUICtrlRead($2Input2), $CALG_MD5)
							If $rtk = "" Or $rmk = "" Then
								MsgBox(16, "Thông báo", "Vui lòng điền đầy đủ thông tin!")
							ElseIf $rand[1] & $rand[2] & $rand[3] & $rand[4] <> GUICtrlRead($2Input3) Then
								MsgBox(16, "Thông báo", "Sai mã xác nhận!")
							Else
								InetRead($myserver&"/register.php?username=" & $rtk & "&password=" & $rmk)
								GUIDelete($Form2)
								MsgBox(0, "Thông báo", "Đăng ký thành công tài khoản " & $rtk)
								GUICtrlSetData($Input1, $rtk)
								ExitLoop
							EndIf
					EndSwitch
				WEnd
			Else
				MsgBox(16, "Thông báo", "Bạn vui lòng thoát tài khoản đang đăng nhập trước khi đăng ký")
			EndIf
	EndSwitch
WEnd
