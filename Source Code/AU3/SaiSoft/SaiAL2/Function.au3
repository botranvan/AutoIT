#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự đăng nhập Lineage2
#ce ==========================================================
;~ Kiểm tra phiên bản mới của Auto
Func AutoCheckUpdate()
	ToolTip("Checking for updates...",0,0)
	
	Local $HTML = _INetGetSource($HomePage)
	Local $start = StringInStr($HTML,"[Auto] Lineage 2 - Scan Monsters") + 53
	Local $len = StringInStr($HTML," |") - $start
	$HTML = StringMid($HTML,$start,$len)


	If $AutoVersion == $HTML Then 
		DelTooltip()
	Else
		Waring_LSet("Newer version is available: v"&$HTML)
		ToolTip("A newer version is available: v"&$HTML&" "&@LF&"Click [ Option ] => [ HomePage ] to download",0,0)
		AdlibRegister("DelTooltip",9000)
	EndIf
	
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

;Lấy khóa để mã hóa
Func GetEncryptPass()
	return $AutoPass
EndFunc

;Lấy ID mặc định
Func DefaultIDGet()
	Local $Default = IniRead($UserListFileName,"Default","ID",'')
	If $Default == "" Then Return 0
	Return $Default
EndFunc

;Cài ID mặc định
Func DefaultIDSet($DefaultID = '')
;~ 	If $DefaultID Then 
		IniWrite($UserListFileName,"Default","ID",$DefaultID)
;~ 	Else
;~ 		IniWrite($UserListFileName,"Default","ID",Account_CBGet())
;~ 	EndIf
EndFunc

;Kiểm tra xem file tồn tại không
Func CheckFile($FileName,$Mode=42)
	If FileExists($FileName) Then
		Return 1
	Else
		If Not $Mode Then Return 0
		Local $File = FileOpen($FileName,$Mode)
		FileClose($File)
		Return $Mode
	EndIf
EndFunc

;Nạp PASS từ file ini bằng ID
Func LoasPASS($LoadID)
	Local $Pass = DeIni($UserListFileName,$LoadID,"p","")
	Return $Pass
EndFunc

;Nạp User từ file ini
Func LoadUserList()
	If Not CheckFile($UserListFileName,0) Then Return 0
	Local $UserList = IniReadSectionNames($UserListFileName)
	Local $Value = $UserList[1]
	For $i=2 To $UserList[0] Step 1
		If $UserList[$i]=="Default" Then ContinueLoop
		$Value&= "|"&$UserList[$i]
	Next
	
	;Kiểm tra xem DefaultID có tồn tại kg
	StringReplace($Value,DefaultIDGet(),"")
	If Not @extended Or Not DefaultIDGet() Then DefaultIDSet($UserList[1])
		
	Account_CBSet("")
	Account_CBSet($Value)
	Password_ISet(LoasPASS(Account_CBGet()))
EndFunc

;Giải Mã khi đọc từ file ini
Func DeIni($Filename, $Section, $Key, $Default,$Mode = 1)
	Local $Text = _StringEncrypt(0,IniRead($Filename,$Section,$Key,$Default), GetEncryptPass(),2)
	Return $Text
EndFunc

;Mã Hóa khi ghi vào file ini
Func EnIni($Filename, $Section, $Key, $Value,$Mode = 1)
	IniWrite($Filename,$Section,$Key,_StringEncrypt(1,$Value, GetEncryptPass(),2))
EndFunc

;Kiểm tra xem ID và Pass nhập chưa
Func IsIDPass()
	If Account_CBGet() And Password_IGet() Then Return True
	Return False
EndFunc

;~ Đợi giao diện login xuất hiện
Func GameWait()
	Local $Lable = Waring_LGet()
	For $i = 16 To 0 Step -1
		Waring_LSet($Lable&" "&$i)
		If WinWait($LauncherTitle,$LauncherText,1) Then Return 1
	Next
	Return 0
