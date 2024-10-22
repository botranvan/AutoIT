;====================================================
;============= Encryption Tool With GUI =============
;====================================================
; AutoIt version: 3.0.103
; Language:       English
; Author:         "Wolvereness"
; Edit:           "Trần Tiến Thành"
; ----------------------------------------------------------------------------
; Script Start
; ----------------------------------------------------------------------------
#include <GuiConstantsEx.au3>
#include <String.au3>
#Include <WinAPI.au3>
Global $WinMain
Global $EditText, $InputPass, $InputLevel, $UpDownLevel
Global $EncryptButton, $DecryptButton, $NewButton, $OpenButton, $SaveButton, $SaveAsButton, $CopyButton
Global $string, $font, $Width
Global $OpenFile, $SaveFile, $SaveAsFile
Global $Lv_Decrypt = 0, $Lv_Ecrypt = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Đang tiến hành chỉnh sửa lại Last open và Last save, New file và thoát chương trình
;Cần thêm tính năng cứu nguy dữ liệu khi mất điện
;Global $RegKey = "HKEY_LOCAL_MACHINE\SOFTWARE\Ecrypt_Decrypt"
;Global $OpenDir, $LastOpenDir = @ScriptDir & "\"
;Global $RegLastOpen = "LastOpen"
;Global $RegLastSave = "LastSave"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Opt("MustDeclareVars", 1)

_Main()

Func _Main()
	$font = "Courier New"
	$WinMain = GUICreate("Công cụ mã hóa thông tin", 400, 440)
	$Width = _WinAPI_GetWindowWidth($WinMain)
	
	$NewButton = GUICtrlCreateButton("&New", 5, 5, ($Width-10)/5-5, 35)
	GUICtrlSetTip(-1, "Tạo tập tin mới")
	
	$OpenButton = GUICtrlCreateButton("&Open", $Width/5, 5, ($Width-10)/5-5, 35)
	GUICtrlSetTip(-1, "Mở tệp tin")
	
	$SaveButton = GUICtrlCreateButton("&Save", 2*$Width/5, 5, ($Width-10)/5-5, 35)
	GUICtrlSetTip(-1, "Lưu tệp tin")	
	GUICtrlSetState($SaveButton, $GUI_DISABLE)
	
	$SaveAsButton = GUICtrlCreateButton("Save &As", 3*$Width/5, 5, ($Width-10)/5-5, 35)
	GUICtrlSetTip(-1, "Lưu tệp tin vào file khác")
	
	$CopyButton = GUICtrlCreateButton("Copy", 4*$Width/5-5, 5, ($Width-10)/5-5, 35)
	GUICtrlSetTip(-1, "Copy thông tin vào bộ nhớ")
	
	$EditText = GUICtrlCreateEdit('', 5, 45, 380, 350)
	GUIctrlSetFont(-1, 9, 400, Default, $font)
	
	$InputPass = GUICtrlCreateInput('', 5, 400, 100, 20, 0x21)
	GUICtrlSetTip(-1, "Mật khẩu mã hóa/giải mã")
	
	$InputLevel = GUICtrlCreateInput(1, 110, 400, 50, 20, 0x2001)
	GUICtrlSetTip(-1, "Cấp độ mã hóa/giải mã")
	$UpDownLevel = GUICtrlSetLimit(GUICtrlCreateUpdown($InputLevel), 10, 1)
	
	$EncryptButton = GUICtrlCreateButton('&Mã hóa', 170, 400, 105, 35)
	
	$DecryptButton = GUICtrlCreateButton('&Giải mã', 285, 400, 105, 35)
	
	GUICtrlCreateLabel('Mật khẩu', 5, 425)
	
	GUICtrlCreateLabel('Cấp độ', 110, 425)
	GUISetState()
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Thoat()
			Case $EncryptButton
				Ecrypt()
			Case $DecryptButton
				Decrypt()
			Case $NewButton
				NewFile()
			Case $OpenButton
				OpenFile()
			Case $SaveButton
				SaveFile()
			Case $SaveAsButton
				SaveAsFile()
			Case $CopyButton
				Copy()
			EndSwitch
			Sleep(100)
	WEnd
EndFunc
;Hàm mã hóa file
Func Ecrypt()
	If GUICtrlRead($InputPass) = "" Then
		MsgBox(0, "Thông báo", "Bạn chưa đặt mật khẩu mã hóa")
	Else
		GUISetState(@SW_DISABLE, $WinMain)
		$Lv_Ecrypt = $Lv_Ecrypt + 1
		$string = GUICtrlRead($EditText)
		GUICtrlSetData($EditText, 'Quá trình mã hóa đang làm việc với: '&@CRLF&"Cấp độ mã hóa: "&GUICtrlRead($InputLevel)&@CRLF&"Mã hóa lần thứ: "&$Lv_Ecrypt)
		GUICtrlSetData($EditText, _StringEncrypt(1, $string, GUICtrlRead($InputPass), GUICtrlRead($InputLevel)))
		GUISetState(@SW_ENABLE, $WinMain)
	EndIf
