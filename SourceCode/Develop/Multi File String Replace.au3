#NoTrayIcon

Func _FILECOUNTLINES($SFILEPATH)
	Local $N = FileGetSize($SFILEPATH) - 1
	If @error Or $N = -1 Then Return 0
	Return StringLen(StringAddCR(FileRead($SFILEPATH, $N))) - $N + 1
EndFunc


Func _FILECREATE($SFILEPATH)
	Local $HOPENFILE
	Local $HWRITEFILE
	$HOPENFILE = FileOpen($SFILEPATH, 2)
	If $HOPENFILE = -1 Then
		SetError(1)
		Return 0
	EndIf
	$HWRITEFILE = FileWrite($HOPENFILE, "")
	If $HWRITEFILE = -1 Then
		SetError(2)
		Return 0
	EndIf
	FileClose($HOPENFILE)
	Return 1
EndFunc


Func _FILELISTTOARRAY($SPATH, $SFILTER = "*", $IFLAG = 0)
	Local $HSEARCH, $SFILE, $ASFILELIST[1]
	If Not FileExists($SPATH) Then Return SetError(1, 1, "")
	If (StringInStr($SFILTER, "\")) Or (StringInStr($SFILTER, "/")) Or (StringInStr($SFILTER, ":")) Or (StringInStr($SFILTER, ">")) Or (StringInStr($SFILTER, "<")) Or (StringInStr($SFILTER, "|")) Or (StringStripWS($SFILTER, 8) = "") Then Return SetError(2, 2, "")
	If Not ($IFLAG = 0 Or $IFLAG = 1 Or $IFLAG = 2) Then Return SetError(3, 3, "")
	$HSEARCH = FileFindFirstFile($SPATH & "\" & $SFILTER)
	If $HSEARCH = -1 Then Return SetError(4, 4, "")
	While 1
		$SFILE = FileFindNextFile($HSEARCH)
		If @error Then
			SetError(0)
			ExitLoop
		EndIf
		If $IFLAG = 1 And StringInStr(FileGetAttrib($SPATH & "\" & $SFILE), "D") <> 0 Then ContinueLoop
		If $IFLAG = 2 And StringInStr(FileGetAttrib($SPATH & "\" & $SFILE), "D") = 0 Then ContinueLoop
		ReDim $ASFILELIST[UBound($ASFILELIST) + 1]
		$ASFILELIST[0] = $ASFILELIST[0] + 1
		$ASFILELIST[UBound($ASFILELIST) - 1] = $SFILE
	WEnd
	FileClose($HSEARCH)
	Return $ASFILELIST
EndFunc


Func _FILEPRINT($S_FILE, $I_SHOW = @SW_HIDE)
	Local $A_RET = DllCall("shell32.dll", "long", "ShellExecute", "hwnd", 0, "string", "print", "string", $S_FILE, "string", "", "string", "", "int", $I_SHOW)
	If $A_RET[0] > 32 And Not @error Then
		Return 1
	Else
		SetError($A_RET[0])
		Return 0
	EndIf
EndFunc


Func _FILEREADTOARRAY($SFILEPATH, ByRef $AARRAY)
	Local $HFILE
	$HFILE = FileOpen($SFILEPATH, 0)
	If $HFILE = -1 Then
		SetError(1)
		Return 0
	EndIf
	$AARRAY = StringSplit(StringStripCR(FileRead($HFILE, FileGetSize($SFILEPATH))), @LF)
	FileClose($HFILE)
	Return 1
EndFunc


Func _FILEWRITEFROMARRAY($FILE, $A_ARRAY, $I_BASE = 0, $I_UBOUND = 0)
	If Not IsArray($A_ARRAY) Then Return SetError(2, 0, 0)
	Local $LAST = UBound($A_ARRAY) - 1
	If $I_UBOUND < 1 Or $I_UBOUND > $LAST Then $I_UBOUND = $LAST
	If $I_BASE < 0 Or $I_BASE > $LAST Then $I_BASE = 0
	Local $HFILE
	If IsString($FILE) Then
		$HFILE = FileOpen($FILE, 2)
	Else
		$HFILE = $FILE
	EndIf
	If $HFILE = -1 Then Return SetError(1, 0, 0)
	Local $ERRORSAV = 0
	For $X = $I_BASE To $I_UBOUND
		If FileWrite($HFILE, @CRLF & $A_ARRAY[$X]) = 0 Then
			$ERRORSAV = 3
			ExitLoop
		EndIf
	Next
	If IsString($FILE) Then FileClose($HFILE)
	If $ERRORSAV Then
		Return SetError($ERRORSAV, 0, 0)
	Else
		Return 1
	EndIf
EndFunc


Func _FILEWRITELOG($SLOGPATH, $SLOGMSG)
	Local $SDATENOW
	Local $STIMENOW
	Local $SMSG
	Local $HOPENFILE
	Local $HWRITEFILE
	$SDATENOW = @YEAR & "-" & @MON & "-" & @MDAY
	$STIMENOW = @HOUR & ":" & @MIN & ":" & @SEC
	$SMSG = $SDATENOW & " " & $STIMENOW & " : " & $SLOGMSG
	$HOPENFILE = FileOpen($SLOGPATH, 1)
	If $HOPENFILE = -1 Then
		SetError(1)
		Return 0
	EndIf
	$HWRITEFILE = FileWriteLine($HOPENFILE, $SMSG)
	If $HWRITEFILE = -1 Then
		SetError(2)
		Return 0
	EndIf
	FileClose($HOPENFILE)
	Return 1
EndFunc


Func _FILEWRITETOLINE($SFILE, $ILINE, $STEXT, $FOVERWRITE = 0)
	If $ILINE <= 0 Then
		SetError(4)
		Return 0
	EndIf
	If Not IsString($STEXT) Then
		SetError(6)
		Return 0
	EndIf
	If $FOVERWRITE <> 0 And $FOVERWRITE <> 1 Then
		SetError(5)
		Return 0
	EndIf
	If Not FileExists($SFILE) Then
		SetError(2)
		Return 0
	EndIf
	Local $FILTXT = FileRead($SFILE, FileGetSize($SFILE))
	$FILTXT = StringSplit($FILTXT, @CRLF, 1)
	If UBound($FILTXT, 1) < $ILINE Then
		SetError(1)
		Return 0
	EndIf
	Local $FIL = FileOpen($SFILE, 2)
	If $FIL = -1 Then
		SetError(3)
		Return 0
	EndIf
	For $I = 1 To UBound($FILTXT) - 1
		If $I = $ILINE Then
			If $FOVERWRITE = 1 Then
				If $STEXT <> "" Then
					FileWrite($FIL, $STEXT & @CRLF)
				Else
					FileWrite($FIL, $STEXT)
				EndIf
			EndIf
			If $FOVERWRITE = 0 Then
				FileWrite($FIL, $STEXT & @CRLF)
				FileWrite($FIL, $FILTXT[$I] & @CRLF)
			EndIf
		ElseIf $I < UBound($FILTXT, 1) - 1 Then
			FileWrite($FIL, $FILTXT[$I] & @CRLF)
		ElseIf $I = UBound($FILTXT, 1) - 1 Then
			FileWrite($FIL, $FILTXT[$I])
		EndIf
	Next
	FileClose($FIL)
	Return 1
EndFunc


Func _PATHFULL($SRELATIVEPATH, $SBASEPATH = @WorkingDir)
	If Not $SRELATIVEPATH Or $SRELATIVEPATH = "." Then Return $SBASEPATH
	Local $SFULLPATH = StringReplace($SRELATIVEPATH, "/", "\")
	Local $SPATH
	Local $BROOTONLY = False
	StringReplace($SFULLPATH, "\", "")
	If @extended = StringLen($SFULLPATH) Then $BROOTONLY = True
	For $I = 1 To 2
		$SPATH = StringLeft($SFULLPATH, 2)
		If $SPATH = "\\" Then
			$SFULLPATH = StringTrimLeft($SFULLPATH, 2)
			$SPATH &= StringLeft($SFULLPATH, StringInStr($SFULLPATH, "\") - 1)
			ExitLoop
		ElseIf StringRight($SPATH, 1) = ":" Then
			$SFULLPATH = StringTrimLeft($SFULLPATH, 2)
			ExitLoop
		Else
			$SFULLPATH = $SBASEPATH & "\" & $SFULLPATH
		EndIf
	Next
	If $I = 3 Then Return ""
	Local $ATEMP = StringSplit($SFULLPATH, "\")
	Local $APATHPARTS[$ATEMP[0]], $J = 0
	For $I = 2 To $ATEMP[0]
		If $ATEMP[$I] = ".." Then
			If $J Then $J -= 1
		ElseIf Not ($ATEMP[$I] = "" And $I <> $ATEMP[0]) And $ATEMP[$I] <> "." Then
			$APATHPARTS[$J] = $ATEMP[$I]
			$J += 1
		EndIf
	Next
	$SFULLPATH = $SPATH
	If Not $BROOTONLY Then
		For $I = 0 To $J - 1
			$SFULLPATH &= "\" & $APATHPARTS[$I]
		Next
	Else
		$SFULLPATH &= "\"
	EndIf
	While StringInStr($SFULLPATH, ".\")
		$SFULLPATH = StringReplace($SFULLPATH, ".\", "\")
	WEnd
	Return $SFULLPATH
EndFunc


Func _PATHMAKE($SZDRIVE, $SZDIR, $SZFNAME, $SZEXT)
	Local $SZFULLPATH
	If StringLen($SZDRIVE) Then
		If Not (StringLeft($SZDRIVE, 2) = "\\") Then $SZDRIVE = StringLeft($SZDRIVE, 1) & ":"
	EndIf
	If StringLen($SZDIR) Then
		If Not (StringRight($SZDIR, 1) = "\") And Not (StringRight($SZDIR, 1) = "/") Then $SZDIR = $SZDIR & "\"
	EndIf
	If StringLen($SZEXT) Then
		If Not (StringLeft($SZEXT, 1) = ".") Then $SZEXT = "." & $SZEXT
	EndIf
	$SZFULLPATH = $SZDRIVE & $SZDIR & $SZFNAME & $SZEXT
	Return $SZFULLPATH
EndFunc


Func _PATHSPLIT($SZPATH, ByRef $SZDRIVE, ByRef $SZDIR, ByRef $SZFNAME, ByRef $SZEXT)
	Local $DRIVE = ""
	Local $DIR = ""
	Local $FNAME = ""
	Local $EXT = ""
	Local $POS
	Local $ARRAY[5]
	$ARRAY[0] = $SZPATH
	If StringMid($SZPATH, 2, 1) = ":" Then
		$DRIVE = StringLeft($SZPATH, 2)
		$SZPATH = StringTrimLeft($SZPATH, 2)
	ElseIf StringLeft($SZPATH, 2) = "\\" Then
		$SZPATH = StringTrimLeft($SZPATH, 2)
		$POS = StringInStr($SZPATH, "\")
		If $POS = 0 Then $POS = StringInStr($SZPATH, "/")
		If $POS = 0 Then
			$DRIVE = "\\" & $SZPATH
			$SZPATH = ""
		Else
			$DRIVE = "\\" & StringLeft($SZPATH, $POS - 1)
			$SZPATH = StringTrimLeft($SZPATH, $POS - 1)
		EndIf
	EndIf
	Local $NPOSFORWARD = StringInStr($SZPATH, "/", 0, -1)
	Local $NPOSBACKWARD = StringInStr($SZPATH, "\", 0, -1)
	If $NPOSFORWARD >= $NPOSBACKWARD Then
		$POS = $NPOSFORWARD
	Else
		$POS = $NPOSBACKWARD
	EndIf
	$DIR = StringLeft($SZPATH, $POS)
	$FNAME = StringRight($SZPATH, StringLen($SZPATH) - $POS)
	If StringLen($DIR) = 0 Then $FNAME = $SZPATH
	$POS = StringInStr($FNAME, ".", 0, -1)
	If $POS Then
		$EXT = StringRight($FNAME, StringLen($FNAME) - ($POS - 1))
		$FNAME = StringLeft($FNAME, $POS - 1)
	EndIf
	$SZDRIVE = $DRIVE
	$SZDIR = $DIR
	$SZFNAME = $FNAME
	$SZEXT = $EXT
	$ARRAY[1] = $DRIVE
	$ARRAY[2] = $DIR
	$ARRAY[3] = $FNAME
	$ARRAY[4] = $EXT
	Return $ARRAY
EndFunc


Func _REPLACESTRINGINFILE($SZFILENAME, $SZSEARCHSTRING, $SZREPLACESTRING, $FCASENESS = 0, $FOCCURANCE = 1)
	Local $IRETVAL = 0
	Local $HWRITEHANDLE, $AFILELINES, $NCOUNT, $SENDSWITH, $HFILE
	If StringInStr(FileGetAttrib($SZFILENAME), "R") Then
		SetError(6)
		Return -1
	EndIf
	$HFILE = FileOpen($SZFILENAME, 0)
	If $HFILE = -1 Then
		SetError(1)
		Return -1
	EndIf
	Local $S_TOTFILE = FileRead($HFILE, FileGetSize($SZFILENAME))
	If StringRight($S_TOTFILE, 2) = @CRLF Then
		$SENDSWITH = @CRLF
	ElseIf StringRight($S_TOTFILE, 1) = @CR Then
		$SENDSWITH = @CR
	ElseIf StringRight($S_TOTFILE, 1) = @LF Then
		$SENDSWITH = @LF
	Else
		$SENDSWITH = ""
	EndIf
	$AFILELINES = StringSplit(StringStripCR($S_TOTFILE), @LF)
	FileClose($HFILE)
	$HWRITEHANDLE = FileOpen($SZFILENAME, 2)
	If $HWRITEHANDLE = -1 Then
		SetError(2)
		Return -1
	EndIf
	For $NCOUNT = 1 To $AFILELINES[0]
		If StringInStr($AFILELINES[$NCOUNT], $SZSEARCHSTRING, $FCASENESS) Then
			$AFILELINES[$NCOUNT] = StringReplace($AFILELINES[$NCOUNT], $SZSEARCHSTRING, $SZREPLACESTRING, 1 - $FOCCURANCE, $FCASENESS)
			$IRETVAL = $IRETVAL + 1
			If $FOCCURANCE = 0 Then
				$IRETVAL = 1
				ExitLoop
			EndIf
		EndIf
	Next
	For $NCOUNT = 1 To $AFILELINES[0] - 1
		If FileWriteLine($HWRITEHANDLE, $AFILELINES[$NCOUNT]) = 0 Then
			SetError(3)
			FileClose($HWRITEHANDLE)
			Return -1
		EndIf
	Next
	If $AFILELINES[$NCOUNT] <> "" Then FileWrite($HWRITEHANDLE, $AFILELINES[$NCOUNT] & $SENDSWITH)
	FileClose($HWRITEHANDLE)
	Return $IRETVAL
EndFunc


Func _TEMPFILE($S_DIRECTORYNAME = @TempDir, $S_FILEPREFIX = "~", $S_FILEEXTENSION = ".tmp", $I_RANDOMLENGTH = 7)
	Local $S_TEMPNAME
	If Not FileExists($S_DIRECTORYNAME) Then $S_DIRECTORYNAME = @TempDir
	If Not FileExists($S_DIRECTORYNAME) Then $S_DIRECTORYNAME = @ScriptDir
	If StringRight($S_DIRECTORYNAME, 1) <> "\" Then $S_DIRECTORYNAME = $S_DIRECTORYNAME & "\"
	Do
		$S_TEMPNAME = ""
		While StringLen($S_TEMPNAME) < $I_RANDOMLENGTH
			$S_TEMPNAME = $S_TEMPNAME & Chr(Random(97, 122, 1))
		WEnd
		$S_TEMPNAME = $S_DIRECTORYNAME & $S_FILEPREFIX & $S_TEMPNAME & $S_FILEEXTENSION
	Until Not FileExists($S_TEMPNAME)
	Return ($S_TEMPNAME)
EndFunc

GUICreate("Multi File Replace", 500, 500)
GUICtrlCreateLabel("find in files", 0, 5, 100, 15)
$ABOUT = GUICtrlCreateButton("About", 460, 0, 40, 20)
$IFIND = GUICtrlCreateInput("", 0, 20, 500, 20)
GUICtrlCreateLabel("replace with", 0, 45, 100, 15)
$CHECK = GUICtrlCreateCheckbox("Case Sensetive", 400, 40, 90, 20)
$IREP = GUICtrlCreateInput("", 0, 60, 500, 20)
$LIST = GUICtrlCreateEdit("", 0, 90, 500, 360)
$ADD = GUICtrlCreateButton("^^^      Add File(s)      ^^^", 0, 450, 500, 20)
$REP = GUICtrlCreateButton("REPLACE ALL", 0, 480, 500, 20)
GUISetState()
While 1
	$M = GUIGetMsg()
	If $M = -3 Then Exit
	If $M = $ADD Then ADD()
	If $M = $REP Then REPLACE()
	If $M = $ABOUT Then ABOUT()
WEnd

Func ABOUT()
	MsgBox(0, "About: Multi File Replace", "This software will replace text strings in large amounts of files." & @CRLF & "This is a simplified form of the software that is hard to find for free on the internet." & @CRLF & "Fed up with having to replace data manually, I have created my own and released it for free." & @CRLF & @CRLF & "Created by: Sean Buckley" & @CRLF & "Email: Sean.Bck@gmail.com")
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
EndFunc


Func ADD()
	$OPENDATA = FileOpenDialog("Open File(s)", "", "(*.*)", 4)
	If Not @error Then
		If StringInStr($OPENDATA, "|") Then
			$POS = StringInStr($OPENDATA, "|")
			$DIR = StringLeft($OPENDATA, $POS - 1) & "/"
			$FILES = StringRight($OPENDATA, StringLen($OPENDATA) - $POS + 1)
			$FINAL = StringReplace($FILES, "|", @CRLF & $DIR)
			GUICtrlSetData($LIST, GUICtrlRead($LIST) & $FINAL)
		Else
			GUICtrlSetData($LIST, GUICtrlRead($LIST) & @CRLF & $OPENDATA)
		EndIf
	EndIf
EndFunc


Func REPLACE()
	$DATA = StringSplit(GUICtrlRead($LIST), @CRLF)
	$FINDDATA = GUICtrlRead($IFIND)
	$REPDATA = GUICtrlRead($IREP)
	If GUICtrlRead($CHECK) = 1 Then
		$CASEVAR = 1
	Else
		$CASEVAR = 0
	EndIf
	ProgressOn("Replacement", "Percent done")
	For $COUNT = 1 To $DATA[0]
		If Not $DATA[$COUNT] = "" Then _REPLACESTRINGINFILE($DATA[$COUNT], $FINDDATA, $REPDATA, $CASEVAR)
		$PROG = $COUNT / $DATA[0] * 100
		ProgressSet($PROG, StringLeft($PROG, 5) & "%")
	Next
	ProgressOff()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
	GUIGetMsg()
EndFunc