EndFunc

;Tự nhập ID và Pass
Func TypeIDPASS($LogID,$LogPASS)
	Local $time = 77
	Local $Lable = Waring_LGet()
	
	Sleep($time)
	Waring_LSet($Lable&" Click Start")
	ControlClick($LauncherTitle,$LauncherText,"[CLASS:Button; INSTANCE:5; CLASSNN:Button5]")
	
	Sleep(777)
	Waring_LSet($Lable&" Type User Name")
	;ControlSend("[CLASS:#32770;]","","[CLASSNN:Button85]",$LogID)
	Send($LogID)
	
	Waring_LSet($Lable&" Type Password")
	Sleep($time)
	ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:5; CLASSNN:Button5]")	
	Sleep($time)
	TypePass($LogPASS)

	Sleep($time)
	Waring_LSet($Lable&" Click Login")
	Send("{Enter}")
	;ControlClick("[CLASS:#32770;]","","[CLASS:Button; INSTANCE:2; CLASSNN:Button2]")
EndFunc

;Nhập PASS
Func TypePass($String)
	$ArrayString=StringSplit($String,"")
	for $i=1  to $ArrayString[0] step +1
		If Asc($ArrayString[$i])> 96 And Asc($ArrayString[$i])<123 Then
			ClickKey($ArrayString[$i])
		Else
			ControlSend(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:86; CLASSNN:Button86]",$ArrayString[$i])
		EndIf
	Next
EndFunc

;Click trên phím ảo của Game
Func ClickKey($Char)
	Select
		Case $Char="1"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:6; CLASSNN:Button6]")
		Case $Char="2"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:7; CLASSNN:Button7]")
		Case $Char="3"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:8; CLASSNN:Button8]")
		Case $Char="4"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:9; CLASSNN:Button9]")
		Case $Char="5"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:10; CLASSNN:Button10]")
		Case $Char="6"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:11; CLASSNN:Button11]")
		Case $Char="7"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:12; CLASSNN:Button12]")
		Case $Char="8"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:13; CLASSNN:Button13]")
		Case $Char="9"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:14; CLASSNN:Button14]")
		Case $Char="0"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:15; CLASSNN:Button15]")
					
		Case $Char="q"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:17; CLASSNN:Button17]")
		Case $Char="w"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:18; CLASSNN:Button18]")
		Case $Char="e"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:19; CLASSNN:Button19]")
		Case $Char="r"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:20; CLASSNN:Button20]")
		Case $Char="t"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:21; CLASSNN:Button21]")
		Case $Char="y"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:22; CLASSNN:Button22]")
		Case $Char="u"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:23; CLASSNN:Button23]")
		Case $Char="i"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:24; CLASSNN:Button24]")
		Case $Char="o"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:25; CLASSNN:Button25]")
		Case $Char="p"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:26; CLASSNN:Button26]")

		Case $Char="a"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:27; CLASSNN:Button27]")
		Case $Char="s"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:28; CLASSNN:Button28]")
		Case $Char="d"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:29; CLASSNN:Button29]")
		Case $Char="f"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:30; CLASSNN:Button30]")
		Case $Char="g"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:31; CLASSNN:Button31]")
		Case $Char="h"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:32; CLASSNN:Button32]")
		Case $Char="j"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:33; CLASSNN:Button33]")
		Case $Char="k"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:34; CLASSNN:Button34]")
		Case $Char="l"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:35; CLASSNN:Button35]")

		Case $Char="z"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:36; CLASSNN:Button36]")
		Case $Char="x"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:37; CLASSNN:Button37]")
		Case $Char="c"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:38; CLASSNN:Button38]")
		Case $Char="v"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:39; CLASSNN:Button39]")
		Case $Char="b"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:40; CLASSNN:Button40]")
		Case $Char="n"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:41; CLASSNN:Button41]")
		Case $Char="m"
			ControlClick(GetHandle("","#32770"),"","[CLASS:Button; INSTANCE:42; CLASSNN:Button42]")

	EndSelect
