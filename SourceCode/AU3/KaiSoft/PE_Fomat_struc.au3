Global $gui1 = GUICreate("Autoit Pro",680,330)
Global $menu = GUICtrlCreateMenu ("File")
Global $open = GUICtrlCreateMenuItem("Open File",$menu)
GUICtrlCreateMenuItem("",$menu)
Global $thoat = GUICtrlCreateMenuItem("Exit",$menu)
GUICtrlCreateMenuItem("",$menu)
Global $openfile1 = GUICtrlCreateMenuItem("Testhead.exe",$menu)
Global $openfile2 = GUICtrlCreateMenuItem("explorer.exe",$menu)
Global $openfile3 = GUICtrlCreateMenuItem("uset32.dll",$menu)

Global $file[1][10]
$file[0][6] = GUICtrlCreateTreeView(0, 0, 200, 280,-1,131584)


$hLineLabel = GUICtrlCreateLabel("", 200, 279,480, 2, 0x8001000)
GUICtrlSetResizing($hLineLabel, 576)
GUISetState(@SW_SHOW)

Global $LangCodeCurrent

Global $i,$x
Global $progress,$sizefile,$import[1][1],$resources[1][1]
Global $sFile,$hFile,$fileimage,$a,$Export[9],$imagebase


Global $thanhghi[4][8] =	[[	"AL","CL","DL","BL","AH","CH","DH","BH"	], _
							[	"AX","CX","DX","BX","SP","BP","SI","DI"	], _
							["BX + SI","BX + DI","BP + SI","BP + DI","SI","DI","BP","BX"], _
							["ES","","","DS","","","",""]]
Global $opitionna[15][10] = [[0,0,0,0,0,0,	'Export'				], _
							[0,0,0,0,0,0,	'Import'				], _
							[0,0,0,0,0,0,	'Resource'				], _
							[0,0,0,0,0,0,	'Exception'				], _
							[0,0,0,0,0,0,	'Security'				], _
							[0,0,0,0,0,0,	'Base Relocations'		], _
							[0,0,0,0,0,0,	'Debug'					], _
							[0,0,0,0,0,0,	'Copyright'				], _
							[0,0,0,0,0,0,	'GlobalPrt'				], _
							[0,0,0,0,0,0,	'TLS'					], _
							[0,0,0,0,0,0,	'Load Config'			], _
							[0,0,0,0,0,0,	'Bound Import'			], _
							[0,0,0,0,0,0,	'IAT'					], _
							[0,0,0,0,0,0,	'Delay Import'			], _
							[0,0,0,0,0,0,	'CLR Header'			]]
Global $aArrayTypes[24][2] = 	[[	"CURSOR"		, 	"Cursor"						], _
								[	"BITMAP"		, 	"Bitmap"						], _
								[	"ICON"			, 	"Icon"							], _
								[	"MENU"			, 	"Menu"							], _
								[	"DIALOG"		, 	"Dialog box"					], _
								[	"STRING"		, 	"String-table"					], _
								[	"FONTDIR"		,	"Font Directory"				], _
								[	"FONT"			,	"Font"							], _
								[	"ACCELERATOR"	,	"Accelerator table"				], _
								[	"RCDATA"		,	"Resource Data"					], _
								[	"MESSAGETABLE"	,	"Message-table"					], _
								[	"GROUP_CURSOR"	,	"Hardware-independent Cursor"	], _
								[	"13"			,	"13"							], _
								[	"GROUP_ICON"	,	"Hardware-independent Icon"		], _
								[	"15"			,	"15"							], _
								[	"VERSION"		,	"Version Info"					], _
								[	"DLGINCLUDE"	,	"Include"						], _
								[	"18"			,	"18"							], _
								[	"PLUGPLAY"		,	"Plug and Play"					], _
								[	"VXD"			,	"VXD"							], _
								[	"ANICURSOR"		,	"Animated cursor"				], _
								[	"ANIICON"		,	"Animated icon"					], _
								[	"HTML"			,	"HTML"							], _
								[	"MANIFEST"		,	"XML Manifest"					]]


While 1
	even(GUIGetMsg())

	$x = GUICtrlRead($file[0][6])
	If $x = 0 Then ContinueLoop

	If $opitionna[0][0] And $opitionna[0][4] = $x Then
		chon3()
		ContinueLoop
	EndIf
	For $i = 0 To 14
		If $opitionna[$i][0] And $opitionna[$i][3] And $opitionna[$i][5] = $x Then
			Hexview(DllStructCreate("byte[" & $opitionna[$i][2] & "]",DllStructGetPtr($file[$opitionna[$i][3]][4])+$opitionna[$i][1]- $file[$opitionna[$i][3]][2]),$opitionna[$i][2],$opitionna[$i][8],$opitionna[$i][9],$opitionna[$i][5])
			ExitLoop
		EndIf
	Next
	If $i <= 14 Then ContinueLoop
	For $i = 1 To $file[0][0]
		If $x = $file[$i][6] Then
			chon($i)
			ExitLoop
		EndIf
	Next
	If $i <= $file[0][0] Then ContinueLoop
	If $import[0][0] > 0 Then
		For $i = 1 To $import[0][0]
			If $x = $import[$i][2] Then
				chon1($i)
				ExitLoop
			EndIf
		Next
		If $i <= $import[0][0] Then ContinueLoop
	EndIf
	If $resources[0][0] > 0 Then
		For $i = 1 To $resources[0][0]
			If $x = $resources[$i][3] Then
				chon2($i)
				ExitLoop
			EndIf
		Next
	EndIf
WEnd
Func even($msg)
	Switch $msg
		Case -3,$thoat
			Exit
		Case $open
			$sFile = FileOpenDialog("Choose file", "", "(*.exe; *.dll; *.scr; *.ocx; *.cpl; *.icl)| All files(*.*)", 1, "", $gui1)
			If Not @error Then
				openfile()
				Return 1
			EndIf
		Case $openfile1
			$sFile = 'D:\Users\BuiHuuTan\Desktop\testhead.exe'
			openfile()
			Return 1
		Case $openfile2
			$sFile = @WindowsDir & "\explorer.exe"
			openfile()
			Return 1
		Case $openfile3
			$sFile = @SystemDir & "\user32.dll"
			openfile()
			Return 1
		Case Else
	EndSwitch
	Return 0
