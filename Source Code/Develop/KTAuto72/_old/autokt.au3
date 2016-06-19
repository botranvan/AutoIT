Global $LabelProgress[1][6] = [[0]]
Global $check[10],$input[10],$input1[10]
Global $data[1][70],$mang = 27,$hientotip = 0
Global $luu = 0,$i = 0,$x = 0,$chuyen = 0,$chuyen1 = 0, $time = @SEC, $dem = 100,$a =0

#Region ### START Koda GUI section ###
$Form1 = GUICreate("Auto Kiem Tien", 218, 425, 407, 159)
$ListView1 = GUICtrlCreateListView("Nhân vật        |Cấp|Đang", 0, 0, 220, 88)
$batdau = GUICtrlCreateButton("Bắt đầu",30,394,60,25)
$batdau1 = GUICtrlCreateButton("kiemtra",130,394,60,25)
$Tab1 = GUICtrlCreateTab(0, 88, 220, 300)

$TabSheet1 = GUICtrlCreateTabItem("Nhân vật") ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GUICtrlCreateLabel("Máu", 6, 117, 30, 17)
GUICtrlCreateLabel("Mana", 6, 137, 30, 17)
$mau = GUICtrlCreateLabelProgress("0/0", 60, 115, 140, 17,1,16711680,0xFFFFF)
$mana = GUICtrlCreateLabelProgress("0/0", 60, 135, 140, 17,1,6184703,0xFFFFF)
GUICtrlCreateLabel("Máu còn", 6, 168, 45, 17)
GUICtrlCreateLabel("Mana còn", 6, 193, 51, 17)
GUICtrlCreateLabel("%", 98, 167, 12, 17)
GUICtrlCreateLabel("%", 98, 192, 12, 17)
GUICtrlCreateLabel("ô", 140, 167, 18, 17)
GUICtrlCreateLabel("ô", 140, 192, 18, 17)
$input[0] = GUICtrlCreateInput("30", 70, 165, 25, 17)
$input[1] = GUICtrlCreateInput("20", 70, 190, 25, 17)
$input1[0] = GUICtrlCreateInput("F7", 150, 165, 30, 17)
GUICtrlSetLimit(-1, 2)
$input1[1] = GUICtrlCreateInput("F8", 150, 190, 30, 17)
GUICtrlSetLimit(-1, 2)
$check[0] = GUICtrlCreateCheckbox("",190, 165, 15, 17)
$check[1] = GUICtrlCreateCheckbox("",190, 190, 15, 17)
For $i = 1 To 6
	$check[$i+3] = GUICtrlCreateCheckbox("", 8, 204 + 24*$i, 13, 17)
	GUICtrlCreateLabel("Skill "&$i, 24, 206 + 24*$i, 55, 17)
	GUICtrlCreateLabel("ô", 90, 205 + 24*$i, 9, 17)
	GUICtrlCreateLabel("s", 180, 207 + 24*$i, 9, 17)
	$input1[$i+3] = GUICtrlCreateInput("F"&$i, 104, 204 + 24*$i, 25, 21)
	$input[$i+3] = GUICtrlCreateInput("1", 147, 204 + 24*$i, 30, 21)
Next
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

