#include <GUIConstants.au3>
#include <StaticConstants.au3>
Opt("GUIOnEventMode", 1)
Opt("SendKeyDelay",10)
Opt("SendKeyDownDelay",10)
Opt("SendCapslockMode",0)
WinSetTitle("[TITLE:ThucSon | Bát Quái Môn | 1.2.1422.0]", "","Thuc Son")
$Pid=WinGetProcess("Thuc Son")
$MEMID=_memoryopen($pid)

$Form1 = GUICreate("Thuc Son auto beta 1.0",447, 241, 890, 237)
$Label1 = GUICtrlCreateLabel("Thong tin nhan vat", 8, 16, 142, 25)
$Hp_Dislay = GUICtrlCreateLabel("", 8, 48, 140, 36)
$Mp_Dislay = GUICtrlCreateLabel("", 8, 96, 164, 44)
$Label2 = GUICtrlCreateLabel("Key", 248, 16, 22, 17)
$Label3 = GUICtrlCreateLabel("Skill 1", 176, 40, 52, 28)
$Label5 = GUICtrlCreateLabel("Skill 3", 176, 128, 52, 28)
$Label4 = GUICtrlCreateLabel("Skill 2", 176, 80, 52, 28)
$Skill1_Key_D = GUICtrlCreateCombo("", 240, 40, 60, 25)
GUICtrlSetData(-1,"1|2|3|4|5|6","1")
$Skill2_Key_D = GUICtrlCreateCombo("", 240, 86, 60, 25)
GUICtrlSetData(-1,"1|2|3|4|5|6","2")
$Skill3_Key_D = GUICtrlCreateCombo("", 240, 128, 60, 25)
GUICtrlSetData(-1,"1|2|3|4|5|6","3")
$Skill1_Timer_D = GUICtrlCreateInput("1000", 304, 40, 49, 21)
$Skill1_Repeat_D = GUICtrlCreateInput("1", 360, 40, 30, 21)
$Skill2_timer_D = GUICtrlCreateInput("1000", 304, 86, 49, 21)
$Skill3_Timer_D = GUICtrlCreateInput("1000", 304, 128, 49, 21)
$Skill2_Repeat_D = GUICtrlCreateInput("1", 360, 86, 30, 21)
$Skill3_Repeat_D = GUICtrlCreateInput("1", 360, 128, 30, 21)
$Skill1_Check_D = GUICtrlCreateCheckbox("Skill1_Check", 416, 40, 17, 17)
$Skill2_Check_D = GUICtrlCreateCheckbox("Skill2_Check", 416, 86, 17, 17)
$Skill3_Check_D = GUICtrlCreateCheckbox("Skill3_Check", 416, 128, 17, 17)
$Label7 = GUICtrlCreateLabel("Time delay", 296, 16, 55, 17)
$Label8 = GUICtrlCreateLabel("Repeat", 360, 16, 39, 17)
$Label9 = GUICtrlCreateLabel("Use", 408, 16, 23, 17)
$Hp_Check_D = GUICtrlCreateCheckbox("", 8, 168, 17, 17)
$Mp_Check_D = GUICtrlCreateCheckbox("", 240, 168, 17, 17)
$Label10 = GUICtrlCreateLabel("Hp danger", 24, 168, 54, 17)
$Label11 = GUICtrlCreateLabel("Mp danger", 264, 168, 55, 17)
$Hp_Danger_D = GUICtrlCreateInput("1000", 152, 168, 65, 21)
$Mp_Danger_D = GUICtrlCreateInput("400", 384, 168, 49, 21)
$Hp_key_D = GUICtrlCreateCombo("", 88, 168, 57, 25)
GUICtrlSetData(-1,"1|2|3|4|5|6","4")
$Mp_key_D = GUICtrlCreateCombo("", 320, 168, 57, 25)
GUICtrlSetData(-1,"1|2|3|4|5|6","5")
$Label6 = GUICtrlCreateLabel("Time change mod", 8, 200, 89, 17)
$Time_mod_D = GUICtrlCreateInput("8000", 104, 200, 129, 21)
$Exit = GUICtrlCreateButton("Exit", 336, 200, 49, 25, 0)
	GUICtrlSetOnEvent ($Exit, "AltQ")