EndFunc
Func chon($thutu)
	Local $x,$i,$z,$dem,$y,$dem1,$dem2,$dem3
	Switch $file[$thutu][0]
		Case 1
			Local $lade[14][2]
			Local $DOS_Header[14] = ["Signature","PartPag","PageCnt","ReloCnt","HdrSize","MinMem","MaxMem","ReloSS","ExeSP","ChkSum","ExeIP","ReloCS","TablOff","Overlay"]
			Local $lade1 = GUICtrlCreateLabel("DOS Header",200,5,480,17,1)
			For $i = 0 To 6
				$lade[$i][0] = GUICtrlCreateLabel($DOS_Header[$i],220,50 + $i*30,50,17)

				$lade[$i+7][0] = GUICtrlCreateLabel($DOS_Header[$i+7],480,50 + $i*30,50,17)

				$lade[$i][1] = GUICtrlCreateInput("",330,50 + $i*30,60,17,2050)
				GUICtrlSetbkColor(-1,0xFFFFFF)
				$lade[$i+7][1] = GUICtrlCreateInput("",590,50 + $i*30,60,17,2050)
				GUICtrlSetbkColor(-1,0xFFFFFF)
			Next

			GUICtrlSetData($lade[0][1],docbilary($file[$thutu][4],0,2))
			For $i = 1 To 13
				GUICtrlSetData($lade[$i][1],Hex(hexread($file[$thutu][4],$i*2,2),4))
			Next
			While 1
				If even(GUIGetMsg()) Then ExitLoop

				If GUICtrlRead($file[0][6]) <> $file[$thutu][6] Then
					ExitLoop
				EndIf
			WEnd
			GUICtrlDelete($lade1)
			For $i = 0 To 13
				GUICtrlDelete($lade[$i][0])
				GUICtrlDelete($lade[$i][1])
			Next
		Case 2
			Local $edit = GUICtrlCreateEdit("",200,0,480,279,3145728+2048)
			GUICtrlSetbkColor(-1,0xFFFFFF)
			GUICtrlSetFont(-1, 8,-1, 1, "Courier New")

			$dem3 = 1
			While 1
				If even(GUIGetMsg()) Then ExitLoop
				If GUICtrlRead($file[0][6]) <> $file[$thutu][6] Then ExitLoop

				If $i < $file[$thutu][3] Then
					$x = $i
					$dem = dichasmdos($file[$thutu][4],$i)
					If $dem <> "" Then
						$dem1 &= Hex($x,4) &" :   "& $dem & @CRLF
					Else
						$i = $file[$thutu][3]
					EndIf
				Else
					If $dem3 Then
						GUICtrlSetData($edit,$dem1)
						$dem3 = 0
					EndIf
				EndIf
			WEnd
			GUICtrlDelete($edit)
		Case 3
			Local $lade[18][2]
			Local $FE_Header[18][5] = 	[[	"Signature"				,0	,4], _
										[	"Machine"				,4	,2], _
										[	"EntryPoint"			,40	,4], _
										[	"ImageBase"				,52	,4], _
										[	"SizeOfImage"			,80	,4], _
										[	"BaseOfCode"			,44	,4], _
										[	"BaseOfData"			,48	,4], _
										[	"SectionAlignment"		,56	,4], _
										[	"FileAlignment"			,60	,4], _
										[	"Magic"					,24	,2], _
										[	"SubSytem"				,92	,2], _
										[	"NumberOfSections"		,6	,2], _
										[	"TimeDateStamp"			,8	,4], _
										[	"SizeOfHeaders"			,84	,4], _
										[	"Characteristics"		,22	,2], _
										[	"Checksum"				,88	,4], _
										[	"SizeOfOptionnalHeader"	,20	,2], _
										[	"NumOfRvaAndSizes"		,116,4]]

			Local $lade1 = GUICtrlCreateLabel("FE Header",200,5,480,17,1)
			For $i = 0 To 8
				$FE_Header[$i][3] = GUICtrlCreateLabel($FE_Header[$i][0],220,50 + $i*25,110,17)

				$FE_Header[$i+9][3] = GUICtrlCreateLabel($FE_Header[$i+9][0],450,50 + $i*25,115,17)
				If $i = 0 Then
					$FE_Header[$i][4] = GUICtrlCreateInput(docbilary($file[$thutu][4],0,4),370,50 + $i*25,60,17,2050)
				Else
					$FE_Header[$i][4] = GUICtrlCreateInput(Hex(hexread($file[$thutu][4],$FE_Header[$i][1],$FE_Header[$i][2]),$FE_Header[$i][2]*2),370,50 + $i*25,60,17,2050)
				EndIf
				GUICtrlSetbkColor(-1,0xFFFFFF)
				$FE_Header[$i+9][4] = GUICtrlCreateInput(Hex(hexread($file[$thutu][4],$FE_Header[$i+9][1],$FE_Header[$i+9][2]),$FE_Header[$i+9][2]*2),600,50 + $i*25,60,17,2050)
				GUICtrlSetbkColor(-1,0xFFFFFF)
			Next
			While 1
				If even(GUIGetMsg()) Then ExitLoop

				If GUICtrlRead($file[0][6]) <> $file[$thutu][6] Then
					ExitLoop
				EndIf
			WEnd
			GUICtrlDelete($lade1)
			For $i = 0 To 17
				GUICtrlDelete($FE_Header[$i][3])
				GUICtrlDelete($FE_Header[$i][4])
			Next
		Case 4
			Local $item[1][2] = [[0]],$ctrl[9]
			$ctrl[0] = GUICtrlCreateLabel("Optionnal Header",200,5,480,17,1)
			$ctrl[1] = GUICtrlCreateTreeView(200,53,170,227,1,131584)
			$ctrl[2] = GUICtrlCreateInput("",530,180,70,17,2050)
			GUICtrlSetbkColor(-1,0xFFFFFF)
			$ctrl[3] = GUICtrlCreateInput("",530,220,70,17,2050)
			GUICtrlSetbkColor(-1,0xFFFFFF)
			$ctrl[4] = GUICtrlCreateLabel("VA",430,180,50,17)
			$ctrl[5] = GUICtrlCreateLabel("Size",430,220,50,17)
			$ctrl[6] = GUICtrlCreateLabel("",370,80,310,17,1)
			$ctrl[7] = GUICtrlCreateLabel("RVA",430,140,50,17)
			$ctrl[8] = GUICtrlCreateInput("",530,140,70,17,2050)
			GUICtrlSetbkColor(-1,0xFFFFFF)

			For $i = 0 To 14
				If $opitionna[$i][0] Then
					$item[0][0] += 1
					ReDim $item[$item[0][0]+1][2]
					$item[$item[0][0]][0] = GUICtrlCreateTreeViewItem($opitionna[$i][6],$ctrl[1])
					$item[$item[0][0]][1] = $i
				EndIf
			Next

			$dem = 0
			While 1
				If even(GUIGetMsg()) Then ExitLoop
				$x = GUICtrlRead($ctrl[1])
				If $x <> $dem Then
					$dem = $x
					For $i = 1 To $item[0][0]
						If $item[$i][0] = $x Then
							GUICtrlSetData($ctrl[2],Hex($opitionna[$item[$i][1]][1],8))
							GUICtrlSetData($ctrl[3],Hex($opitionna[$item[$i][1]][2],8))
							$z = timadrren($opitionna[$item[$i][1]][1])
							GUICtrlSetData($ctrl[8],Hex($opitionna[$item[$i][1]][1]-$file[$z][2]+$file[$z][7],8))
							GUICtrlSetData($ctrl[6],$opitionna[$item[$i][1]][6])
						EndIf
					Next
				EndIf
				If GUICtrlRead($file[0][6]) <> $file[$thutu][6] Then
					ExitLoop
				EndIf
			WEnd

			For $i = 0 To 8
				GUICtrlDelete($ctrl[$i])
			Next
		Case 5
			Local $item[1][2] = [[0]],$ctrl[9]
			$ctrl[0] = GUICtrlCreateLabel("Sections",200,5,480,17,1)
			$ctrl[1] = GUICtrlCreateTreeView(200,53,170,227,1,131584)
			$ctrl[2] = GUICtrlCreateInput("",530,180,70,17,2050)
			GUICtrlSetbkColor(-1,0xFFFFFF)
			$ctrl[3] = GUICtrlCreateInput("",530,220,70,17,2050)
			GUICtrlSetbkColor(-1,0xFFFFFF)
			$ctrl[4] = GUICtrlCreateLabel("VA",430,180,50,17)
			$ctrl[5] = GUICtrlCreateLabel("Size",430,220,50,17)
			$ctrl[6] = GUICtrlCreateLabel("",370,80,310,17,1)
			$ctrl[7] = GUICtrlCreateLabel("RVA",430,140,50,17)
			$ctrl[8] = GUICtrlCreateInput("",530,140,70,17,2050)
			GUICtrlSetbkColor(-1,0xFFFFFF)

			For $i = 6 To $file[0][0]
				$item[0][0] += 1
				ReDim $item[$item[0][0]+1][2]
				$item[$item[0][0]][0] = GUICtrlCreateTreeViewItem($file[$i][1],$ctrl[1])
				$item[$item[0][0]][1] = $i
			Next

			$dem = 0
			While 1
				If even(GUIGetMsg()) Then ExitLoop
				$x = GUICtrlRead($ctrl[1])
				If $x <> $dem Then
					$dem = $x
					For $i = 1 To $item[0][0]
						If $item[$i][0] = $x Then
							GUICtrlSetData($ctrl[2],Hex($file[$i+5][2],8))
							GUICtrlSetData($ctrl[3],Hex($file[$i+5][3],8))
							GUICtrlSetData($ctrl[8],Hex($file[$i+5][7],8))
							GUICtrlSetData($ctrl[6],$file[$i+5][1])
						EndIf
					Next
				EndIf
				If GUICtrlRead($file[0][6]) <> $file[$thutu][6] Then
					ExitLoop
				EndIf
			WEnd

			For $i = 0 To 8
				GUICtrlDelete($ctrl[$i])
			Next
		Case 6
			Hexview($file[$thutu][4],$file[$thutu][3],$file[$thutu][8],$file[$thutu][9],$file[$thutu][6],$file[$thutu][2]+$imagebase)
		Case 7
			Local $edit = GUICtrlCreateEdit("Code asm 32",200,0,480,279,2048)
			GUICtrlSetbkColor(-1,0xFFFFFF)
			While 1
				If even(GUIGetMsg()) Then ExitLoop

				If GUICtrlRead($file[0][6]) <> $file[$thutu][6] Then
					ExitLoop
				EndIf
			WEnd
			GUICtrlDelete($edit)
	EndSwitch
EndFunc
Func chon1($thutu)
	Local $i
	Local $lade = GUICtrlCreateLabel($import[$thutu][1],200,20,480,17,1)
	Local $List = GUICtrlCreateList("", 200, 53, 480, 230)


	For $i = 3 To $import[$thutu][0]+2
		GUICtrlSetData($List,$import[$thutu][$i])
	Next

	While 1
		If even(GUIGetMsg()) Then ExitLoop
		If GUICtrlRead($file[0][6]) <> $import[$thutu][2] Then
			ExitLoop
		EndIf
	WEnd
	GUICtrlDelete($lade)
	GUICtrlDelete($List)
