#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <NomadMemory.au3>

HotKeySet("^q","AltQ")

Opt("GUIOnEventMode", 1)
Opt("SendKeyDelay",10)
Opt("SendKeyDownDelay",10)
Opt("SendCapslockMode",0)



$Form = GUICreate("Thuc Son auto beta 1.0", 445, 236, 292, 170)
$Hp_Dislay = GUICtrlCreateLabel("", 8, 24, 140, 20)
$Mp_Dislay = GUICtrlCreateLabel("", 0, 56, 148, 28)
$Label2 = GUICtrlCreateLabel("Key", 248, 16, 22, 17)
$Label3 = GUICtrlCreateLabel("Skill 1", 176, 40, 52, 28)
$Label5 = GUICtrlCreateLabel("Skill 3", 176, 128, 52, 28)
$Label4 = GUICtrlCreateLabel("Skill 2", 176, 80, 52, 28)
$Skill1_Key_D = GUICtrlCreateCombo("", 240, 40, 60, 25)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","1")
$Skill2_Key_D = GUICtrlCreateCombo("", 240, 86, 60, 25)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","2")
$Skill3_Key_D = GUICtrlCreateCombo("", 240, 128, 60, 25)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","3")
$Skill1_Timer_D = GUICtrlCreateInput("1000", 304, 40, 49, 21)
$Skill1_Repeat_D = GUICtrlCreateInput("4", 360, 40, 30, 21)
$Skill2_timer_D = GUICtrlCreateInput("6500", 304, 86, 49, 21)
$Skill3_Timer_D = GUICtrlCreateInput("3000", 304, 128, 49, 21)
$Skill2_Repeat_D = GUICtrlCreateInput("1", 360, 86, 30, 21)
$Skill3_Repeat_D = GUICtrlCreateInput("1", 360, 128, 30, 21)
$Skill1_Check_D = GUICtrlCreateCheckbox("Skill1_Check", 416, 40, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Skill2_Check_D = GUICtrlCreateCheckbox("Skill2_Check", 416, 86, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Skill3_Check_D = GUICtrlCreateCheckbox("Skill3_Check", 416, 128, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Label7 = GUICtrlCreateLabel("Time delay", 296, 16, 55, 17)
$Label8 = GUICtrlCreateLabel("Repeat", 360, 16, 39, 17)
$Label9 = GUICtrlCreateLabel("Use", 408, 16, 31, 17)
$Hp_Check_D = GUICtrlCreateCheckbox("", 8, 168, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Mp_Check_D = GUICtrlCreateCheckbox("", 240, 168, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Label10 = GUICtrlCreateLabel("Hp danger", 24, 168, 54, 17)
$Label11 = GUICtrlCreateLabel("Mp danger", 264, 168, 55, 17)
$Hp_Danger_D = GUICtrlCreateInput("100", 152, 168, 65, 21)
$Mp_Danger_D = GUICtrlCreateInput("150", 384, 168, 49, 21)
$Hp_key_D = GUICtrlCreateCombo("", 88, 168, 57, 25)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","9")
$Mp_key_D = GUICtrlCreateCombo("", 320, 168, 57, 25)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","0")
$Label6 = GUICtrlCreateLabel("Buff pet", 32, 200, 49, 17)
$Exit = GUICtrlCreateButton("Exit", 336, 200, 49, 25)
 GUICtrlSetOnEvent ($Exit, "AltQ")
$Start = GUICtrlCreateButton("Start", 272, 200, 49, 25)
 GUICtrlSetOnEvent ($Start, "Start")
$Hp_Pet_Key_D = GUICtrlCreateCombo("", 88, 200, 57, 25)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","8")
$Hp_Pet_Danger_D = GUICtrlCreateInput("100", 152, 200, 65, 21)
$Hp_Pet_Check_D = GUICtrlCreateCheckbox("", 8, 200, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Hp_Pet_Display = GUICtrlCreateLabel("", 8, 104, 148, 28)
$Group1 = GUICtrlCreateGroup("Thong tin nhan vat", 0, 8, 169, 145)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)

Dim $BaseMod =0x00e7d5bc,$Hp_Mod
Dim $BasePet =0x00ec53e4,$Hp_Pet_Curren,$Hp_Pet_Max,$Hp_Pet_Check,$Hp_Pet_Danger
Dim $Sum_timer,$Curren_timer,$TimerInfo,$TimerStamp,$TimerTab,$Timer_Hp,$Timer_Mp,$Time_mod
Dim $Hp_Curren,$Hp_Max,$Mp_Curren,$Mp_Max,$Sendok =False,$Mp_Ok=True,$Hp_Ok=True, $HP_Check, $MP_Check, $Hp_Danger, $Mp_Danger
Dim $BaseAdd = 0x00EB7EE0
Dim $Skill1_Check, $Skill2_Check, $Skill1_Check, $Skill2_Check, $Skill1_Time, $Skill2_Time,$Skill3_Check, $Skill3_Time,$Skill1_Repeat,$Skill3_Repeat,$Skill2_Repeat,$CurentSkill
$Pid=WinGetProcess("[TITLE:ThucSon; CLASS:evWin32Wnd]")
$MEMID=_memoryopen($pid)

Do
	$Msg = GUIGetMsg()
	If $Sendok Then   
		 if TimerDiff($TimerInfo)>500 then 
			info()
			$TimerInfo=TimerInit()
			Hp_Mod()
		EndIf	
;~ 	    If Hp_Mod() = 444 then 
;~              if TimerDiff($TimerTab)>10000 then 
;~ 			    ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "{TAB}" )
;~ 			    sleep(500)
;~ 				if $Hp_Pet_Check then ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "T")
;~ 				$TimerTab=TimerInit()
;~ 			EndIf
;~ 		EndIf		
		If Hp_Mod() = 0 then  
			ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "{TAB}" )
			sleep(100)
			if $Hp_Pet_Check then 
				ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "T")
				sleep(200)
				ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "T")
				sleep(200)
				ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "T")
			EndIf	
		EndIf	
		If $Hp_Check Then Hp_Check() 
		If $Mp_Check Then Mp_Check()
		if $Hp_Pet_Check Then Hp_Pet_Check()
		if $Hp_Pet_Check then ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", "T")
		if $Skill1_Check Then Skill_1()
		if $Skill2_Check Then Skill_2()
		if $Skill3_Check Then Skill_3()
		
		Sleep(500)
	EndIf	
	Sleep(77)
