#include-once

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FSaveLog(" == FAutoStart ===============================")
	FSettingLoad()
	LNoticeSetSize(200)
;	LNoticeBackGround(0xFF0000)
	MainGUIFix()
;~ 	MainGUISetState()

	LGroundPosSet($Ground[0]&'x'&$Ground[1])
	LGroundSizeSet($Ground[2]&'x'&$Ground[3])
	FCreateChar()
	FCharOnTop()
EndFunc

;~ Kết thúc chương trình
Func FAutoEnd()
	FSettingSave()
	MainGUISave()
	_GEng_Shutdown()

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

;~ Lấy chuỗi dự liệu từ file text
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

;~ Tạo nhân vật
Func FCreateChar()
	Local $mm1
	$mm1 = _GEng_ImageLoad($mm1l,$mm1width,$mm1height)
	$mm1obj = _GEng_Sprite_Create()


	$mm1showup = _GEng_Anim_Create()
	For $i=$CharStepShowUp[0] To $CharStepShowUp[1]
		_GEng_Anim_FrameAdd($mm1showup, $mm1, 70,$CharWidth*$i,0,$CharWidth,$CharHeight)
	Next


	$mm1standright = _GEng_Anim_Create()
	_GEng_Anim_FrameAdd($mm1standright, $mm1, 3000,$CharWidth*$CharStandRight[0],0,$CharWidth,$CharHeight)
	For $i=$CharStandRight[0]+1 To $CharStandRight[1]
		_GEng_Anim_FrameAdd($mm1standright, $mm1, 70,$CharWidth*$i,0,$CharWidth,$CharHeight)
	Next

	$mm1standleft = _GEng_Anim_Create()
	_GEng_Anim_FrameAdd($mm1standleft, $mm1, 3000,$CharWidth*$CharStandLeft[0],71,$CharWidth,$CharHeight)
	For $i=$CharStandLeft[0]+1 To $CharStandLeft[1]
		_GEng_Anim_FrameAdd($mm1standleft, $mm1, 70,$CharWidth*$i,71,$CharWidth,$CharHeight)
	Next



	$mm1moveright = _GEng_Anim_Create()
	For $i=$CharMoveRight[0] To $CharMoveRight[1]
		_GEng_Anim_FrameAdd($mm1moveright, $mm1, 75,$CharWidth*$i,0,$CharWidth,$CharHeight)
	Next

	$mm1moveleft = _GEng_Anim_Create()
	For $i=$CharMoveLeft[0] To $CharMoveLeft[1]
		_GEng_Anim_FrameAdd($mm1moveleft, $mm1, 75,$CharWidth*$i,71,$CharWidth,$CharHeight)
	Next



	_GEng_Sprite_Animate($mm1obj, $mm1showup)
EndFunc

Func FCharGetInfo()
	$CharPos = WinGetPos($__GEng_hGui)
	$CharPos[1] = $CharPos[1]+$CharPos[3]-$CharHeightDif
	LCharPosSet($CharPos[0]&'x'&$CharPos[1])
EndFunc

Func FCharLiving()
	If FCharDropDown() Then
		$CharOnGround = True
	EndIf

	FCharStand()
	FCharMoving()

	If Not Random(0,5) Then GUISetState (@SW_RESTORE,$__GEng_hGui)
EndFunc

Func FCharMoving()
	If Not $CharOnGround Then Return

	Local $Pos,$CharPosOld
	$Pos = MouseGetPos()
	$CharPosOld = $CharPos

;~ 	Move To right
	If ($Pos[0]-$CharPos[0]) > $CharStandBy+$CharWidth Then
		If $CharStand Then _GEng_Sprite_AnimRewind($mm1obj,1)
		If $CharLeft Then _GEng_Sprite_AnimRewind($mm1obj,1)
		_GEng_Sprite_Animate($mm1obj, $mm1moveright)
		$CharPos[0]+=$CharMoveSpeed
		$CharRight = True
		$CharLeft = False

;~ 	Move To left
	ElseIf ($CharPos[0]-$Pos[0]) > $CharStandBy Then
		If $CharStand Then _GEng_Sprite_AnimRewind($mm1obj,1)
		If $CharRight Then _GEng_Sprite_AnimRewind($mm1obj,1)
		_GEng_Sprite_Animate($mm1obj, $mm1moveleft)
		$CharPos[0]-=$CharMoveSpeed
		$CharRight = False
		$CharLeft = True

;~ 	Stop
	Else
		If Not $CharStand Then _GEng_Sprite_AnimRewind($mm1obj,1)
		$CharStand = True
		Return False
	EndIf

	WinMove($__GEng_hGui,'',$CharPos[0],$CharPos[1]-$CharPos[3]+$CharHeightDif)
	$CharStand = False
	Return True
EndFunc

Func FCharStand()
	If Not $CharOnGround Or Not $CharStand Then Return

	If($CharRight) Then
		_GEng_Sprite_Animate($mm1obj, $mm1standright)
	ElseIf($CharLeft) Then
		_GEng_Sprite_Animate($mm1obj, $mm1standleft)
	EndIf
EndFunc

Func FCharDropDown()
	If $CharOnGround Then Return

	If $CharPos[1] < $Ground[1] Then $CharPos[1]+=Ceiling(($Ground[1]-$CharPos[1])/$CharDropSpeed+10)
	If $CharPos[1] > $Ground[1] Then $CharPos[1] = $Ground[1]
	WinMove($__GEng_hGui,'',$CharPos[0],$CharPos[1]-$CharPos[3]+$CharHeightDif)

	If(($Ground[1]-$CharPos[1]) < 10) Then
		If _GEng_Sprite_Animate($mm1obj, $mm1showup,$CharStepShowUp[2]) == -1 Then
			_GEng_Sprite_AnimRewind($mm1obj,1)
			Return True
		EndIf
	EndIf

	Return False
EndFunc

Func FCharOnTop($Top = 1)
	WinSetOnTop($__GEng_hGui,'',$Top)
EndFunc

Func FCharSetOnTop()
	Local $Text
	$Text = TrayItemGetText($TrayOnTop)
	If $Text == 'Set On-Top' Then
		FCharOnTop(1)
		TrayItemSetText($TrayOnTop,"Not On-Top")
	Else
		FCharOnTop(0)
		TrayItemSetText($TrayOnTop,"Set On-Top")
	EndIf
EndFunc

Func FCharReborn()
	$CharOnGround = False
	$CharRight = True
	$CharLeft = False
	_GEng_Sprite_AnimRewind($mm1obj,1)
	_GEng_Sprite_Animate($mm1obj, $mm1showup)
	WinMove($__GEng_hGui,'',$CharBornPos[0],$CharBornPos[1])
EndFunc

Func FAutoHelp()
	Local $Text
	$Text&= " Free tool"&@CRLF
	$Text&= " __________________"&@CRLF
	$Text&= " Hotkey"&@CRLF
	$Text&= " Shift+Esc: Exit"&@CRLF
	$Text&= " __________________"&@CRLF
	$Text&= "Author: LeeSai - HocAutoIT.com"&@CRLF
	$Text&= "Email: tranminhduc18116@yahoo.com"&@CRLF
	$Text&= "Year: Dec 20 2012"&@CRLF


	TrayTip ($AutoName&" v"&$AutoVersion, $Text,30,1)
EndFunc

