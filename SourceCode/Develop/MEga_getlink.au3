#Region
#AutoIt3Wrapper_icon=icon_mega.ico
#AutoIt3Wrapper_compression=4
#AutoIt3Wrapper_res_description= Get link Mega.1280.com
#AutoIt3Wrapper_res_fileversion= 1.0
#AutoIt3Wrapper_res_legalcopyright=lenguyenitbk - lenguyenitbk@gmail.com
#Endregion

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
;~ #include <GuiEdit.au3>
#Include <GuiListBox.au3>
;~ #################################################
$host = 'mega.1280.com'

$k = 0
$link_downs = ''
Global $captcha_link = 'http://mega.1280.com/security_code.php'
Dim $arr[50]
$dem = 0 
$j = 0
$active = 0


Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode",1)
Opt("TrayOnEventMode", 1)

$prefsitem  = TrayCreateItem("Show")
TrayItemSetOnEvent(-1,"show")
TrayCreateItem("")
$aboutitem  = TrayCreateItem("About")
TrayItemSetOnEvent(-1,"about")
TrayCreateItem("")
$exititem   = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1,"quit")
Global $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$links = ''
$click = False
$pic = ''

    Local $hListView
$title = "Get Link Mega.1280.com - Version 1.0"
   $gui =  GUICreate($title, 700, 550)
GUICtrlCreateLabel("All rights reseved by lenguyenitbk.", 10, 500, 700, 21, $SS_CENTER)
GUICtrlSetFont(-1, 11, 400, 2, "Arial")
GUICtrlSetColor(-1, 0xFF0000)

	$input = GUICtrlCreateEdit('Link',10,290,250,130,BitOR($ES_AUTOVSCROLL,$WS_VSCROLL,$ES_MULTILINE,$ES_WANTRETURN))
	GUICtrlCreateButton('Add',10,422,250,50)
	GuictrlSetOnEvent(-1,"add")
	GUICtrlCreateButton('>',260,150,40,30)
	GUICtrlSetFont(-1, 15, 400)
	GuictrlSetOnEvent(-1,"getlink")
	
	GUICtrlCreateButton('>>>',260,220,40,30)
	GUICtrlSetFont(-1, 15, 400)
	GuictrlSetOnEvent(-1,"getlinks")
	
	GUICtrlCreateButton('Del',260,80,40,30)
	GuictrlSetOnEvent(-1,"del")
;~ 	####################
	$input_captcha = GUICtrlCreateInput('',300,335,150,23,$ES_LOWERCASE)
		$captcha = GUICtrlRead($input_captcha)
	Global $input_captcha
	GUICtrlCreateButton('Copy all',465,300,70,60)
	GuictrlSetOnEvent(-1,"clip_get")
	GUICtrlCreateButton('Save As',545,300,70,60)
	GuictrlSetOnEvent(-1,"save")
	GUICtrlCreateButton('Exit',625,300,70,60)
	GuictrlSetOnEvent(-1,"quit")
	$out = GUICtrlCreateEdit('Result',300,370,395,100)