$TabSheet2 = GUICtrlCreateTabItem("Thú nuôi");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GUICtrlCreateLabel("Máu", 6, 117, 30, 17)
GUICtrlCreateLabel("Mana", 6, 137, 30, 17)
$maupet = GUICtrlCreateLabelProgress("0/0", 60, 115, 140, 17,1,16711680,0xFFFFF)
$manapet = GUICtrlCreateLabelProgress("0/0", 60, 135, 140, 17,1,6184703,0xFFFFF)
GUICtrlCreateLabel("Máu còn", 6, 168, 45, 17)
GUICtrlCreateLabel("Mana còn", 6, 193, 51, 17)
GUICtrlCreateLabel("%", 98, 167, 12, 17)
GUICtrlCreateLabel("%", 98, 192, 12, 17)
GUICtrlCreateLabel("ô", 140, 167, 18, 17)
GUICtrlCreateLabel("ô", 140, 192, 18, 17)
$input[2] = GUICtrlCreateInput("30", 70, 165, 25, 17)
$input[3] = GUICtrlCreateInput("20", 70, 190, 25, 17)
$input1[2] = GUICtrlCreateInput("F7", 150, 165, 30, 17)
GUICtrlSetLimit(-1, 2)
$input1[3] = GUICtrlCreateInput("F8", 150, 190, 30, 17)
GUICtrlSetLimit(-1, 2)
$check[2] = GUICtrlCreateCheckbox("",190, 165, 15, 17)
$check[3] = GUICtrlCreateCheckbox("",190, 190, 15, 17)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

$TabSheet3 = GUICtrlCreateTabItem("Khác");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$TOADONHANVAT = GUICtrlCreateGroup("Toạ độ hiện tại của nhân vật", 8, 120, 200, 120)
GUICtrlCreateLabel("Toạ độ X:", 24, 144, 74, 17)
GUICtrlCreateLabel("Toạ độ Y:", 24, 168, 74, 17)
GUICtrlCreateLabel("Bán kính",60, 192, 54, 17)
GUICtrlCreateLabel("Quanh điểm",37, 217, 74, 17)
$tam = GUICtrlCreateLabel("(0,0)",105, 217, 94, 17,1)
$toadox = GUICtrlCreateLabel("0", 112, 168, 74, 17)
$toadoy = GUICtrlCreateLabel("0", 112, 144, 74, 17)
$toadocheck = GUICtrlCreateCheckbox("", 20, 215, 15, 17)
$toador = GUICtrlCreateInput("50",120, 190, 34, 17)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

$TabSheet4 = GUICtrlCreateTabItem("Thông tin");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Opt("GUIOnEventMode", 1)
GUISetOnEvent(-3, "thoat")
GUICtrlSetOnEvent($batdau1, "inmang")
GUICtrlSetOnEvent($batdau, "batdau")
AdlibRegister("capnhat",300)



While 1
	If $dem > 50 Then
		$dem = 0
		timgame()
	EndIf
	docmem()
	auto()
	$chon = GUICtrlRead ($ListView1)
	If $chon <> 0 And $luu <> $chon Then
		$luu = $chon
		For $x = 1 To $data[0][0]
			If $chon = $data[$x][21] Then ExitLoop
		Next
		$chon = 1
		For $i = 0 To 9
			GUICtrlSetState($check[$i],$data[$x][$i+$mang])
			GUICtrlSetData($input[$i],$data[$x][$i+$mang+10])
			GUICtrlSetData($input1[$i],$data[$x][$i+$mang+20])
		Next
		GUICtrlSetState($toadocheck,$data[$x][22])
		If $data[$x][1] = 2 Then
			GUICtrlSetData($batdau,"Tạm dừng")
		Else
			GUICtrlSetData($batdau,"Bắt đầu")
		EndIf
	Else
		$chon = 0
		If Not $data[$x][1] > 0 Then
			For $x = 1 To $data[0][0]
				If $data[$x][1] > 0 Then
					$chon = 1
					ExitLoop
				EndIf
			Next
			If $x > $data[0][0] Then $x = 0
		Else
			$chon = 1
		EndIf
	EndIf
	If $chon Then
		$chuyen = 0
		GUICtrlsetdataLabelProgress($mau,$data[$x][7],$data[$x][11])
		GUICtrlsetdataLabelProgress($mana,$data[$x][8],$data[$x][12])
		GUICtrlSetData($toadox,$data[$x][17])
		GUICtrlSetData($toadoy,$data[$x][18])
		If $data[$x][16] = 1 Then
			$chuyen1 = 1
			GUICtrlsetdataLabelProgress($maupet,$data[$x][9],$data[$x][13])
			GUICtrlsetdataLabelProgress($manapet,$data[$x][10],$data[$x][14])
		Else
			If $chuyen1 = 1 Then
				GUICtrlsetdataLabelProgress($maupet,0,0)
				GUICtrlsetdataLabelProgress($manapet,0,0)
				$chuyen1 = 0
			EndIf
		EndIf
		For $i = 0 To 9
			$data[$x][$i+$mang] = GUICtrlRead($check[$i])
			$data[$x][$i+$mang+10] = GUICtrlRead($input[$i])
			$data[$x][$i+$mang+20] = GUICtrlRead($input1[$i])
		Next
		$a = GUICtrlRead($toadocheck)
		If $data[$x][22] <> $a Then
			$data[$x][22] = $a
			If $data[$x][22] = 1 And $data[$x][1] =2 Then
				$data[$x][24] = $data[$x][19]
				$data[$x][25] = $data[$x][20]
				GUICtrlSetData($tam,"("&$data[$x][24]&","&$data[$x][25]&")")
			Else
				GUICtrlSetData($tam,"(0,0)")
			EndIf
		EndIf
	Else
		If $chuyen = 0 Then
			GUICtrlsetdataLabelProgress($mau,0,0)
			GUICtrlsetdataLabelProgress($mana,0,0)
			GUICtrlsetdataLabelProgress($maupet,0,0)
			GUICtrlsetdataLabelProgress($manapet,0,0)
			GUICtrlSetData($toadox,0)
			GUICtrlSetData($toadoy,0)
			$chuyen = 1
		EndIf
	EndIf
	Sleep(10)
