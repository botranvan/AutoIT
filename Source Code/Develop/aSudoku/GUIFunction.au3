;~ Hiệu chỉnh lại GUI
Func MainGUIFix()
	Local $MainSize = ($SudokuSize*$InputSize) + ($Spam*$SudokuSize)
	WinMove($MainGUI,"",$AutoPos[0],$AutoPos[1])
	WinSetTitle($MainGUI,"",AutoTitleGet())
	SudokuFixSize()
	SudokuFixLevel()
	SoftFixLevel()
	SoftListCoSet('Sudoku Creator Pro')
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

;~ Lập giá trị cho $SoftListCo
Func SoftListCoGet()
	Return GUICtrlRead($SoftListCo)
EndFunc
;~ Lấy giá trị từ $SoftListCo
Func SoftListCoSet($NewValue = "")
	Local $Check = SoftListCoGet()
	If $Check <> $NewValue Then GUICtrlSetData($SoftListCo,$NewValue,$NewValue)
EndFunc

;~ Mở trang chủ nơi tải chương trình
Func HomePage_BClick()
		_IECreate($HomePage,1,1,0)
EndFunc

;~ Tạo các ô số
Func SudokuZoneCreate()
	Local $Number 
	Local $Pos = WinGetPos($MainGUI)
	$Pos[0]+= $Pos[2]

	$Pos[2] = $SudokuSize*$InputSize
	$Pos[3] = $Pos[2]
	
	$SudokuZone = GUICreate(AutoTitleGet(),$Pos[2],$Pos[3],$Pos[0],$Pos[1],Default,Default,$MainGUI)
	GUISetOnEvent($GUI_EVENT_CLOSE, "SudokuZoneClose",$SudokuZone)
	
	For $x=0 To $SudokuSize-1
	For $y=0 To $SudokuSize-1
		$SudokuValue[$x][$y] = Random(1,$SudokuSize,1)
		SudokuValueCheck($x,$y)
		$SudokuInput[$x][$y] = GUICtrlCreateInput(Hex($SudokuValue[$x][$y],1),$y*$InputSize,$x*$InputSize,$InputSize,$InputSize,$ES_CENTER)
		GUICtrlSetFont(-1,13,1900)
	Next
	Next

	GUISetState(@SW_SHOW,$SudokuZone)
;~ 	_ArrayDisplay($SudokuValue)
;~ 	SudokuCheckX()
;~ 	SudokuCheckY()
EndFunc

;~ Đóng Sudoku Zone
Func SudokuZoneClose()
	GUIDelete($SudokuZone)
	$SudokuZone = 0
	SudokuNumbersReset()
EndFunc

;~ tạo mới Sudoku Zone
Func Create_BClick()
	If $SudokuZone Then SudokuZoneClose()
	SudokuZoneCreate()
EndFunc

;~ Đổi kích thước sudoku
Func Mode_CoChange()
	$SudokuSize = GUICtrlRead($Mode_Co)
	ReDim $SudokuInput[$SudokuSize][$SudokuSize]
	ReDim $SudokuValue[$SudokuSize][$SudokuSize]
EndFunc

;~ Đổi kích thước sudoku
Func SoftListCoChange()
	Local $Soft = SoftListCoGet()
	Switch $Soft 
	Case 'mtSudoku'
		$SoftPath = 'C:\Program Files\MaaTec\MaaTec Sudoku\mtSudoku.exe'
	Case 'Sudoku Creator Pro'
		$SoftPath = 'Sudoku.exe'
	EndSwitch	
EndFunc

;~ Thay đổi giá trị của Level 
Func LevelCoChange()
	$SudokuLevel = GUICtrlRead($LevelCo)
EndFunc

;~ Thay đổi giá trị của Soft Level
Func SoftLevelBChange()
	$SoftLevel = GUICtrlRead($SoftLevelB)
EndFunc

;~ Lấy đường dẫn của Software
Func SoftPathBClick()
	Local $Path = InputBox(AutoTitleGet(),"Path of Sudoku Creator (Software)",$SoftPath)
	If Not @error Then $SoftPath = $Path
EndFunc
	
;~ Lấy ô số Sudoku từ Software
Func SoftSudokuGetBClick()
	$SoftRun = Not $SoftRun
	If $SoftRun Then
		SoftSudokuGetBSet("Stop Get")
	Else
		SoftSudokuGetBSet("Get Sudoku")
	EndIf
EndFunc	

;~ Mởi Software đang được chọn
Func SoftRunBClick()
	If Not WinExists($SoftTitle) Then Run($SoftPath)
	WinActivate($SoftTitle)
EndFunc	

;~ Lập giá trị cho $SoftSudokuGetB
Func SoftSudokuGetBGet()
	Return GUICtrlRead($SoftSudokuGetB)
EndFunc
;~ Lấy giá trị từ $SoftSudokuGetB
Func SoftSudokuGetBSet($NewValue = "")
	Local $Check = SoftSudokuGetBGet()
	If $Check <> $NewValue Then GUICtrlSetData($SoftSudokuGetB,$NewValue)
EndFunc