EndFunc
Func chon2($thutu)
	Local $item[14],$a=0,$b=0,$c=1,$i,$x,$y,$z=2,$luu[1][2]
	Local $hex,$hex1,$handef,$adrren,$dem,$kt[4],$button
	Local $namef = @TempDir&"\AutoitPro\"
	$item[0] = GUICtrlCreateTab(200,-2,482,283)
	$item[1] = GUICtrlCreateTabItem("TabSheet1")
	$item[2] = GUICtrlCreateTreeView( 200, 20, 200, 260,-1,131584)
	$item[4] = GUICtrlCreateInput("",530,200,70,17,2050)
	GUICtrlSetbkColor(-1,0xFFFFFF)
	$item[5] = GUICtrlCreateInput("",530,240,70,17,2050)
	GUICtrlSetbkColor(-1,0xFFFFFF)
	$item[6] = GUICtrlCreateLabel("VA",460,200,50,17)
	$item[7] = GUICtrlCreateLabel("Size",460,240,50,17)
	If $resources[$thutu][0] > 2147483647 Then
		$item[8] = GUICtrlCreateLabel($resources[$thutu][2],400,30,278,17,1)
	Else
		If $resources[$thutu][0] < 25 Then
			$item[8] = GUICtrlCreateLabel($aArrayTypes[$resources[$thutu][0]-1][0],400,30,278,17,1)
		Else
			$item[8] = GUICtrlCreateLabel($resources[$thutu][0],400,30,278,17,1)
		EndIf
	EndIf

	$item[10] = GUICtrlCreatePic("",0,0,0,0)
	GUICtrlSetState($item[10],32)
	$item[12] = GUICtrlCreateIcon("",-1,0,0)
	GUICtrlSetState($item[12],32)

	$item[3] = GUICtrlCreateTabItem("TabSheet2")
	$item[9] = GUICtrlCreatePic("",0,0,0,0)
	GUICtrlSetState($item[9],32)
	$item[11] = GUICtrlCreateIcon("",-1,0,0)
	GUICtrlSetState($item[11],32)
	$item[13] = GUICtrlCreateEdit("",200,20,480,260,2048+3145728)
	GUICtrlSetState($item[13],32)
	GUICtrlSetbkColor(-1,0xFFFFFF)
	GUICtrlCreateTabItem("")



	GUICtrlSetState($item[1],16)
	$luu[0][1] = $item[2]
	$luu[0][0] = $thutu
	$x = $resources[0][0]+1
	While 1
		If $z = $resources[$x][1]  Then
			For $y = $a To $b
				If $luu[$y][0] = $resources[$x][2] Then
					For $i = 1 To $resources[$x][0]
						$c += 1
						ReDim $luu[$c][2]
						$luu[$c-1][1] = GUICtrlCreateTreeViewItem($resources[$i+$x][2],$luu[$y][1])
						$luu[$c-1][0] = $i+$x
					Next
				EndIf
			Next
		Else
			If $z < $resources[$x][1] Then
				$a = $b +1
				$b = $c -1
				If $b = 0 Then ExitLoop
				$z += 1
				ContinueLoop
			EndIf
		EndIf
		$x += $resources[$x][0]+1
		If $x >= $resources[0][3] Then ExitLoop
	WEnd
	GUICtrlSetState($luu[0][1],16)

	$a = 0
	While 1
		If even(GUIGetMsg()) Then ExitLoop
		If GUICtrlRead($file[0][6]) <> $resources[$thutu][3] Then
			ExitLoop
		EndIf
		$x = GUICtrlRead($item[2])
		If $x = $a Then ContinueLoop
		$a = $x
		For $i = 0 To $c -1
			If $x = $luu[$i][1] Then
				If $resources[$luu[$i][0]][1] < 2147483648 Then
					GUICtrlSetData($item[4],Hex($resources[$luu[$i][0]][3]))
					GUICtrlSetData($item[5],Hex($resources[$luu[$i][0]][4]))
					Switch $resources[$thutu][0]
						Case 1
							While 1
								$msg = GUIGetMsg()
								Switch $msg
									Case Else
										If even($msg) Then
											ExitLoop 3
										EndIf
								EndSwitch
								If GUICtrlRead($item[2]) <> $luu[$i][1] Or GUICtrlRead($file[0][6]) <> $resources[$thutu][3] Then ExitLoop
							WEnd
						Case 2
							$button = GUICtrlCreateButton("Saver Bitmap",300,285,80,20)

							$dem = timadrren($resources[$luu[$i][0]][3])
							$hex = docbilary($file[$dem][4],$resources[$luu[$i][0]][3]-$file[$dem][2],$resources[$luu[$i][0]][4])

							$hex1 = hexread($hex,0,4,1)
							Switch $hex1
								Case 40
									$dem = hexread($hex,20,4,1)
									$kt[0] = hexread($hex,4,4,1)
									$kt[1] = hexread($hex,8,4,1)
									$kt[2] = hexread($hex,14,2,1)
									$kt[3] = 4
								Case 12
									$dem = 0
									$kt[0] = hexread($hex,4,2,1)
									$kt[1] = hexread($hex,6,2,1)
									$kt[2] = hexread($hex,10,2,1)
									$kt[3] = 3
								Case Else
									$kt[3] = 0
							EndSwitch

							If $kt[3] Then
								If $dem Then
									$dem = $resources[$luu[$i][0]][4]+14 - $dem
								Else
									If $kt[2] = 24 Then
										$dem = $hex1+14
									Else
										$dem = $resources[$luu[$i][0]][4]+14 - (4 * Floor(($kt[0]*$kt[2]+31)/32)*$kt[1])
										$kt[2] = 2^$kt[2]*$kt[3] + $hex1+14
										If $b - $dem -2 <= 0 Then $dem = $kt[2]
									EndIf
								EndIf
								$hex1 = "424D"&daohex($resources[$luu[$i][0]][4]+14)&"00000000"&daohex($dem)

								$handef = FileOpen($namef&"BitMap.bmp",26)
								FileWrite($handef,"0x"&$hex1&$hex)
								FileClose($handef)
								GUICtrlSetImage($item[9],$namef&"BitMap.bmp",-1)
								GUICtrlSetImage($item[10],$namef&"BitMap.bmp",-1)

								$dem = coanh($kt[0],$kt[1],479,257)
								GUICtrlSetPos($item[9],200+$dem[2],20+$dem[3],$dem[0],$dem[1])
								GUICtrlSetState($item[9],16)

								$dem = coanh($kt[0],$kt[1],279,140)
								GUICtrlSetPos($item[10],400+$dem[2],50 + $dem[3],$dem[0],$dem[1])
								GUICtrlSetState($item[10],16)
							EndIf

							While 1
								$msg = GUIGetMsg()
								Switch $msg
									Case $button
										$dem = FileSaveDialog("Saver","","Bitmap(*.bmp)",16,"Bitmap",$gui1)
										If Not @error Then
											If StringRight($kt[0],4) <> ".bmp" Then $dem &= ".bmp"
											FileCopy($namef&"BitMap.bmp",$kt[0],9)
										EndIf
									Case Else
										If even($msg) Then
											GUICtrlDelete($button)
											ExitLoop 3
										EndIf
								EndSwitch
								If GUICtrlRead($item[2]) <> $luu[$i][1] Or GUICtrlRead($file[0][6]) <> $resources[$thutu][3] Then ExitLoop
							WEnd
							GUICtrlDelete($button)

							GUICtrlSetState($item[10],32)
							GUICtrlSetImage($item[10],"")
							GUICtrlSetPos($item[10],0,0)

							GUICtrlSetState($item[9],32)
							GUICtrlSetImage($item[9],"")
							GUICtrlSetPos($item[9],0,0)
						Case 3
							$button = GUICtrlCreateButton("Saver Icon",300,285,80,20)

							$dem = timadrren($resources[$luu[$i][0]][3])
							$hex = docbilary($file[$dem][4],$resources[$luu[$i][0]][3]-$file[$dem][2],$resources[$luu[$i][0]][4])

							$hex1 = hexread($hex,0,4,1)
							$dem = 0
							$b = 0
							Switch $hex1
								Case 40
									$kt[0] = hexread($hex,4,4,1)
									$kt[1] = hexread($hex,8,4,1)
									$kt[2] = hexread($hex,12,2,1)
									$kt[3] = hexread($hex,14,2,1)
									$dem = hexread($hex,34,2,1)
								Case 12
									$kt[0] = hexread($hex,4,2,1)
									$kt[1] = hexread($hex,6,2,1)
									$kt[2] = hexread($hex,8,2,1)
									$kt[3] = hexread($hex,10,2,1)
								Case Else
									If StringLeft($hex,8) = "89504E47" Then
										For $kt[0] = 4 To $resources[$luu[$i][0]][4]-18
											If StringMid($hex,$kt[0]*2,2) = "49" And StringMid($hex,($kt[0]+1)*2+1,6) = "484452" Then
												$hex1 = StringMid($hex,($kt[0]+4)*2+1,26)
												$kt[0] = hexread($hex,0,4,1)
												$kt[1] = hexread($hex,4,4,1)
												$kt[2] = 0
												$kt[3] = hexread($hex,8,1,1)
												$b = 1
												ExitLoop
											EndIf
										Next
									EndIf
							EndSwitch

							$hex1 = "000001000100"&daohex($kt[0],1)&daohex($kt[1],1)&daohex($dem,1)&"00"&daohex($kt[2],2)&daohex($kt[3],2)&daohex($resources[$luu[$i][0]][4],4)&daohex(22,4)

							$handef = FileOpen($namef&"Icon.ico",26)
							FileWrite($handef,"0x"&$hex1&$hex)
							FileClose($handef)

							$kt[1] = $kt[0]

							$dem = coanh($kt[0],$kt[1],479,257)
							GUICtrlSetPos($item[11],200+$dem[2],20+$dem[3],$dem[0],$dem[1])
							GUICtrlSetImage($item[11],$namef&"Icon.ico")
							GUICtrlSetState($item[11],16)

							$dem = coanh($kt[0],$kt[1],279,140)
							GUICtrlSetPos($item[12],400+$dem[2],50 + $dem[3],$dem[0],$dem[1])
							GUICtrlSetImage($item[12],$namef&"Icon.ico")
							GUICtrlSetState($item[12],16)


							While 1
								$msg = GUIGetMsg()
								Switch $msg
									Case $button
										$dem = FileSaveDialog("Saver","","Icon(*.ico)",16,"Icon",$gui1)
										If Not @error Then
											If StringRight($dem,4) <> ".ico" Then $dem &= ".ico"
											FileCopy($namef&"Icon.ico",$dem,9)
										EndIf
									Case Else
										If even($msg) Then
											GUICtrlDelete($button)
											ExitLoop 3
										EndIf
								EndSwitch
								If GUICtrlRead($item[2]) <> $luu[$i][1] Or GUICtrlRead($file[0][6]) <> $resources[$thutu][3] Then ExitLoop
							WEnd
							GUICtrlDelete($button)
							GUICtrlSetState($item[11],32)
							GUICtrlSetState($item[12],32)

						Case 16
							Local $as,$aa,$ab,$af,$ax
							$dem = timadrren($resources[$luu[$i][0]][3])
							$hex = DllStructCreate("byte["&$resources[$luu[$i][0]][4]&"]",DllStructGetPtr($file[$dem][4])+$resources[$luu[$i][0]][3]-$file[$dem][2])
							$hex1 = @CRLF
							$hex1 &= "<"&DllStructGetData(DllStructCreate("wchar[15]",DllStructGetPtr($hex)+6),1)&">" & @CRLF
							$hex1 &= @CRLF
							$hex1 &= "      File Version: "&hexread($hex,50,2)&"."&hexread($hex,48,2)&"."&hexread($hex,54,2)&"."&hexread($hex,52,2)&@CRLF
							$hex1 &= "      Product Version: "&hexread($hex,58,2)&"."&hexread($hex,56,2)&"."&hexread($hex,62,2)&"."&hexread($hex,60,2)&@CRLF
							$hex1 &= "      File Os: "&hexread($hex,72)&@CRLF
							$hex1 &= "      File Type: "&hexread($hex,76)&@CRLF

							$kt[1] = 92
							While $kt[1] < hexread($hex,0,2)
								$kt[2] += 1
								If $kt[2] = 10 Then ExitLoop

								Switch DllStructGetData(DllStructCreate("wchar[14]",DllStructGetPtr($hex)+6+$kt[1]),1)
									Case "StringFileInfo"
										$hex1 &= "      <StringFileInfo>" & @CRLF
										$kt[0] = $kt[1] + 36

										$dem = DllStructGetData(DllStructCreate("wchar[8]",DllStructGetPtr($hex)+6+$kt[0]),1)
										$hex1 &= "          <"&$dem&">" & @CRLF

										$hex1 &= "              Language identifier: " &Number("0x" & StringLeft($dem, 4))& @CRLF
										$hex1 &= "              Code page: " &Number("0x" & StringRight($dem, 4))& @CRLF
										$hex1 &= @CRLF

										$kt[3] = $kt[0] + 24
										$y = 0
										While $y < hexread($hex,$kt[0],2) -24
											$b = hexread($hex,$kt[3]+$y,2)

											$dem = Mod($b, 4)
											If $dem Then $b += 4 - $dem

											$dem = DllStructGetData(DllStructCreate("wchar["&$b-6&"]",DllStructGetPtr($hex)+6+$kt[3]+$y),1)
											If StringLen($dem) < 21 Then
												$aa = DllStructCreate("byte[" & 20 - StringLen($dem) & "]")
												$as = StringReplace(BinaryToString(DllStructGetData($aa, 1)), Chr(0), Chr(32))
											Else
												$as = ""
											EndIf

											$hex1 &= "                  " & $dem & ": " & $as

											$ab = hexread($hex,$kt[3]+$y+2,2)
											$af = 4 - Mod(2 * StringLen($dem) + 6, 4)

											$ax = DllStructGetData(DllStructCreate("wchar["&$ab&"]",DllStructGetPtr($hex)+6+StringLen($dem)*2+$af+$kt[3]+$y),1)

											If Not $ax Then $ax =  ""

											$hex1 &= $ax & @CRLF

											$y += $b
										WEnd

										$hex1 &= @CRLF & "          </" & DllStructGetData(DllStructCreate("wchar[8]",DllStructGetPtr($hex)+6+$kt[0]),1) & ">"
										$hex1 &= @CRLF & "      </StringFileInfo>" & @CRLF

									Case "VarFileInfo"
										$hex1 &= @CRLF & "      <VarFileInfo>"

										$kt[0] = $kt[1] + 32

										$hex1 &= @CRLF & "          <" & DllStructGetData(DllStructCreate("wchar[13]",DllStructGetPtr($hex)+6+$kt[0]),1) & ">" & @CRLF

										$as = hexread($hex,$kt[0]+2,2)/2

										For $aa = 1 To $as
											$ab = hexread($hex,$kt[0]+32+$aa*2,2)
											If Mod($aa,2) Then
												$hex1 &= "              Language identifier: " & $ab & @CRLF
											Else
												$hex1 &= "              Code page: " & $ab & @CRLF
											EndIf
										Next

										$hex1 &= "          </" & DllStructGetData(DllStructCreate("wchar[13]",DllStructGetPtr($hex)+6+$kt[0]),1) & ">"
										$hex1 &= @CRLF & "      </VarFileInfo>" & @CRLF
								EndSwitch

								$kt[1] += hexread($hex,$kt[1],2)
								$dem  = Mod($kt[1]-92, 4)
								If $dem Then $kt[1] += 4 - $dem
							WEnd
							$hex1 &= @CRLF&"</"&DllStructGetData(DllStructCreate("wchar[15]",DllStructGetPtr($hex)+6),1)&">"

							GUICtrlSetData($item[13],$hex1)

							GUICtrlSetState($item[13],16)
							GUICtrlSetState($item[3],16)
							While 1
								$msg = GUIGetMsg()
								Switch $msg
									Case Else
										If even($msg) Then
											ExitLoop 3
										EndIf
								EndSwitch
								If GUICtrlRead($item[2]) <> $luu[$i][1] Or GUICtrlRead($file[0][6]) <> $resources[$thutu][3] Then ExitLoop
							WEnd
							GUICtrlSetState($item[13],32)
						Case Else
							While 1
								$msg = GUIGetMsg()
								Switch $msg
									Case Else
										If even($msg) Then
											ExitLoop 3
										EndIf
								EndSwitch
								If GUICtrlRead($item[2]) <> $luu[$i][1] Or GUICtrlRead($file[0][6]) <> $resources[$thutu][3] Then ExitLoop
							WEnd
					EndSwitch
				EndIf
				GUICtrlSetData($item[4],"")
				GUICtrlSetData($item[5],"")
				ExitLoop
			EndIf
		Next

	WEnd
	For $i = 0 To 13
		GUICtrlDelete($item[$i])
	Next