WEnd
Func batdau()
	Local $i
	If $data[$x][1] =1 Then
		If $data[$x][22] = 1 Then
			$data[$x][24] = $data[$x][19]
			$data[$x][25] = $data[$x][20]
			GUICtrlSetData($tam,"("&$data[$x][24]&","&$data[$x][25]&")")
		EndIf
		$data[$x][1] = 2
		guictrlsetdata($batdau,"Tạm dừng")
		For $i=4 To 10
			$data[$x][$i+$mang+30] = 9999
		Next
	Else
		If $data[$x][1] = 2 Then
			$data[$x][1] = 1
			guictrlsetdata($batdau,"Bắt đầu")
		EndIf
	EndIf
EndFunc
Func auto()
	Local $x,$i,$a,$b
	For $x = 1 to $data[0][0]
		If $data[$x][1] <> 2 Then ContinueLoop
		For $i = 0 To 4
			Switch $i
				Case 0,1
					If $data[$x][$i+$mang] = 1 And $data[$x][$i+$mang+10] > $data[$x][$i+7]/$data[$x][$i+11]*100 Then sengame($data[$x][$i+$mang+20])
				Case 2,3
					If $data[$x][16] = 1 And $data[$x][$i+$mang] = 1 And $data[$x][$i+$mang+10] > $data[$x][$i+7]/$data[$x][$i+11]*100 Then sengame($data[$x][$i+$mang+20])
				Case Else
					If $data[$x][15] = 1 Then
						$a = $data[$x][23]
						While 1
							$a += 1
							If $a > 10 Then $a = 4
							If $data[$x][$a+$mang] = 1 And $data[$x][$a+$mang+30] > $data[$x][$a+$mang+10] Then
								sengame($data[$x][$a+$mang+20])
								$data[$x][$a+$mang+30] = 0
								$data[$x][23] = $a
								ExitLoop
							Else
								ContinueLoop
							EndIf
							If $a = $data[$x][23] Then
								ExitLoop
							EndIf
						WEnd
					Else
						sengame("{`}")
					EndIf
			EndSwitch
		Next
		If $data[$x][22] = 1 Then
			$a = Abs($danhsach[$x][19] - $danhsach[$x][24])
			$b = Abs($danhsach[$x][20] - $danhsach[$x][25])
			If Sqrt($a*$a + $b*$b) > $danhsach[$x][22] Then

			EndIf
		EndIf
	Next