EndFunc

;Hàm lấy mã số game
Func GetHandle($Title="",$Class="",$Text="")
	If $Title="" And $Class="" then Return 0
	$Handle=WinGetHandle("[TITLE:"&$title&"; CLASS:"&$GameClass&";]",$Text)
	Return $Handle
EndFunc

;~ Lấy thông tin GUI để search
Func SearchInfoGet()
	Waring_LSet("Search: Get keyword")
	$SearchKey = SeachKey_IGet()
	$SearchType = SeachType_CoGet()
EndFunc

;~ Thực hiện tìm kiếm http://lineage.pmfun.com/?s=Lineage+II
Func SearchProcess()
	Local $URL = "lineage.pmfun.com"
	Local $URLFull = "http://"&$URL
	Local $Key = StringReplace($SearchKey," ","+")

	$URLFull &= "/?s="&$Key

	Waring_LSet("Search: Access database")
	Local $HTMLType = SearchGetTypeHTML(_INetGetSource($URLFull))
;~ 	Local $HTMLType = _INetGetSource($URLFull)
	
	If Not $HTMLType Then 
		Waring_LSet("Search: Not Found")
		Return
	EndIf
		
	Waring_LSet("Search: Get all results")
	Global $Link = SearchGetLinkFormHTML($HTMLType)
	
	If $Link[0] == 1 Then
		Waring_LSet("Search: Get "&$SearchType&" Info")
		ModShowInf(SearchModLoad($Link[2]),$Link[1])
	Else
		Waring_LSet("Search: Found "&$Link[0]&" "&$SearchType)
		ModsShow($Link)
	EndIf
EndFunc

;~ Lưu thông tin quái vừa tìm được
Func SearchModSave($Mod)
	Local $F = StringLeft($Mod[2],1)
	Local $FilePath = @WorkingDir&"\data\npc\"&$F&".ini"
	
	If Not FileExists($FilePath) Then
		$F = FileOpen($FilePath,1+8+128)
		FileClose($F)
	EndIf
	
	Local $Section = StringMid($Mod[2],1,StringInStr($Mod[2]," (")-1)
	For $i = 0 To $Mod[0]
		IniWrite($FilePath,$Section,$i,$Mod[$i])
	Next
EndFunc

;~ Lấy thông tin quái cần tìm
Func SearchModLoad($Name)
	Local $F = StringLeft($Name,1)
	Local $FilePath = @WorkingDir&"\data\npc\"&$F&".ini"
	
	If Not FileExists($FilePath) Then Return 0
		
	$FilePath = IniReadSection($FilePath,$Name)
	If @error Then Return 0
		
	Local $Mod[1] = [$FilePath[1][1]]
	For $i=2 To $FilePath[0][0]
		_ArrayAdd($Mod,$FilePath[$i][1])
	Next
	
;~ 	_ArrayDisplay($Mod)
	Return $Mod
EndFunc

;~ Lưu từ khóa vừa dùng
Func SearchKeySave($Name)
	$Name = StringSplit($Name," (",1)
	$Name = $Name[1]
	If SearchIsNewKey($Name) Then
		$SearchKeyList&= "|"&$Name
		SearchKeyListSave()
	EndIf
EndFunc

;~ Lưu danh sách key
Func SearchKeyListSave()
	IniWrite($DataFileName,"KeyList","Key",$SearchKeyList)
	SeachKey_ISet()
	SeachKey_ISet($SearchKeyList)
EndFunc
	
;~ Tìm xem Key có phải là mới hay không
Func SearchIsNewKey($Name)
	Local $List = StringSplit($SearchKeyList,"|")
	For $i = 1 To $List[0]
		If $Name = $List[$i] Then Return 0
	Next
	Return 1	