EndFunc
Func chon3()
	Local $i,$x,$dem,$dem1,$z,$y
	Local $lade = GUICtrlCreateLabel("Export ("&$Export[1]&")",200,15,480,17,1)
	If $Export[8] = "" Or $Export[8] = 0 Then
		$Export[8] = GUICtrlCreateList("", 200, 42, 480, 240,0x50310001)
	Else
		GUICtrlSetState($Export[8],16)
	EndIf

	$progress = GUICtrlCreateProgress(300,285,100,20)
	While $Export[7] <= $Export[0]-1
		GUICtrlSetData($progress,$Export[7]/$Export[0]*100)
		$dem = DllStructGetData($Export[4],1,$Export[7]+1)
		If $dem <> 0 Then
			$dem1 = ""
			For $x = 1 To $Export[3]
				If DllStructGetData($Export[6],1,$x) = $Export[7] Then
					$y = DllStructGetData($Export[5],1,$x)
					$z = timadrren($y)
					$dem1 = stringch($file[$z][4],$y - $file[$z][2])&" "
					ExitLoop
				EndIf
			Next
			GUICtrlSetData($Export[8],$dem1&"("&$Export[7]+$Export[2]&") ("&Hex($dem)&")")
		EndIf
		$Export[7] += 1
	WEnd
	GUICtrlDelete($progress)

	While 1
		If even(GUIGetMsg()) Then ExitLoop
		If GUICtrlRead($file[0][6]) <> $opitionna[0][4] Then ExitLoop
	WEnd
	GUICtrlDelete($lade)
	GUICtrlSetState($Export[8],32)
