;~ Hiệu chỉnh lại GUI
Func MainGUIFix()
	WinMove($MainGUI,"",$AutoPos[0],$AutoPos[1])
	WinSetTitle($MainGUI,"",$AutoName&" v"&$AutoVersion&" | 72ls.NET")
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc

;~ Đóng chương trình
Func MainGUIClose()
	SaveSetting()
	Exit
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
;~ Lấy giá trị từ $Warning_Lable
Func Waring_LSet($NewValue = "")
	Local $Check = Waring_LGet()
	If $Check <> $NewValue Then GUICtrlSetData($Waring_L,$NewValue)
EndFunc

;~ Mở trang chủ nơi tải chương trình
Func HomePage_BClick()
		_IECreate($HomePage,1,1,0)
EndFunc
	
;~ Lập giá trị cho $LGold
Func LGold_Get()
	Return GUICtrlRead($LGold)
EndFunc
;~ Lấy giá trị từ $LGold
Func LGold_Set($NewValue = "")
	Local $Check = LGold_Get()
	If $Check <> $NewValue Then GUICtrlSetData($LGold,$NewValue)
EndFunc	
	
	
	