Until ($Msg = $GUI_EVENT_CLOSE) 

Func Hp_Mod() 
    $Hp_Mod = _MemoryRead($BaseMod ,$MEMID)	
	$Hp_Mod = _MemoryRead($Hp_Mod+0xC ,$MEMID)
	$Hp_Mod = _MemoryRead($Hp_Mod+ 0x2AC,$MEMID)
	$Hp_Mod = _MemoryRead($Hp_Mod+ 0x538,$MEMID)
	Return $Hp_Mod
EndFunc	

Func Hp_Pet_Curren() 
    $Hp_Pet_Curren = _MemoryRead($BasePet ,$MEMID)	
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren+0x8f8 ,$MEMID)
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren+ 0xC,$MEMID)
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren+ 0x740,$MEMID)
	Return $Hp_Pet_Curren
EndFunc	
Func Hp_Pet_Max() 
    $Hp_Pet_Max = _MemoryRead($BasePet ,$MEMID)	
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max+0x8f8 ,$MEMID)
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max+ 0xC,$MEMID)
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max+ 0x47C,$MEMID)
	Return $Hp_Pet_Max
EndFunc	
Func Hp_Curren() 
    $Hp_Curren = _MemoryRead($BaseAdd ,$MEMID)	
	$Hp_Curren = _MemoryRead($Hp_Curren+0x10c ,$MEMID)
	$Hp_Curren = _MemoryRead($Hp_Curren+ 0x740,$MEMID)
	Return $Hp_Curren
