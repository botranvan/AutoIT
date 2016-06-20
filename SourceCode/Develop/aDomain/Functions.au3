#include-once

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FSaveLog(" == FAutoStart ===============================")
	FSettingLoad()
	LNoticeSetSize(200)
	MainGUIFix()
EndFunc

;~ Kết thúc chương trình
Func FAutoEnd()
	FSettingSave()
	MainGUISave()
	FSaveLog(" == FAutoEnd =================================")
;	FileClose($LogFile)
	Exit
EndFunc

;~ Xóa ToolTip
Func FToolTipDel()
	ToolTip("")
EndFunc

;~ Tạm dừng chương trình
Func FAutoPause()
	If Not $AutoPause Then Return
	FSaveLog(" FAutoPause "&$AutoPause)
	While $AutoPause
		Sleep(10)
		LNoticeSet("Pause "&@SEC)
	WEnd
	LNoticeSet("")
EndFunc

;~ Ẩn hiện chương trình
Func FAutoShow($Show = 0)
	Local $Span = 35
	If $Show Then
		BHiddenSet("/\")
		MainGUISetPos($AutoPos[0],$AutoPos[1])
	Else
		$AutoPos = MainGUIGetPos()
		BHiddenSet("\/")
		MainGUISetPos($AutoPos[0],0-$AutoPos[3]+$Span,2)
	EndIf
EndFunc


;~ Nạp các thông số chung của chương trình
Func FSettingLoad()

EndFunc

;~ Lưu các thông số chung của chương trình
Func FSettingSave()

EndFunc

;~ Ghi dữ liệu xuống file log để tracking code
Func FSaveLog($Log = "!!!!!!!")
	If Not $SaveLog Then Return
	Local $Data
	If $LogFile == 0 Then $LogFile = FileOpen($LogFileName,1+8)
	$Data = @HOUR&":"&@MIN&":"&@SEC&" "&@MSEC&" | "&$Log
	FileWriteLine($LogFile,$Data)
EndFunc

;~ Lấy chuỗi dữ liệu từ file text
Func FT($Patten,$Original = "")
	Local $Text
    If Not FileExists($LangFile) Then
        $File = FileOpen($LangFile,1+8+128)
        FileClose($File)
    EndIf

    $Text = ""
    $File = FileOpen($LangFile)
    While 1
        $Line = FileReadLine($File)
        If @error = -1 Then ExitLoop

        If StringInStr($Line,$Patten&"=") Then
            $Text = StringReplace($Line,$Patten&"=","")
        EndIf
    WEnd
    FileClose($File)

    If $Text == "" Then
		$Text = $Patten
		If $Original Then $Text = $Original
        $File = FileOpen($LangFile,1+8+128)
        FileWriteLine($File,$Patten&"="&$Text)
        FileClose($File)
    EndIf

	Return $Text
EndFunc

;~ Lưu chuỗi dữ liệu vào file
Func FTWrite($Patten,$NewValue)
    $Data = ""
	$Found = False
    $File = FileOpen($LangFile)
    While 1
        $Line = FileReadLine($File)
        If @error = -1 Then ExitLoop
        If StringInStr($Line,$Patten&"=") Then
            $Text = StringReplace($Line,$Patten&"=","")
			$Data&= $Patten&'='&$NewValue&@LF
			$Found = True
		Else
			$Data&= $Line&@LF
        EndIf
    WEnd
    FileClose($File)

	if(Not $Found) Then $Data&= $Patten&'='&$NewValue&@LF
	$File = FileOpen($LangFile,2+8+128)
	FileWrite($File,$Data)
	FileClose($File)
EndFunc


;~ Kiểm tra công việc kế cần thực hiện
Func FCommandCheck()
    Local $Command,$Pos,$TheTran,$HamDoi
    $Command = $CommandList[0]

    If $Command == -1 Then
        ;Xử lý khi không có lệnh nào
    EndIf

    FCommandSplit($Command)
    Switch $CommandCurrent[1]

		Case "TestCase"
;~ 			FTest()

    EndSwitch
EndFunc

;~ Phân tách command
Func FCommandSplit($Command)
    $CommandCurrent = StringSplit($Command,"|")
    Return $CommandCurrent
EndFunc

;~ Thêm 1 công việc vào danh sách
Func FCommandAdd($Command)
    If $Command <> $CommandList[0] Then _ArrayInsert($CommandList,0,$Command)
EndFunc

;~ Thêm 1 công việc vào danh sách
Func FCommandRemove($Command)
    For $i = 0 To UBound($CommandList)-1
        If $CommandList[$i] == $Command Then
            _ArrayDelete($CommandList,$i)
            Return
        EndIf
    Next
EndFunc

;~ Xóa toàn bộ lệnh hiện tại
Func FCommandClear()
    ReDim $CommandList[1]
    $CommandList[0] = -1
EndFunc

Func FComputerIPGet()
	LNoticeSet("Get Computer IP")

	$TryAttack = 1;
	Local $oIE = _IECreate($ComputerIP_URL,$TryAttack,$ShowIE)
	Local $oDiv = _IEGetObjById($oIE, "checkip")
	$value = _IEFormElementGetValue($oDiv)
	LComputerIPSet($value)
	_IEQuit($oIE)
EndFunc

Func FDomainIPGet()

	Local $oIE = _IECreate($DomainIP_URL,1,$ShowIE,1)
;~ 	Local $oIE = _IECreate($DomainList_URL,1)

	$TryCount = 0
	Do
		$TryCount+=1
		Sleep(1000)

;~ 		If(_IEPropertyGet($oIE, 'busy') Then
			Local $sText = _IEBodyReadHTML($oIE)
			Local $return = _StringBetween($sText,'PADDING-TOP: 0px"><INPUT value=',' size=30 type=text name=records[0][value]')
			If Not @error Then ExitLoop
;~ 		EndIf


		LNoticeSet("Waiting domain ip... "&@SEC)
		If(Mod($TryCount,10)==0) Then _IENavigate($oIE,$DomainIP_URL,0)

	Until False

	If(Not @error) Then
		LDomainIPSet($return[0])
	EndIf

	Return $oIE
EndFunc

Func FDomainIPUpdate($oIE)
	Local $DomainIP = LDomainIPGet()
	Local $ComputerIP = LComputerIPGet()

;~ 	$ComputerIP = '58.186.55.111'

	If StringCompare($DomainIP,$ComputerIP) == 0 Then
		LNoticeSet("IP ok")
		Return
	EndIf

	LNoticeSet("IP updating")

	Local $html = _IEBodyReadHTML($oIE)
	$html = StringReplace($html,$DomainIP,$ComputerIP)
	_IEBodyWriteHTML($oIE,$html)

	Local $oForms = _IEFormGetCollection($oIE)
;~ 	MsgBox(0, "Forms Info", "There are " & @extended & " forms on this page")
	For $oForm In $oForms
		_IEFormSubmit($oForm)
		ExitLoop
	Next

	LNoticeSet('IP updated')
EndFunc

Func FDomainUpdateTimer()
	If Not $AutoRuning Then Return
	$DomainTimeCount = Round(TimerDiff($DomainTimer)/1000)
	Local $RepeatTime = IRepeatTimeGet()


	LNoticeSet('Next check:' &$DomainTimeCount&" / "&$RepeatTime&" s")

	If($DomainTimeCount < $RepeatTime) Then Return

	FComputerIPGet()
	$oIE = FDomainIPGet()
	FDomainIPUpdate($oIE)
	_IEQuit($oIE)

	Sleep(5000)

	$DomainTimer = TimerInit()
EndFunc