;~ 	 ################
    $hListView = GUICtrlCreateListView("", 300, 10, 394, 268, $LVS_SHOWSELALWAYS)
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	$links_ = GUICtrlCreateListView("", 10, 10, 250, 268,BitOR ($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	_GUICtrlListView_SetExtendedListViewStyle($links_, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
    GUISetState()
	_GUICtrlListView_AddColumn($links_, "Top",35)
 _GUICtrlListView_AddColumn($links_, "                        Link Down",211)
 
_GUICtrlListView_AddColumn($hListView, "Top",35)
_GUICtrlListView_AddColumn($hListView, "                File name",165)
_GUICtrlListView_AddColumn($hListView, "           Size", 100)
_GUICtrlListView_AddColumn($hListView, "        Link", 90)
	GUISetOnEvent($GUI_EVENT_CLOSE,'quit')
	GUISetOnEvent($GUI_EVENT_MINIMIZE,'minimize')
    Do
		Sleep(10)
    Until GUIGetMsg() = -3
Func minimize()
	TrayTip("minimize mode", "", 3, 1)
	GUISetState(@SW_HIDE,$gui)
EndFunc
Func show()
	GUISetState(@SW_SHOW,$gui)
	GUISetState(@SW_RESTORE,$gui)
	EndFunc
Func quit()
	FileDelete('banner.jpg')
	Exit
	EndFunc

Func add()
	Local $str,$i
	$link = GUICtrlRead($input)
	$link = StringReplace($link,@CR,'')
	$str = StringSplit($link,@LF)
	For $i= 1 To $str[0]
		If Not StringInStr($str[$i],'http://mega.1280.com') Then ContinueLoop
			If StringInStr($str[$i],'http://mega.1280.com/folder') Then
				$Links_folder = add_link_folder($str[$i])
				ContinueLoop
			EndIf
		$k =	_GUICtrlListView_GetItemCount($links_) + 1
	_GUICtrlListView_AddItem($links_, $k, 0)
	_GUICtrlListView_AddSubItem($links_,$k - 1,StringReplace( $str[$i],' ',''),1)
	Next
GUICtrlSetData($input,'')
	EndFunc
	
Func update($file_name,$size,$link)
			Local $index_
			$j+=1
		_GUICtrlListView_BeginUpdate($hListView)
				$index_ = _GUICtrlListView_AddItem($hListView, $j, 0)
				    _GUICtrlListView_AddSubItem($hListView,$index_,  $file_name, 1)
				    _GUICtrlListView_AddSubItem($hListView,$index_,  $size, 2)
                     _GUICtrlListView_AddSubItem($hListView,$index_, $link, 3)
					_GUICtrlListView_EndUpdate($hListView)
;~ 	$k+=1
EndFunc
;~ 	##################################################################
	Func getlink()
		Local $links_get = '',$link_arr = ''
		Local $txt = ''
		$count = _GUICtrlListView_GetItemCount($links_)
		ConsoleWrite($count)
    
		$result = _GUICtrlListView_GetSelectedIndices($links_)
		$select = StringSplit($result,'|')
		For $i = 1 To $select[0]
			$txt  =  _GUICtrlListView_GetItemText($links_, Int($select[$i]),1)
				If $txt = '' Then ContinueLoop
				$links_get &=download($txt)&@LF
			Next
			$s2 = StringSplit($links_get,@LF)
			For $i = 1 To $s2[0]
				test($s2[$i])
			Next
	EndFunc
;~ ###########################################
	Func getlinks()
		Local $links_get = '',$link_arr = ''
		Local $txt = ''
		$count = _GUICtrlListView_GetItemCount($links_)
		For $i = 0 To $count + 1
			$txt  =  _GUICtrlListView_GetItemText($links_, $i,1)
				If $txt = '' Then ContinueLoop
				$links_get &=download($txt)&@LF
			Next
			$s2 = StringSplit($links_get,@LF)
			For $i = 1 To $s2[0]
				test($s2[$i])
			Next
	EndFunc
;~ ###########################################
Func download($link)
	Dim $database[3]
	Local $link_down = '',$ip = '',$hash = '',$name = '',$recv = '',$info = '',$size = ''
	$recv = http('GET',$link)
	$id = StringBetween($recv,'id" value="','"')
	$oHTTP.Open("GET", $captcha_link, False)
	$oHTTP.Send()
$recv = $oHTTP.ResponseBody
Local $fh=FileOpen(@ScriptDir&"\banner.jpg", 2)
FileWrite($fh, $recv)
FileClose($fh)
	
	 $pic =  GUICtrlCreatePic(@ScriptDir&"\banner.jpg", 300, 300, 150, 30)
	 $dll = DllOpen("user32.dll")
	 Opt("GUIOnEventMode", 0)
 While GUIGetMsg() <> -3
	 Sleep(50)
	If IsPressed("0D", $dll) Then
		  $captcha = GUICtrlRead($input_captcha)
			If StringLen($captcha) <> 5 Then
				GUICtrlSetData($input_captcha,'')
				ContinueLoop
			EndIf
		 GUICtrlDelete($pic)
		ExitLoop
	EndIf
WEnd
 Opt("GUIOnEventMode", 1)
DllClose($dll)
  GUICtrlSetData($input_captcha,'')
$data = 'code_security='&$captcha&'&btn_download.x=5&btn_download.y=17&btn_download=Download&action=download_file&file_id='&$id[0]
$post =  http("POST",$link, $data)
 If Not StringInStr($post,'mega.1280.com') Then
	MsgBox(64,'Sai captcha roai',':|')
	EndIf

;~ 	  #############################
	 If StringInStr($post ,'downloads') Then
	 $name = StringBetween($post,'clr05"><b>','</b>')
		$info = StringBetween($post,'none">','</div')
		$size =  StringBetween($post,'<strong>','</strong>')
;~ 		ConsoleWrite($post)
		$hash = $info[3]
		$name = $info[4]
		$ip = $info[5]
	 EndIf
	 $link_down = $ip &'downloads/file/'&$hash&'/'&$name
;~ 	 ConsoleWrite($link_down)
	 If IsArray($size) Then
	 update($name,$size[1],$link_down)
		Else
	 Return 
	 EndIf
	 $links &= $link_down&@CRLF
	 GUICtrlSetData($out,$links)
	 $click = False
	  Return $link
  EndFunc
;~ ########################################################################################################
Func http($method,$oURL, $oData = "")
$oHTTP.Open($method, $oURL, False)
If $method = 'POST' Then 
 $oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
 EndIf
 $oHTTP.setRequestHeader ("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.4) Gecko/20091007 Firefox/3.5.7")
$oHTTP.setRequestHeader ("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
  $oHTTP.setRequestHeader ("Accept-Language", "en-us,en;q=0.5")
 $oHTTP.setRequestHeader ("Accept-Charset", "ISO-8859-1,utf-8;q=0.7,*;q=0.7")
  $oHTTP.setRequestHeader ("Connection", "keep-alive")
  $oHTTP.setRequestHeader ("Keep-alive", "300")
  $oHTTP.Send($oData)
  $cookies = $oHTTP.getallresponseheaders
	Return $oHTTP.Responsetext
EndFunc
;~ ########################################################################################################
Func read()
	$click = True
 	$captcha = GUICtrlRead($input_captcha)
	Global $captcha,$click
EndFunc
Func del()
	$handle = GUICtrlGetHandle($links_)
	$handle2 = GUICtrlGetHandle($hListView)
	_GUICtrlListView_DeleteItemsSelected($handle)
	_GUICtrlListView_DeleteItemsSelected($handle2)
    EndFunc

Func test($link)
;~ 	$count = _GUICtrlListView_GetItemCount($links_)
;~ 		ConsoleWrite(@CRLF&$count)
;~ _GUICtrlListView_SetItemChecked($hListView, 1)
	_GUICtrlListBox_BeginUpdate($links_) 
	$handle = GUICtrlGetHandle($links_)
	$p = Int(_GUICtrlListView_FindInText($handle,$link))
	$conlai =  _GUICtrlListBox_DeleteString($handle, $p)
	_GUICtrlListView_DeleteItem($handle, $p)
	  _GUICtrlListBox_EndUpdate($links_)
	EndFunc

	Func clip_get()
		$result_ = GUICtrlRead($out)
		ClipPut($result_)
	EndFunc

Func about()
	MsgBox(64,'Getlink Mega 1280 ','Version : 1.0'&@CRLF&'Author : lenguyenitbk'&@CRLF&'Date created : 14/02/2010')
EndFunc

Func save()
	Local $file
$save_ = FileSaveDialog( "Save as . . .", @ScriptDir, "Txt (*.txt)",2)
$link_collect = GUICtrlRead($out)
If StringRight($save_,4) <> '.txt' Then
	$save_ &= '.txt'
	EndIf
$file = FileOpen($save_,1)
FileWrite($file,$link_collect)
FileClose($file)
	EndFunc
	
	Func IsPressed($sHexKey, $vDLL = 'user32.dll')
	Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($a_R[0], 0x8000) <> 0
EndFunc   

Func add_link_folder($folder)
	Local $config1,$config3,$rec = '',$result = '',$str=''
	TCPStartup()
		$ip = TCPNameToIP($host)
		$socket = TCPConnect($ip,80)
		$folder = StringReplace($folder,'http://mega.1280.com','')
			$config1 = 'GET '&$folder&' HTTP/1.1' & @CRLF & _
			'Accept: image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/x-shockwave-flash, */*'& @CRLF & _
			'Accept-Language: vi-VN'& @CRLF & _
			'User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0)'& @CRLF & _
			'Accept-Encoding: gzip, deflate'& @CRLF & _
			'Host: mega.1280.com'& @CRLF & _
			'Connection: Keep-Alive'& @CRLF  &@CRLF
			$config3 = 'GET /getlinks.php?onLoad=%5Btype%20Function%5D HTTP/1.1'& @CRLF & _
			'Accept: */*'& @CRLF & _
			'Accept-Language: vi-VN'& @CRLF & _
			'Referer: http://mega.1280.com/flash.swf'& @CRLF & _
			'x-flash-version: 10,0,45,2'& @CRLF & _
			'Accept-Encoding: gzip, deflate'& @CRLF & _
			'User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0)'& @CRLF & _
			'Host: mega.1280.com'& @CRLF & _
			'Connection: Keep-Alive'& @CRLF & _
			'Cookie: '
TCPSend($socket,$config1)
For $i = 1 To 50
	Sleep(10)
	$rec&= TCPRecv($socket,500)
	If StringInStr($rec,'lastvisit') Then ExitLoop
	Next
	
$cookies_ = StringBetween($rec,'Set-Cookie: ',';')
$cookie = $cookies_[0] & '; '&$cookies_[1] & '; '&$cookies_[2]

$config = $config3 & $cookie & @CRLF &@CRLF 
$rec = ''
TCPSend($socket,$config)

While 1
	Sleep(100)
	$rec= TCPRecv($socket,5000)
			$result&=$rec
			If StringRight($rec,1) =='&' Then
				ExitLoop
			EndIf
WEnd
;~ ConsoleWrite($result)
If StringInStr($result,'&errorcode=3') Then 
		MsgBox(16,'!!!','Folder : '&$str[$i]&' da bi xoa hoac ko ton tai',2)
	Return 0
	EndIf
$dem = 0
Dim $arr_link[100]
		If StringInStr($result,'file_linkcode') Then
			$str = StringBetween($result,'file/','/')
			For $i = 0 To UBound($str) - 1
				$arr_link[$dem + $i] = 'http://mega.1280.com/file/'& $str[$i]
;~ 				ConsoleWrite($i &' : '&$arr[$dem + $i]&@CRLF)
				$k =	_GUICtrlListView_GetItemCount($links_) + 1
						_GUICtrlListView_AddItem($links_, $k, 0)
						_GUICtrlListView_AddSubItem($links_,$k - 1, $arr_link[$dem + $i],1)
			Next
			$active = 1
			$dem += UBound($str)
			
			EndIf
			ReDim $arr_link[UBound($str) ]
			Return $arr_link
TCPShutdown()

EndFunc








Func StringBetween($s_String, $s_Start, $s_End, $v_Case = -1)

	; Set case type
	Local $s_case = ""
	If $v_Case = Default Or $v_Case = -1 Then $s_case = "(?i)"

	; Escape characters
	Local $s_pattern_escape = "(\.|\||\*|\?|\+|\(|\)|\{|\}|\[|\]|\^|\$|\\)"
	$s_Start = StringRegExpReplace($s_Start, $s_pattern_escape, "\\$1")
	$s_End = StringRegExpReplace($s_End, $s_pattern_escape, "\\$1")

	; If you want data from beginning then replace blank start with beginning of string
	If $s_Start = "" Then $s_Start = "\A"

	; If you want data from a start to an end then replace blank with end of string
	If $s_End = "" Then $s_End = "\z"

	Local $a_ret = StringRegExp($s_String, "(?s)" & $s_case & $s_Start & "(.+?)" & $s_End, 3)
	If @error Then Return SetError(1, 0, 0)
	Return $a_ret
EndFunc 