EndFunc
;Hàm giải mã
Func Decrypt()
	If GUICtrlRead($InputPass) = "" Then
		MsgBox(0, "Thông báo", "Bạn chưa có mật khẩu giải mã")
	Else
		GUISetState(@SW_DISABLE, $WinMain)
		$Lv_Decrypt = $Lv_Decrypt + 1
		$string = GUICtrlRead($EditText)
		GUICtrlSetData($EditText, 'Quá trình giải mã đang làm việc với: '&@CRLF&"Cấp độ mã hóa: "&GUICtrlRead($InputLevel)&@CRLF&"Giải mã lần thứ: "&$Lv_Decrypt)
		GUICtrlSetData($EditText, _StringEncrypt(0, $string, GUICtrlRead($InputPass), GUICtrlRead($InputLevel)))
		GUISetState(@SW_ENABLE, $WinMain)
	EndIf
EndFunc
;Hàm đọc mã Registry
Func ReadReg($ValueName)
	RegRead($RegKey, $ValueName)
EndFunc
;Hàm ghi mã Registry
Func WriteReg($ValueName, $iType=7, $Value="")
	Local $Type[7]
	$Type[0] = "REG_SZ"
	$Type[1] = "REG_MULTI_SZ"
	$Type[2] = "REG_EXPAND_SZ"
	$Type[3] = "REG_DWORD"
	$Type[4] = "REG_QWORD"
	$Type[5] = "REG_BINARY"
	$Type[6] = ""
	RegWrite($RegKey, $ValueName, $Type[$iType], $Value)
	If $iType>6 Or $iType<0 Then
		MsgBox(0, "Thông báo", "Không ghi được Registry")
		Exit
	EndIf
EndFunc
;Hàm mở một file mới
Func NewFile()
	Local $Msgbox
	If GUICtrlRead($EditText)<>"" Then
		$Msgbox = MsgBox(1, "Thông báo", "Bạn có ghi lại dữ liệu không?")
		If $Msgbox=1 Then 
			SaveAsFile()
		Else
			Sleep(100)
		EndIf
	EndIf
	GUICtrlSetData($EditText, "")
	GUICtrlSetData($InputPass, "")
	GUICtrlSetData($InputLevel, "1")
	GUICtrlSetState($SaveButton, $GUI_DISABLE)
EndFunc
;Hàm mở file
Func OpenFile()
	$OpenFile = FileOpenDialog("Open File", @ScriptDir&"\", "Text files (*.txt)|INI Files (*.ini)|TTT files (*.ttt)|Log Files (*.log)", 1)
	If @error Then 
		Sleep(100)
	Else
		GUICtrlSetData($EditText, FileRead($OpenFile))
		GUICtrlSetState($SaveButton, $GUI_ENABLE)
	EndIf
EndFunc
;Hàm ghi thông tin
Func SaveFile()
	FileDelete($OpenFile)
	FileWrite($OpenFile, GUICtrlRead($EditText))
EndFunc
;Hàm ghi thông tin vào file khác
Func SaveAsFile()
	If GUICtrlRead($EditText)="" Then
		MsgBox(0, "Thông báo", "Có cái gì đâu mà Lưu?")
	Else
		$SaveAsFile = FileSaveDialog("Save As File", @ScriptDir & "\", "All files (*.*)", 1)
		If @error Then 
			Sleep(100)
		Else
			FileWrite($SaveAsFile, GUICtrlRead($EditText))
		EndIf
	EndIf
EndFunc
;Hàm Copy thông tin vào ClipBoard
Func Copy()
	Local $Copy
	If GUICtrlRead($EditText)="" Then
		ToolTip("Có cái gì đâu mà Copy?", Default, Default, "", 0, 1)
		Sleep(2000)
		ToolTip("")
	Else
		$Copy = ""
		ClipPut($Copy)
		$Copy = GUICtrlRead($EditText)
		ClipPut($Copy)
		ToolTip("Đã Copy", Default, Default, "", 0, 1)
		Sleep(2000)
		ToolTip("")
	EndIf
EndFunc
;Hàm thoát
Func Thoat()
	Local $Msgbox
	If GUICtrlRead($EditText)<>"" Then
		$Msgbox = MsgBox(1, "Thông báo", "Bạn có ghi lại dữ liệu không?")
		If $Msgbox=1 Then 
			SaveAsFile()
		Else	
			Sleep(100)
		EndIf
	EndIf
	Exit
EndFunc