EndFunc
Func docmem()
	Local $x,$y
	For $x = 1 To $data[0][0]
		If WinWait($data[$x][2]) Then
			If _MEMORYREAD(0x9DD9F0,$data[$x][4]) = 1 Then
				$data[$x][5]  = _MEMORYREAD(0xA1E013, $data[$x][4],"char[24]")			;tên nhân vật
				$data[$x][6]  = _MEMORYREAD(0xA43AD4, $data[$x][4])						;LV nhân vật
				$data[$x][7]  = _MEMORYREAD(0xA43AC8, $data[$x][4])						;máu nhân vật
				$data[$x][8]  = _MEMORYREAD(0xBB0178, $data[$x][4])						;mana nhân vật
				$data[$x][9]  = _MEMORYREAD(0xA5EF4C, $data[$x][4])						;máu pet
				$data[$x][10] = _MEMORYREAD(0xA5F26C, $data[$x][4])						;mana pet
				$data[$x][11] = _MEMORYREAD(0xA43AE4, $data[$x][4])						;máu tối đa
				$data[$x][12] = _MEMORYREAD(0xBB017C, $data[$x][4])						;mana tối đa
				$data[$x][13] = _MEMORYREAD(0xA5EF50, $data[$x][4])						;max máu pet
				$data[$x][14] = _MEMORYREAD(0xA5F270, $data[$x][4])						;max mana pet
				$data[$x][15] = _MEMORYREAD(0xC2DA3C, $data[$x][4])						;chọn quai
				$data[$x][16] = _MEMORYREAD(0xA5E088, $data[$x][4])						;triệu pet
				$data[$x][17] = Floor(_MEMORYREAD(0xA43A80, $data[$x][4],"float"))		;Tọa độ x nhân vật
				$data[$x][18] = Floor(_MEMORYREAD(0xA43A84, $data[$x][4],"float"))		;Tọa độ y nhân vật
				$data[$x][19] = Floor(_MEMORYREAD(0xA3C064, $data[$x][4],"float"))		;Tọa độ x chuột
				$data[$x][20] = Floor(_MEMORYREAD(0xA3C068, $data[$x][4],"float"))		;Tọa độ y chuột
				If $data[$x][1] = 2 Then
					$y = "Auto"
				Else
					$y = "Nghỉ"
				EndIf
				If $data[$x][21] = 0 Then
					$data[$x][21] = GUICtrlCreateListViewItem($data[$x][5] &"|"&$data[$x][6]&"|"&$y,$ListView1)
				Else
					If GUICtrlRead($data[$x][21]) <> ($data[$x][5] &"|"&$data[$x][6]&"|"&$y) Then
						GUICtrlSetData($data[$x][21],$data[$x][5] &"|"&$data[$x][6]&"|"&$y)
					EndIf
				EndIf

				If $data[$x][1] < 1 Then
					$data[$x][1] = 1
					$data[$x][23] = 4
					For $i = 0 To 9
						$data[$x][$i+$mang] = GUICtrlRead($check[$i])
						$data[$x][$i+$mang+10] = GUICtrlRead($input[$i])
						$data[$x][$i+$mang+20] = GUICtrlRead($input1[$i])
					Next
					$data[$x][22] = GUICtrlRead($toadocheck)
				EndIf
			Else
				$data[$x][1] = 0
				If $data[$x][21] <> 0 Then GUIDelete($data[$x][21])
			EndIf
		Else
			$data[$x][1] = -1
			If $data[$x][21] <> 0 Then GUIDelete($data[$x][21])
		EndIf
	Next
EndFunc
Func capnhat()
	Local $x ,$y
	If $time <> @SEC Then
		$time = @SEC
		$dem +=1
		For $x = 1 To $data[0][0]
			If $data[$x][1] = 2 Then
				For $y = 1 To 6
					If $data[$x][$y+$mang+4] = 1 Then
						$data[$x][$y+$mang+4+30] += 1
					EndIf
				Next
			EndIf
		Next
	EndIf