EndFunc
Func Hexview($hex,$size,ByRef $doan,ByRef $view,$even,$adrren=0)
	Local $x,$y,$dem,$dem1,$z,$i
	Local $lade = GUICtrlCreateLabel(" Offset     0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F   0123456789ABCDEF",200,0,550,15)
	GUICtrlSetFont(-1, 8,-1, 1, "Courier New")

	If $view = "" Or $view = 0 Then
		$view = GUICtrlCreateList("", 200, 12, 482,280,3145728)
		GUICtrlSetFont(-1, 8,-1, 1, "Courier New")
	Else
		GUICtrlSetState($view,16)
	EndIf
	$progress = GUICtrlCreateProgress(300,285,100,20)
	Do
		If even(GUIGetMsg()) Then
			GUICtrlDelete($lade)
			GUICtrlDelete($progress)
			Return
		EndIf
		If GUICtrlRead($file[0][6]) <> $even Then
			GUICtrlDelete($lade)
			GUICtrlSetState($view,32)
			GUICtrlDelete($progress)
			Return
		EndIf
		GUICtrlSetData($progress,$doan/$size*100)
		$y = $size - $doan
		If $y > 16 Then $y = 16
		If $y < 1 Then ExitLoop
		$dem = ""
		$x = ""
		For $i = 1 To $y
			$dem1 = DllStructGetData($hex,1,$i+$doan)
			If $dem1 = 0 Then
				$x &= "."
				$dem &= " 00"
			Else
				$dem &= " "&Hex($dem1,2)
				Switch $dem1
					Case 0 To 32,124,127 To 255
						$z = "."
					Case Else
						$z = Chr($dem1)
				EndSwitch
				$x &= $z
			EndIf
		Next
		If $y < 16 Then
			For $i = $y+1 To 16
				$x = "   "&$x
			Next
		EndIf
		GUICtrlSetData($view,Hex($doan+$adrren) & "  "&$dem&"  "&$x)
		$doan += 16
	Until $y < 16
	GUICtrlDelete($progress)

	While 1
		If even(GUIGetMsg()) Then ExitLoop
		If GUICtrlRead($file[0][6]) <> $even Then
			GUICtrlSetState($view,32)
			ExitLoop
		EndIf
	WEnd

	GUICtrlDelete($lade)
EndFunc
Func timfile($giatri)
	Local $a=0,$b=0,$c=1,$i,$x,$y,$z=2
	Local $fodel[1],$file[1] = [0]
	$fodel[0] = $giatri
	$x = $resources[0][0]+1
	While 1
		If $z = $resources[$x][1]  Then
			For $y = $a To $b
				If $fodel[$y] = $resources[$x][2] Then
					For $i = 1 To $resources[$x][0]
						If $resources[$i+$x][1] < 2147483648 Then
							$file[0] += 1
							ReDim $file[$file[0]+1]
							$file[$file[0]] = $i+$x
						Else
							$c += 1
							ReDim $fodel[$c]

							$fodel[$c-1] = $i+$x
						EndIf
					Next
				EndIf
			Next
		Else
			If $z < $resources[$x][1] Then
				$a = $b +1
				$b = $c -1
				If $b = 0 Then ExitLoop
				$z += 1
				ContinueLoop
			EndIf
		EndIf
		$x += $resources[$x][0]+1
		If $x >= $resources[0][3] Then ExitLoop
	WEnd
	Return $file
EndFunc
Func coanh($anhcao,$anhngang,$cao,$ngang)
	Local $dem,$ret[4]
	If $anhcao >= $anhngang Then
		$dem = $anhcao / $anhngang
		If $anhcao > $cao Then
			$anhcao = $cao
			$anhngang = $anhcao / $dem
		EndIf
		If $anhngang > $ngang Then
			$anhngang = $ngang
			$anhcao = $anhngang * $dem
		EndIf
		$ret[0] = $anhcao
		$ret[1] = $anhngang
		$ret[2] = ($cao - $anhcao) / 2
		$ret[3] = ($ngang - $anhngang) / 2
	Else
		$dem = coanh($anhngang,$anhcao,$ngang,$cao)
		$ret[0] = $dem[1]
		$ret[1] = $dem[0]
		$ret[2] = $dem[3]
		$ret[3] = $dem[2]
	EndIf
	Return $ret
EndFunc
Func Header()
	Local $i,$x,$z,$dem,$luu
	Local $sesion,$entrypoin
	$progress = GUICtrlCreateProgress(300,285,100,20)
	$sizefile = FileGetSize($sFile)

	$file[0][0] = 0
	$file[0][1] = 0
	nhap(1,"DOS Header",$file[0][1],0x1C)

	If docbilary($file[$file[0][0]][4],0,2) <> "4D5A" Then Return 1

	bo(0x3C)

	$dem = hexread(StringRight(FileRead($hFile,4),8),0,4,1)
	$file[0][1] += 4

	If $dem = 0 Then
		nhap(2,"DOS Stub",$file[0][1])
		Return
	EndIf

	nhap(2,"DOS Stub",$file[0][1],$dem-$file[0][1])

	nhap(3,"PE Header",$file[0][1],0x78)

	$imagebase = hexread($file[$file[0][0]][4],52)
	$sesion = hexread($file[$file[0][0]][4],6,2)

	If $sesion < 1 Then Return
	$entrypoin =hexread($file[$file[0][0]][4],0x28,2)

	nhap(4,"Optional Header",$file[0][1],0x80)

	nhap(5,"Sections - ("&$sesion&" Item )",$file[0][1],$sesion*0x28)

	$x = $file[0][0]
	For $i = 0 To $sesion-1
		$z = $i*0x28
		$dem = hexread($file[$x][4],$z+20,4)
		If $dem = 0 Then
			$luu = 0
		Else
			bo($dem)
			$luu = hexread($file[$x][4],$z+16,4)
		EndIf
		nhap(6,stringch($file[$x][4],$z,8),hexread($file[$x][4],$z+12,4),$luu,$x)
	Next
	FileClose($hFile)
	If $entrypoin > 0 Then
		$i = timadrren($entrypoin)
		If $i > 5 Then $file[$i][0] = 7
	EndIf

	For $i = 0 To 14
		GUICtrlSetData($progress,50+$i*(50/15))
		$z = $i*8
		$opitionna[$i][1] = hexread($file[$x-1][4],$z,4)
		If $opitionna[$i][1] = 0 Then
			$opitionna[$i][0] = 0
		Else
			$opitionna[$i][0] = 1
			$opitionna[$i][2] = hexread($file[$x-1][4],$z+4,4)
			$opitionna[$i][3] = timadrren($opitionna[$i][1])
			tainguyen($i)
		EndIf
	Next
	ReDim $opitionna[15][10]
	GUICtrlSetData($progress,100)
	GUICtrlDelete($progress)
EndFunc
Func hienview()
	Local $i
	For $i = 1 To $file[0][0]
		$file[$i][6] = GUICtrlCreateTreeViewItem($file[$i][1],$file[$file[$i][5]][6])
	Next
	If $file[0][0] > 3 Then
		For $i = 0 To 14
			If $opitionna[$i][0] = 1 Then
				$opitionna[$i][4] = GUICtrlCreateTreeViewItem($opitionna[$i][6]&$opitionna[$i][7],$file[4][6])
				If $opitionna[$i][3] <> 0 Then
					$opitionna[$i][5] = GUICtrlCreateTreeViewItem($opitionna[$i][6],$file[$opitionna[$i][3]][6])
				EndIf
			EndIf
		Next
		For $i = 1 To $import[0][0]
			$import[$i][2] = GUICtrlCreateTreeViewItem($import[$i][1]&" - "&$import[$i][0]&" Item",$opitionna[1][4])
		Next
		If $resources[0][0] > 0 Then
			For $i = 1 To $resources[0][0]
				If $resources[$i][0] > 2147483647 Then
					$resources[$i][3] = GUICtrlCreateTreeViewItem($resources[$i][2],$opitionna[2][4])
				Else
					If $resources[$i][0] < 25 Then
						$resources[$i][3] = GUICtrlCreateTreeViewItem($aArrayTypes[$resources[$i][0]-1][0],$opitionna[2][4])
					Else
						$resources[$i][3] = GUICtrlCreateTreeViewItem($resources[$i][0],$opitionna[2][4])
					EndIf
				EndIf
			Next
		EndIf
	EndIf
	$fileimage = GUICtrlCreateTreeViewItem("File Image",$file[0][6])
	GUICtrlSetState($file[0][6],16)
