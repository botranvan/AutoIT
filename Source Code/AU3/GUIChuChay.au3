#cs ==========================================================
- Thiết kế: Hola
- AutoIT: v3.3.6.1
- Chức năng: Tạo 1 dòng chữ chạy hiện trong Label
#ce ==========================================================
#include <GUIConstants.au3>
Global $String = "Nhập dòng chữ bạn muốn chạy vào đây"
Global $Cur_Str = ""
Opt("GUIOnEventMode", 1)
$Main = GUICreate("Chữ Chạy | 72ls.NET",300,100)
GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
$Ip = GUICtrlCreateInput($String,10,10,280,21)
$Lb = GUICtrlCreateLabel("",10,40,280,21)
GUISetState()

While 1
	Sleep(270)
	_update_str()
	If $Cur_Str <> "" Then	;Nếu $Cur_Str khác rỗng thì tạo hiệu ứng chạy 
		$Cur_Str = $Cur_Str & StringLeft($Cur_Str,1)
		$Cur_Str = StringRight($Cur_Str,StringLen($Cur_Str)-1)
		GUICtrlSetData($LB,$Cur_Str)
	EndIf
WEnd

Func _update_str()
	$Str = GUICtrlRead($IP)
	If $Str <> $String Then ;Nếu chuỗi mới được nhập thì mới cập nhật vào $Cur_Str
		$String = $Str
		$Cur_Str = " " & $String
	EndIf
EndFunc		;=>_update_str

Func _exit()
	Exit
EndFunc		;=>_exit