EndFunc
Func timgame()
	Local $hande = WinList("Kiem TienOnline")
	Local $x,$y,$z,$kt

	If $hande[0][0] >0 Then
		For $x =1 To $hande[0][0]
			$kt = 0
			For $z = 1 To $data[0][0]
				If $data[$z][1] <> -1 And $data[$z][2] = $hande[$x][1] Then
					$kt = 1
					ExitLoop
				EndIf
			Next
			If $kt = 0 Then
				For $z = 1 To $data[0][0]
					If $data[$z][1] = -1 Then
						$data[$z][2] = $hande[$x][1]
						$data[$z][3] = WinGetProcess($hande[$x][1])
						$data[$z][4] = _MEMORYOPEN($data[$x][3])
						$data[$z][1] = 0
						$kt = 1
					EndIf
				Next
				If $data[0][7] = 0 Then
					$data[0][0] += 1
					ReDim $data[$data[0][0]+1][70]
					$data[$data[0][0]][2] = $hande[$x][1]
					$data[$data[0][0]][3] = WinGetProcess($hande[$x][1])
					$data[$data[0][0]][4] = _MEMORYOPEN($data[$x][3])
					$data[$data[0][0]][1] = 0
					$kt = 0
				EndIf
			EndIf
		Next
	EndIf
EndFunc
Func sengame($key)
	Local $12
	Switch $key
		Case "`","{`}"
			$12 = "{`}"
		Case "1"
			$12 = "1"
		Case "2"
			$12 = "2"
		Case "3"
			$12 = "3"
		Case "4"
			$12 = "4"
		Case "5"
			$12 = "5"
		Case "6"
			$12 = "6"
		Case Else
			Switch $key
				Case "F1","{F1}"
					$12 = "{F1}"
				Case "F2","{F2}"
					$12 = "{F2}"
				Case "F3","{F3}"
					$12 = "{F3}"
				Case "F4","{F4}"
					$12 = "{F4}"
				Case "F5","{F5}"
					$12 = "{F5}"
				Case "F6","{F6}"
					$12 = "{F6}"
				Case "F7","{F7}"
					$12 = "{F7}"
				Case "F8","{F8}"
					$12 = "{F8}"
				Case Else
					Return
			EndSwitch
	EndSwitch
	ControlSend($data[$x][2],"","",$12)
EndFunc
Func GUICtrlCreateLabelProgress($text,$left,$top,$width,$height,$stile="",$Color="",$color1= -1)
	$LabelProgress[0][0] += 1
	ReDim $LabelProgress[$LabelProgress[0][0]+1][6]
	If $color1 >= 0 Then
		GUICtrlCreateLabel("",$left,$top,$width,$height,$stile)
		GUICtrlSetBkColor(-1,$color1)
	EndIf
	$LabelProgress[$LabelProgress[0][0]][0]= GUICtrlCreateLabel("",$left,$top,$width,$height,$stile)
	$LabelProgress[$LabelProgress[0][0]][1] = GUICtrlCreateLabel($text,$left,$top,$width,$height,$stile)
	$LabelProgress[$LabelProgress[0][0]][2] = $left
	$LabelProgress[$LabelProgress[0][0]][3] = $top
	$LabelProgress[$LabelProgress[0][0]][4] = $width
	$LabelProgress[$LabelProgress[0][0]][5] = $height
	GUICtrlSetBkColor($LabelProgress[$LabelProgress[0][0]][0], $Color)
	Return $LabelProgress[0][0]
