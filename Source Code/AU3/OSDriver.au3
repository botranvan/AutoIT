#cs ==================
# Ví dụ về thoát khỏi GUI bằng 1 Event
#ce ==================

;~ Các Include cần
#include <GUIConstantsEx.au3>

;~ Phím nóng ESC để thoát
HotKeySet("{ESC}","ExitAuto")
Func ExitAuto()
	Exit
EndFunc
	
;~ Tạo GUI
AutoItSetOption("GUIOnEventMode",1)
$MainGUI = GUICreate("Check OS", 151,77)
GUISetOnEvent($GUI_EVENT_CLOSE,"ExitAuto",$MainGUI)		;Sự kiện cho nút thoát mặc định

;~ Nút thực hiện 1 việc gì đó
$StartButton = GUICtrlCreateButton("Check", 7, 7, 43)
GUICtrlSetOnEvent($StartButton,"StartAuto")

;~ Lable hiện chữ
$Lable1 = GUICtrlCreateLabel("", 7, 43,151,25)

GUISetState(@SW_SHOW,$MainGUI)

;~ Vòng lặp giữ GUI và thực hiện công việc
While 1
	Sleep(77) 		;Lệnh để chương trình không nặng
WEnd

;~ Thực hiện 1 việc gì đó
Func StartAuto()
	$Text = @SystemDir
	GUICtrlSetData($Lable1,$Text)
	$Drive = StringLeft($Text,3)
	msgbox(0,"OS","Bạn đã cài Win vào ổ "&$Drive)
EndFunc
