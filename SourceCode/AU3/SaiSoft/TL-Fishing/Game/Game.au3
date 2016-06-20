;~ Nạp danh sách địa chỉ của 1 loại
Func AddressNameLoad()
	Local $List,$i,$address
	
	If Not FileExists($AddressFileName) Then
		IniWrite($AddressFileName,"$AIsFishing","1","0x0BBEF108")
		IniWrite($AddressFileName,"$AIsCaught","default","0")
	EndIf
	
	$List = IniReadSectionNames($AddressFileName)
	For $i = 1 To $List[0]
		$address = AddressLoad($List[$i])
		If $List[$i] == "$AIsFishing" Then $AIsFishing = $address
		If $List[$i] == "$AIsCaught" Then $AIsCaught = $address
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


;~ Kiểm tra sự tồn tại của game
Func GameCheck()
	If Not $Fishing Then Return
		
	If Not $GameHandle Then
		MsgBox(0,$AutoName,"Game chưa khởi động")
		$Fishing = 1
		BStartClick()
	EndIf
	
EndFunc


;~ Kiểm tra xem có đang câu cá hay không
Func GameIsFishing()
	$IsFishing = GameRead($AIsFishing[$AIsFishingIndex])
	
	If $IsFishing == 1 Then
		LIsFishingSet("Đang câu cá")
		LIsFishingColor(0x0000FF)
	Else
		LIsFishingSet("Chưa câu cá")
		LIsFishingColor(0xFF0000)
	EndIf
EndFunc


;~ Kiểm tra xem cá có đang cắn câu hay không
Func GameIsCaught()
	$IsCaught = GameRead($AIsCaught[$AIsCaughtIndex])
	
	If $IsCaught == 1 Then
		LIsCaughtSet("Cắn Câu")
		LIsCaughtColor(0x0000FF)
	Else
		LIsCaughtSet("Cá chưa cắn câu")
		LIsCaughtColor(0xFF0000)
	EndIf

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
	Return $GameList
EndFunc

;~ Lấy tọa độ nút Fishing Hole
Func GameFishingHoleGet()
	LNoticeSet("")
	HotKeySet("{Insert}")
	$FishingHolePos = MouseGetPos()
	LFishingHoleSet($FishingHolePos[0]&":"&$FishingHolePos[1])
EndFunc

;~ Lấy tọa độ nút Kook
Func GameHookGet()
	LNoticeSet("")
	HotKeySet("{Insert}")
	$HookPos = MouseGetPos()
	LHookSet($HookPos[0]&":"&$HookPos[1])
EndFunc

;~ Bấm nút thoát
Func GamePressESC()
	ControlSend($GameHandle,"",0,"{ESC}")
EndFunc

;~ Gởi key vào Game
Func GameSend($Key)
	ControlSend($GameHandle,"",0,$Key)
EndFunc