;~ Hiệu chỉnh lại GUI
Func GUIFix()
	WinMove($MainGUI,"",$AutoPos[0],$AutoPos[1])
	WinSetTitle($MainGUI,"",$AutoName&" v"&$AutoVersion&" | 72ls.NET")
	SeachKey_ISet()
	SeachKey_ISet($SearchKeyList)
	GUISetOnEvent($GUI_EVENT_PRIMARYUP,"SearchDrawImage",$MainGUI)
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc

;~ Đóng chương trình
Func MainGUIClose()
	SaveSetting()
	Exit
EndFunc

;~ Ẩn chương trình
Func Hidden_BClick()
	$AutoMini = Not $AutoMini
	If $AutoMini Then
		$AutoPos = WinGetPos($MainGUI)
		GUICtrlSetData($Hidden_B,"\/")
		WinMove($MaingUI,"",$AutoPos[0],0-$AutoPos[3]+27,Default,Default,2)
	Else
		GUICtrlSetData($Hidden_B,"/\")
		WinMove($MaingUI,"",$AutoPos[0],$AutoPos[1])
	EndIf
EndFunc

;Hàm Lấy ID từ GUI
Func Account_CBGet()
	Return GUICtrlRead($Account_CB)
EndFunc

;Ghi dự liệu vào chỗ nhập ID
Func Account_CBSet($NewValue = "")
	Local $Check = GUICtrlRead($Account_CB)
	If $Check <> $NewValue Then GUICtrlSetData($Account_CB,$NewValue,DefaultIDGet())
EndFunc
	
;~ Thực hiện khi đổi tài khoản
Func Account_CBChange()
	Local $User = Account_CBGet()
	DefaultIDSet($User)
	Password_ISet(LoasPASS($User))
EndFunc

;Lấy dữ liệu từ chỗ nhập PASS
Func Password_IGet()
	Return GUICtrlRead($Password_I)
EndFunc
	
;Ghi dữliệu vào chỗ nhập PASS
Func Password_ISet($NewValue = "")
	Local $Check = GUICtrlRead($Password_I)
	If Not ($Check == $NewValue) Then GUICtrlSetData($Password_I,$NewValue)
EndFunc

;~ Hiện mật khẩu
Func Password_LClick()
	MsgBox(0,"72ls.NET",Password_IGet())
EndFunc

;~ Lưu User mới
Func Save_BClick()
	Local $User = Account_CBGet()
	EnIni($UserListFileName,$User,"p",Password_IGet())
	Waring_LSet("Saved: "&$User)
	DefaultIDSet($User)
	LoadUserList()
EndFunc

;~ Xóa 1 User
Func Delete_BClick()
	Local $User = Account_CBGet()
	IniDelete($UserLIstFileName,$User)
	Waring_LSet("Deleted: "&$User)
	DefaultIDSet()
	LoadUserList()
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

;~ Khởi động Game
Func Run_BClick()
	Run($GamePath,StringReplace($GamePath,$GameName,""))
	If @error Then
		Waring_LSet("Game can't be Find")
		Return 0
	EndIf
	Waring_LSet("Game Launching ...")
	Return 1
EndFunc

;~ Nạp lại danh sách User
Func Load_BClick()
	LoadUserList()
	Waring_LSet("Loaded all Users")
EndFunc


;Tự Đăng Nhập
Func Login_BClick()
	Waring_LSet("Waiting Game...")
	
	;Kiểm tra IP và Pass
	If Not IsIDPass() Then
		Waring_LSet("No User Name or Password")
		Return 0
	EndIf
	
	If Not WinExists($LauncherTitle) Then 
		If Not Run_BClick() Then Return
	EndIf
	
	If GameWait() then 
		Waring_LSet("Login: ")
		TypeIDPASS(Account_CBGet(),Password_IGet())
	Else
		Waring_LSet("Launcher error")
	EndIf

	Return 1
EndFunc

;~ Cài đặt đường dẫn của Game
Func GamePathSet_BClick()
	Local $Path = InputBox("72ls.NET","Set Game Path, where the game setup.",$GamePath,"",Default,100)
	If @error Then Return
	$GamePath = $Path
	IniWrite($DataFileName,"Game","Path",$Path)
EndFunc

;~ Tắt nhanh game
Func KillGame_BClick()
	Local $WinList = ProcessList($ProcessName)
	If $WinList[0][0] Then
		ProcessClose($WinList[1][1])
		If $WinList[0][0] == 1 Then
			Waring_LSet("Killed all game")
		Else
			Waring_LSet("Killed 1 of "&$WinList[0][0]&" game")
		EndIf
	Else
		Waring_LSet("No Game Running")
	EndIf
	ProcessClose($GameName)
EndFunc

;~ Thực hiện khi bấm Search
Func Seach_BClick()
	SearchInfoGet()
	SearchProcess()
EndFunc

;~ Hàm lấy Key từ GUI để search
Func SeachKey_IGet()
	Return GUICtrlRead($Key_I)
EndFunc
;~ Hàm cập nhật lại Key để search
Func SeachKey_ISet($Data = "")
	Local $Old = SeachKey_IGet()
	If $Old <> $Data Then GUICtrlSetData($Key_I,$Data,$SearchKey)
EndFunc

;~ Hàm lấy Key từ GUI để search
Func SeachType_CoGet()
	Return GUICtrlRead($Type_Co)
EndFunc

;~ Xóa từ khóa hiện tại
Func DeleteKey_BClick()
	Local $Key = SeachKey_IGet()
	$SearchKeyList = StringReplace($SearchKeyList,$Key&"|","")
	If Not @extended Then $SearchKeyList = StringReplace($SearchKeyList,"|"&$Key,"")
	SearchKeyListSave()
EndFunc

;~ Mở trang chủ nơi tải chương trình
Func HomePage_BClick()
		_IECreate($HomePage,1,1,0)
EndFunc

;~ Lấy danh sách các Char đang được login
Func GUISetCharList()
	Local $Pid 
	Local $Mem 
;~ 	Local $Add = 0x0CF3DFFC
	For $i = 1 To $GameCharList[0][0]
		$Pid = WinGetProcess($GameCharList[$i][1])
		$MemGame = _MemoryOpen($Pid)
		
;~ 		$Add = _MemoryRead($Add,$Mem)
;~ 		$Add = _MemoryRead($Add,$Mem)
;~ 		$Add = _MemoryRead($Add,'WCHAR[52]')
		
		$GameCharList[$i][0] = $i &" - "& GameGetTarget()
	Next
	
	CharList_C_Set()
EndFunc

;~ Xóa trắng danh sách Char
Func CharList_CClear()
	GUICtrlSetData($GameList_Co,"","")
EndFunc
;~ Lấy tên của Char đang được chọn
Func CharList_C_Get()
	Return GUICtrlRead($GameList_Co)
EndFunc
;~ Đưa danh sách Char vào ComboBox
Func CharList_C_Set()
	CharList_CClear()
	Local $Data = "No Game|"
	For $i = 1 To $GameCharList[0][0]
		$Data &= $GameCharList[$i][0]&"|"
	Next
	GUICtrlSetData($GameList_Co,$Data,"No Game")
EndFunc

;~ Thực hiện khi thay đổi char
Func GameList_CoChange()
	$Char_Name = CharList_C_Get()
	For $i = 1 To $GameCharList[0][0]
		If $Char_Name == $GameCharList[$i][0] Then
			$GameHandle = $GameCharList[$i][1]
			$GamePid = WinGetProcess($GameHandle) 
			GameOpenMemory()
			Return
		EndIf
	Next
EndFunc

;~ Nạp lại danh sách Game
Func Reload_BClick()
	Global $GameClass = "[TITLE:Lineage II; CLASS:l2UnrealWWindowsViewportWindow]"
	Global $GameCharList = WinList($GameClass)
	
	If $GameCharList[0][0] Then
		Global $GameHandle = $GameCharList[1][1]
		Global $GamePid = WinGetProcess($GameHandle)
	Else
		Global $GamePid
	EndIf

	GUISetCharList()
EndFunc