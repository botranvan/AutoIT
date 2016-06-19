;~ Hiệu chỉnh lại GUI
Func MainGUIFix()
	WinMove($MainGUI,"",$AutoPos[0],$AutoPos[1],$AutoSize[0],$AutoSize[1])
	WinSetTitle($MainGUI,"",$FlashName&" | "&$AutoName&" v"&$AutoVersion&" | 72ls.NET")
	GUISetOnEvent($GUI_EVENT_RESIZED, "MainGUIResize")
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc

;~ Đóng chương trình
Func MainGUIClose()
	SaveSetting()
	Exit
EndFunc

;~ Hiểu chỉnh kích thước GUI
Func MainGUIResize()
	Local $MainSize = WinGetPos($MainGUI)
	FlashControlSetSize($MainSize[2],$MainSize[3])
EndFunc

;~ Ẩn chương trình
Func Hidden_BClick()
	$AutoHide = Not $AutoHide
	If $AutoHide Then
		$AutoPos = WinGetPos($MainGUI)
		GUICtrlSetData($Hidden_B,"\/")
		WinMove($MaingUI,"",$AutoPos[0],0-$AutoPos[3]+27,Default,Default,2)
	Else
		GUICtrlSetData($Hidden_B,"/\")
		WinMove($MaingUI,"",$AutoPos[0],$AutoPos[1])
	EndIf
EndFunc

;~ Lập giá trị cho $Warning_Lable
Func Waring_LGet()
	Return GUICtrlRead($Waring_L)
EndFunc
;~ Lập giá trị cho $Warning_Lable
Func Waring_LSet($NewValue = "")
	Local $Check = Waring_LGet()
	If $Check <> $NewValue Then GUICtrlSetData($Waring_L,$NewValue)
EndFunc

;~ Mở trang chủ nơi tải chương trình
Func HomePage_BClick()
		_IECreate($HomePage,1,1,0)
EndFunc