; Chương trình hẹn giờ tắt máy tính
; by Justin Billy @
; Phiên bản v1.0
;
;~ các thu viện
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

; chuyển sang chế độ GuiGetMsg()
Opt("GUICoordMode", 1)

;#NoTrayIcon ; Hết tắt trong sys tray nhá ^^

Global $i,$tg,$ii
;~ GUI
$Form1 = GUICreate("Turn off computer v1.0", 293, 148, 192, 124)
GUISetIcon("C:\Documents and Settings\LY THE MINH\My Documents\Autoit Project\Clock.ico")
$thoi_gian = GUICtrlCreateLabel("Nhập thời gian muốn chờ (tính bằng phút):", 8, 8, 283, 22)
GUICtrlSetFont(-1, 11, 400, 0, "Tahoma")
$tg = GUICtrlCreateInput("1", 8, 40, 201, 22)
$bd = GUICtrlCreateButton("Bắt đầu", 16, 80, 113, 33)
$stop = GUICtrlCreateButton("Thoát", 160, 80, 121, 33)
$status = GUICtrlCreateInput("Turn off Computer v1.0- by Justn Billy @", 8, 120, 273, 22)
GUICtrlSetBkColor(-1, 0x808080)
$Label2 = GUICtrlCreateLabel("phút", 216, 40, 25, 18)
GUISetState(@SW_SHOW)

#NoTrayIcon ; không hiện ở sys tray
MsgBox(0,"Hide","Ấn F1 để ẩn chương trình !")
;MsgBox(64,"Huong dan","Ấn OK để mở chương trình cứu nguy !",3)
;Run(@WorkingDir & "\Kill Process.exe")

; Vòng lặp
While 1
HotKeySet("{ESC}","tt1")
HotKeySet("{F1}","hide")
	$nMsg = GUIGetMsg()
	Select
	;Case $nMsg = $GUI_EVENT_CLOSE ; thoát
	;	Exit
	case $nMsg = $bd ; Bắt đầu
		tinh_gio()
	case $nMsg = $stop ; Stop
		thoat()
EndSelect
WEnd


Func tinh_gio()
GUISetState(@SW_MINIMIZE)

GUICtrlSetData($bd,"Đang chạy . . .")
GUICtrlSetState($bd,$GUI_DISABLE) ; Disable nut Bắt đầu
GUICtrlSetData($stop,"Ấn ESC để thoát !")
GUICtrlSetState($stop,$GUI_DISABLE)

for $i = GUICtrlRead($tg)*60 to 0 step -1 ; trừ dần thời gian cho đến 0
	GUICtrlSetData($thoi_gian,"Muốn thoát, tắt trong Task manager !")
	GUICtrlSetData($status,"Bạn còn "& $i & " giây = " & Round($i/60,1) & " phút" )
$text = "Ấn ESC để thoát chương trình" & @CRLF & _
"Thời gian còn lại : " & $i & " giây = " & Round($i/60,1) & " phút" ; Hàm làm tròn Round
;"Ấn F7 để tắt thông báo, Ấn F8 để mở thông báo" & @CRLF & _
;"Ấn ESC để thoát chương trình ! ^^" & @CRLF & _
;TrayTip("Turn off computer - Tắt máy tự động v1.0",$text,"",1)
ToolTip($text,757,651,"Tắt máy tự động v1.0")
$ii = $i
	Sleep(1000)
		if $i = 0 then tat_may() ; Nếu thời gian = 0 thì tắt máy
Next
EndFunc

Func thoat()
	MsgBox(64,"Turn Off computer","Thanks to use")
	exit
EndFunc


Func tat_may()
	WinKill("winlogon")
	WinClose("winlogon")
	MsgBox(64,"Turn OFF","Tắt máy trong 2 giây nữa !",2)
	Shutdown(1)
EndFunc

Func tt1()
	MsgBox(64,"Turn Off computer","Thanks to use")
	Exit
	;TrayTip("","...") ; ^^ nhiễu Tray Tip --> error --> thoát ^^
EndFunc

Func hide()
	GUISetState(@SW_HIDE)
EndFunc