EndFunc	
Func Hp_Max() 
    $Hp_Max = _MemoryRead($BaseAdd ,$MEMID)	
	$Hp_Max = _MemoryRead($Hp_Max+0x10c ,$MEMID)
	$Hp_Max = _MemoryRead($Hp_Max+ 0x47c,$MEMID)	
	Return $Hp_Max
EndFunc	
Func Mp_Max() 
    $Mp_Max = _MemoryRead($BaseAdd ,$MEMID)	
	$Mp_Max = _MemoryRead($Mp_Max+0x10c ,$MEMID)
	$Mp_Max = _MemoryRead($Mp_Max+ 0x6ec,$MEMID)		
	Return $Mp_Max
EndFunc	
Func Mp_Curren()
	$Mp_Curren = _MemoryRead($BaseAdd ,$MEMID)	
	$Mp_Curren = _MemoryRead($Mp_Curren+0x10c ,$MEMID)
	$Mp_Curren = _MemoryRead($Mp_Curren+ 0x744,$MEMID)	 
	Return $Mp_Curren
EndFunc
Func Hp_Pet_Check()
	If ( Hp_Pet_Curren() <> 0) and (Hp_Pet_Curren() < $Hp_Danger)  Then
		ControlSend("[TITLE:ThucSon; CLASS:evWin32Wnd]","","",GUICtrlRead($Hp_Pet_Key_D))
		Sleep(100)
	EndIf
EndFunc	
Func Hp_Check()
	If not $Hp_Ok then 
		If TimerDiff($Timer_Hp)> 5000 Then 
			$Hp_Ok = True
		EndIf
	EndIf	
	If ( Hp_Curren() <> 0) and (Hp_Curren() < $Hp_Danger) and $Hp_Ok Then
		ControlSend("[TITLE:ThucSon; CLASS:evWin32Wnd]","","",GUICtrlRead($Hp_key_D))
		Sleep(100)
		$Hp_Ok = False
		$Timer_Hp = TimerInit()
	EndIf
EndFunc	
Func Mp_Check()
	If not $Mp_Ok then 
		If TimerDiff($Timer_Mp)> 5000 Then 
			$Mp_Ok = True
		EndIf
	EndIf	
	If (Mp_Curren() <> 0) and (Mp_Curren() < $Mp_Danger) and $Mp_Ok Then
		ControlSend("[TITLE:ThucSon; CLASS:evWin32Wnd]","","",GUICtrlRead($Mp_key_D))
		Sleep(100)
		$Mp_Ok = False
		$Timer_Mp = TimerInit()
	EndIf
EndFunc	
Func Skill_1()
	$Curren_timer = Int(Timerdiff($TimerStamp))      
	$Sum_timer = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat + $Skill3_Time * $Skill3_Repeat)	 
	If $CurentSkill <= $Skill1_Repeat Then     
		If  (Mod($Curren_timer, $Sum_timer) <= ($Skill1_Time * $Skill1_Time)) Then   
			ControlSend ("[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", GUICtrlRead($Skill1_Key_D) )   
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
	If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat+ $Skill3_Repeat)) And (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * $Skill2_Repeat+ $Skill3_Time * ($Skill3_Repeat - 1))) Then
		$TimerStamp = TimerInit()  
		$CurentSkill =1
	EndIf
EndFunc

Func Skill_2()
	$Curren_timer = Int(Timerdiff($TimerStamp))
	$Sum_timer = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat+ $Skill3_Time * $Skill3_Repeat)
	If ($CurentSkill > $Skill1_Repeat) and ($CurentSkill <= ($Skill1_Repeat + $Skill2_Repeat)) Then
		If  (Mod($Curren_timer, $Sum_timer) <= ($Skill1_Time * $Skill1_Repeat + $Skill2_Time *  $Skill2_Repeat)) Then
			ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", GUICtrlRead($Skill2_Key_D) )
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
	If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat + $Skill3_Repeat)) And (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * $Skill2_Repeat+ $Skill3_Time * ($Skill3_Repeat - 1)))Then
		$TimerStamp = TimerInit()
		$CurentSkill =1
	EndIf
