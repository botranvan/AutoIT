Global $thanhghi[4][8] =	[[	"AL","CL","DL","BL","AH","CH","DH","BH"	], _
							[	"AX","CX","DX","BX","SP","BP","SI","DI"	], _
							["BX + SI","BX + DI","BP + SI","BP + DI","SI","DI","BP","BX"], _
							["ES","","","DS","","","",""]]
Global $file,$data,$gioihan
Global $vitri,$dem,$adren
Global $code,$hien

$Form1 = GUICreate("Form1", 515, 339, 412, 177)
Global $menu = GUICtrlCreateMenu ("File")
$Edit1 = GUICtrlCreateEdit("", 0, 0, 513, 317,3145728+2048)
GUICtrlSetbkColor(-1,0xFFFFFF)
GUICtrlSetFont(-1, 9,-1, 1, "Courier New")
Global $open = GUICtrlCreateMenuItem("Open File",$menu)
GUICtrlSetData(-1, "Edit1")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case -3
			Exit
		Case $open
			$file = FileOpenDialog("Choose file", "", "(*.com)| All files(*.*)", 1, "", $Form1)
			If Not @error Then
				$gioihan = FileGetSize($file)
				$file = FileOpen($file,16)
				$data = DllStructCreate("byte["& $gioihan &"]")
				DllStructSetData($data,1,FileRead($file))
				FileClose($file)
				$vitri = 0
				$code = ""
				$hien = 1
			EndIf
	EndSwitch
	If $vitri < $gioihan Then
		$adren = $vitri
		$dem = dichasmdos($data,$vitri)
		If $dem <> "" Then
			$code &= Hex($adren,4) &" :  "& $dem & @CRLF
		Else
			$vitri = $gioihan
		EndIf
	Else
		If $hien Then
			GUICtrlSetData($Edit1,$code)
			$hien = 0
		EndIf
	EndIf
WEnd




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
Func thamso($soluong,$Pointer,ByRef $vitri,$kttg,$chieu,$loai=0)
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
Func docbilary($Pointer,$vitri=0,$soluong=1)
	Local $i
	$i = DllStructCreate("byte[" & $soluong & "]",DllStructGetPtr($Pointer,1)+$vitri)
	Return StringMid(DllStructGetData($i,1),3)
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