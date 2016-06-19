#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Auto Hỗ Trợ Game Kiếm Tiên
#ce ==========================================================

;~ Cài đặt các file cần dùng
Func AutoSetFile()
	FileInstall("att.gif","att.gif")
EndFunc

;~ Kiểm tra phiên bản mới của Auto
Func AutoCheckUpdate()
	ToolTip("Đang kiểm tra phiên bản...",0,0)
	
	Local $HTML = _INetGetSource($URL)
	Local $start = StringInStr($HTML,"[Auto] Ki")+26
	Local $len = StringInStr($HTML," | ") - $start
	$HTML = StringMid($HTML,$start,$len)

	If $Version == $HTML Then 
		ClearToolTip()
	Else
		ToolTip("Đã có bản v"&$HTML&" trên http://autoit.72ls.net"&@LF&"Bấm dấu [ ? ] trên Auto để tải bản mới về",0,0)
		AdlibRegister("ClearToolTip",9000)
	EndIf
	
EndFunc

;~ Kiểm tra phiên bản mới của Auto
Func AutoCheckUpdate2()
	Local $URL = "http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/KTAuto72/"&StringReplace($Version,".","")&".gif"
	Local $File = InetGet($URL,"72ls.NET",1+2+8,1)
	
	Do
		ToolTip("Đang kiểm tra phiên bản",0,0)
	Until InetGetInfo($File, 2)
	
	Local $aData = InetGetInfo($File)
	
	InetClose($File)

	If Not $aData[3] or Not $aData[1] Then 
		ToolTip("Đã có bản mới trên http://autoit.72ls.net"&@LF&"Bấm Esc để tắt thông báo",0,0)
		AdlibRegister("ClearToolTip",9000)
	Else
		ClearToolTip()
	EndIf
	FileDelete("72ls.NET")
EndFunc

;~ Xóa thông báo hiện tại
Func ClearToolTip()
	ToolTip("")
	AdlibUnRegister("ClearToolTip")
EndFunc

;~ Từ chọn quái
Func TargetMod()
	If IsChat() Then Return

	Do
		$Target = IsTarget()
		If $Target = 0 or $Target = 1 Then 
			ControlSend($GameHandle,'','',"{`}")		
		EndIf
		Sleep(72)
	Until($Target <> 1)
;~ 	If IsTarget() > 2 Then AttackMod(0)
EndFunc

;~ Sử Dụng skill
Func UseSkills()
	If IsChat() Then Return
	
	For $i = 13 To 15
		If Not $Buffing Then ExitLoop
		If $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $SkillNeed[$i] Then
			ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
			$SkillDelay[$i] = TimerInit()
		EndIf
	Next
	
	If $Target < 2 Or Not $Training Then Return
	If Not IsAttack() And $Attacked Then Return
	For $i = 0 To 4
		If $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $SkillNeed[$i] Then
			ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
			$SkillDelay[$i] = TimerInit()
		EndIf
	Next
EndFunc

;~ Tự Heal cho Char
Func HealChar()
	If Not $CharHeal Then Return
	Local $Chatting = IsChat()
	Local $Delay = 4000
	Local $i = 5
	If $Chatting Then Return

	GetCharInfo()
	Local $HP = GetPercentHP()
	If $HP <= $SkillNeed[$i] And $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
	$i += 1
	If $HP <= $SkillNeed[$i] And $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
	$i += 1
	Local $MP = GetPercentMP()
	If $MP <= $SkillNeed[$i] And $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
	$i += 1
	If $MP <= $SkillNeed[$i] And $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
	$i += 1
	If $Char_XPCur == 1000 And $SkillOn[$i] And $Target > 1 And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
	$i += 1

	If IsPet() Then
		GetPetInfo()
		Local $PetHP = GetPercentPetHP()
		If $PetHP <= $SkillNeed[$i] And $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
		$i += 1
		Local $PetMP = GetPercentPetMP()
		If $PetMP <= $SkillNeed[$i] And $SkillOn[$i] And TimerDiff($SkillDelay[$i]) > $Delay Then ControlSend($GameHandle,'','',"{"&$Skill[$i]&"}")
	EndIf
EndFunc


;~ Mở Memory của Game
Func GameOpenMemory()
	If $GamePid <> -1 Then 
		_MemoryOpen($MemGame)
		$MemGame = _MemoryOpen($GamePid)
		If @Error Then 
;~ 			msgbox(0,"72ls.net","Lỗi mở vùng nhớ Game")
;~ 			ExitAuto()
		EndIf
	Else
;~ 		msgbox(0,"72ls.net","Không thấy Game")
;~ 		ExitAuto()
	EndIf
EndFunc

;~ Đọc bộ nhớ game
Func GameRead($iv_Address,$sv_Type = 'dword')
	If $GamePid == -1 Then Return
	Local $Data = _MemoryRead($iv_Address,$MemGame,$sv_Type)
	If @error Then 
		return 0
