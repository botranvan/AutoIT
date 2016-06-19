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
	
;~ Lập giá trị cho $ipPage
Func ipPageGet()
	Return GUICtrlRead($ipPage)
EndFunc
;~ Lấy giá trị từ $ipPage
Func ipPageSet($NewValue = "")
	Local $Check = ipPageGet()
	If $Check <> $NewValue Then GUICtrlSetData($ipPage,$NewValue)
EndFunc	
	
;~ Lập giá trị cho $ipPageItem
Func ipPageItemGet()
	Return GUICtrlRead($ipPageItem)
EndFunc
;~ Lấy giá trị từ $ipPageItem
Func ipPageItemSet($NewValue = "")
	Local $Check = ipPageItemGet()
	If $Check <> $NewValue Then GUICtrlSetData($ipPageItem,$NewValue)
EndFunc		
	
;~ Lập giá trị cho $ipWidth
Func ipWidthGet()
	Return GUICtrlRead($ipWidth)
EndFunc
;~ Lấy giá trị từ $ipWidth
Func ipWidthSet($NewValue = "")
	Local $Check = ipWidthGet()
	If $Check <> $NewValue Then GUICtrlSetData($ipWidth,$NewValue)
EndFunc			
	
;~ Lập giá trị cho $ipWidth
Func ipHeightGet()
	Return GUICtrlRead($ipHeight)
EndFunc
;~ Lấy giá trị từ $ipWidth
Func ipHeightSet($NewValue = "")
	Local $Check = ipHeightGet()
	If $Check <> $NewValue Then GUICtrlSetData($ipHeight,$NewValue)
EndFunc			
	
;~ Mở trang chủ nơi tải chương trình
Func HomePage_BClick()
	_IECreate($HomePage,1,1,0)
EndFunc

;~ Lập giá trị cho $Warning_Lable
Func bStartClickGet()
	Return GUICtrlRead($bStart)
EndFunc
;~ Lấy giá trị từ $Warning_Lable
Func bStartClickSet($NewValue = "")
	Local $Check = bStartClickGet()
	If $Check <> $NewValue Then GUICtrlSetData($bStart,$NewValue)
EndFunc

;~ Lập giá trị cho $Warning_Lable
Func inKeyGet()
	Return GUICtrlRead($inKey)
EndFunc
;~ Lấy giá trị từ $Warning_Lable
Func inKeySet($NewValue = "")
	Local $Check = inKeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($inKey,$NewValue)
EndFunc	
	
;~ Kích hoạt chức năng tự tạo Content
Func bStartClick()
	$Finding = Not $Finding
	$FindingStart = ipPageItemGet() * ipPageGet()
	
	If $Finding Then
		bStartClickSet("Stop")
	Else
		bStartClickSet("Start")
	EndIf
EndFunc