$Start = GUICtrlCreateButton("Start", 272, 200, 49, 25, 0)
    GUICtrlSetOnEvent ($Start, "Start")
GUISetState(@SW_SHOW)
Dim $Hp_Curren,$Hp_Max,$Mp_Curren,$Mp_Max,$Sendok =False,$Mp_Ok,$Hp_Ok, $HP_Check, $MP_Check, $Hp_Danger, $Mp_Danger
Dim $BaseAdd = 0x128307e8,$Hp_Ok = True,$CurentSkill,$TimerInfo,$TimerStamp,$TimerTab,$Timer_Hp,$Timer_Mp,$Time_mod
Dim $Skill1_Check, $Skill2_Check, $Skill1_Check, $Skill2_Check, $Skill1_Time, $Skill2_Time,$Skill3_Check, $Skill3_Time,$Skill1_Repeat,$Skill3_Repeat,$Skill2_Repeat
Do
	$Msg = GUIGetMsg()
	If $Sendok Then   
		 if TimerDiff($TimerInfo)>500 then 
			info()
			$TimerInfo=TimerInit()
		EndIf	
		if TimerDiff($TimerTab)>$Time_mod then 
			ControlSend ( "Thuc Son", "", "", "{TAB}" )
			$TimerTab=TimerInit()
		EndIf	
		If $Hp_Check Then Hp_Check() 
		If $Mp_Check Then Mp_Check() 
		if $Skill1_Check Then Skill_1()
		if $Skill2_Check Then Skill_2()
		if $Skill3_Check Then Skill_3()
		Sleep(100)
	EndIf	
Until ($Msg = $GUI_EVENT_CLOSE) 
Func Hp_Curren()
	$Hp_Curren = _MemoryRead($BaseAdd +0x2e4,$MEMID)  
	Return $Hp_Curren
EndFunc	
Func Mp_Curren()
	$Mp_Curren = _MemoryRead($BaseAdd +0x2e8,$MEMID)  
	Return $Mp_Curren
EndFunc
Func Hp_Check()
	If not $Hp_Ok then 
		If TimerDiff($Timer_Hp)> 5000 Then 
			$Hp_Ok = True
		EndIf
	EndIf	
	If ( Hp_Curren() <> 0) and (Hp_Curren() < $Hp_Danger) and $Hp_Ok Then
		ControlSend("Thuc Son","","",GUICtrlRead($Hp_key_D))
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
		ControlSend("Thuc Son","","",GUICtrlRead($Mp_key_D))
		Sleep(100)
		$Mp_Ok = False
		$Timer_Mp = TimerInit()
	EndIf
EndFunc	
Func Skill_1()
	$Num1 = Int(Timerdiff($TimerStamp))      
	$Num2 = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat + $Skill3_Time * $Skill3_Repeat)	 
	If $CurentSkill <= $Skill1_Repeat Then     
		If  (Mod($Num1, $Num2) > ($Skill1_Time * ($CurentSkill -1))) Then   
			ControlSend ("Thuc Son", "", "", GUICtrlRead($Skill1_Key_D) )   
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
	If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat+ $Skill3_Repeat)) And (Mod($Num1, $Num2) < ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * $Skill2_Repeat+ $Skill3_Time * ($Skill3_Repeat - 1))) Then
		$TimerStamp = TimerInit()  
		$CurentSkill =1
	EndIf
EndFunc

Func Skill_2()
	$Num1 = Int(Timerdiff($TimerStamp))
	$Num2 = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat+ $Skill3_Time * $Skill3_Repeat)
	If $CurentSkill > $Skill1_Repeat Then
		If  (Mod($Num1, $Num2) > ($Skill1_Time * ($Skill1_Repeat) + $Skill2_Time * ($CurentSkill -1 - $Skill1_Repeat))) Then
			ControlSend ( "Thuc Son", "", "", GUICtrlRead($Skill2_Key_D) )
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
	If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat)) And (Mod($Num1, $Num2) < ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * $Skill2_Repeat+ $Skill3_Time * ($Skill3_Repeat - 1)))Then
		$TimerStamp = TimerInit()
		$CurentSkill =1
	EndIf
