;~ Chương trình lấy mã màu
;~ #include <GUIConstants.au3>
#include <WindowsConstants.au3>

$Hex1=False
$Hex2=False
$Hex3=False

Global $Running = True
Opt("GUIOnEventMode", 1)
$Form1_1 = GUICreate("Test Color", 418, 151, 313, 209,$WS_POPUP)
GUISetBkColor(0xFFFFFF,$Form1_1)

$Input1 = GUICtrlCreateInput(Int(Random(0xFFFFFF)), 16, 96, 97, 21)
$Button1 = GUICtrlCreateButton("Ok", 32, 120, 27, 25, 0)
GUICtrlSetOnEvent(-1, "AButton1Click")
$Button2 = GUICtrlCreateButton("=>Hex", 72, 120, 51, 25, 0)
GUICtrlSetOnEvent(-1, "AButton2Click")
$Graphic1 = GUICtrlCreateGraphic(8, 0, 129, 89)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, Int(GUICtrlRead($Input1)))
GUICtrlSetTip($Graphic1,"0x"&Hex(Int(GUICtrlRead($Input1)),6))

$Input2 = GUICtrlCreateInput(Int(Random(0xFFFFFF)), 152, 96, 97, 21)
$Button3 = GUICtrlCreateButton("Ok", 168, 120, 27, 25, 0)
GUICtrlSetOnEvent(-1, "AButton3Click")
$Button4 = GUICtrlCreateButton("=>Hex", 208, 120, 51, 25, 0)
GUICtrlSetOnEvent(-1, "AButton4Click")
$Graphic2 = GUICtrlCreateGraphic(144, 0, 129, 89)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, Int(GUICtrlRead($Input2)))
GUICtrlSetTip($Graphic2,"0x"&Hex(Int(GUICtrlRead($Input2)),6))
	
$Input3 = GUICtrlCreateInput(Int(Random(0xFFFFFF)), 288, 96, 97, 21)
$Button5 = GUICtrlCreateButton("Ok", 304, 120, 27, 25, 0)
GUICtrlSetOnEvent(-1, "AButton5Click")
$Button6 = GUICtrlCreateButton("=>Hex", 344, 120, 51, 25, 0)
GUICtrlSetOnEvent(-1, "AButton6Click")
$Graphic3 = GUICtrlCreateGraphic(280, 0, 129, 89)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, Int(GUICtrlRead($Input3)))
GUICtrlSetTip($Graphic3,"0x"&Hex(Int(GUICtrlRead($Input3)),6))

$Button7 = GUICtrlCreateButton("X", 1, 120, 23, 25, 0)
GUICtrlSetOnEvent(-1, "AButton7Click")
GUISetState(@SW_SHOW)

While $Running
	Sleep(100)
WEnd
		
;Đóng chương trình		
Func AButton7Click()
 GUIDelete($Form1_1)
 $Running = False
EndFunc
		
Func AButton1Click()
	GUICtrlSetBkColor($Graphic1,GUICtrlRead($Input1))
;~ 	GUICtrlSetTip($Graphic1,"0x"&Hex(Int(GUICtrlRead($Input1)),6))
EndFunc

		
Func AButton2Click()
	$Hex1=Not $Hex1
	If $Hex1 Then
		GUICtrlSetData($Button2,"=>Dec")
		GUICtrlSetData($Input1,"0x"&Hex(Int(GUICtrlRead($Input1)),6))
		GUICtrlSetTip($Graphic1,Int(GUICtrlRead($Input1)))
	Else
		GUICtrlSetData($Button2,"=>Hex")
		GUICtrlSetData($Input1,Int(GUICtrlRead($Input1)))
		GUICtrlSetTip($Graphic1,"0x"&Hex(Int(GUICtrlRead($Input1)),6))
	EndIf
EndFunc

		
Func AButton3Click()
	GUICtrlSetBkColor($Graphic2,GUICtrlRead($Input2))
;~ 	GUICtrlSetTip($Graphic2,"0x"&Hex(Int(GUICtrlRead($Input3)),6))
EndFunc

		
Func AButton4Click()
	$Hex2=Not $Hex2
	If $Hex2 Then
		GUICtrlSetData($Button4,"=>Dec")
		GUICtrlSetData($Input2,"0x"&Hex(Int(GUICtrlRead($Input2)),6))
		GUICtrlSetTip($Graphic2,Int(GUICtrlRead($Input2)))
	Else
		GUICtrlSetData($Button4,"=>Hex")
		GUICtrlSetData($Input2,Int(GUICtrlRead($Input2)))
		GUICtrlSetTip($Graphic2,"0x"&Hex(Int(GUICtrlRead($Input2)),6))
	EndIf
EndFunc

		
Func AButton5Click()
	GUICtrlSetBkColor($Graphic3,GUICtrlRead($Input3))
;~ 	GUICtrlSetTip($Graphic1,"0x"&Hex(Int(GUICtrlRead($Input1)),6))
EndFunc

		
Func AButton6Click()
	$Hex3=Not $Hex3
	If $Hex3 Then
		GUICtrlSetData($Button6,"=>Dec")
		GUICtrlSetData($Input3,"0x"&Hex(Int(GUICtrlRead($Input3)),6))
		GUICtrlSetTip($Graphic3,Int(GUICtrlRead($Input3)))
	Else
		GUICtrlSetData($Button6,"=>Hex")
		GUICtrlSetData($Input3,Int(GUICtrlRead($Input3)))
		GUICtrlSetTip($Graphic3,"0x"&Hex(Int(GUICtrlRead($Input3)),6))
	EndIf
EndFunc