EndFunc
Func tainguyen($loai)
	Local $i,$x,$z,$y,$dem,$dem1
	Switch $loai
		Case 0
			If $opitionna[$loai][3] = 0 Then Return

			ReDim $Export[9]
			$dem = DllStructCreate("dword[7]",DllStructGetPtr($file[$opitionna[$loai][3]][4])+$opitionna[$loai][1]-$file[$opitionna[$loai][3]][2] + 12)
			$Export[0] = DllStructGetData($dem,1,3)
			$opitionna[$loai][7] = " - "&$Export[0]&" Item"
			If $Export[0] < 1 Then Return

			$dem1 = DllStructGetData($dem,1,1)
			$z = timadrren($dem1)
			$Export[1] = stringch($file[$z][4],$dem1-$file[$z][2])
			$Export[2] = DllStructGetData($dem,1,2)
			$Export[3] = DllStructGetData($dem,1,4)

			$dem1 = DllStructGetData($dem,1,5)
			$z = timadrren($dem1)
			$Export[4] = DllStructCreate("dword["& $Export[0] &"]",DllStructGetPtr($file[$z][4],1)+$dem1 - $file[$z][2])

			$dem1 = DllStructGetData($dem,1,6)
			$z = timadrren($dem1)
			$Export[5] = DllStructCreate("dword["& $Export[3] &"]",DllStructGetPtr($file[$z][4],1)+$dem1 - $file[$z][2])

			$dem1 = DllStructGetData($dem,1,7)
			$z = timadrren($dem1)
			$Export[6] = DllStructCreate("short["& $Export[3] &"]",DllStructGetPtr($file[$z][4],1)+$dem1 - $file[$z][2])
		Case 1
			If $opitionna[$loai][3] = 0 Then Return
			$dem = 0
			$i = 12+$opitionna[$loai][1]-$file[$opitionna[$loai][3]][2]
			While 1
				$dem1 = hexread($file[$opitionna[$loai][3]][4],$i,4)
				If $dem1 = 0 Then ExitLoop
				$import[0][0] += 1
				ReDim $import[$import[0][0]+1][$dem+3]
				$z = timadrren($dem1)
				$import[$import[0][0]][1] = stringch($file[$z][4],$dem1 - $file[$z][2])
				$dem1 = hexread($file[$z][4],$i+4,4)
				If $dem1 <> 0 Then
					$z = timadrren($dem1)
					$x = $dem1 - $file[$z][2]
					While 1
						$dem1 = hexread($file[$z][4],$x,4)
						If $dem1 = 0 Then ExitLoop
						$import[$import[0][0]][0] += 1
						If $import[$import[0][0]][0] > $dem Then $dem = $import[$import[0][0]][0]
						ReDim $import[$import[0][0]+1][$dem+3]
						If $dem1 > 2147483647 Then
							$import[$import[0][0]][$import[$import[0][0]][0]+2] = $dem1 - 2147483648
						Else
							$y = timadrren($dem1)
							If $y = 0 Then
								$import[$import[0][0]][$import[$import[0][0]][0]+2] = ""
							Else
								$import[$import[0][0]][$import[$import[0][0]][0]+2] = stringch($file[$y][4],$dem1 - $file[$y][2]+2)
							EndIf
						EndIf
						$x += 4
					WEnd
				EndIf
				$i += 20
			WEnd
		Case 2
			$resources[0][3] = 0
			$resources[0][1] = 0
			$dem = $opitionna[$loai][1] - $file[$opitionna[$loai][3]][2]
			$x = 0
			$dem1 = 0

			While 1
				$resources[0][3]+=1
				ReDim $resources[$resources[0][3]][5]
				$resources[$resources[0][3]-1][0] = hexread($file[$opitionna[$loai][3]][4], $x + $dem + 14,2)
				$resources[$resources[0][3]-1][0] += hexread($file[$opitionna[$loai][3]][4],$x + $dem + 12,2)
				$resources[$resources[0][3]-1][1] = $resources[$dem1][1] +1
				$resources[$resources[0][3]-1][2] = $y

				ReDim $resources[$resources[0][3]+$resources[$resources[0][3]-1][0]][5]
				For $i = 0 To $resources[$resources[0][3]-1][0]-1
					$resources[$i+$resources[0][3]][0] = hexread($file[$opitionna[$loai][3]][4],$x + $dem + 16 + $i*8,4)
					$resources[$i+$resources[0][3]][1] = hexread($file[$opitionna[$loai][3]][4],$x + $dem + 20 + $i*8,4)
					If $resources[$i+$resources[0][3]][0] > 2147483647 Then
						$resources[$i+$resources[0][3]][2] = unicode($opitionna[$loai][3],$dem+$resources[$i+$resources[0][3]][0]-2147483648)
					Else
						$resources[$i+$resources[0][3]][2] = $resources[$i+$resources[0][3]][0]
					EndIf
					If $resources[$i+$resources[0][3]][1] < 2147483648 Then
						$resources[$i+$resources[0][3]][3] = hexread($file[$opitionna[$loai][3]][4],$dem + $resources[$i+$resources[0][3]][1],4)
						$resources[$i+$resources[0][3]][4] = hexread($file[$opitionna[$loai][3]][4],$dem + $resources[$i+$resources[0][3]][1] + 4,4)
					EndIf
				Next
				$resources[0][3] += $resources[$resources[0][3]-1][0]

				While 1
					$y+= 1
					If $y = $dem1 + $resources[$dem1][0]+1 Then
						$dem1 += $resources[$dem1][0]+1
						If $dem1 = $resources[0][3] Then Return
					Else
						If $resources[$y][1] > 2147483647 Then
							$x = $resources[$y][1] - 2147483648
							ExitLoop
						EndIf
					EndIf
				WEnd
			WEnd
		Case Else

	EndSwitch
EndFunc
Func openfile()
	Local $i
	WinSetTitle($gui1,"","Autoit Pro - "&$sFile)
	GUICtrlDelete($file[0][6])
	$file[0][6] = GUICtrlCreateTreeView(0, 0, 200, 280,-1,131584)
	$hFile = FileOpen($sFile,16)

	For $i = 1 To $file[0][0]
		If $file[$i][9] <> "" Then GUICtrlDelete($file[$i][9])
	Next
	For $i =0 To 14
		If $opitionna[$i][9] <> "" Then GUICtrlDelete($opitionna[$i][9])
	Next
	If $Export[8] <> "" Then GUICtrlDelete($Export[8])
	ReDim $file[1][10]
	ReDim $Export[1]
	ReDim $Export[9]
	ReDim $import[1][2]
	ReDim $resources[1][5]
	ReDim $opitionna[15][8]
	$resources[0][0] = 0
	$Export[0] = 0
	$import[0][0] = 0

	Header()
	hienview()
EndFunc
Func nhap($loai,$name,$adrren,$size=0,$vew=0)
	If $size < 0 Then Return 1
	$file[0][0] += 1
	ReDim $file[$file[0][0]+1][10]
	$file[$file[0][0]][0] = $loai
	$file[$file[0][0]][1] = $name
	$file[$file[0][0]][2] = $adrren
	$file[$file[0][0]][3] = $size
	$file[$file[0][0]][4] = DllStructCreate ( "byte[" & $size & "]" )
	$file[$file[0][0]][5] = $vew
	$file[$file[0][0]][7] = $file[0][1]
	$file[0][1] += $size
	DllStructSetData($file[$file[0][0]][4], 1, FileRead($hFile,$size))
	GUICtrlSetData($progress,($file[0][1]/$sizefile)*100-50)
	If @error = -1 Then Return 2
	If @error > 0 Then Return 3
EndFunc
Func bo($a)
	Local $b
	If $a < $file[0][1] Then Return 1
	$b = $a - $file[0][1]
	FileRead($hFile,$b)
	If @error = -1 Then Return 2
	If @error > 0 Then Return 3
	$file[0][1] += $b
EndFunc
Func hexread($hex,$vt=0,$kt=4,$mode=0)
	Local $i,$ret,$a
	If $mode Then
		$hex = StringMid($hex,$vt*2+1,$kt * 2)
	Else
		Local $byte
		Switch $kt
			Case 1
				$byte = "byte"
			Case 2
				$byte = "ushort"
			Case 4
				$byte = "dword"
			Case 8
				$byte = "int64"
		EndSwitch
		If $byte <> "" Then
			Return DllStructGetData(DllStructCreate($byte,DllStructGetPtr($hex,1)+$vt),1)
		EndIf
		$hex = docbilary($hex,$vt,$kt)
	EndIf
	For $i= ($kt * 2 - 1) To 1 Step -2
		$ret &= StringMid($hex,$i,2)
	Next
	Return Number("0x"&$ret)