EndFunc

;~ Lấy vùng dữ liệu chứa loại cần tìm
Func SearchGetTypeHTML($Data)
	Local $Monsters,$NPC
	$Data = StringSplit($Data,'<td colspan="3" align="left"><b>NPC</b></td>',1)	
	If $Data[0] >= 2 Then $NPC = $Data[2]
	$Data = StringSplit($Data[1],'<td colspan="3" align="left"><b>Monsters</b></td>',1)	
	If $Data[0] >= 2 Then $Monsters = $Data[2]
	Return $Monsters&$NPC
EndFunc

;~ Lấy link từ trong kết quả search
Func SearchGetLinkFormHTML($Data)
	Local $Link[1] = [0]

	$Data = StringSplit($Data,'a href="/npc',1)
	For $i = 2 To $Data[0]
		$Link[0] += 1
		Local $aData = StringSplit($Data[$i],'" title="View ',1)
		Local $Len = StringInStr($aData[2],' drop and spoil') - 1
		$aData[2] = StringMid($aData[2],1,$Len)
		
		_ArrayAdd($Link,"/npc"&$aData[1])
		_ArrayAdd($Link,$aData[2])
	Next
	
	Return $Link
EndFunc

;~ Lấy thông tin của Mod từ link
Func ModGetInfo($Link,$Name = '')
	Local $T1,$T2,$T2,$Start,$Len
	Local $ModInfo[2] = [0,$Link]
	Local $HTML = _INetGetSource($SearchPage&$ModInfo[1])
;~ 	_IECreate($SearchPage&$ModInfo[1],1,1,0)

;~ 	Lấy tên và Level
	$HTML = StringSplit($HTML,'<span class="txtbig"><b>',1)
	$HTML = $HTML[2]
	$Len = StringInStr($HTML,'</span>')-1
	_ArrayAdd($ModInfo,StringReplace(StringMid($HTML,1,$Len),"</b>",""))
	
;~ 	Lấy Link Location
	$T1 = StringSplit($HTML,'Location</a>',1)	
	If $T1[0] >= 2 Then
		_ArrayAdd($ModInfo,StringReplace($ModInfo[1],"npc","loc"))
		$HTML = $T1[2]
	Else
		_ArrayAdd($ModInfo,"Unknow")
	EndIf

;~ 	Lấy danh sách Skill
	$T1 = StringSplit($HTML,'<img src="data/img/skill',1)
	$T2 = ""
	$T3 = ""
	For $i = 2 To $T1[0] Step 1
		$Start = StringInStr($T1[$i],'alt="')+5
		$Len = StringInStr($T1[$i],'title="')-$Start-2
		$T2 = StringMid($T1[$i],$Start,$Len)
		$T3&= StringMid($T2,1,StringInStr($T2,@LF)-1)
		If $i < $T1[0] Then $T3&=", "
	Next
	$HTML = $T1[$i-1]
	_ArrayAdd($ModInfo,$T3)
	
;~ 	Lấy chỉ số của Quái
	$Start = StringInStr($HTML,'"12"')+9
	$Len = StringInStr($HTML,'</td>')-$Start
	$T1 = StringReplace(StringReplace(StringMid($HTML,$Start,$Len),@LF,""),"  ","")
	_ArrayAdd($ModInfo,$T1)
	$ModInfo[0] = 5
	
;~ 	$HTML = StringSplit($HTML,"<b>Spoil</b>",1) 
;~ 	Lấy các item 
	$T1 = StringSplit($HTML,'src="data/img/',1)
	
	$Time = @MDAY&@HOUR&@MIN&@SEC
	For $i=2 To $T1[0]
		$T2 = ""
		$T3 = ""
		
;~ 		Lấy ảnh của item
		$T2 = StringSplit($T1[$i],'" align=',1)
		$T3&= $T2[1]&","

