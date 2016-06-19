#cs ==================
# Ví dụ về thoát khỏi GUI bằng 1 Event
#ce ==================

;~ Các Include cần
#include <GUIConstantsEx.au3>

;~ Biến chương trình
Dim $Running = False	;True - Đang thực hiện công việc
Dim $RunningI = 0		;Trang thái công việc
Dim $RunningI2 = 0		;Trang thái công việc

;~ Phím nóng ESC để thoát
HotKeySet("{ESC}","ExitAuto")
Func ExitAuto()
	Exit
EndFunc
	
;~ Tạo GUI
AutoItSetOption("GUIOnEventMode",1)
$MainGUI = GUICreate("Exit GUI", 151,77)
GUISetOnEvent($GUI_EVENT_CLOSE,"ExitAuto",$MainGUI)		;Sự kiện cho nút thoát mặc định

;~ Nút thực hiện 1 việc gì đó
$StartButton = GUICtrlCreateButton("Start", 7, 7, 34)
GUICtrlSetOnEvent($StartButton,"StartAuto")

;~ Nút thoát tự tạo
$ExitButton = GUICtrlCreateButton("Exit", 52, 7, 34)
GUICtrlSetOnEvent($ExitButton,"ExitAuto")			;Sự kiện cho nút thoát tự tạo

;~ Lable hiện chữ
$Lable1 = GUICtrlCreateLabel(">", 0, 43)
GUICtrlSetFont($Lable1,16,700)
;~ GUICtrlSetBkColor(-1,0xFFAACC)


GUISetState(@SW_SHOW,$MainGUI)

;~ Vòng lặp giữ GUI và thực hiện công việc
While 1
	Sleep(77) 		;Lệnh để chương trình không nặng
	
	Animation()		;Dùng vòng lặp chính để gọi các Case của Select
	Animation2()	; để làm công việc có tính chất lặp

;~ 	WhileAni()		;Cách thứ 2
WEnd

;~ Thực hiện 1 việc gì đó
Func StartAuto()
	$Running = Not $Running
	If $Running Then 
		$RunningI = 1
		$RunningI2 = 1
	Else
		$RunningI = 0
		$RunningI2 = 0
	EndIf
EndFunc

;~ Cộng việc ví dụ thứ nhất
Func Animation()
	If Not $Running Then 
		Return False
	EndIf
	
	Select
		Case $RunningI=1
			$PosX = @MSEC/5
			GUICtrlSetData($Lable1,">")
 			GUICtrlSetPos($Lable1,$PosX,43)
			If @MSEC > 500 Then $RunningI = 2
		Case $RunningI=2
			$PosX = (1000-@MSEC)/5
			GUICtrlSetData($Lable1,"<")
 			GUICtrlSetPos($Lable1,$PosX,43)
			If @MSEC < 500 Then $RunningI = 1
	EndSelect
EndFunc

;~ Cộng việc ví dụ thứ 2
Func Animation2()
	If Not $Running Then 
		Return False
	EndIf
	
	Select
		Case $RunningI2=1
			$Text = 5-Mod(@SEC,10)
			GUICtrlSetData($StartButton,$Text)
			GUICtrlSetPos($ExitButton,Random(52,61),Random(2,9))
			If Mod(@SEC,10) = 0 Then $RunningI2 = 2
		Case $RunningI2=2
			$Text = 5-Mod(@SEC,10)
			GUICtrlSetData($StartButton,$Text)
 			GUICtrlSetPos($ExitButton,Random(99,115),Random(2,9))
			If Mod(@SEC,10) = 5 Then $RunningI2 = 1
	EndSelect
EndFunc

;~ Dùng một vòng lặp khác để gọi 2 công việc
Func WhileAni()
	While $Running
		Sleep(77)
		Animation()
		Animation2()
	WEnd
EndFunc