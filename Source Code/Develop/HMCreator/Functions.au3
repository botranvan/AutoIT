#include-once

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FSaveLog(" == FAutoStart ===============================")
	FSettingLoad()
	MainGUIFix()
	FAccLoad()
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

Func FAccCreating()
	Local $Line,$FaultUpdate,$File,$Acc,$CreateDone

	If Not $Start Then Return

	FHotMailOpen()
	Sleep(1000)
	$Acc = FAccCreate()
	$CreateDone = FHotMailFixCaptcha()

	If $CreateDone Then
;~ 		MsgBox(0,'','Done')
		LCountSet($AccCount)
		$Acc[3]&="@hotmail.com"
		$Line = _ArrayToString($Acc,@TAB)
		FSaveLog("Status: Done")
		$File = FileOpen($FileAccount,1+8+128)
		FileWriteLine($File,$Line)
		FileClose($File)

		_IELinkClickByText($oIE,'sign out')
		_IELinkClickByText($oIE,'Sign out and sign in with a different account.')
		Sleep(5000)
	Else
;~ 		MsgBox(0,'','Flase')
		$AccCount-=1
	EndIf

	_IEQuit($oIE)

	Sleep(1000)
EndFunc


Func FHotMailFixCaptcha()
	Local $Text,$Check
	$Check = 0

	Do
;~ 		ToolTip("Wait "&@msec,0,0)
		If WinExists("Sign up - Microsoft account - Windows Internet Explorer") Then ContinueLoop
		ExitLoop
	Until 0

	Do
;~ 		ToolTip("Reading "&@msec,0,0)
		Sleep(5000)
		$Check+=1
		If $Check>5 Then Return False

		_IELoadWait($oIE,1000,2000)

		$Text = _IEBodyReadText($oIE)
		If StringInStr($Text,'Already have a Microsoft account') Then ContinueLoop
		If StringInStr($Text,'You have 1 unread message') Then ExitLoop
		If StringInStr($Text,"You're already signed in") Then ExitLoop

		If StringInStr($Text,"You've reached the daily limit for creating Microsoft accounts") Then
			_IEQuit($oIE)
			MsgBox(0,'Error','Need change VPN account')
			Return False
		EndIf

	Until 0

	Return True
EndFunc

Func FHotMailOpen()
	Local $URL

	$URL = 'https://signup.live.com/signup.aspx?lic=1'
	$URL = 'https://signup.live.com/signup.aspx?wa=wsignin1.0&rpsnv=11&ct=1357150555&rver=6.1.6206.0&wp=MBI&wreply=http%3a%2f%2fmail.live.com%2fdefault.aspx&id=64855&cbcxt=mai&snsc=1&bk=1357150557&uiflavor=web&mkt=EN-US&lc=1033&lic=1'
	$oIE = _IECreate($URL,1)

EndFunc

;~ Tạo account
Func FAccCreate()
	Local $Input,$Acc[13]

	$AccCount+=1
	$Acc[0] = $AccCount
	$Acc[1] = $FirstName[Random(1,$FirstName[0],1)]
	$Acc[2] = $LastName[Random(1,$LastName[0],1)]
	$Acc[3] = $Mail[Random(1,$Mail[0],1)]
	$Acc[4] = Random(1,28,1)							;Birth-Day
	$Acc[5] = Random(1,12,1)							;Birth-Month
	$Acc[6] = Random(@YEAR-40,@YEAR-21,1)				;Birth-Year
	$Acc[7] = $Gender[Random(1,$Gender[0],1)]			;Gender
	$Acc[8] = FRandomText()								;Password
	$Acc[9] = 'KR'										;Country
	$Acc[10] = ''										;Phone
	$Acc[11] = 'alsk4040'								;answer

	If $AlterMail[0] == 1 Then
		$Acc[12] = $AlterMail[1]
	Else
		$Acc[12] = $AlterMail[Random(0,$AlterMail[0],1)]	;AltEmail
	EndIf

	LDoneSet($Acc[3])

	$Input = _IEGetObjById($oIE,'iFirstName')
	_IEFormElementSetValue($Input,$Acc[1])

	$Input = _IEGetObjById($oIE,'iLastName')
	_IEFormElementSetValue($Input,$Acc[2])

	$Input = _IEGetObjById($oIE,'iBirthDay')
	_IEFormElementOptionSelect($Input, $Acc[4])

	$Input = _IEGetObjById($oIE,'iBirthMonth')
	_IEFormElementOptionSelect($Input, $Acc[5])

	$Input = _IEGetObjById($oIE,'iBirthYear')
	_IEFormElementOptionSelect($Input, $Acc[6])

	$Input = _IEGetObjById($oIE,'iGender')
	_IEFormElementOptionSelect($Input, $Acc[7])

	$Input = _IEGetObjById($oIE,'imembernamelive')
	_IEFormElementSetValue($Input,$Acc[3])

	$Input = _IEGetObjById($oIE,'idomain')
	_IEFormElementOptionSelect($Input, 'hotmail.com')

	$Input = _IEGetObjById($oIE,'iPwd')
	_IEFormElementSetValue($Input,$Acc[8])

	$Input = _IEGetObjById($oIE,'iRetypePwd')
	_IEFormElementSetValue($Input,$Acc[8])

	$Input = _IEGetObjById($oIE,'iCountry')
	_IEFormElementOptionSelect($Input, $Acc[9])

	$Input = _IEGetObjById($oIE,'iSMSCountry')
	_IEFormElementOptionSelect($Input, $Acc[9])

	$Input = _IEGetObjById($oIE,'iPhone')
	_IEFormElementSetValue($Input, $Acc[10])

	_IELinkClickByText($oIE,'Or choose a security question')

	$Input = _IEGetObjById($oIE,'iSQ')
	_IEFormElementOptionSelect($Input,1,1,'byIndex')

	$Input = _IEGetObjById($oIE,'iSA')
	_IEFormElementSetValue($Input, $Acc[11])

	$Input = _IEGetObjById($oIE,'iAltEmail')
	_IEFormElementSetValue($Input, $Acc[12])



	ControlSend("[CLASS:IEFrame;]",'','','{END}')

	Return $Acc
EndFunc

;~ Tắt tất cả Popup
Func FPopupClose()
	FSaveLog('FPopupClose')
	Local $ie,$Popup1
	$Popup1 = 'http://www.melon.com/cds/sub/web/info_melonNotice.htm'

;~ 	$ie = _IECreate($Popup1,1)
;~ 	_IEQuit($ie)
EndFunc

Func FAccLoad()
	Local $File,$Data

	$File = FileOpen("firstname.txt")
	$Data = FileRead($File)
	Global $FirstName = StringSplit($Data,@CRLF,1)


	$File = FileOpen("lastname.txt")
	$Data = FileRead($File)
	Global $LastName = StringSplit($Data,@CRLF,1)


	$File = FileOpen("mail.txt")
	$Data = FileRead($File)
	Global $Mail = StringSplit($Data,@CRLF,1)


	$File = FileOpen("altermail.txt")
	$Data = FileRead($File)
	Global $AlterMail = StringSplit($Data,@CRLF,1)
	If $AlterMail[0]>1 And $AlterMail[2]=='' Then
		ReDim $AlterMail[2]
		$AlterMail[0] = 1
	EndIf

	Global $Gender[3] = [2,'m','f']
EndFunc

Func FRandomText($Len = 9)
	Local $Text

	For $i=1 To $Len
		$Text&=  Chr(Random(48,122,1))
	Next

	Return $Text
EndFunc