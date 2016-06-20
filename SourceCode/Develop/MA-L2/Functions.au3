#include-once
#include "GUI\GUIFunctions.au3"
#include "Game\GameFunctions.au3"


#cs >> Danh sách hàm ===============================================================================================

Func AutoStart()			;~ Nạp các thông số của Auto khi khởi động
Func AutoEnd()				;~ Kết thúc chương trình
Func AutoCheckUpdate()		;~ Kiểm tra phiên bản mới của Auto
Func SaveSetting()			;~ Lưu các thông số trên GUI
Func SaveGUIPos()			;~ Lưu vị trí GUI
Func LoadGUIPos()			;~ Nạp vị trí GUI
Func ToolTipDel()			;~ Xóa ToolTip
Func Percent()				;~ Tính phần trăm giữa 2 số
Func NumberCheckSum()		;~ Kiểm tra xem 2 số có gần bằng nhau hay không

#ce << Danh sách hàm ===============================================================================================


;~ Nạp các thông số của Auto khi khởi động
Func AutoStart()
	AutoSetFile()
	CreateAttGif()
	CharListLoad()
	GameInfoLoad()
	GameAddressNameLoad()
	GameTargetKeyLoad()
	GameFishingKeyLoad()
	GamePumpingKeyLoad()
	GameReelingKeyLoad()
	GameUseBuffLoad()
	SkillLoad()
	LoadGUIPos()
	MainGUIFix()
	;~ AutoCheckUpdate()
	
	GameGetList()
	GameOpenMemory()
	;FShowADS()
EndFunc

;~ Hiện mẫu quản cáo
Func FShowADS()
	Local $NotShow = Random(0,3,1)
	If $NotShow Then Return
	Sleep(1111)
	LNoticeSet("Ads loading")
	Local $IEOb = _IECreate($ADSLink,1,0,0)
	AdlibRegister("FOffADS",10000)
EndFunc

Func FOffADS()
	Local $Pos,$Message
	WinMove($ADSTitle,"",100,100,800,600)
	WinSetState($ADSTitle,"",@SW_SHOW)
	WinSetState($ADSTitle,"",@SW_RESTORE)
	$Pos = WinGetPos($ADSTitle,"")	
	
	$Message = "Hãy nhấn: SKIP AD"
	ToolTip($Message,$Pos[0]+$Pos[2]-50,$Pos[1]+120,"Click here",1,1)
	LNoticeSet("Waiting click")
	Sleep(7000)
	ToolTip("")
	LNoticeSet()
	AdlibUnRegister("FOffADS")
EndFunc


;~ Nạp danh sách Character
Func CharListLoad()
	Local $List,$file
	Local $search = FileFindFirstFile("Setting/*.ini")
	If @error Then Return
		
	While 1
		$file = FileFindNextFile($search) 
		If @error Then ExitLoop
		$file = StringReplace($file,".ini","")
		DBCharListAdd($file)
	WEnd
	DBCharListDefault(CharDefaultLoad())
EndFunc

;~ Nạp char đã chọn
Func CharDefaultLoad()
	Local $Char
	$Char = IniRead($DataFileName,"Char","default","")
	Return $Char
EndFunc

;~ Lưu char đang chọn
Func CharDefaultSave()
	Local $Char
	$Char = DBCharListGet()
	IniWrite($DataFileName,"Char","default",$Char)
EndFunc


;~ Lấy file name lưu setting của char
Func CharFileNameGet()
	Local $char
	$char = DBCharListGet()
	$char = "Setting/"&$char&".ini"
	Return $char
EndFunc
	
;~ Kết thúc chương trình
Func AutoEnd()
	MainGUIClose()
EndFunc

;~ Cài đặt các file cần dùng
Func AutoSetFile()
	FileInstall("att.gif","att.gif")
EndFunc

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

;~ Lưu các thông số trên GUI
Func SaveSetting()
	GameSaveSetting()
	LCharListClick()
	CharDefaultSave()
	SaveGUIPos()
	SkillSave()
EndFunc


;~ Lưu các thông số skill
Func SkillSave($SID = 0)
	Local $data,$i,$value

	If Not $SID Then
		For $i = 1 To $SkillMax
			SkillSave($i)
		Next
	Else
		If $Skill[$SID][0] == "" Then Return
		For $i = 0 To $SkillLen-1
			$value = $Skill[$SID][$i]
			$data &= $value&"|"
		Next
		IniWrite(CharFileNameGet(),"Skill",$SID,$data)
	EndIf
EndFunc

