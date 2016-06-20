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

Func FCTConnect()
	If $CETutorialCon<>0 Then Return

	Local $ProcessName = IProcessNameGet()
	Local $aProcessList = ProcessList($ProcessName)
	If(@error==1) Then Return
	If($aProcessList[0][0]==0) Then
		LNoticeSet('Process cant be found')
		Return
	EndIf

	$CETutorialPID = $aProcessList[1][1]

	$CETutorialCon = _MemoryOpen($CETutorialPID)
	LNoticeSet('Found the process')
EndFunc

Func FCTRead($iv_Address,$sv_Type = 'dword')
	Return _MemoryRead($iv_Address, $CETutorialCon,$sv_Type)
EndFunc

Func FCTWrite($iv_Address,$v_Data, $sv_Type = 'dword')
	Return _MemoryWrite($iv_Address, $CETutorialCon, $v_Data, $sv_Type)
EndFunc




Func FCTStep1LoadAddress()
	Local $iv_Address = IStep1AddressGet() 	;(mã hex)
	Local $Heath = FCTRead($iv_Address)
	LStep1HeathSet($Heath)
EndFunc

Func FCTStep1ChangeTo()
	Local $iv_Address = IStep1AddressGet() 	;(mã hex)
	Local $v_Data = IStep1ChangeToGet()
	Return FCTWrite($iv_Address,$v_Data)
EndFunc



Func FCTStep2LoadAddress()
	Local $Step2DataType = StringLower(COStep2DataTypeGet())

	Local $iv_Address = IStep2AddressGet() 	;(mã hex)
	Local $Heath = FCTRead($iv_Address,$Step2DataType)
	LStep2HeathSet($Heath)
EndFunc

Func FCTStep2ChangeTo()
	Local $iv_Address = IStep2AddressGet() 	;(mã hex)
	Local $v_Data = IStep2ChangeToGet()
	Return FCTWrite($iv_Address,$v_Data,StringLower(COStep2DataTypeGet()))
EndFunc

Func FCTStep5ChangeTo()
	Local $CodeAddress = IStep5CodeAddressGet() 	;(mã hex)
	Local $NewValue = IStep5NewAddValueGet() 	;(mã hex)
;~ 	MsgBox(0,$CodeAddress,$NewValue)
	Return FCTWrite($CodeAddress,$NewValue)
EndFunc

Func FCTStep6LoadAddress()

	Local $iv_Address = IStep6PointerGet() 	;(mã hex)
	Local $Data1 = FCTRead($iv_Address)		;(mã thập phân)
	$Data1 = '0x'&Hex($Data1)				;0x1842398
	Local $Data2 = FCTRead($Data1)

	If ($Step6ValueIsHex==True) Then
		$Data2 = Hex($Data2,8)
	EndIf

	LStep6ValueSet($Data2)
EndFunc

Func FCTStep6ChangeTo()

	Local $iv_Address = IStep6PointerGet() 	;(mã hex)
	Local $Data1 = FCTRead($iv_Address)		;(mã thập phân)
	$Data1 = '0x'&Hex($Data1)				;0x1842398
	$Step6FreezeAdd = $Data1
	Local $Data2 = FCTRead($Data1)

;~ 	MsgBox(0,$autoname,$Data2)
	Local $NewValue = IStep6ChangeToGet() 	;(mã hex)
	Return FCTWrite($Data1,$NewValue)
EndFunc