;~ 		Lấy link của item
		$T2 = StringSplit($T2[2],'href="/item/',1)
		$T2 = StringSplit($T2[2],'" title="',1)
		$T3&= $T2[1]&","

;~ 		Lấy tên của Item		
		$Len = StringInStr($T2[2],'">')-1
		$T3&= StringMid($T2[2],1,$Len)
		
;~ 		Lấy số tiên của Adena
		If StringInStr($T2[2],")") And StringInStr($T2[2],"-") And Not StringInStr($T2[2],'html">view</a>') Then 
			$Start = StringInStr($T2[2]," (")
			$End = StringInStr($T2[2],")")-$Start
			$T3&= StringMid($T2[2],$Start,$End)&")"
		EndIf
		$T3&= ","

;~ 		Lấy tỷ lệ rớt của Item
		$T2 = StringSplit($T2[2],'<td>',1)
		$Len = StringInStr($T2[3],'</td>')-1
		$T3&= StringMid($T2[3],1,$Len)
		
		_ArrayAdd($ModInfo,$T3)
		$ModInfo[0] += 1
		If StringInStr($T1[$i],"<b>Spoil</b>",1) Then 
			_ArrayAdd($ModInfo,"Spoil")
			$ModInfo[0] += 1
		EndIf
	Next
	
;~ 	_ArrayDisplay($ModInfo)
	Return $ModInfo
EndFunc

;~ Hiển thị danh sách Mod trùng tên
Func ModsShow($Link)
	If $ListGUI Then ListGUIClose()
		
	Local $Pos = WinGetPos($MainGUI)
	$ListGUI = GUICreate($SearchKey,$Pos[2],$Pos[3],$Pos[0],$Pos[1]+$Pos[3],BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS),$WS_EX_TOPMOST,$MainGUI)
	GUISetOnEvent($GUI_EVENT_CLOSE, "ListGUIClose",$ListGUI)
	GUISetOnEvent($GUI_EVENT_PRIMARYUP,"ListShowMod",$ListGUI)
	
    Global $ListView = GUICtrlCreateListView("Name|#",0,0, $Pos[2], $Pos[3],$LVS_SORTASCENDING+$LVS_SINGLESEL+$LVS_NOSORTHEADER-$LVS_REPORT);
	GUISetOnEvent($ListView,"ListShowMod",$ListGUI)
	
	For $i = 1 To $Link[0]*2 Step 2
		GUICtrlCreateListViewItem($Link[$i+1]&"|"&$Link[$i], $ListView)
	Next
	
	GUISetState(@SW_SHOW,$ListGUI)
;~ 	_ArrayDisplay($Link)
EndFunc

;~ Hiển thị Mod được chọn trong List
Func ListShowMod()
	Local $Sel = GUICtrlRead(GUICtrlRead($listview))
	Sleep(270)
	If Not $Sel Then Return
		
	Waring_LSet("Search: Get "&$SearchType&" Info")
	$Sel = StringSplit($Sel,"|")
	ClipPut($Sel[1])
	ModShowInf(SearchModLoad($Sel[1]),$Sel[2])
EndFunc

;~ Đóng danh sách Mod trùng tên
Func ListGUIClose()
	GUIDelete($ListGUI)
	$ListGUI = 0
EndFunc

;~ Xuất thông tin của Quái ra
#cs
+ Mod:
+ + 1: Link của Mod trên PmFun
+ + 2: Tên Mod và Level
+ + 3: Link vị trí Mod trên Map
+ + 4: Danh sách Skill của Mod
+ + 5: Trạng thái của Mod
+ + 6: Đến hết là danh sách Item quái rớt