;~ 		msgbox(0,"72ls.net",@error&": Lỗi đọc vùng nhớ Game")
;~ 		ExitAuto()
	EndIf
	Return $Data
EndFunc

;~ Đọc bộ nhớ game
Func GameWrite($iv_Address,$Value,$sv_Type = 'dword')
	If $GamePid == -1 Then Return
	_MEMORYWRITE($iv_Address, $MemGame, $Value, $sv_Type)
EndFunc
	
;~ Kích hoạt Chức Năng Tự Nhặt của Game
Func GameAutoOn($Mode = 1)
	$GameAuto = Not $GameAuto
	GameWrite(0x00E56290,$Mode,'char')
EndFunc

;~ Kiểm Tra xem Game có đang Auto hay không
Func GameIsAuto()
	Return GameRead(0x0167B204)
EndFunc

;~ Lấy thông tin trong game
Func GetGameInfo()
	GetCharInfo()
	GetPetInfo()
	GetTargetInfo()
EndFunc

;~ Lấy thông tin của nhận vật
Func GetCharInfo()
	$Char_Name = CharNameRead()
	$Char_HPCur = GameRead(0x01113F1C)
	$Char_HPMax = GameRead(0x01113F20)
	$Char_MPCur = GameRead(0x00E607E8)
	$Char_MPMax = GameRead(0x00E60820)
	$Char_XPCur = GameRead(0x00FF44A4)
EndFunc

;~ Lấy thông tin của Pet
Func GetPetInfo()
	$Pet_HPCur = GetPetHPCur()
	$Pet_HPMax = GetPetHPMax()
	$Pet_MPCur = GameRead(0x00E7C5A0)
	$Pet_MPMax = GameRead(0x00E7C5A4)
EndFunc

Func CharNameRead()
	Return GameRead(0x00E5808C,"char[24]")
EndFunc
	
;~ Lấy HP hiện tại của Pet
Func GetPetHPCur()
	Return GameRead(0x00E7C27C)
EndFunc
;~ Lấy HP tối đa của Pet
Func GetPetHPMax()
	Return GameRead(0x00E7C280)
EndFunc

;~ Lấy thông tin của Mod
Func GetTargetInfo()
	$Target = IsTarget()	
	$Mod_HPCur = (GameRead(0x01090E0C)/10)&"%"
	Return
	
	Local $HP =  0;GameRead(0x00C2E904)
	If $Mod_HPMax <> $HP Then
		$Mod_HPMax = $HP
		Local $Title = "Máu của Quái lúc đầu"
		GUICtrlSetTip($Mod_HPCur_L,$Mod_HPMax,$Title)
		GUICtrlSetTip($ModHP_L,$Mod_HPMax,$Title)
	EndIf
EndFunc

;~ Hàm lấy phần trăm
Func GetPercent($Num1,$Num2)
	Return Floor($Num1/$Num2*100)
EndFunc

;~ Hàm lấy phần trăm của Char HP
Func GetPercentHP()
	Return GetPercent($Char_HPCur,$Char_HPMax)
EndFunc

;~ Hàm lấy phần trăm của Char MP
Func GetPercentMP()
	Return GetPercent($Char_MPCur,$Char_MPMax)
EndFunc

;~ Hàm lấy phần trăm của Pet HP
Func GetPercentPetHP()
	Return GetPercent($Pet_HPCur,$Pet_HPMax)
EndFunc

;~ Hàm lấy phần trăm của Pet MP
Func GetPercentPetMP()
	Return GetPercent($Pet_MPCur,$Pet_MPMax)
EndFunc

;~ Kiểm tra xem có đang Target không
;~ 0: Không target
;~ 1: Mod dã bị đánh
;~ 2: Mod
Func IsTarget()
	Local $Type = 0
	If GameRead(0x0108FF34) Then $Type = 2
	If $Type And GameRead(0x0109816C) Then $Type = 1
	Return $Type
EndFunc

;~ Kiểm tra xem có đang chat hay kg
Func IsChat()
	Local $Chatting1 = GameRead(0x01729C7F)	;Chat thường
	Local $Chatting2 = GameRead(0x014FC8DC)	;Chat theo loại tin
	Local $Chatting3 = GameRead(0x01547504) ;Chat với bạn hữu
	If $Chatting1 Or $Chatting2 Or $Chatting3 Then Return 1
	Return 0
EndFunc

;~ Kiểm tra xem có đang tấn công ai hay kg
Func IsAttack()
	Return 1;GameRead(0x05C97A2C)
EndFunc

;~ Kiểm tra xem Pet có đang được gọi hay không
Func IsPet()
	Return 1;GameRead(0x0A5E088)
EndFunc

