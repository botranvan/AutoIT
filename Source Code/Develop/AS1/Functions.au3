#include-once

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FSaveLog(" == FAutoStart ===============================")
	FSettingLoad()
	LNoticeSetSize(200)
;	LNoticeBackGround(0xFF0000)
	BStartSet("Start Setup")
	ELogSet("")

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

;~ Tự động cài đặt
Func FSetup()
	If Not $Start Then Return
	
	FFolderCreate()
	FFolderClone($CloneSource,$CloneDest,1)
	FSetupVisual()
	FSetupDotNet()
	
	If $Step == 300 Then
		$Start = 1
		BStartClick()
		FAutoEnd()
	EndIf

EndFunc
	
;~ Tạo thư mục gốc
Func FFolderCreate()
	If Not $Start Then Return
	If $Step <> 0 Then Return
;~ 	$Step=100
;~ 	Return
	
	If Not FileExists($CloneSource) Then 
		;FAddLog("Folder Create: "&$CloneSource)
		;DirCreate($CloneSource)
		MsgBox(0,$AutoName,"No have Dia3") 
		$Start = 1
		BStartClick()
		Return
	EndIf
	
	If Not FileExists($CloneDest) Then 
		FAddLog("Folder Create: "&$CloneDest)
		DirCreate($CloneDest)
	EndIf
	
	FAddLog("Clone: "&$CloneSource)
	$Step+=1
EndFunc	

;~ Copy cây thư mục
Func FFolderClone($source,$dest,$root = 0)
	If Not $Start Then Return
	If $Step <> 1 Then Return
		
	FAddLog("..."&StringRight($source,16))
	
	Local $File,$Search,$Current
	$Search = FileFindFirstFile($source&"*")
	If $Search = -1 Then Return 0

	While 1
		$File = FileFindNextFile($Search) 
		If @error Then ExitLoop
		$CurSource = $source&$File
		$CurDest = $dest&$File
		If FIsDir($CurSource) Then
			If Not FileExists($CurDest) Then 
				DirCreate($CurDest)
				FFolderClone($CurSource&"\",$CurDest&"\")
			EndIf
		Else
			If Not FileExists($CurDest) Then 
				MsgBox(0,$CurSource,$CurDest) 
				FAddLog("..."&StringRight($CurDest,16))
				FileCopy($CurSource,$CurDest,8)
			EndIf
		EndIf
	WEnd
	
	If $root Then 
		$Step = 100
	EndIf
	
	Return 1
EndFunc

;~ Kiểm tra xem có phải là folder không
Func FIsDir($Path)
	Local $Attributes = FileGetAttrib($Path)
	If StringInStr($Attributes,"D") Then Return 1
	Return 0
EndFunc

;~ Tự cài dotNet
Func FSetupDotNet()
	If Not $Start Then Return
	If $Step < 200 Or $Step >= 300 Then Return
	
	If Not FileExists($dotNet) Then		
		FAddLog("Can't find dotNet")
		$Step = 300
		Return 0
	EndIf	

	If $Step == 200 Then 
		Run($dotNet)
		FAddLog("dotNet: run")
		$Step+= 1
	EndIf

	If WinExists($dNTitle2,$dNText4) Then
		ControlClick($dNTitle2,$dNText4,2)
		Sleep(500) 
		ControlClick($dNTitle2,$dNText5,6)
		FAddLog("dotNet: already done")
		$Step = 300
		Return 0
	EndIf
	
	If $Step == 201 And WinExists($dNTitle1) Then
		FAddLog("dotNet: extracting")
	EndIf

	If $Step == 201 And WinExists($dNTitle2) Then
		FAddLog("dotNet: extract done")
		$Step+= 1
	EndIf
	
	If $Step == 202 Then
		ControlClick($dNTitle2,$dNText2,104)
		
		ControlClick($dNTitle2,$dNText2,12324)
		FAddLog("dotNet: installing")
		$Step+= 1
	EndIf

	If WinExists($dNTitle2,$dNText3) Then
		ControlClick($dNTitle2,$dNText3,12325)
		FAddLog("dotNet: done")
		$Step = 300
	EndIf
EndFunc

;~ Tự cài Visual
Func FSetupVisual()
	If Not $Start Then Return
	If $Step < 100 Or $Step >= 200 Then Return
		
	If Not FileExists($VisualFile) Then		
		FAddLog("Can't find Visual")
		$Step = 200
		Return 0
	EndIf	

	If $Step == 100 Then 
		Run($VisualFile)
		FAddLog("Visual: run")
		$Step+= 1
	EndIf

	If WinExists($VisualTitle2,$VisualText4) Then
		ControlClick($VisualTitle2,$VisualText4,2)
		Sleep(500) 
		ControlClick($VisualTitle2,$VisualText5,6)
		FAddLog("Visual: already done")
		$Step = 200
		Return 0
	EndIf
	
	If $Step == 101 And WinExists($VisualTitle1) Then
		FAddLog("Visual: extracting")
	EndIf

	If $Step == 101 And WinExists($VisualTitle2) Then
		FAddLog("Visual: extract done")
		$Step+= 1
	EndIf

	If $Step == 102 Then
		ControlClick($VisualTitle2,$VisualText2,104)
		ControlClick($VisualTitle2,$VisualText2,12324)
		FAddLog("Visual: installing")
		$Step+= 1
	EndIf

	If WinExists($VisualTitle2,$VisualText3) Then
		ControlClick($VisualTitle2,$VisualText3,12325)
		FAddLog("Visual: done")
		$Step = 200
	EndIf
 EndFunc
 
;~ Ghi vào log edit
Func FAddLog($Text)
	Local $Old = ELogGet()
	If $Text And $Text<>$LastLog Then 
		ELogSet($Old&""&$Text&@CRLF)
		ELogScrollEnd()
		$LastLog = $Text
	EndIf
EndFunc












