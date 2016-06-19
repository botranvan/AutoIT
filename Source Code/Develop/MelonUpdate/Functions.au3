#include-once

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FSaveLog(" == FAutoStart ===============================")
	FSettingLoad()
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
	ConsoleWrite($Data&@CRLF)
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

Func FAccUpdating()
	Local $Line,$FaultUpdate,$File,$Acc

	If Not $Start Then Return

	$DoneNumber+=1
	$Line = FileReadLine($FAcc,$DoneNumber)
	If @error = -1 Then
		$Start = 1
		BStartClick()
		MsgBox(0,$AutoName,'All done')
		Return
	EndIf

	$Acc = _StringBetween($Line,'[',']')

	LDoneSet($Acc[0])
	LDoneSave()

	FAccLogin($Acc)
	Sleep(2000)
	$UpdateDone	= FAccUpdate($Acc)
	Sleep(2000)
	FAccLogout()
	Sleep(2000)


	If $UpdateDone Then
		FSaveLog("Status: Done")
		$File = FileOpen($FileAccDone,1+8+128 )
		FileWriteLine($File,$Line)
	Else
		FSaveLog("Status: error")
		$File = FileOpen($FileAccWron,1+8+128 )
		FileWriteLine($File,$Line)
	EndIf

	FileClose($File)
	FPopupClose()
	Sleep(1000)
EndFunc

;~ Đăng nhập
Func FAccLogin($Acc)
	FSaveLog('FAccLogin')
	$oIE = _IECreate($URL,1)

	$UserName = _IEGetObjById($oIE,'memberId')
	_IEFormElementSetValue($UserName, $Acc[0])

	$UserPass = _IEGetObjById($oIE,'memberPwd')
	_IEFormElementSetValue($UserPass, $Acc[1])

	_IEFormImageClick($oIE, "http://image.melon.com/resource/image/cds/common/web/button/login2.gif")

	Return $oIE
EndFunc

;~ Thoát
Func FAccLogout()
	FSaveLog('FAccLogout')
	Local $oLinks,$index
	$oLinks= _IELinkGetCollection($oIE)
	$index = 0;
	For $oLink In $oLinks
		If($oLink.href == 'javascript:logout();') Then
			_IELinkClickByIndex($oIE, $index)
			Return
		EndIf
		$index+=1
	Next
;~ 	_IEFormImageClick($oIE, "http://image.melon.com/resource/image/cds/common/web/button/logout2.gif")
EndFunc

;~ Tắt tất cả Popup
Func FPopupClose()
	FSaveLog('FPopupClose')
	Local $ie,$Popup1
	$Popup1 = 'http://www.melon.com/cds/sub/web/info_melonNotice.htm'

	$ie = _IECreate($Popup1,1)
	_IEQuit($ie)
EndFunc

;~ Cập nhật lại số CMND
Func FAccUpdate($Acc)
	FSaveLog('FAccUpdate:'&$Acc[0])
	Local $oLinks,$index,$Popup1,$Popup2,$ie

;~ 	Click vào Menu mở trang cập nhật
	$oLinks= _IELinkGetCollection($oIE)
	$index = 0;
	For $oLink In $oLinks
		If($oLink.href == 'http://www.melon.com/commerce/cybermoney/web/charge_melonCashView.htm?MAIN=SKY') Then
			_IELinkClickByIndex($oIE, $index,1)
			ExitLoop
		EndIf
		$index+=1
	Next

	Sleep(2000)


;~ 	Click vào link ảnh mở trang nhập CMND
	$Popup1 = 'https://www.melon.com/muid/popup/web/realnamepopup_inform.htm?viewType=charge'
	$ie = _IEAttach($Popup1,'URL')
	If @Error Then Return True

	$oLinks= _IELinkGetCollection($ie)

	$index = 0;
	For $oLink In $oLinks
		If($oLink.href == "javascript:niceAuthentication('1');") Then
			_IELinkClickByIndex($ie,$index)
			ExitLoop
		EndIf
		$index+=1
	Next

	Sleep(2000)

;~ 	Nhập thông tin
	FSaveLog('Popup2')
	$Popup2 = "https://cert.namecheck.co.kr/certnc_input.asp"
	$ie = _IEAttach($Popup2,'URL')
	If @Error Then Return False

	$IName = _IEGetObjByName($ie,'name')
	$juminid1 = _IEGetObjByName($ie,'juminid1')
	$juminid2 = _IEGetObjByName($ie,'juminid2')

	_IEFormElementSetValue($IName, $Acc[2])
	_IEFormElementSetValue($juminid1, $Acc[3])
	_IEFormElementSetValue($juminid2, $Acc[4])

	Sleep(2000)
	FSaveLog('_IEGetObjByName:form1')
	$form1 = _IEFormGetObjByName($ie,'form1')
	FSaveLog('error:'&@Error)
	FSaveLog('_IEFormSubmit')
;~ 	_IEFormSubmit($form1)
	_IEImgClick($form1, 'images/btn_ok_k.gif')

;~ 	Exit
	Sleep(2000)

;~ https://cert.namecheck.co.kr/certnc_fail.asp
;~ (Name and(or) foreign registration number incorrect.)

;~ 	Tắt popup
	FSaveLog("Popup3")
	$Popup3 = "http://www.melon.com/muid/popup/web/realnamepopup_blank.htm"
	$ie = _IEAttach($Popup3,'URL')
	If @Error Then Return False
	$oLinks= _IELinkGetCollection($ie)
	FSaveLog('Popup3-1')
	$index = 0;
	For $oLink In $oLinks
		FSaveLog('Popup3-1-'&$index)
		If($oLink.href == "javascript:window.close();") Then
			_IELinkClickByIndex($ie,$index)
			ExitLoop
		EndIf
		$index+=1
	Next

	FSaveLog("Return")
	Return True
EndFunc