EndFunc
Func Skill_3()
	$Num1 = Int(Timerdiff($TimerStamp))
	$Num2 = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat+ $Skill3_Time * $Skill3_Repeat)
	If $CurentSkill > $Skill1_Repeat+$Skill2_Repeat Then
		If  (Mod($Num1, $Num2) > ($Skill1_Time * ($Skill1_Repeat) +$Skill2_Time * ($Skill2_Repeat)+ $Skill3_Time * ($CurentSkill -1 - $Skill1_Repeat-$Skill2_Repeat))) Then
			ControlSend ( "Thuc Son", "", "", GUICtrlRead($Skill3_Key_D) )
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
	If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat)) And (Mod($Num1, $Num2) < ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * $Skill2_Repeat+ $Skill3_Time * ($Skill3_Repeat - 1))) Then
		$TimerStamp = TimerInit()
		$CurentSkill =1
	EndIf
EndFunc		
Func start()
	$Sendok = Not $Sendok 
	If $Sendok Then 
		GUICtrlSetData($Start,"Stop")
		$TimerStamp = TimerInit()
		$CurentSkill=1
		If GUICtrlRead($Mp_Check_D)=$GUI_CHECKED Then $Mp_Check = True 
		If GUICtrlRead($Hp_Check_D)=$GUI_CHECKED Then $Hp_Check = True
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
		$Time_mod =GUICtrlRead($Time_mod_D)
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
		GUICtrlSetState($Time_mod_D, $GUI_DISABLE)
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
		GUICtrlSetState($Time_mod_D, $GUI_ENABLE)
	EndIf	
EndFunc		
func info()
$Hp_Curren = _MemoryRead($BaseAdd +0x2e4,$MEMID)  
$Hp_Max = _MemoryRead($BaseAdd +0x20,$MEMID)
$Mp_Curren = _MemoryRead($BaseAdd +0x2e8,$MEMID)
$Mp_Max = _MemoryRead($BaseAdd +0x290,$MEMID)
GUICtrlSetData($Hp_Dislay,"Hp  "&$Hp_Curren & " / " & $Hp_Max)
GUICtrlSetData($Mp_Dislay,"Mp  "&  $Mp_Curren & "/ " & $Mp_Max)
EndFunc
Func AltQ()
	Exit
EndFunc
Func _MemoryOpen($iv_Pid, $iv_DesiredAccess = 0x1F0FFF, $iv_InheritHandle = 1)
	
	If Not ProcessExists($iv_Pid) Then
		SetError(1)
        Return 0
	EndIf
	
	Local $ah_Handle[2] = [DllOpen('kernel32.dll')]
	
	If @Error Then
        SetError(2)
        Return 0
    EndIf
	
	Local $av_OpenProcess = DllCall($ah_Handle[0], 'int', 'OpenProcess', 'int', $iv_DesiredAccess, 'int', $iv_InheritHandle, 'int', $iv_Pid)
	
	If @Error Then
        DllClose($ah_Handle[0])
        SetError(3)
        Return 0
    EndIf
	
	$ah_Handle[1] = $av_OpenProcess[0]
	
	Return $ah_Handle
	
EndFunc
Func _MemoryRead($iv_Address, $ah_Handle, $sv_Type = 'dword')
	
	If Not IsArray($ah_Handle) Then
		SetError(1)
        Return 0
	EndIf
	
	Local $v_Buffer = DllStructCreate($sv_Type)
	
	If @Error Then
		SetError(@Error + 1)
		Return 0
	EndIf
	
	DllCall($ah_Handle[0], 'int', 'ReadProcessMemory', 'int', $ah_Handle[1], 'int', $iv_Address, 'ptr', DllStructGetPtr($v_Buffer), 'int', DllStructGetSize($v_Buffer), 'int', '')
	
	If Not @Error Then
		Local $v_Value = DllStructGetData($v_Buffer, 1)
		Return $v_Value
	Else
		SetError(6)
        Return 0
	EndIf
	
EndFunc