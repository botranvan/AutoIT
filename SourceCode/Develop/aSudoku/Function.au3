#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự tạo ô số Sudoku
#ce ==========================================================

;~ Kiểm tra phiên bản mới của Auto
Func AutoCheckUpdate()
	ToolTip("Checking for updates...",0,0)
	
	Local $HTML = _INetGetSource($HomePage)
	Local $start = StringInStr($HTML,"[Auto] Lineage 2 - Scan Monsters") + 53
	Local $len = StringInStr($HTML," |") - $start
	$HTML = StringMid($HTML,$start,$len)


	If $AutoVersion == $HTML Then 
		ToolTipDel()
	Else
		ToolTip("A newer version is available: v"&$HTML&" "&@LF&"Click [ Option ] => [ HomePage ] to download",0,0)
		AdlibRegister("DelTooltip",9000)
	EndIf
	
EndFunc

;~ Hiệu chỉnh chế độ thử nghiệm
Func TestingSet()
	$Testing = Not $Testing
EndFunc
	
;~ Tạo title cho Auto
Func AutoTitleGet()
	Return $AutoName&" v"&$AutoVersion&" | 72ls.NET"
EndFunc

;~ Lưu các thông số trên GUI
Func SaveSetting()
	SaveGUIPos()
EndFunc