;~ Nạp các thông số skill
Func SkillLoad()
	Global $Skill[$SkillMax+1][$SkillLen]
	Local $data,$i,$SID
	Local $OldSkill = IniReadSection(CharFileNameGet(), "Skill")
	If @error Then Return
	For $i = 1 To $OldSkill[0][0]
		$SID = $OldSkill[$i][0]
		$data = StringSplit($OldSkill[$i][1],"|")
		For $j = 0 to $SkillLen-1
			$Skill[$SID][$j] = $data[$j+1]
		Next
	Next
EndFunc


;~ 	Sử dụng skill khi train
Func SkillUse()
	Local $i
	
	If Not $Training Then Return
	If Not $IsTarget Then GameNextTarget()
	If Not $IsTarget Then Return
		
	For $i = 1 To $SkillInUse
		If $Skill[$i][0] == 1 Then
			If TimerDiff($SkillTimer[$i]) > $Skill[$i][2] Then 
				ControlSend($GameHandle,"",0,"{"&$Skill[$i][1]&"}")
				$SkillTimer[$i] = TimerInit()
				LNoticeSet("Skill: "&$Skill[$i][1])
			EndIf
		EndIf
	Next
EndFunc

;~ 	Sử dụng skill buff khi có game
Func BuffUse()
	Local $i
	If Not $UsingBuff Then Return
		
	For $i = 101 To $BuffInUse
		If $Skill[$i][0] == 1 Then
			If TimerDiff($SkillTimer[$i]) > $Skill[$i][2] Then 
				ControlSend($GameHandle,"",0,"{"&$Skill[$i][1]&"}")
				$SkillTimer[$i] = TimerInit()
				LNoticeSet("Buff: "&$Skill[$i][1])
			EndIf
		EndIf
	Next
EndFunc


;~ Lưu vị trí GUI
Func SaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite(CharFileNameGet(),"AutoPos","x",$Pos[0])
	IniWrite(CharFileNameGet(),"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc


;~ Nạp vị trí GUI
Func LoadGUIPos()
	$AutoPos[0] = IniRead(CharFileNameGet(),"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead(CharFileNameGet(),"AutoPos","y",$AutoPos[1])
EndFunc

;~ Xóa ToolTip
Func ToolTipDel()
	ToolTip("")
EndFunc

;~ Tính phần trăm giữa 2 số
Func Percent($a,$b)
	local $percent = (( $a / $b )*100)
	return $percent
EndFunc

;~ Kiểm tra xem 2 số có gần bằng nhau hay không
Func NumberCheckSum($a,$b,$Span=3)
	Local $Start = $Span*-1
	For $i = $Start To $Span
		If ($a == ($b+$i)) Then Return 1
	Next
	Return 0
EndFunc
	
;~ 	Tạo Gif báo hiệu trạng thái Train
Func CreateAttGif()
	Local $aArrayOfHandlesAndTimes
	Global $hGIFThread
	Local $iTransparent
	Local $tCurrentFrame
	Global $AttGif = _GUICtrlCreateGIF($AttGifFile, 2, 305,$aArrayOfHandlesAndTimes,$hGIFThread,$iTransparent,$tCurrentFrame)
	_StopGIFAnimation($hGIFThread)
	GUICtrlSetOnEvent($AttGif,"BStartAutoClick")
	GUICtrlSetCursor ($AttGif, 0)
EndFunc

Func FFishing()
	Local $Len1,$Len2
	Local $Pos[2] = [100,200]
	
	GameIsFishing()
	
	If Not $Fishing Then Return
	$Pos = $FishingBar
	
	Switch $IsFishing
		Case 0
			GameFishing()
			Sleep(2000)
		Case 1
			LNoticeSet("Wait fish")
			LPumpKeyColor(0x0000FF)
			LReelKeyColor(0x0000FF)
			$HitCount = 0
		Case 2
			If $HitCount == 0 Then
				GamePumpling()
				Sleep(2000)
			EndIf
		
			$Len1 = _ColorLen($GameHandle,$Pos[0],$Pos[1],$LFishing)
			LNoticeSet($Len1&" "&$Len2)
			Sleep(1000)
			$Len2 = _ColorLen($GameHandle,$Pos[0],$Pos[1],$LFishing)
			LNoticeSet($Len1&" "&$Len2)
			
			If $Len2 > 230 And $HitCount>1 Then GamePumpling()
			If $Len2 > 200 And $HitCount>2 Then GameFishing()
				
			if $Len1 > $Len2 Then
				LNoticeSet()
			ElseIf($Len1 == $Len2) Then
				GamePumpling()
			Else
				GameReelKey()
			EndIf
			$HitCount+=1
			Sleep(2000)
		Case Else
			
	EndSwitch
	
EndFunc