+ Item:
+ + 1: Ảnh của Item
+ + 2: Link của item trên PmFun
+ + 3: Tên Item và số lượng rớt
+ + 4: Tỷ lệ rớt của item
#ce
Func ModShowInf($Mod,$Link)
	If $MiniGUI Then CloseMiniGUI()
		
	If Not IsArray($Mod) Then
		$Mod = ModGetInfo($Link)
		SearchModSave($Mod)			
	EndIf
	SearchKeySave($Mod[2])
		
	$ModInfo = $Mod	
	Local $Item,$Image
	$MiniGUI = GUICreate($ModInfo[2],Default,Default,Default,Default,BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS),$WS_EX_TOPMOST,$MainGUI)
	GUISetOnEvent($GUI_EVENT_CLOSE, "CloseMiniGUI",$MiniGUI)
	GUISetOnEvent($GUI_EVENT_PRIMARYUP,"SearchDrawImage",$MiniGUI)
	
	$ModSkill_B = GUICtrlCreateButton("Skill",1,1,40,20)
	GUICtrlSetTip(-1,ModGetState(4))
	GUICtrlSetOnEvent(-1,"ModShowSkill")
	
	$ModState_B = GUICtrlCreateButton("State",90,1,40,20)
	GUICtrlSetTip(-1,ModGetState(5))
	GUICtrlSetOnEvent(-1,"ModShowState")
	
	$ModLoca_B = GUICtrlCreateButton("Location",180,1,60,20)
	GUICtrlSetState($ModLoca_B,$GUI_DISABLE)
	
	If $ModInfo[0] = 5 Then GUICtrlCreateLabel("No Item",100,210,150,70)
	
	Local $ItemHeight = 36
	Local $Row = 1
	Local $Col = 0
	For $i = 6 To $ModInfo[0]
		If $Col = 6 And $ModInfo[$i] <> "Spoil" Then
			$Col = 0
			$Row+= 1
		EndIf
			
		If $ModInfo[$i] == "Spoil" Then
			$Row+= 1.6
			$Col = 0
		EndIf
		
		$Item = StringSplit($ModInfo[$i],",")
		If $Item[0] = 4 Then $Col+= 1
	Next
	
;~ 	Lấy tọa độ hiện tại của MiniGUI
	If Not IsArray($MiniGUIPos) Then 
		$MiniGUIPos = WinGetPos($MainGUI)
		$MiniGUIPos[0]+= $MiniGUIPos[2]
	EndIf
	
	WinMove($MiniGUI,"",$MiniGUIPos[0],$MiniGUIPos[1],$MiniGUIPos[2],70+$Row*$ItemHeight)
	GUISetState(@SW_SHOW,$MiniGUI)
	
	If $ModInfo[0] = 5 Then Return	
	SearchDrawImage()
EndFunc

;~ Vẽ hình các Item
Func SearchDrawImage()
	If Not $MiniGUI Then Return
	Sleep(106)
	Local $hImage, $hGraphic	
	Local $ItemHeight = 36
	Local $Row = 1
	Local $Col = 0
	For $i = 6 To $ModInfo[0]
		If $Col = 6 And $ModInfo[$i] <> "Spoil"Then
			$Col = 0
			$Row+= 1
		EndIf
			
		If $ModInfo[$i] == "Spoil" Then
			$Row+= 1.6
			$Col = 0
			GUICtrlCreateLabel("Spoil",2+$Col*$ItemHeight, $Row*$ItemHeight-20)
		EndIf
		
		$Item = StringSplit($ModInfo[$i],",")
		If $Item[0] = 4 Then 
			$Image = ItemGetImage($Item)

			GUICtrlCreatePic($NoPhoto, 2+$Col*$ItemHeight, $Row*$ItemHeight,32,32)
			GUICtrlSetTip(-1,"Tỷ lệ: "&$Item[4],$Item[3])
			
			If Not StringInStr($Image,"\.png") Then
				_GDIPlus_StartUp()
				$hImage   = _GDIPlus_ImageLoadFromFile($Image)
				$hGraphic = _GDIPlus_GraphicsCreateFromHWND($MiniGUI)
				_GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 2+$Col*$ItemHeight, $Row*$ItemHeight)
			EndIf
			
			$Col+= 1
		EndIf
	Next
	Waring_LSet("Search: Done")
