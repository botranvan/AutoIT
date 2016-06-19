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

Func FKeywordCheck()
	LNoticeSet('Checking...')
	BCheckSetState($GUI_DISABLE)

	FKeywordSiteScan()
	FKeywordShowResult()

	LNoticeSet('Check done!!!')
	BCheckSetState($GUI_ENABLE)
EndFunc

Func FKeywordShowResult()
	Local $ShowSpeed = 500
	Local $Keyword = IKeywordGet()
	Local $Website = IWebsiteGet()
	Local $Path = $KeywordFolder&"\"&$Website&"\"&$Keyword&"\"
	Local $Today = @YEAR&'-'&@MON&'-'&@MDAY
	Local $search,$file,$Data, $FilePath,$FileRead,$Domain,$CountLine,$FileDate,$SiteFound
	Local $Input

	LNoticeSet('Show result...')
	EResultSet()

	$search = FileFindFirstFile($Path&"*.txt")

	While 1
		$file = FileFindNextFile($search)
		If @error Then ExitLoop

		$FileDate = StringReplace($file,'.txt','')
		EResultAddLine(" ================================ ")
		EResultAddLine(" == Date: "&$FileDate&" == ")

		$FilePath = $Path&$file

		$SiteFound = False
		$CountLine = 0
		$Data = ""
		$FileRead = FileOpen($FilePath)
		While 1
			$CountLine+=1
			$Domain = FileReadLine($FileRead)
			If @error = -1 Then ExitLoop
			$Data&= $CountLine&" - "&$Domain&@CRLF

			If StringInStr($Domain,$Website) Then
				EResultAddLine($Data)
				$SiteFound = True
				ExitLoop
			EndIf
		WEnd

		FileClose($FileRead)
		Sleep($ShowSpeed)

		If $Today == $FileDate And Not $SiteFound Then EResultAddLine($Data)

		If $SiteFound Then
			EResultAddLine(" "&$FileDate&" site rank: "&$CountLine)
		Else
			EResultAddLine(" "&$FileDate&" site can't found")
		EndIf
		EResultAddLine(" ")
	WEnd

	EResultAddLine(" End ")

	If Not $SiteFound And $Today == $FileDate Then
		$Input = MsgBox (4,$AutoName,'Hôm nay website vẫn chưa hiện.'&@CRLF&'Bạn có muốn tìm lại không?')
		If $Input == 6 Then
			LNoticeSet('Re-checking...')
			FKeywordSiteScan(True)
			FKeywordShowResult()
		EndIf
	EndIf
EndFunc

Func FKeywordSiteScan($NewScan = False)
	Local $URL = "https://www.google.com/search?q="
	Local $Keyword = IKeywordGet()
	Local $Website = IWebsiteGet()
	Local $Today = @YEAR&'-'&@MON&'-'&@MDAY
	Local $FilePath,$File,$SiteFound,$Link

	$FilePath = $KeywordFolder&"\"&$Website&"\"&$Keyword&"\"&$Today&".txt"
	If FileExists($FilePath) And Not $NewScan Then Return

	$File = FileOpen($FilePath,2+8+128)

	$URL&= urlencode($Keyword)

	$Website = StringLower($Website)
	$SiteFound = False
	$start = 0
	$oIE = _IECreate($URL&"&start="&$start,1,0)
	Do
		$res = _IEGetObjById($oIE, 'res')
		$html = _IEBodyReadHTML($res)
		$LinkList = _StringBetween($html,'<h3','</h3>')

		For $Link In $LinkList
			$Link = _StringBetween($Link,'href="','">')
			FileWriteLine($File,$Link[0])
			If StringInStr($Link[0],$Website) Then $SiteFound = True
		Next

		If $SiteFound Then ExitLoop
		If $start==90 Then ExitLoop
		$start+=10
		_IENavigate($oIE,$URL&"&start="&$start)
		LNoticeSet('Checking... '&$start)
	Until False

	FileClose($File)
	_IEQuit($oIE)

EndFunc



Func urlencode($str, $plus = True)
    Local $i, $return, $tmp, $exp
    $return = ""
    $exp = "[a-zA-Z0-9-._~]"
    If $plus Then
        $str = StringReplace ($str, " ", "+")
        $exp = "[a-zA-Z0-9-._~+]"
    EndIf
    For $i = 1 To StringLen($str)
        $tmp = StringMid($str, $i, 1)
        If StringRegExp($tmp, $exp, 0) = 1 Then
            $return &= $tmp
        Else
            $return &= StringMid(StringRegExpReplace(StringToBinary($tmp, 4), "([0-9A-Fa-f]{2})", "%$1"), 3)
        EndIf
    Next
    Return $return
EndFunc

Func urldecode($str)
    Local $i, $return, $tmp
    $return = ""
    $str = StringReplace ($str, "+", " ")
    For $i = 1 To StringLen($str)
        $tmp = StringMid($str, $i, 3)
        If StringRegExp($tmp, "%[0-9A-Fa-f]{2}", 0) = 1 Then
            $i += 2
            While StringRegExp(StringMid($str, $i+1, 3), "%[0-9A-Fa-f]{2}", 0) = 1
                $tmp = $tmp & StringMid($str, $i+2, 2)
                $i += 3
            Wend
            $return &= BinaryToString(StringRegExpReplace($tmp, "%([0-9A-Fa-f]*)", "0x$1"), 4)
        Else
            $return &= StringMid($str, $i, 1)
        EndIf
    Next
    Return $return
EndFunc