EndFunc
Func Skill_3()
	$Curren_timer = Int(Timerdiff($TimerStamp))
	$Sum_timer = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat+ $Skill3_Time * $Skill3_Repeat)
	If $CurentSkill > $Skill1_Repeat+$Skill2_Repeat Then
		If  (Mod($Curren_timer, $Sum_timer) > ($Skill1_Time * $Skill1_Repeat + $Skill2_Time *  $Skill2_Repeat)) Then
			ControlSend ( "[TITLE:ThucSon; CLASS:evWin32Wnd]", "", "", GUICtrlRead($Skill3_Key_D) )
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
	If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat+$Skill3_Repeat)) And (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * $Skill2_Repeat+ $Skill3_Time * ($Skill3_Repeat - 1))) Then
		$TimerStamp = TimerInit()
		$CurentSkill =1
	EndIf
EndFunc	
Func start()
	$Sendok = Not $Sendok 
	WinSetTitle("[TITLE:ThucSon; CLASS:evWin32Wnd]", "","ThucSon")
	If $Sendok Then 
		GUICtrlSetData($Start,"Stop")
		$TimerStamp = TimerInit()
		$CurentSkill=1
		If GUICtrlRead($Mp_Check_D)=$GUI_CHECKED Then $Mp_Check = True 
		If GUICtrlRead($Hp_Check_D)=$GUI_CHECKED Then $Hp_Check = True
		If GUICtrlRead($Hp_Pet_Check_D)=$GUI_CHECKED Then 
			$Hp_Pet_Check = True
			$Hp_Pet_Danger = GUICtrlRead($Hp_Pet_Danger_D)
			ToolTip($Hp_Pet_Check&@SEC,0,0)
		Else
			ToolTip($Hp_Pet_Check&@SEC,0,0)
		EndIf	
		$Skill1_time=GUICtrlRead($Skill1_timer_D)
		$Skill2_time=GUICtrlRead($Skill2_timer_D)
		$Skill3_time=GUICtrlRead($Skill3_timer_D)
		$Skill1_Repeat=GUICtrlRead($Skill1_Repeat_D)
		$Skill2_Repeat=GUICtrlRead($Skill2_Repeat_D)
		$Skill3_Repeat=GUICtrlRead($Skill3_Repeat_D)
		$Hp_Danger=GUICtrlRead($Hp_Danger_D)
		$Mp_Danger=GUICtrlRead($Mp_Danger_D)
		If GUICtrlRead($Skill1_Check_D)=$GUI_CHECKED Then $Skill1_Check = True
		If GUICtrlRead($Skill2_Check_D)=$GUI_CHECKED Then $Skill2_Check = True
		If GUICtrlRead($Skill3_Check_D)=$GUI_CHECKED Then $Skill3_Check = True
		GUICtrlSetState($Skill1_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Danger_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_Danger_D, $GUI_DISABLE)
		WinActive("[TITLE:ThucSon; CLASS:evWin32Wnd]")
	Else 
		GUICtrlSetData($Start,"Start")
		GUICtrlSetState($Skill1_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Danger_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_Danger_D, $GUI_ENABLE)
		_MemoryClose($MEMID)
	EndIf	
EndFunc		

func info()
GUICtrlSetData($Hp_Dislay,"Hp  "& Hp_Curren() & "/" & Hp_Max())
GUICtrlSetData($Mp_Dislay,"Mp  "&  Mp_Curren() & "/" & Mp_Max())
If $Hp_Pet_Check then GUICtrlSetData($Hp_Pet_Display,"PetHp  "&  Hp_Pet_Curren() & "/" & Hp_Pet_Max())
EndFunc

Func AltQ()
	Exit
EndFunc
