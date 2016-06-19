#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $kqlabel1,$kqlabel2
$Form1 = GUICreate("My Gui", 316, 209, 193, 125)
$Button1 = GUICtrlCreateButton("Check", 104, 168, 75, 25, 0)
$Combo1 = GUICtrlCreateCombo("5", 136, 72, 145, 25)
GUICtrlSetData(-1,"50|100",5)
$Radio1 = GUICtrlCreateRadio("Tổng", 24, 24, 113, 17)
GUICtrlSetState($radio1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("Hiệu", 24, 48, 113, 17)
$Radio3 = GUICtrlCreateRadio("Chia", 24, 72, 113, 17)
$Input1 = GUICtrlCreateInput("Input1", 136, 24, 121, 21)
$Input2 = GUICtrlCreateInput("Input2", 136, 48, 121, 21)
$Label1 = GUICtrlCreateLabel("Label1", 40, 110, 50, 50)
$Label2 = GUICtrlCreateLabel("Label1", 140, 110, 50, 50)
$Label3 = GUICtrlCreateLabel("Label3", 240, 110, 50, 50)
GUISetState(@SW_SHOW)
While 1
	$msg = GUIGetMsg()	
		Select
			Case $msg=$Button1 And BitAND(GUICtrlRead($radio1), $GUI_CHECKED) = $GUI_CHECKED
				$kqlabel1=(GUICtrlRead($Input1) + GUICtrlRead($Input2))*1
				GUICtrlSetData($Label1,$kqlabel1)
				$kqlabel2=(GUICtrlRead($Combo1))
				GUICtrlSetData($Label2,$kqlabel2)
				If $kqlabel1> $kqlabel2 then GUICtrlSetData($Label3,"Tổng lớn hơn Số Đã Chọn")  
				if $kqlabel1< $kqlabel2 then GUICtrlSetData($Label3,"Tổng nhỏ hơn Số Đã Chọn")
			
			Case $msg=$Button1 And BitAND(GUICtrlRead($radio2), $GUI_CHECKED) = $GUI_CHECKED
				$kqlabel1=(GUICtrlRead($Input1) - GUICtrlRead($Input2))*1
				GUICtrlSetData($Label1,$kqlabel1)
				$kqlabel2=(GUICtrlRead($Combo1))
				GUICtrlSetData($Label2,$kqlabel2)
				If $kqlabel1> $kqlabel2 then GUICtrlSetData($Label3,"Hiệu lớn hơn Số Đã Chọn") 
				if $kqlabel1< $kqlabel2 then GUICtrlSetData($Label3,"Hiệu nhỏ hơn Số Đã Chọn")
			
			Case $msg=$Button1 And BitAND(GUICtrlRead($radio3), $GUI_CHECKED) = $GUI_CHECKED
				$kqlabel1=(GUICtrlRead($Input1) / GUICtrlRead($Input2))*1
				GUICtrlSetData($Label1,$kqlabel1)
				$kqlabel2=(GUICtrlRead($Combo1))
				GUICtrlSetData($Label2,$kqlabel2)
				If $kqlabel1> $kqlabel2 then GUICtrlSetData($Label3,"Phân số lớn hơn Số Đã Chọn") 
				if $kqlabel1< $kqlabel2 then GUICtrlSetData($Label3,"Phân số nhỏ hơn Số Đã Chọn")		
					
			Case $msg=$GUI_EVENT_CLOSE
				Exit			
	
	EndSelect
WEnd


