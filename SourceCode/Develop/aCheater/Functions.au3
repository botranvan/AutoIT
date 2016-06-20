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
		LStep6ValueSet(" 0x"&$Data2)
	Else
		LStep6ValueSet($Data2)
	EndIf

EndFunc

Func FCTStep6ChangeTo()

	Local $iv_Address = IStep6PointerGet() 	;(mã hex)
	Local $Data1 = FCTRead($iv_Address)		;(mã thập phân)
	$Data1 = '0x'&Hex($Data1)				;0x1842398
	Local $Data2 = FCTRead($Data1)

	Local $NewValue = IStep6ChangeToGet() 	;(mã hex)
	Return FCTWrite($Data1,$NewValue)
EndFunc

Func CHStep6Freeze()
	If(Not CHStep6FreezeIsCheck()) Then Return

	LNoticeSet("Step 6: Freezing..."&@SEC)
	FCTStep6ChangeTo()
EndFunc





Func FCTStep7LoadAddress()

	Local $iv_Address = IStep7AddressGet() 	;(mã hex)
	Local $Data1 = FCTRead($iv_Address)		;(mã thập phân)

	If ($Step7ValueIsHex==True) Then
		$Data1 = Hex($Data1,8)
		LStep7AddValueSet(" 0x"&$Data1)
	Else
		LStep7AddValueSet($Data1)
	EndIf

EndFunc

Func FCTStep7Inject()
	Local $iv_Address = IStep7AddressGet()
	Local $iv_AddressDec = Dec(StringReplace($iv_Address,'0x',''))
	Local $NewMem = FCInject()


	$add_current = $iv_AddressDec
	$add_dest = Dec($NewMem)

	$ByteArray = FJmpByteCreate($add_current,$add_dest)
	$ByteHex = $ByteArray[3]&$ByteArray[2]&$ByteArray[1]&$ByteArray[0]

	$AddVar = '0x'&Hex(Dec(StringReplace($ByteHex,' ','')),10)
	LNoticeSet($NewMem&":"&$AddVar&' / '&$ByteHex)
	FCTWrite($iv_Address,$AddVar)

	$iv_AddressDec+=4
	Local $iv_Address2 = '0x'&Hex($iv_AddressDec,8)
	$AddVar = '0x'&Hex(Dec(StringReplace('458D90'&$ByteArray[4],' ','')),8)
	FCTWrite($iv_Address2,$AddVar)


	$NewMem1 = '0x'&Hex(Dec($NewMem),8)
	FCTWrite($NewMem1,0x04608383)

	$NewMem2 = '0x'&Hex(Dec($NewMem)+4,8)
	FCTWrite($NewMem2,0xE9020000)



	$add_current = Dec($NewMem)+7
	$add_dest = $iv_AddressDec+2
	$ByteArray = FJmpByteCreate($add_current,$add_dest)
	$ByteHex = $ByteArray[4]&$ByteArray[3]&$ByteArray[2]&$ByteArray[1]

	$AddVar = '0x'&Hex(Dec(StringReplace($ByteHex,' ','')),8)

;~ 	MsgBox(0,'$add_current',Hex($add_current))
;~ 	MsgBox(0,'$add_dest',Hex($add_dest))
;~ 	_ArrayDisplay($ByteArray,'$ByteArray')
;~ 	MsgBox(0,'$ByteHex',$ByteHex)
;~ 	MsgBox(0,'$AddVar',$AddVar)

	FCTWrite($add_current+1,$AddVar)
EndFunc

;~ 03950000 - 83 83 60040000 02     - add dword ptr [ebx+00000460],02
;~ 03970000 - 83 83 60040000 02     - add dword ptr [ebx+00000460],02

;~ 01780007 - E9 E340CAFE           - jmp 004240EF
;~ "Tutorial-i386.exe"+240E9


Func FCTStep7Restore()
	Local $iv_Address = IStep7AddressGet() 	;(mã hex)
	Local $iv_AddressDec = Dec(StringReplace($iv_Address,'0x',''))

	$iv_AddressDec+=4
	Local $iv_Address2 = '0x'&Hex($iv_AddressDec,8)

	FCTWrite($iv_Address,0x04608BFF)
	FCTWrite($iv_Address2,0x458D0000)
EndFunc

Func FCInject()

	$re = DllCall("Kernel32.Dll", "int", "OpenProcess", "int", 2035711, "int", 0, "int", $CETutorialPID)
	$process = $re[0]

	$re= DllCall("Kernel32.dll", "ptr", "VirtualAllocEx", "int", $process, "ptr", 0, "int", 128, "int", 4096, "int", 64)
	Return StringReplace($re[0],'0x','')
EndFunc

Func FJmpByteCreate($add_current,$add_dest)
	$ByteHex = $add_dest - ($add_current + 5)
	$ByteHex = StringSplit(Hex($ByteHex,8),'')

	Local $ByteArray[5] = ['E9',$ByteHex[7]&$ByteHex[8],$ByteHex[5]&$ByteHex[6],$ByteHex[3]&$ByteHex[4],$ByteHex[1]&$ByteHex[2]]

	Return $ByteArray
EndFunc






Func FCTStep8LoadAddress()

	Local $iv_Address = IStep8PointerGet()
	Local $Data1 = FPointerRead($iv_Address)		;(mã thập phân)

	If ($Step8ValueIsHex==True) Then
		$Data1 = Hex($Data1,8)
		LStep8ValueSet(" 0x"&$Data1)
	Else
		LStep8ValueSet($Data1)
	EndIf

EndFunc


Func CHStep8Freeze()
	If(Not CHStep8FreezeIsCheck()) Then Return

	LNoticeSet("Step 8: Freezing..."&@SEC)
	FCTStep8ChangeTo()
EndFunc


Func FCTStep8ChangeTo()
	Local $iv_Address = IStep8PointerGet() 	;(mã hex)
	Local $NewValue = IStep8ChangeToGet() 	;(mã hex)
	Return FPointerWrite($iv_Address,$NewValue);
EndFunc

;   	0x006903B0|0xC|0x14|0x0|0x18
Func FPointerRead($iv_Address,$sv_Type = 'dword')
	$iv_Address = StringSplit($iv_Address,'|')

	$Cur = FCTRead($iv_Address[1])

	For $i = 2 To $iv_Address[0]-1 Step 1
		$Cur = FCTRead($Cur+$iv_Address[$i])
	Next

	Return FCTRead($Cur+$iv_Address[$i],$sv_Type)
EndFunc

Func FPointerWrite($iv_Address,$NewValue,$sv_Type = 'dword')
	$iv_Address = StringSplit($iv_Address,'|')

	$Cur = FCTRead($iv_Address[1])		;Dec

	For $i = 2 To $iv_Address[0]-1 Step 1
		$Cur = FCTRead($Cur+$iv_Address[$i])
	Next			;	Dec		Hex	(Dec)

	Return FCTWrite($Cur+$iv_Address[$i],$NewValue,$sv_Type)
EndFunc