EndFunc
Func stringch($hex,$vt=0,$kt=0)
	Local $i = 1,$dem,$ret
	Do
		$dem = DllStructGetData($hex,1,$vt+$i)
		If $dem = 0 Then ExitLoop
		$ret &= ChrW($dem)
		$i += 1
	Until $i = $kt
	Return $ret
EndFunc
Func timadrren($adrren)
	Local $i
	For $i = 6 To $file[0][0]
		If $adrren >= $file[$i][2] And $adrren < ($file[$i][2]+$file[$i][3]) Then Return $i
	Next
EndFunc
Func unicode($thutu,$vt=0)
	Local $dem
	$dem =  hexread($file[$thutu][4],$vt,2)
	Return DllStructGetData(DllStructCreate("wchar["&$dem&"]",DllStructGetPtr($file[$thutu][4])+$vt+2),1)
EndFunc
Func daohex($hex,$kt=4)
	Local $ln[4] = [255,65535,16777215,4294967295]
	If $hex > $ln[$kt-1] Then $hex = 0
	Local $i,$z,$ret
	$z = Hex($hex,$kt*2)
	For $i = $kt*2-1 To 1 Step -2
		$ret &= StringMid($z,$i,2)
	Next
	Return $ret
EndFunc
Func docbilary($Pointer,$vitri=0,$soluong=1)
	Local $i
	$i = DllStructCreate("byte[" & $soluong & "]",DllStructGetPtr($Pointer,1)+$vitri)
	Return StringMid(DllStructGetData($i,1),3)
EndFunc
Func dichasmdos($Pointer,ByRef $vitri,$adrren=0)
	Local $dem,$asm,$thamso,$kttg,$chieu
	Local $i,$x,$z,$y

	$dem = hextobin(docbilary($Pointer,$vitri,1))
	$vitri += 1

	Switch StringLeft($dem,4)
		Case "0000"
			Switch StringMid($dem,5,2)
				Case "00"
					$asm = "ADD " & thamso($Pointer,$vitri,bintodec(StringMid($dem,8,1)),bintodec(StringMid($dem,7,1)),0)
				Case "01"
					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "ADD " & $thanhghi[0][0] &","& dectohex(hexread($Pointer,$vitri,1)) &"h"
							$vitri += 1
						Case "01"
							$asm = "ADD " & $thanhghi[1][0] &","& dectohex(hexread($Pointer,$vitri,2)) &"h"
							$vitri += 2
						Case "10"
							$asm = "PUSH ES"
						Case "11"
							$asm = "POP ES"
					EndSwitch
				Case "10"
					$asm = "OR " & thamso($Pointer,$vitri,bintodec(StringMid($dem,8,1)),bintodec(StringMid($dem,7,1)),0)
				Case "11"
					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "OR "& $thanhghi[0][0] &","& dectohex(hexread($Pointer,$vitri,1)) &"h"
							$vitri += 1
						Case "01"
							$asm = "OR "& $thanhghi[1][0] &","& dectohex(hexread($Pointer,$vitri,2)) &"h"
							$vitri += 2
						Case "10"
							$asm = "PUSH CS"
						Case "11"
							$asm = "EXT ???"
					EndSwitch
			EndSwitch
		Case "0001"
			Switch StringMid($dem,5,2)
				Case "00"
					$asm = "ADC " & thamso($Pointer,$vitri,bintodec(StringMid($dem,8,1)),bintodec(StringMid($dem,7,1)))
				Case "01"
					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "ADC " & $thanhghi[0][0] & dectohex(hexread($Pointer,$vitri,1))
							$vitri += 1
						Case "01"
							$asm = "ADC " & $thanhghi[1][0] & dectohex(hexread($Pointer,$vitri,2))
							$vitri += 2
						Case "10"
							$asm = "PUSH SS"
						Case "11"
							$asm = "POP SS"
					EndSwitch
				Case "10"
					$asm = "SBB " & thamso($Pointer,$vitri,bintodec(StringMid($dem,8,1)),bintodec(StringMid($dem,7,1)))
				Case "11"
					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "SBB " & $thanhghi[0][0] & dectohex(hexread($Pointer,$vitri,1))
							$vitri += 1
						Case "01"
							$asm = "SBB " & $thanhghi[1][0] & dectohex(hexread($Pointer,$vitri,2))
							$vitri += 2
						Case "10"
							$asm = "PUSH DS"
						Case "11"
							$asm = "POP DS"
					EndSwitch
			EndSwitch
		Case "0100"
			Switch StringMid($dem,5,1)
				Case "1"
					$asm = "DEC " & $thanhghi[1][bintodec(StringRight($dem,3))]
				Case "0"
					$asm = "INC " & $thanhghi[1][bintodec(StringRight($dem,3))]
			EndSwitch
		Case "0111"
			$i = docbilary($Pointer,$vitri,1)
			$vitri += 1
			$x = Number("0x"&$i)
			If $x > 0x79 Then $x = $x - 0xff-1

			Switch StringMid($dem,5,4)
				Case "0000"
					$asm = "JO"
				Case "0001"
					$asm = "JNO"
				Case "0010"
					$asm = "JB"
				Case "0011"
					$asm = "JNB"
				Case "0100"
					$asm = "JZ"
				Case "0101"
					$asm = "JNE"
				Case "0110"
					$asm = "JBE"
				Case "0111"
					$asm = "JNBE"
				Case "1000"
					$asm = "JS"
				Case "1001"
					$asm = "JNS"
				Case "1010"
					$asm = "JPE"
				Case "1011"
					$asm = "JPO"
				Case "1100"
					$asm = "JL"
				Case "1101"
					$asm = "JNL"
				Case "1110"
					$asm = "JLE"
				Case "1111"
					$asm = "JNLE"
			EndSwitch
			$asm &= " " & $i &"h  (" & Hex($x+$vitri+$adrren,4) &")"
		Case "1000"
			Switch StringMid($dem,5,2)
				Case "10"
					$asm = "MOV " & thamso($Pointer,$vitri,bintodec(StringMid($dem,8,1)),bintodec(StringMid($dem,7,1)))
				Case "11"
					Switch bintodec(StringMid($dem,8,1))
						Case "0"
							$asm = "MOV " & thamso($Pointer,$vitri,1,bintodec(StringMid($dem,7,1)),1)
						Case "1"
							$asm = "LEA " & thamso($Pointer,$vitri,1,1,0)
					EndSwitch
				Case "00"
					Switch StringMid($dem,7,2)
						Case "00"
							$i = hextobin(docbilary($Pointer,$vitri,1))
							$vitri += 1
							Switch StringMid($i,1,2)
								Case "11"
									If StringMid($dem,8,1) = "1" Then
										$asm = "SUB " & $thanhghi[1][bintodec(StringMid($i,6,3))] & "," & dectohex(hexread($Pointer,$vitri,2)) &"h"
										$vitri += 2
									Else
										$asm = "SUB " & $thanhghi[0][bintodec(StringMid($i,6,3))] & "," & dectohex(hexread($Pointer,$vitri,1)) &"h"
										$vitri += 1
									EndIf
								Case Else

							EndSwitch
						Case "11"
							$i = hextobin(docbilary($Pointer,$vitri,1))
							$vitri += 1
							Switch StringMid($i,3,3)
								Case "000"
									Switch StringMid($i,1,2)
										Case "11"
											$asm = "ADD " & $thanhghi[bintodec(StringMid($dem,8,1))][bintodec(StringMid($i,6,3))] &","
											If StringMid($dem,7,1) = "1" Then
												$asm &= dectohex(hexread($Pointer,$vitri,1)) &"h"
												$vitri += 1
											Else
												$asm &= dectohex(hexread($Pointer,$vitri,2)) &"h"
												$vitri += 2
											EndIf
										Case Else

									EndSwitch
								Case Else

							EndSwitch
						Case Else

					EndSwitch
				Case "01"

			EndSwitch
		Case "1010"
			Switch StringMid($dem,5,2)
				Case "00"
					Switch StringMid($dem,7,1)
						Case "1"
							$asm = "["& dectohex(hexread($Pointer,$vitri,2)) &"h]," & $thanhghi[bintodec(StringMid($dem,8,1))][0]
						Case "0"
							$asm =  $thanhghi[bintodec(StringMid($dem,8,1))][0] & ",["& dectohex(hexread($Pointer,$vitri,2)) &"h]"
					EndSwitch
					$vitri += 2
				Case "01"
					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "MOVSB"
						Case "01"
							$asm = "MOVSW"
						Case "10"
							$asm = "CMPSB"
						Case "11"
							$asm = "CMPSW"
					EndSwitch
				Case "10"
					Switch StringMid($dem,7,1)
						Case "0"
							$asm = "TEST " & $thanhghi[StringMid($dem,8,1)][0] &","&dectohex(hexread($Pointer,$vitri,1))&"h"
							$vitri += 1
						Case "1"
							Switch StringMid($dem,8,1)
								Case "0"
									$asm = "STOSB"
								Case "1"
									$asm = "STOSW"
							EndSwitch
					EndSwitch
				Case "11"
					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "LODSB"
						Case "01"
							$asm = "LODSW"
						Case "10"
							$asm = "SCASB"
						Case "11"
							$asm = "SCASB"
					EndSwitch
			EndSwitch
		Case "1011"
			$asm = "MOV "
			If StringMid($dem,5,1) = "1" Then
				$asm &= $thanhghi[1][bintodec(StringRight($dem,3))] & "," & dectohex(hexread($Pointer,$vitri,2)) & "h"
				$vitri += 2
			Else
				$asm &= $thanhghi[0][bintodec(StringRight($dem,3))] & "," & dectohex(hexread($Pointer,$vitri,1)) & "h"
				$vitri += 1
			EndIf
		Case "1100"
			Switch StringMid($dem,5)
				Case "0011"
					$asm = "RET"
				Case "1101"
					$asm = "INT " & dectohex(hexread($Pointer,$vitri,1)) & "h"
					$vitri += 1
				Case "0110"
					Switch docbilary($Pointer,$vitri,1)
						Case "04"
							$asm = "MOV [SI], " & hextobin(docbilary($Pointer,$vitri+1,1)) & "b"
							$vitri += 2
						Case "05"
							$asm = "MOV [DI], " & hextobin(docbilary($Pointer,$vitri+1,1)) & "b"
							$vitri += 2
						Case "06"
							$asm = "MOV [" & dectohex(hexread($Pointer,$vitri+1,2)) & "h], '" & Chr(hexread($Pointer,$vitri+3,1)) & "'"
							$vitri += 4
						Case Else

					EndSwitch
				Case Else

			EndSwitch
		Case "1101"
			Switch StringMid($dem,5,2)
				Case "00"
					$i = hextobin(docbilary($Pointer,$vitri,1))
					$vitri += 1
					Switch StringMid($dem,7,1)
						Case "0"
							$y = 1
							While hextobin(docbilary($Pointer,$vitri,2)) = $dem & $x
								$y += 1
								$vitri += 2
							WEnd
							$x = " " & $thanhghi[StringMid($dem,8,1)][bintodec(StringMid($i,6,3))] & ", "&$y
						Case "1"
							$x = " " & $thanhghi[StringMid($dem,8,1)][bintodec(StringMid($i,6,3))] & ", CL"
					EndSwitch
					Switch StringMid($i,3,3)
						Case "000"
							$asm = "ROL"
						Case "001"
							$asm = "ROR"
						Case "010"
							$asm = "RCL"
						Case "011"
							$asm = "RCR"
						Case "100"
							$asm = "SHL"
						Case "101"
							$asm = "SHR"
						Case "110"
							$asm = "SHL"
						Case "111"
							$asm = "SAR"
					EndSwitch
					$asm &= $x
				Case Else

			EndSwitch
		Case "1110"
			Switch StringMid($dem,5,2)
				Case "00"
					$i = docbilary($Pointer,$vitri,1)
					$vitri += 1
					$x = Number("0x"&$i)
					If $x > 0x79 Then $x = $x - 0xff
					$y = " " & $i &"h  (" & Hex($x+$vitri-1+$adrren,4) &")"

					Switch StringMid($dem,7,2)
						Case "00"
							$asm = "LOOPNE"
						Case "01"
							$asm = "LOOPE"
						Case "10"
							$asm = "LOOP"
						Case "11"
							$asm = "JCXZ"
					EndSwitch
					$asm &= $y
				Case "01"
					Switch StringMid($dem,7,1)
						Case "0"
							$asm = "IN " & $thanhghi[bintodec(StringMid($dem,8,1))][0] & "," & dectohex(hexread($Pointer,$vitri,1)) & "h"
						Case "1"
							$asm = "OUT " & dectohex(hexread($Pointer,$vitri,1)) & "h," & $thanhghi[bintodec(StringMid($dem,8,1))][0]
					EndSwitch
				Case "10"
					Switch StringMid($dem,7,2)
						Case "00"
							$i = docbilary($Pointer,$vitri,2)
							$vitri += 2
							$x = Number("0x"&$i)
							If $x > 0x79 Then $x = $x - 0xff
							$asm = "CALL " & $i &"h  (" & Hex($x+$vitri-1+$adrren,4) &")"
						Case "01"
							$i = docbilary($Pointer,$vitri,2)
							$vitri += 2
							$x = Number("0x"&$i)
							If $x > 0x79 Then $x = $x - 0xff
							$asm = "JMP " & $i &"h  (" & Hex($x+$vitri-1+$adrren,4) &")"
						Case "10"
							$asm = "JMP " & dectohex(hexread($Pointer,$vitri+2,2)) &"h:"& dectohex(hexread($Pointer,$vitri,2)) & "h"
							$vitri += 4
						Case "11"
							$i = docbilary($Pointer,$vitri,1)
							$vitri += 1
							$x = Number("0x"&$i)
							If $x > 0x79 Then $x = $x - 0xff
							$asm = "JMP " & $i &"h  (" & Hex($x+$vitri-1+$adrren,4) &")"
					EndSwitch
				Case "11"
					Switch StringMid($dem,7,1)
						Case "0"
							$asm = "IN " & $thanhghi[StringMid($dem,8,1)][0] & ",DX"
						Case "1"
							$asm = "OUT " & "DX," & $thanhghi[StringMid($dem,8,1)][0]
					EndSwitch
			EndSwitch
		Case "1111"
			Switch StringMid($dem,5,3)
				Case "011"
					$i = hextobin(docbilary($Pointer,$vitri,1))
					$vitri += 1
					Switch StringMid($i,3,3)
						Case "000"
							If StringMid($dem,8,1) = "1" Then
								$asm = "TEST " & $thanhghi[1][bintodec(StringMid($i,6,3))] & "," & dectohex(hexread($Pointer,$vitri,2)) &"h"
								$vitri += 2
							Else
								$asm = "TEST " & $thanhghi[0][bintodec(StringMid($i,6,3))] & "," & dectohex(hexread($Pointer,$vitri,1)) &"h"
								$vitri += 1
							EndIf
						Case Else

					EndSwitch
				Case Else

			EndSwitch
	EndSwitch

	Return $asm
