;~ Hiệu chỉnh lại GUI
Func MainGUIFix()
	WinMove($MainGUI,"",$AutoPos[0],$AutoPos[1])
	WinSetTitle($MainGUI,"",$AutoName&" v"&$AutoVersion&" | 72ls.NET")
	GUISetState(@SW_SHOW,$MainGUI)
	
	inKeySet("Vicki Zhao")
EndFunc

;~ Kiểm tra phiên bản mới của Auto
Func AutoCheckUpdate()
	ToolTip("Checking for updates...",0,0)
	
	Local $HTML = _INetGetSource($HomePage)
	Local $start = StringInStr($HTML,"[Auto] Lineage 2 - Scan Monsters") + 53
	Local $len = StringInStr($HTML," |") - $start
	$HTML = StringMid($HTML,$start,$len)


	If $AutoVersion == $HTML Then 
		ToolTipDel()
	Else
		ToolTip("A newer version is available: v"&$HTML&" "&@LF&"Click [ Option ] => [ HomePage ] to download",0,0)
		AdlibRegister("DelTooltip",9000)
	EndIf
	
EndFunc

;~ Hiệu chỉnh chế độ thử nghiệm
Func TestingSet()
	$Testing = Not $Testing
EndFunc

;~ Lưu các thông số trên GUI
Func SaveSetting()
	SaveGUIPos()
EndFunc

;~ Lưu vị trí GUI
Func SaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite($DataFileName,"AutoPos","x",$Pos[0])
	IniWrite($DataFileName,"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc

;~ Nạp các thông số của Auto lưu ở file
Func LoadSetting()
	LoadGUIPos()
EndFunc

;~ Nạp vị trí GUI
Func LoadGUIPos()
	$AutoPos[0] = IniRead($DataFileName,"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($DataFileName,"AutoPos","y",$AutoPos[1])
EndFunc

;~ Xóa ToolTip
Func ToolTipDel()
	ToolTip("")
EndFunc

;~ Thực hiện một lượt upload dữ liệu
Func DownloadProcess()
	Local $IE
;~ 	Local $URL = "http://www.google.com/images?q=Ring&hl=en&tbs=isch:1&ei=PnC2TK_UC8iQjAfrjK3lBA&sa=N&start=36&ndsp=18")
	Local $URL = "http://www.google.com/images?start="&$FindingStart&"&q="&StringReplace(inKeyGet()," ","+")
	
	Local $width = ipWidthGet()*1
	Local $height = ipHeightGet()*1
	If ($width or $height) Then
		If Not $width Then $width = $height
		If Not $height Then $height = $width
		$URL&= '&tbs=isch:1,isz:ex,iszw:'&$width&',iszh:'&$height
	EndIf
;~ 	http://www.google.com.vn/images?q=logo&um=1&hl=en&client=firefox-a&rls=org.mozilla:vi:official&biw=1600&bih=767&tbs=isch:1,isz:ex,iszw:100,iszh:100&source=lnt

	$CurrentPage = $FindingStart/$ImagePerPage
	Waring_LSet("Page: "&$CurrentPage&" loading...")
	
	$IE = _IECreate($URL,1,1)
	$HTML = _IEBodyReadHTML($IE)
	$aImage = StringSplit($HTML,'src="http://',1)
	$count = $FindingStart
	FOR $el IN $aImage
		ToolTipDel()
		If StringInStr($el,'gstatic.com') Then
			Waring_LSet("Page: "&$CurrentPage&" | Start:"&$count)
			$el = StringSplit($el,':http://',1)
			If $el[0] > 1 Then 
				$el = StringSplit($el[2],'" width',1)
			Else
				_ArrayDisplay($el)
				ContinueLoop
			EndIf
			
			$image = "http://"&$el[1]
			
			$save = "Image\"&inKeyGet()&"\"
			DirCreate($save)
			$save&= @SEC&@MSEC&'_'&urlGetFileName($image)
			
			tooltip("Saving: "&$save,0,0)
			InetGet($image,$save,1)
			$count+=1
		EndIf
	NEXT
	
	
	If $Testing Then msgbox(0,"72ls.net",$URL)
	_IEQuit($IE)
	
	$FindingStart+=$ImagePerPage
EndFunc



Func urlGetFileName($im)
	Local $FileName = $im
	$FileName = StringSplit(_StringReverse($FileName),'/')
	$Filename = _StringReverse($FileName[1])
	Return $FileName
EndFunc