EndFunc

;~ Lấy ảnh của Item
Func ItemGetImage($Item)
	Local $Folder = "data\img\"
	
	Local $T1 = StringMid($Item[1],1,StringInStr($Item[1],"_")-1)

	If Not FileExists($Folder&$T1) And $Item[1]<> ".png" Then 
		DirCreate($Folder&$T1)
	EndIf
	
	$FilePath = $Folder&StringReplace($Item[1],"_","\",1)

	If Not FileExists($FilePath) Then
		Local $Name = $Item[1]
		If StringLen($Item[1]) > 25 Then $Name= "..."&StringRight($Item[1],22)
		Waring_LSet("Loaded: "&$Name)
		$URL = $SearchPage&StringReplace($Folder,"\","/")&$Item[1]	
		InetGet($URL,@WorkingDir&"\"&$FilePath,1)
	EndIf
	
	Return @WorkingDir&"\"&$FilePath
EndFunc

;~ Đóng GUI hiện thông tin của mod
Func CloseMiniGUI()
	Local $Pos = WinGetPos($MiniGUI)
	If Not @error Then $MiniGUIPos = $Pos 
	GUIDelete($MiniGUI)
	$MiniGUI = 0
EndFunc

;~ Xóa thông báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Mở Memory của Game
Func GameOpenMemory()
	If $GamePid <> -1 Then 
;~ 		_MemoryOpen($MemGame)
		$MemGame = _MemoryOpen($GamePid)		
	EndIf
EndFunc

;~ Đọc bộ nhớ game
Func GameRead($iv_Address,$sv_Type = 'dword')
	If $GamePid == -1 Then Return
	Local $Data = _MemoryRead($iv_Address,$MemGame,$sv_Type)
	If @error Then 
		msgbox(0,"72ls.net",@error&": Lỗi đọc vùng nhớ Game")
		ExitAuto()
	EndIf
	Return $Data
EndFunc

;~ Lấy tên mục tiêu đang được chọn
Func GameGetTarget()
;~ 	Return GameRead(GameRead(0x0CEDE2FC),'WCHAR[27]')

	Local $Add = 0x0CF3DFFC

	$Add = GameRead($Add)
;~ 	$Add = GameRead($Add)
	$Add = GameRead($Add,'WCHAR[52]')
	Return $Add
EndFunc


;~ Hiện thông tin state của Mod
Func ModShowState()
	ToolTip(ModGetState(5)&@LF&@LF&"Press Ctrl+Shilf+Delete",0,0,$ModInfo[2],1)
EndFunc

;~ Hiện thông tin skill của Mod
Func ModShowSkill()
	ToolTip(ModGetState(4)&@LF&@LF&"Press Ctrl+Shilf+Delete",0,0,$ModInfo[2],1)
EndFunc

;~ Hiện thông tin state của Mod
Func ModGetState($i)
	$Image = ""
	$Item = StringSplit($Modinfo[$i],",")
	For $i = 1 to $Item[0]
		$Image&= $Item[$i]
		If $i <> $Item[0] Then $Image&= @LF
	Next
	Return $Image
EndFunc

;~ Xử lý việc tự ép
Func EnchantProcess()
	If GameCount() <> 1 Then
		msgbox(0,"72ls.net","Chỉ có thể tự ép khi chạy 1 Game mà thôi")
		$Enchanting = 1
		AutoEnchantClick()
		Return
	EndIf
	
	If Not $GameHandle Then
		msgbox(0,"72ls.net","Lỗi nhận dạng Game")
		$Enchanting = 1
		AutoEnchantClick()
		Return
	EndIf
	
	Local $Wait = 222

	
	WinActivate($GameHandle)
	Sleep(5000)
	
	Enchant(2)
	Enchant(3)
	Enchant(4)
	Enchant(5)
	Enchant(6)
	Enchant(7)

	Sleep($Wait)	;Bấm Entrer
	ControlSend($GameHandle,"",0,"{F12}")
	Sleep(2000)
	
	Sleep($Wait)	;Mở Option
	ControlSend($GameHandle,"",0,"x")
	
	Sleep($Wait)	;Click Chơi Lại
	Local $ChoiLaiClick = ClickGetPost($ChoiLai)
	MouseClick("left",$ChoiLaiClick[0], $ChoiLaiClick[1],1,1)

	Sleep($Wait)	;Click Ok Chơi Lại
	Local $OkChoiLaiClick = ClickGetPost($OkChoiLai)
	MouseClick("left",$OkChoiLaiClick[0], $OkChoiLaiClick[1],1,1)
	Sleep(5000)

	Sleep($Wait)	;Click Ok Chơi Lại
	Local $BatDauClick = ClickGetPost($BatDau)
	;MouseClick("left",$BatDauClick[0], $BatDauClick[1],1,1)
	ControlSend($GameHandle,"",0,"{Enter}")

EndFunc

;~ Thực hiện 1 lần ép
Func Enchant($Num)
	Local $Wait = 222
	
	Sleep($Wait)	;Click Enchant
	ControlSend($GameHandle,"",0,$Num)
	
	Sleep($Wait)	;Click Weapon
	Local $WeaponClick = ClickGetPost($WeaponPos1)
	MouseClick("left",$WeaponClick[0], $WeaponClick[1],1,1)
	
	Sleep($Wait)	;Click Ok
	Local $OkClick = ClickGetPost($OkButton)
	MouseClick("left",$OkClick[0], $OkClick[1],1,1)
	
	Sleep($Wait)	;Click Huy
	Local $HuyClick = ClickGetPost($HuyButton)
;~ 	MouseClick("left",$HuyClick[0], $HuyClick[1])
	
EndFunc

;~ Lấy tọa độ vị trí cần Click
Func ClickGetPost($Pos)
	Local $GamePos = WinGetPos($GameHandle)
	Local $GameGreen = WinGetClientSize ($GameHandle)
	Local $Span[2] = [$GameGreen[0] - $GamePos[2],$GameGreen[1] - $GamePos[3]]
	
	$Pos[0]+= $GamePos[0] - $Span[0]
	$Pos[1]+= $GamePos[1] - $Span[1]
	
	Return $Pos
EndFunc

Func GameCount() 
	Local $WL = ProcessList($ProcessName)
;~ 	_ArrayDisplay($WL)
	Return $WL[0][0]
EndFunc

Func ShowTextTest()
	If Not $GameHandle Then Return
		
	Local $Text = ""
	Local $Mouse = MouseGetPos()
	Local $GamePos = WinGetPos($GameHandle)
	Local $GameGreen = WinGetClientSize ($GameHandle)
	Local $ControlPos[2]
	$ControlPos[0] = $Mouse[0] - $GamePos[0] + ($GameGreen[0] - $GamePos[2])
	$ControlPos[1] = $Mouse[1] - $GamePos[1] + ($GameGreen[1] - $GamePos[3])
	
	$Text&= $Mouse[0]&"/"&$Mouse[1]&" "&$GamePos[0]&"/"&$GamePos[1]&"-"&$GamePos[2]&"/"&$GamePos[3]&" "&$GameGreen[0]&"/"&$GameGreen[1]&@CRLF
	$Text&= $ControlPos[0]&"/"&$ControlPos[1]
	
	tooltip(@sec&@msec&" "&$Text,$GamePos[0],$GamePos[1])
EndFunc

;~ Bật tắt chế độ Test
Func TestControl()
	$Testing = Not $Testing
	$GameHandle = WinGetHandle("[CLASS:l2UnrealWWindowsViewportWindow]")
EndFunc