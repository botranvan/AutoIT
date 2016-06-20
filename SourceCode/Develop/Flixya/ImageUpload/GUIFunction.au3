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
;~ Lập giá trị cho $Warning_Lable
Func Waring_LSet($NewValue = "")
	Local $Check = Waring_LGet()
	If $Check <> $NewValue Then GUICtrlSetData($Waring_L,$NewValue)
EndFunc

;~ Mở trang chủ nơi tải chương trình
Func HomePage_BClick()
		_IECreate($HomePage,1,1,0)
EndFunc
	
;~ Lấy ảnh từ Folder được chỉ định
Func ImageGetBClick()
	Local $Path = GUICtrlRead($ImagesPathI)&"\*.*"
	Local $Search = FileFindFirstFile($Path)
	ReDim $ImageList[1]
	$ImageList[0] = 0
	While 1
		$File = FileFindNextFile($Search) 
		If @error Then ExitLoop
		If StringInStr($File,'.GIF') Then ;GIF, PNG
			_ArrayAdd($ImageList,$File)
			$ImageList[0] +=1
		EndIf
	WEnd
	$CurImage = 0
	ImageGetLSet("Found "&$ImageList[0]&" Images")
	ImageUpLSet("Uploaded 0 / "&$ImageList[0]&" Images")
EndFunc

;~ Lập giá trị cho $ImageGetL
Func ImageGetLGet()
	Return GUICtrlRead($ImageGetL)
EndFunc
;~ Lập giá trị cho $ImageGetL
Func ImageGetLSet($NewValue = "")
	Local $Check = ImageGetLGet()
	If $Check <> $NewValue Then GUICtrlSetData($ImageGetL,$NewValue)
EndFunc

;~ Lập giá trị cho $ImageUpL
Func ImageUpLGet()
	Return GUICtrlRead($ImageUpL)
EndFunc
;~ Lập giá trị cho $ImageUpL
Func ImageUpLSet($NewValue = "")
	Local $Check = ImageGetLGet()
	If $Check <> $NewValue Then GUICtrlSetData($ImageUpL,$NewValue)
EndFunc




