#include <GUIConstantsEx.au3>

HotKeySet ("{END}","ExitAuto")					;End 	- Thoát Auto

;~ Tạo GUI
$MainGUI=GUICreate("PTB2",205,106)

;~ Tạo chỗ nhập hệ số A
$hsA = GUICtrlCreateInput("[Hệ số A]",0,0)

;~ Tạo chỗ nhập hệ số B
$hsB = GUICtrlCreateInput("[Hệ số B]",0,25)

;~ Tạo chỗ nhập hệ số C
$hsC = GUICtrlCreateInput("[Hệ số C]",0,52)

;~ Tạo nút Tính Kết Quả
$button = GUICtrlCreateButton("Tính",77,77)

;~ Hiển thị GUI
GUISetState(@SW_SHOW,$MainGUI)

;~ Vòng lặp giữ cho GUI tồn tại
While 1
	$msg = GUIGetMsg()
	Sleep(7)
	
;~ Tạo chức năng cho nút Tính Kết Quả	
	If $msg = $button Then TinhPTB2()
		
;~ 	Thoát chương trình khi bấm dấu X
	If $msg = $GUI_EVENT_CLOSE Then ExitAuto()
WEnd

;~ Hàm thoát Auto
Func ExitAuto()
	GUIDelete($MainGUI)
	Exit
EndFunc



Func TinhPTB2()
	;~ Nhập liệu
	$cosoa = GUICtrlRead($hsA)
	$cosob = GUICtrlRead($hsB)
	$cosoc = GUICtrlRead($hsC)

	;~ Tính Denta
	$bbinh = $cosob * $cosob
	$ac = $cosoa * $cosoc
	$denta = $bbinh - ($ac + $ac +$ac +$ac)
	IF $denta>0 Then
		$nghiem1 = (-$cosob- sqrt($denta)) / ($cosoa + $cosoa)
		$nghiem2 = -($cosob / $cosoa) - $nghiem1
		MsgBox(0,"Phương Trình Bậc 2","Nhiệm 1: "&$nghiem1&@CRLF&"Nhiệmm 2: "&$nghiem2)
	ElseIf $denta=0 Then
		$nghiem = -$cosob / ($cosoa + $cosoa)
		MsgBox(0,"Phương Trình Bậc 2","Nhiệm : "&$nghiem)
	ElseIf $denta<0 Then
		MsgBox(0,"Phương Trình Bậc 2","Phương Trình Vô Nhiệm")
	EndIf
EndFunc