;~ Lưu vị trí GUI
Func SaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite($DataFileName,"AutoPos","x",$Pos[0])
	IniWrite($DataFileName,"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc

;~ Nạp các thông số của Auto lưu ở file
Func LoadSetting()
	LoadGUIPos()
	LoadCreateURL()
EndFunc

;~ Nạp vị trí GUI
Func LoadGUIPos()
	$AutoPos[0] = IniRead($DataFileName,"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($DataFileName,"AutoPos","y",$AutoPos[1])
EndFunc

;~ Nạp đường dẫn tạo Sudoku
Func LoadCreateURL()
	$CreateURL = IniRead($DataFileName,"AutoData","CreateURL",$CreateURL)
EndFunc

;~ Xóa ToolTip
Func ToolTipDel()
	ToolTip("")
EndFunc

;~ Trả về 0  tất cả ô số trong array
Func SudokuNumbersReset()
	For $y=0 To $SudokuSize-1
	For $x=0 To $SudokuSize-1
		$SudokuValue[$x][$y] = 0
	Next
	Next
EndFunc

;~ Tạo số cho 1 ô sudoku
Func SudokuValueCheck($x,$y)
	Local $Num = $SudokuValue[$x][$y]
	Local $Count = 0
	While 1		
		$Ok = SudokuCheckX($x,$y,$Num)
		If $Ok Then
			$SudokuValue[$x][$y] = $Num
			Return
		Else
			$Num+=1
			If $Num = 10 Then $Num = 1
				
			$Count+=1
			If $Count > 10 Then
				$x2 = $x
				$y2 = $y
				$x2-= 1
				If $x2 < 0 Then 
					$x2 = 8
					$y2-= 1
				EndIf
				$SudokuValue[$x2][$y2]+=2
				SudokuValueCheck($x2,$y2)
				Sleep(720)
			EndIf
		EndIf
		SudokuShowTip()	
	WEnd

EndFunc


Func SudokuShowTip()
	Local $T = ""
	For $x=0 To $SudokuSize-1
	For $y=0 To $SudokuSize-1
		$T&=$SudokuValue[$x][$y]&" "
	Next
		$T&=@LF
	Next
	tooltip(@sec&@msec&@LF&$T,0,0)
EndFunc

;~ Kiểm tra số theo chiều ngang
Func SudokuCheckX($x=5,$y=5,$Num=1)
	For $i=0 To $y-1
		If $SudokuValue[$x][$i] = $Num Then Return 0
	Next
	Return SudokuCheckY($x,$y,$Num) 
EndFunc
	
;~ Kiểm tra số theo chiều dọc
Func SudokuCheckY($x=5,$y=5,$Num=1)
	For $i=0 To $x-1
;~ 		msgbox(0,"72ls.net",$SudokuValue[$i][$y])
		If $SudokuValue[$i][$y] = $Num Then Return 0
	Next
	Return 1
EndFunc

;~ Lưu ô số thành chuỗi
Func SudokuInputSave()
	$y = 5
	$x = 7
	For $i=0 To $x-1
		msgbox(0,"72ls.net",$SudokuValue[$i][$y])
	Next	
EndFunc



;~ Lấy ô số sudoku từ Software
Func SudokuFromSoftProcess()
	Local $Soft = SoftListCoGet()
	
	If Not FileExists($SoftPath) Then 
		msgbox(0,"72ls.net","Not Found Sudoku Creator")
		$SoftRun = 0
		Return
	EndIf
	
	SoftRunBClick()	
	Switch $Soft 
	Case 'mtSudoku'
		SudokuFrommtSudoku()
	Case 'Sudoku Creator Pro'
		SudokuFrommtSCPro()
	EndSwitch
	
EndFunc

;~ Lấy ô số từ Sudoku Creator Pro
Func SudokuFrommtSCPro()	
	Local $Wait = 270
	ControlSend($SoftTitle,'','',"!scl")
	For $i = 2 To $SoftLevel
		Send("{Down}")	
;~ 		Sleep($Wait)
	Next
	Sleep($Wait)
	Send("{Enter}")
	Sleep($Wait)
	ControlSend($SoftTitle,'','',"!ss")
	Sleep($Wait)
	If WinExists(" Enter the name of the file to save:") Then 
		WinActivate(" Enter the name of the file to save:")
		ControlSetText(" Enter the name of the file to save:",'',1148,"1")
		Sleep($Wait)
		ControlSend(" Enter the name of the file to save:",'','',"{Enter}")
	EndIf
	
	Sleep($Wait)
	If WinExists('[TITLE:Sudoku; CLASS:#32770]') Then 
		WinActivate('[TITLE:Sudoku; CLASS:#32770]')
		Send("{Enter}")
		Return
	EndIf
	Sleep($Wait)
	ControlSend("File Exists",'','',"{Enter}")
	Local $File = FileOpen('1.sud')
	Local $Line = FileReadLine($File,1)
	FileClose($File)
	Local $Len = StringLen(StringReplace($Line,'0',''))
	
	Waring_LSet("Level "&$SoftLevel&": "&$Len)
	If $Len Then SudokuSubmit($Line, $SudokuLevel, $SudokuSize)
EndFunc

;~ Lấy ô số từ mtSudoku
Func SudokuFrommtSudoku()
	Local $Wait = 270
	LoadCreateURL()
	Sleep($Wait)
	
	ClipPut("")
	Switch $SoftLevel
	Case 1
		Waring_LSet("Create Level Easy")
		ControlSend($SoftTitle,'','',"^e")
	Case 2
		Waring_LSet("Create Level Medium")
		ControlSend($SoftTitle,'','',"^m")
	Case 3
		Waring_LSet("Create Level Hard")
		ControlSend($SoftTitle,'','',"^n")
	Case 4
		Waring_LSet("Create Level Very Hard")
		ControlSend($SoftTitle,'','',"!g")
		If $Testing Then Sleep($Wait*2)
		ControlSend($SoftTitle,'','',"{DOWN}")
		If $Testing Then Sleep($Wait*2)
		ControlSend($SoftTitle,'','',"{DOWN}")
		If $Testing Then Sleep($Wait*2)
		ControlSend($SoftTitle,'','',"{DOWN}")
		If $Testing Then Sleep($Wait*2)
		ControlSend($SoftTitle,'','',"{ENTER}")
	Case 5
		ContinueCase
	Case 6
		ContinueCase
	Case 7
		Waring_LSet("Can't be create Level")
		SoftSudokuGetBClick()
		Return
	EndSwitch
	
	Sleep($Wait)
	If WinExists('mtSudoku','The current game will be deleted.') Then ControlSend($SoftTitle,'','',"{ENTER}")
	Sleep($Wait)
	ControlSend($SoftTitle,'','',"^c")
	Sleep($Wait)
	
	Local $String = ClipGet()
	If Not $String Then Return
	StringFixZero($String)
	SudokuSubmit($String, $SudokuLevel, $SudokuSize)
EndFunc

;~ Post Sudoku lên website
Func SudokuSubmit($Str, $Level, $Size)
	Local $oIE = _IECreate($CreateURL,1)
	Local $oForm = _IEGetObjById ($oIE, "node-form")
	Local $oQuery = _IEFormElementGetObjByName ($oForm, "snumber")
	If @error Then 
		SoftSudokuGetBClick()
		Return		
	EndIf
	_IEFormElementSetValue ($oQuery, $Str)
	Local $oQuery = _IEFormElementGetObjByName ($oForm, "level")
	_IEFormElementSetValue ($oQuery, $Level)
	Local $oQuery = _IEFormElementGetObjByName ($oForm, "stype")
	_IEFormElementSetValue ($oQuery, $Size)
	Send("{End}")
	If $Testing Then
		Sleep(2000)
	EndIf
	_IEFormSubmit ($oForm)
	_IEQuit ($oIE)	
EndFunc

;~ Thêm số 0 vào chuỗi Sudoku
Func StringFixZero(ByRef $String)
	$S = StringSplit($String,@CRLF,1)
	$String = ''
	For $i = 1 To $S[0]
		$T = StringSplit($S[$i],@TAB)
		For $j = 1 To $T[0]
			If Not $T[$j] Then $T[$j] = 0
			$String&=$T[$j]
		Next
	Next
	Return $String
EndFunc

;~ Hiểu chỉnh Level trên GUI
Func SudokuFixLevel($Level = 0)
	If Not $Level Then $Level = $SudokuLevel
	GUICtrlSetData($LevelCo,$Level)
EndFunc

;~ Hiểu chỉnh Kích Thước Sudoku trên GUI
Func SudokuFixSize($Size = 0)
	If Not $Size Then $Size = $SudokuSize
	GUICtrlSetData($Mode_Co,$Size)
EndFunc

;~ Hiểu chỉnh Kích Thước Sudoku trên GUI
Func SoftFixLevel($Size = 0)
	If Not $Size Then $Size = $SoftLevel
	GUICtrlSetData($SoftLevelB,$Size)
EndFunc