EndFunc
Func thamso($Pointer,ByRef $vitri,$kttg,$chieu,$loai=0)
	Local $dem,$z,$rec

	$dem = hextobin(docbilary($Pointer,$vitri,1))
	$vitri += 1

	If $loai Then
		$rec = $thanhghi[3][bintodec(StringMid($dem,3,3))]
	Else
		$rec = $thanhghi[$kttg][bintodec(StringMid($dem,3,3))]
	EndIf
	$z = StringMid($dem,6,3)

	Switch StringLeft($dem,2)
		Case "00"
			$dem = $thanhghi[2][bintodec($z)]
			If $z = "110" Then
				$dem = "["&dectohex(hexread($Pointer,$vitri,2)) & "h]"
				$vitri += 2
			EndIf
		Case "01"
			$dem = "["&$thanhghi[2][bintodec($z)] & " + " & dectohex(hexread($Pointer,$vitri,1)) & "h]"
			$vitri += 1
		Case "10"
			$dem = "["&$thanhghi[2][bintodec($z)] & " + " & dectohex(hexread($Pointer,$vitri,2)) & "h]"
			$vitri += 2
		Case "11"
			$dem = $thanhghi[$kttg][bintodec($z)]
	EndSwitch

	If $chieu Then
		$dem = $rec&","&$dem
	Else
		$dem = $dem&","&$rec
	EndIf
	Return $dem
EndFunc
Func hextobin($hex)
	Local $i,$ret
	Local $bin[16] = ["0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111"]
	For $i = 1 To StringLen($hex)
		$ret &= $bin[Number("0x"&StringMid($hex,$i,1))]
	Next
	Return $ret
EndFunc
Func bintodec($bin)
	Local $i,$dec=0
	$len = StringLen($bin)
	For $i = 0 To $len -1
		If StringMid($bin,$len-$i,1) = "1" Then $dec += 2^$i
	Next
	Return $dec
EndFunc
Func dectohex($dec)
	Local $hex,$i,$ss = "0"
	If $dec < 0 Then $ss = "F"
	$hex = Hex($dec)
	For $i = 1 To 7
		If StringMid($hex,$i,1) <> $ss Or $i = 7 Then
			$hex = StringMid($hex,$i)
			ExitLoop
		EndIf
	Next
	If Number("0x"&StringLeft($hex,1)) > 9 Or $hex = "" Then $hex = $ss&$hex
	Return $hex
EndFunc

