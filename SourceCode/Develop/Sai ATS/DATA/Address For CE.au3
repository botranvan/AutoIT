#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.2.12.1
 Author:         Saihukaru

 Hướng dẫn: 
 - Chạy CE trước xong chạy chương trình này.
 - Thay đổi các biến ngay bên dưới để nhập liệu cho CE.
 - Mỗi lần chạy nên Restart CE để các thông số của nó về mặc định.
#ce ----------------------------------------------------------------------------

HotKeySet ("{PAUSE}","ActivePauseAuto")				;Pause				- Tạm Dừng Auto
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto

;~ Biến hiệu chỉnh Address
Global $IsPointer=True				;Chỉ số số là Con Trỏ
Global $BaseAddress="00EC53E0"		;Địa chỉ gốc bằng số Hex
Global $MiddleOffset=0				;Offset thêm bằng số Dec
Global $StarOffset=1743				;Chỉ số đầu bằng số Dec
Global $EndOffset=1872				;Chỉ số cuối bằng số Dec
Global $ValueType="4 Byte"			;Dạng số 4 Byte 
;~ Global $ValueType="Text"			;Dạng chữ

;~ Biến hiệu chỉnh chương trình
Global $Pause=False				;True - Tạm dừng chương trình
Global $CE_Handle=""			;Handle của CE
Global $AddAddress_Handle=""	;Handle của Add Address Window
Global $Speed=106				;Tốc độ chạy, số nhỏ quá sẽ có nhiều lỗi nhập liệu

$ToolTipT1="Chương trình tự tạo Address cho Cheat Engine."

ToolTip($ToolTipT1,0,0)
;Lấy tất mã số cần dùng của CE
GetAllHandle()

;~ Đợi 2 giây
For $i=1 To 1 Step -1
	ToolTip($ToolTipT1&@LF&"Bắt đầu trong: "&$i&" giây",0,0)
	Sleep(1000)
Next

ToolTip($ToolTipT1,0,0)

If $IsPointer Then 
	AddPointer()
Else
;~ 	AddAddress()
EndIf
	
;~ =====================================================================================================================================	
Func ActivePauseAuto()
	$Pause = Not $Pause
	If $Pause Then 
		ToolTip("Pause",0,0)
		While $Pause
			Sleep(777)
		WEnd
	Else
		ToolTip($ToolTipT1,0,0)
	EndIf
		
EndFunc

Func ExitAuto()
	Exit
EndFunc

;~ Hàm lấy tất các Handle cần dùng
Func GetAllHandle()
;~ 	CE Handle
	$CE_Handle = WinGetHandle("[TITLE:Cheat Engine; CLASS:TMainForm]")
	If $CE_Handle="" Then 
		MsgBox(0,"Sai", "Cần khởi động Cheat Engine 5.4 trước")
		Exit
	EndIf	
	;~ CE ontop
	WinActivate($CE_Handle)

;~ 	Bấm nút Add Address Manually
	ControlClick($CE_Handle,"","[CLASS:TButton; INSTANCE:2]")
	
;~ 	Lấy Handle của Add Address Window
	$AddAddress_Handle=WinGetHandle("Add address","Pointer")
	
	Send("{ESC}")
EndFunc

;~ Hàm thêm con trỏ vào CE
Func AddPointer()
	Local $CheckBox=1 ;Instance của CheckPointer với dữ liệu loại 4Byte
	Local $EditBox=2 ; Instance của DescriptionBox với dữ liệu loại 4Byte
	
	;~ Ghi địa chỉ vào CE
	For $i=$StarOffSet To $EndOffSet Step 1
		ToolTip(Hex($StarOffSet)&" => "&Hex($EndOffSet)&": "&Hex($i)&" ~ "&$EndOffSet-$i,0,0)
		
;~ 		Bấm nút Add Address Manually
		ControlClick($CE_Handle,"","[CLASS:TButton; INSTANCE:2]")
		
;~ 		Ghi chú
		ControlSetText($AddAddress_Handle,"","[CLASS:TEdit; INSTANCE:"&$EditBox&"]",Hex($i))
			
;~ 		Check Pointer
		ControlCommand($AddAddress_Handle,"","[CLASS:TCheckBox; INSTANCE:"&$CheckBox&"]","Check")
		Sleep($Speed)

;~ 		Nhập BaseAddress
		ControlSetText($AddAddress_Handle,"","[CLASS:TEdit; INSTANCE:2]",$BaseAddress)
		
;~ 		Nhập Offset
		ControlSetText($AddAddress_Handle,"","[CLASS:TEdit; INSTANCE:1]",Hex($MiddleOffset+$i))

;~ 		Chọn kiểu dự liệu khi lần đầu nhập
		If $i = $StarOffSet Then 
			ControlCommand($AddAddress_Handle,"","[CLASS:TComboBox; INSTANCE:1]","ShowDropDown")
			ControlCommand($AddAddress_Handle,"","[CLASS:TComboBox; INSTANCE:1]","SelectString",$ValueType)
			ControlClick($AddAddress_Handle,"","[CLASS:TComboBox; INSTANCE:1]","left",1,52,11)
			
			If $ValueType="Text" Then
;~ 				Lấy độ dài cho Text là 32
				ControlSetText($AddAddress_Handle,"","[CLASS:TEdit; INSTANCE:1]","32")
				$CheckBox=2 ;Tăng Instance của CheckPointer lên đối với dữ liệu loại Text
				$EditBox=3 ;Tăng Instance của DescriptionBox lên đối với dữ liệu loại Text
			EndIf
		EndIf

;~ 		Nhấn Ok
		Send("{Enter}")
	Next
EndFunc
