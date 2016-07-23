#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <ListViewConstants.au3>
#include <GuiListView.au3>
#include "_SimpleSystem_UDF.au3"
Opt("GUIResizeMode", 802)

_Login()

Func _Login()
	$GUILOGIN = GUICreate("Simple System", 264, 142, -1, -1)
	GUICtrlCreateLabel("Hi, this is an example simple system", 16, 8, 226, 17, $SS_CENTER)
	GUICtrlCreateLabel("Account:", 16, 40, 47, 17)
	GUICtrlCreateLabel("Password:", 16, 72, 53, 17)
	$Account = GUICtrlCreateInput("", 72, 37, 177, 21)
	$Password = GUICtrlCreateInput("", 72, 69, 177, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))

	$RePassword = GUICtrlCreateInput("", 72, 69 + 32, 177, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
	$RePassword_txt = GUICtrlCreateLabel("RePass:", 16, 72 + 32, 53, 17)

	$Name = GUICtrlCreateInput("", 72, 69 + 32 * 2, 177, 21)
	$Name_txt = GUICtrlCreateLabel("Name:", 16, 72 + 32 * 2, 53, 17)

	$Email = GUICtrlCreateInput("", 72, 69 + 32 * 3, 177, 21)
	$Email_txt = GUICtrlCreateLabel("Email:", 16, 72 + 32 * 3, 53, 17)

	$Login_Button = GUICtrlCreateButton("Login", 176, 104, 75, 25)
	$Reg_Button = GUICtrlCreateButton("Register", 72, 104, 75, 25)
	$Label_Or = GUICtrlCreateLabel("or", 152, 109, 21, 17, $SS_CENTER)

	$RegOK_Button = GUICtrlCreateButton("Register", 176, 104 + 32 * 3, 75, 25)
	$Cancel_Button = GUICtrlCreateButton("Cancel", 72, 104 + 32 * 3, 75, 25)
	$Label_Or2 = GUICtrlCreateLabel("or", 152, 109 + 32 * 3, 21, 17, $SS_CENTER)

	GUICtrlSetState($RePassword, $GUI_HIDE)
	GUICtrlSetState($RePassword_txt, $GUI_HIDE)
	GUICtrlSetState($Name, $GUI_HIDE)
	GUICtrlSetState($Name_txt, $GUI_HIDE)
	GUICtrlSetState($Email, $GUI_HIDE)
	GUICtrlSetState($Email_txt, $GUI_HIDE)
	GUICtrlSetState($RegOK_Button, $GUI_HIDE)
	GUICtrlSetState($Cancel_Button, $GUI_HIDE)
	GUICtrlSetState($Label_Or2, $GUI_HIDE)
	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $Login_Button
				If GUICtrlRead($Account) <> '' And GUICtrlRead($Password) <> '' Then
					_SS_Login(GUICtrlRead($Account), GUICtrlRead($Password))
					If Not @error Then
						GUIDelete($GUILOGIN)
						_GUIMAIN()
					EndIf
				Else
					MsgBox(16, 'Thông báo', 'Vui lòng nhập đầy đủ thông tin bên trên')
				EndIf
			Case $RegOK_Button
				If GUICtrlRead($Account) <> '' And GUICtrlRead($Password) <> '' And GUICtrlRead($RePassword) <> '' And GUICtrlRead($Name) <> '' And GUICtrlRead($Email) <> '' Then
					If GUICtrlRead($Password) == GUICtrlRead($RePassword) Then
						$reg = _SS_RegAcc(GUICtrlRead($Account), GUICtrlRead($Password), $__MY__ID, GUICtrlRead($Name), GUICtrlRead($Email))
						If Not @error Then
							MsgBox(64, 'Thông báo', 'Đăng ký thành công')
							GUICtrlSetState($Reg_Button, $GUI_SHOW)
							GUICtrlSetState($Login_Button, $GUI_SHOW)
							GUICtrlSetState($Label_Or, $GUI_SHOW)
							WinMove($GUILOGIN, '', Default, Default, Default, 142 + 32)
							GUICtrlSetState($RePassword, $GUI_HIDE)
							GUICtrlSetState($RePassword_txt, $GUI_HIDE)
							GUICtrlSetState($Name, $GUI_HIDE)
							GUICtrlSetState($Name_txt, $GUI_HIDE)
							GUICtrlSetState($Email, $GUI_HIDE)
							GUICtrlSetState($Email_txt, $GUI_HIDE)
							GUICtrlSetState($RegOK_Button, $GUI_HIDE)
							GUICtrlSetState($Cancel_Button, $GUI_HIDE)
							GUICtrlSetState($Label_Or2, $GUI_HIDE)
						EndIf
					Else
						MsgBox(16, 'Thông báo', 'Mật khẩu không trùng khớp')
					EndIf
				Else
					MsgBox(16, 'Thông báo', 'Vui lòng nhập đầy đủ thông tin bên trên')
				EndIf
			Case $GUI_EVENT_CLOSE
				Exit
			Case $Cancel_Button
				GUICtrlSetState($Reg_Button, $GUI_SHOW)
				GUICtrlSetState($Login_Button, $GUI_SHOW)
				GUICtrlSetState($Label_Or, $GUI_SHOW)
				WinMove($GUILOGIN, '', Default, Default, Default, 142 + 32)
				GUICtrlSetState($RePassword, $GUI_HIDE)
				GUICtrlSetState($RePassword_txt, $GUI_HIDE)
				GUICtrlSetState($Name, $GUI_HIDE)
				GUICtrlSetState($Name_txt, $GUI_HIDE)
				GUICtrlSetState($Email, $GUI_HIDE)
				GUICtrlSetState($Email_txt, $GUI_HIDE)
				GUICtrlSetState($RegOK_Button, $GUI_HIDE)
				GUICtrlSetState($Cancel_Button, $GUI_HIDE)
				GUICtrlSetState($Label_Or2, $GUI_HIDE)
			Case $Reg_Button
				GUICtrlSetState($Reg_Button, $GUI_HIDE)
				GUICtrlSetState($Login_Button, $GUI_HIDE)
				GUICtrlSetState($Label_Or, $GUI_HIDE)
				WinMove($GUILOGIN, '', Default, Default, Default, 142 + 32 * 4)
				GUICtrlSetState($RePassword, $GUI_SHOW)
				GUICtrlSetState($RePassword_txt, $GUI_SHOW)
				GUICtrlSetState($Name, $GUI_SHOW)
				GUICtrlSetState($Name_txt, $GUI_SHOW)
				GUICtrlSetState($Email, $GUI_SHOW)
				GUICtrlSetState($Email_txt, $GUI_SHOW)
				GUICtrlSetState($RegOK_Button, $GUI_SHOW)
				GUICtrlSetState($Cancel_Button, $GUI_SHOW)
				GUICtrlSetState($Label_Or2, $GUI_SHOW)
		EndSwitch
	WEnd
EndFunc   ;==>_Login


Func _GUIMAIN()
	If $USER_DETAILS = '' Or $USER_DETAILS = Null Then Return 0
	$GUIMAIN = GUICreate("Simple System", 322, 195, -1, -1)
	$Info1 = GUICtrlCreateLabel("Tên: " & $USER_DETAILS[2], 32, 32, 186, 17)
	$Info2 = GUICtrlCreateLabel("Email: " & $USER_DETAILS[3], 32, 64, 192, 17)
	$Change1 = GUICtrlCreateButton("Đổi", 224, 32, 67, 17)
	$Change2 = GUICtrlCreateButton("Đổi", 224, 64, 67, 17)
	$Get_Trial = GUICtrlCreateButton("Get Trial", 224, 94, 67, 17)
	GUICtrlCreateGroup("Thông tin", 8, 8, 305, 113)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$vaild_text = GUICtrlCreateLabel("", 32, 96, 190, 17)
	$user_func = GUICtrlCreateButton("SỬ DỤNG", 112, 128, 91, 57)
	$add_coin = GUICtrlCreateButton("NẠP LẦN", 16, 128, 91, 57)
	$Admin_func = GUICtrlCreateButton("ADMIN FUNC", 208, 128, 91, 57)
	GUICtrlSetData($vaild_text, 'Sử dụng được ' & $USER_DETAILS[5] & ' lần')
	GUISetState(@SW_SHOW)

	While 1
		If $USER_CHANGE Then ; kiểm tra thông tin thay đổi
			$USER_CHANGE = False
			GUICtrlSetData($Info1, "Tên: " & $USER_DETAILS[2])
			GUICtrlSetData($Info2, "Email: " & $USER_DETAILS[3])
			If Number(_SS_GetInfo()[2]) = 1 Then
				GUICtrlSetData($add_coin, 'NẠP NGÀY')
				GUICtrlSetData($vaild_text, 'Sử dụng đến ' & StringRight($USER_DETAILS[5], 2) & '/' & StringMid($USER_DETAILS[5], 5, 2) & '/' & StringLeft($USER_DETAILS[5], 4))
			Else
				GUICtrlSetData($add_coin, 'NẠP LẦN')
				GUICtrlSetData($vaild_text, 'Sử dụng được ' & $USER_DETAILS[5] & ' lần')
			EndIf
		EndIf
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $Admin_func
				_ADMINGUI()
			Case $Get_Trial
				MsgBox(64,'Thông tin','Phiên bản lite không có tính năng này')
			Case $add_coin
				If _SS_AddCode() Then GUICtrlSetData($vaild_text, 'Sử dụng được ' & $USER_DETAILS[5] & ' lần')
			Case $user_func
				If _SS_CheckVaild() Then ; kiểm tra hạn dùng
					$ss = _SS_CFC('userfunc') ; call func command lên php
					MsgBox(64, 'Hi', 'Secret Text: ' & $ss)
				Else
					MsgBox(16, 'Thông báo', 'Tài khoản đã hết hạn dùng hãy Nạp sử dụng')
				EndIf
			Case $Change1
				$ib = InputBox('Nhập tên', 'Nhập tên mới')
				If $ib <> '' And Not @error Then
					_SS_ChangeInfo('name', $ib)
					GUICtrlSetData($Info1, "Tên: " & $USER_DETAILS[2])
				EndIf
			Case $Change2
				$ib = InputBox('Nhập email', 'Nhập email mới')
				If $ib <> '' And Not @error Then
					_SS_ChangeInfo('email', $ib)
					GUICtrlSetData($Info2, "Email: " & $USER_DETAILS[3])
				EndIf
			Case $GUI_EVENT_CLOSE
				Exit
		EndSwitch
	WEnd

EndFunc   ;==>_GUIMAIN


Func _ADMINGUI()
if not  _SS_Admin_IsAdmin() Then
	MsgBox(16,'Thông báo', 'Bạn không phải là admin')
	Return 0
Endif

$GUIADMIN = GUICreate("Admin Simple System", 480, 238, -1, -1)
$txt_member = GUICtrlCreateLabel("List member:", 16, 8, 63, 17)
$ListView = GUICtrlCreateListView("acc|name|email|vaild|status|type", 8, 32, 465, 161)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 60)
$Button1 = GUICtrlCreateButton("Change Name", 8, 200, 83, 25)
$Button2 = GUICtrlCreateButton("Change Pass", 96, 200, 83, 25)
$Button3 = GUICtrlCreateButton("Change Vaild", 184, 200, 91, 25)
$Button4 = GUICtrlCreateButton("Block Account", 280, 200, 91, 25)
$Button5 = GUICtrlCreateButton("Add Admin", 376, 200, 91, 25)
$list_mem = _SS_Admin_GetListMember()
if IsArray($list_mem) Then
	For $x In $list_mem
		GUICtrlCreateListViewItem($x, $ListView)
	Next
EndIf
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Button1, $Button2, $Button3, $Button4, $Button5
			$acc = GUICtrlRead(GUICtrlRead($ListView))
			if $acc = '' Then
				MsgBox(16,'Thông báo','Vui lòng chọn 1 account')
			Else
				$acc = StringSplit($acc,'|')
				$info = ''
				Switch $nMsg
					Case $Button1
						$info = 'name'
					Case $Button2
						$info = 'pass'
					Case $Button3
						$info = 'vaild'
					Case $Button4
						$info = 'status'
					Case $Button5
						$info = 'type'
				EndSwitch
				$ib = InputBox('Nhập','Nhập thông tin thay đổi tại đây')
				if not @error and $ib <> '' Then
					if _SS_Admin_ChangeInfo($acc[1],$info, $ib) Then
						_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView))
						$list_mem = _SS_Admin_GetListMember()
						if IsArray($list_mem) Then
							For $x In $list_mem
								GUICtrlCreateListViewItem($x, $ListView)
							Next
						EndIf
					Else
						MsgBox(16,'Thông báo','Thất bại')
					EndIf
				EndIf
			EndIf
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd
EndFunc