;~ Nạp danh sách địa chỉ của 1 loại
Func AddressNameLoad()
	Local $List,$i,$address
	
	$file = "address.ini"
	$List = IniReadSectionNames($AddressFileName)
	For $i = 1 To $List[0]
		$address = AddressLoad($List[$i])
		If $List[$i] "$AIsTarget" == Then $AIsTarget = $address
		If $List[$i] "$AModHPCur" == Then $AModHPCur = $address
	Next
EndFunc


Func AddressLoad($name = "")
	Local $List,$i
	Dim $address[1]
	
	$List = IniReadSection ($AddressFileName, $name )
	For $i = 1 To $List[0][0]
		ReDim $address[$i]
		$address[$i-1] = $List[$i][1]
	Next
	Return $address
EndFunc

;~ Lưu các thông số Game
Func GameSaveSetting()
	GameInfoSave()
	GameTargetKeySave()
	GameUseBuffSave()
EndFunc

;~ Lấy handle của game từ Game List
Func GameHandleGet($handle = 0)
	Local $i
	
	If Not $GameList[0][0] Then Return 
	$i = 1
	If $handle Then
		For $i = 1 To $GameList[0][0]
			If $handle == $GameList[$i][1] Then Return $GameList[$i][1]
		Next
	EndIf
EndFunc
	
;~ Hiệu chỉnh tiêu đề của Game
Func GameActivate()
	$GameHandle = GameHandleGet($GameHandle)
	WinActivate($GameHandle)
EndFunc

;~ Hiệu chỉnh tiêu đề của Game
Func GameTitleSet($title = "")
	Local $old
	
	$GameHandle = GameHandleGet($GameHandle)	
	$old = GameTitleGet($GameHandle)
	If $title == $old Then Return
		
	WinSetTitle($GameHandle,"",$title)
EndFunc

;~ Hiệu chỉnh tiêu đề của Game
Func GameTitleGet($handle = 0)
	$handle = GameHandleGet($handle)	
	WinGetTitle($handle)
EndFunc

;~ Lưu các thông số nhận dạng của Game
Func GameInfoSave()
	If FileExists($DataFileName) Then Return
	IniWrite($DataFileName,"Game","Title",$GameTitle)
EndFunc

;~ Nạp các thông số nhận dạng của Game
Func GameInfoLoad()
	$GameTitle = IniRead($DataFileName,"Game","Title",$GameTitle)
EndFunc

;~ Lưu phím nóng mục tiêu kế
Func GameTargetKeySave()
	IniWrite(CharFileNameGet(),"Game","$TargetKey",$TargetKey)
EndFunc

;~ Nạp phím nóng mục tiêu kế
Func GameTargetKeyLoad()
	$TargetKey = IniRead(CharFileNameGet(),"Game","$TargetKey",$TargetKey)
EndFunc

;~ Lưu tùy chọn sử dụng Skill Buff
Func GameUseBuffSave()
	IniWrite(CharFileNameGet(),"Game","$UsingBuff",$UsingBuff)
EndFunc

;~ Nạp tùy chọn sử dụng Skill Buff
Func GameUseBuffLoad()
	$UsingBuff = IniRead(CharFileNameGet(),"Game","$UsingBuff",0)*1
EndFunc

;~ Kiểm tra sự tồn tại của game
Func GameCheck()
	If Not $Training Then Return
		
	If Not $GameHandle Then
		MsgBox(0,$AutoName,"Game not running now")
		$Training = 1
		BStartAutoClick()
	EndIf
EndFunc

;~ Kiểm tra xem có đang target quái hay không
Func GameIsTarget()
	$IsTarget = GameRead($AIsTarget[$AIsTargetIndex])
	
	If $IsTarget == 1 Then
		GameMobHPCur()
		LIsTargetSet("Targeted")
	ElseIf $IsTarget == 0 Then
		LIsTargetSet("No target")
	Else
		LIsTargetSet("Error")
		If $Training Then BStartAutoClick()
	EndIf
EndFunc

;~ Kiểm tra xem có đang target quái hay không
Func GameMobHPCur()
	$MobHPCur = GameRead($AModHPCur[$AModHPCurIndex])
	If $AModHPCur == 0 Then $MobHPCur = 727272
		 
	If $MobHPCur > 9999999 Then
		LMobHPCurSet("Error")
	Else
		LMobHPCurSet($MobHPCur&" HP")
	EndIf
	If Not $MobHPCur Then GamePressESC() ;GameNextTarget()
EndFunc

;~ Bấm nút thoát
Func GamePressESC()
	If Not $Training Then Return
	ControlSend($GameHandle,"",0,"{ESC}")
EndFunc

;~ Chọn mục tiêu kế
Func GameNextTarget()
	If $IsTarget Then Return
	Sleep(1000)
	ControlSend($GameHandle,"",0,"{"&$TargetKey&"}")
EndFunc

;~ Mở vùng nhớ của game
Func GameOpenMemory($handle = 0)
	Local $i
	
	If Not $GameList[0][0] Then Return 
	$i = 1
	If $handle Then
		For $i = 1 To $GameList[0][0]
			If $handle == $GameList[$i][1] Then ExitLoop
		Next
	EndIf
	
	
	$GamePid = WinGetProcess($GameList[$i][1])
	If $GamePid == -1 Then 
		$GameMem = 0
	Else
		$GameMem = _MemoryOpen($GamePid)
		If @error Then msgbox(0,$GamePid,@error)
	EndIf
EndFunc
	
;~ Đọc vùng nhớ game
Func GameRead($Address,$sv_Type = 'dword')
	Local $Data,$List
	If $GamePid == -1 Then Return
	
	$List = StringSplit($Address,"|")
	$Address = $List[1]		
	$Data = _MemoryRead($Address,$GameMem,$sv_Type)
	
	For $i = 2 To $List[0]
		$Data = _MemoryRead($Data+$List[$i],$GameMem,$sv_Type)
	Next
	
	Return $Data
EndFunc


;~ Lấy danh sách ứng dùng có cùng tiêu đề
Func GameGetList()
	Local $Data,$i
	
	$GameList = WinList($GameTitle)
	If Not $GameList[0][0] Then Return
		
	$Data &= $GameList[1][1]
	For $i = 2 To $GameList[0][0]
		$Data &= "|"&$GameList[$i][1]
	Next
	
	$GameHandle = $GameList[1][1]
	DBGameListSet($Data,$GameList[1][1])
	Return $GameList
EndFunc