;~ Hiển thị các thông số game lên GUI
Func ShowGameInfo()
	ShowTargetInfo()
	Mod_HPCur_L_Set($Mod_HPCur)
	Char_HP_L_Set("HP "&GetPercent($Char_HPCur,$Char_HPMax)&"%")
	Char_MP_L_Set("MP "&GetPercent($Char_MPCur,$Char_MPMax)&"%")
	
	If IsPet() Then
		Pet_HP_L_Set("HP "&GetPercentPetHP()&"%")
		Pet_MP_L_Set("MP "&GetPercentPetMP()&"%")
	Else
		Global $Pet_HPCur = 100
		Global $Pet_HPMax = 100
		Global $Pet_MPCur = 100
		Global $Pet_MPMax = 100
	EndIf
EndFunc

;~ Hiển thị loại nhân vật đang được chọn
Func ShowTargetInfo()
	Switch $Target
	Case 0
		Target_L_Set("Kg Có")
	Case 1
		Target_L_Set("Cấm")
	Case 2
		Target_L_Set("Quái")
	EndSwitch
EndFunc

;~ Xuất các thông tin để test chương trình
Func ShowTestInfo()
	$TestInfo = "GamePid: "&$GamePid&" | MemGame: "&$MemGame[0]&" | AutoWithGame: "&$AutoWithGame
	
	For $i = 0 To $SkillNumber-1
		$TestInfo &= @LF&$i&" | "&$Skill[$i] & " | " & $SkillOn[$i] & " | " & $SkillNeed[$i]
	Next
	
	$TestInfo &= @LF&"Char: "&$Char_Name&" | "&$GameHandle
	For $i = 1 To $GameCharList[0][0]
		$TestInfo &= @LF&$i&" | "&$GameCharList[$i][0]&" | "&$GameCharList[$i][1]
	Next

	tooltip(@sec&@msec&" "&$TestInfo,0,0)
EndFunc

;~ Lưu các thông số trên GUI
Func SaveSetting()
	If Not $Char_Name Then Return
	SaveGUIPos()
	SaveSkillOn()
	SaveSkill()
	SaveSkillNeed()
	SaveOther()
EndFunc

;~ Lưu vị trí GUI
Func SaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite($Char_Name&'.ini',"AutoPos","x",$Pos[0])
	IniWrite($Char_Name&'.ini',"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc

;~ Lưu tùy chọn skill
Func SaveSkill()
	For $i = 0 To $SkillNumber-1
		IniWrite($Char_Name&'.ini',"Skill",$i,$Skill[$i])
	Next
EndFunc

;~ Lưu tùy chọn trạng thái skill
Func SaveSkillOn()
	For $i = 0 To $SkillNumber-1
		If Not $SkillOn[$i] Then $SkillOn[$i] = ''
		IniWrite($Char_Name&'.ini',"SkillOn",$i,$SkillOn[$i])
	Next
EndFunc

;~ Lưu điều kiện kích họat skill
Func SaveSkillNeed()
	For $i = 0 To $SkillNumber-1
		IniWrite($Char_Name&'.ini',"SkillNeed",$i,$SkillNeed[$i])
	Next
EndFunc

;~ Lưu các tùy chọn khác
Func SaveOther()
	If Not $CharHeal Then $CharHeal = ''
	IniWrite($Char_Name&'.ini',"Other","CharHeal",$CharHeal)
EndFunc

;~ Nạp các thông số của Auto lưu ở file
Func LoadSetting()
	If Not $Char_Name Then Return		
	LoadGUIPos()
	LoadSkill()
	LoadSkillOn()
	LoadSkillNeed()
	LoadOther()
	
	If $SkillNeed[10] < 0 Then $SkillNeed[10] = 0
EndFunc
	
;~ Nạp vị trí GUI
Func LoadGUIPos()
	$AutoPos[0] = IniRead($Char_Name&'.ini',"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($Char_Name&'.ini',"AutoPos","y",$AutoPos[1])
EndFunc

;~ Nạp tùy chọn skill
Func LoadSkill()
	For $i = 0 To $SkillNumber-1
		$Skill[$i] = IniRead($Char_Name&'.ini',"Skill",$i,$Skill[$i])
	Next
EndFunc

;~ Nạp tùy chọn trạng thái skill
Func LoadSkillOn()
	For $i = 0 To $SkillNumber-1
		$SkillOn[$i] = IniRead($Char_Name&'.ini',"SkillOn",$i,$SkillOn[$i])
	Next
EndFunc

;~ Nạp điều kiện kích họat skill
Func LoadSkillNeed()
	For $i = 0 To $SkillNumber-1
		$SkillNeed[$i] = IniRead($Char_Name&'.ini',"SkillNeed",$i,$SkillNeed[$i])
	Next
EndFunc

;~ Nạp các tùy chọn khác
Func LoadOther()
	$CharHeal = IniRead($Char_Name&'.ini',"Other","CharHeal",$CharHeal)
EndFunc