EndFunc
Func GUICtrlsetdataLabelProgress($contro,$min="",$max="")
	Local $x=1,$y=1
	If $min >= $max Then
		$x = $LabelProgress[$contro][4]
	Else
		$x = $LabelProgress[$contro][4]*$min/$max
		If $x = 0 Then $x = 1
	EndIf
	GUICtrlSetPos($LabelProgress[$contro][0],$LabelProgress[$contro][2],$LabelProgress[$contro][3],$x, $LabelProgress[$contro][5])
	GUICtrlSetData($LabelProgress[$contro][1],$min&"/"&$max)
EndFunc
Func _MEMORYOPEN($IV_PID, $IV_DESIREDACCESS = 2035711, $IV_INHERITHANDLE = 1)
	Local $AH_HANDLE[2] = [DllOpen("kernel32.dll")]
	Local $AV_OPENPROCESS = DllCall($AH_HANDLE[0], "int", "OpenProcess", "int", $IV_DESIREDACCESS, "int", $IV_INHERITHANDLE, "int", $IV_PID)
	If @error Then
		DllClose($AH_HANDLE[0])
		SetError(3)
		Return 0
	EndIf
	$AH_HANDLE[1] = $AV_OPENPROCESS[0]
	Return $AH_HANDLE
EndFunc
Func _MEMORYREAD($IV_ADDRESS, $AH_HANDLE, $SV_TYPE = "dword")
	Local $V_BUFFER = DllStructCreate($SV_TYPE)
	If @error Then
		SetError(@error + 1)
		Return 0
	EndIf
	DllCall($AH_HANDLE[0], "int", "ReadProcessMemory", "int", $AH_HANDLE[1], "int", $IV_ADDRESS, "ptr", DllStructGetPtr($V_BUFFER), "int", DllStructGetSize($V_BUFFER), "int", "")
	If Not @error Then
		Local $V_VALUE = DllStructGetData($V_BUFFER, 1)
		Return $V_VALUE
	EndIf
EndFunc
Func _MemoryWrite($iv_Address, $ah_Handle, $v_Data, $sv_Type = 'dword')
	Local $v_Buffer = DllStructCreate($sv_Type)
	If @Error Then
		SetError(@Error + 1)
		Return 0
	Else
		DllStructSetData($v_Buffer, 1, $v_Data)
		If @Error Then
			SetError(6)
			Return 0
		EndIf
	EndIf
	DllCall($ah_Handle[0], 'int', 'WriteProcessMemory', 'int', $ah_Handle[1], 'int', $iv_Address, 'ptr', DllStructGetPtr($v_Buffer), 'int', DllStructGetSize($v_Buffer), 'int', '')
	If Not @Error Then
		Return 1
	Else
		SetError(7)
        Return 0
	EndIf
EndFunc
Func _MemoryClose($ah_Handle)
	DllCall($ah_Handle[0], 'int', 'CloseHandle', 'int', $ah_Handle[1])
	If Not @Error Then
		DllClose($ah_Handle[0])
		Return 1
	Else
		DllClose($ah_Handle[0])
		SetError(2)
        Return 0
	EndIf
EndFunc
Func thoat()
	Local $x
	For $x = 1 To $data[0][0]
		If $data[$x][1] <> -1 Then
			_MemoryClose($data[$x][4])
		EndIf
	Next
	Exit
EndFunc


Func inmang()
	If $hientotip = 0 Then
		$hientotip = 1
		Local $i,$x,$mang1[1],$b= 0,$luu
		ReDim $mang1[$data[0][0]]
		For $i =  0 To 69
			$b = 0
			For $x = 1 To $data[0][0]
				$a = StringLen($data[$x][$i])
				If $b < $a Then $b = $a
			Next
			For $x = 1 To $data[0][0]
				$mang1[$x-1] &="|"&$data[$x][$i]
				For $a = StringLen($data[$x][$i])+1 To $b
					$mang1[$x-1] &= "  "
				Next
			Next
		Next
		For $x = 1 To $data[0][0]
			$luu &= $mang1[$x-1]&@CRLF
		Next
		ToolTip($luu,0,0)
	Else
		$hientotip = 0
		ToolTip("")
	EndIf
EndFunc
