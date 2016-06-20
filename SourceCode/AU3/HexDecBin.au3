#include <String.au3>
#include <GUIConstants.au3>

$Form1 = GUICreate("Converter @ Dec - Bin - Hex", 833, 247, 161, 166)

$radio1 = GUICtrlCreateRadio ("Dec", 100, 10, 60, 20)
$radio2 = GUICtrlCreateRadio ("Hex", 160, 10, 60, 20)
$radio3 = GUICtrlCreateRadio ("Bin", 220, 10, 60, 20)
;GUICtrlSetState ($radio1, $GUI_CHECKED)

$label = GUICtrlCreateLabel("Input", 10, 40, 50, 25)
$Input1 = GUICtrlCreateInput("", 100, 40, 650, 21)
$Label1 = GUICtrlCreateLabel("Hexadecimal", 10, 80, 70, 25)
$Label1out = GUICtrlCreateLabel("0", 100, 80, 600, 25)
$Label2 = GUICtrlCreateLabel("Binary", 10, 115, 50, 25)
$Label2out = GUICtrlCreateLabel("0", 100, 115, 600, 25)
GUISetState(@SW_SHOW)


While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $radio1 And BitAND(GUICtrlRead($radio1), $GUI_CHECKED) = $GUI_CHECKED
           
            GUICtrlSetData($Label1out,_DecimalToHex(GUICtrlRead($Input1,1)))
            GUICtrlSetData($Label1,"Hexadecimal")
            GUICtrlSetData($Label2out,_DecToBinary(GUICtrlRead($Input1,1)))
            GUICtrlSetData($Label2,"Binary")
                ;ConsoleWrite("_DecimalToHex " & _DecimalToHex(GUICtrlRead($Input1,1)) & @LF)
                ;ConsoleWrite("_DecToBinary " & _DecToBinary(GUICtrlRead($Input1,1)) & @CRLF)
        
        Case $msg = $radio2 And BitAND(GUICtrlRead($radio2), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($Label1out,_HexToDecimal(GUICtrlRead($Input1,1)))
            GUICtrlSetData($Label1,"Decimal")
            GUICtrlSetData($Label2out,_HexToBinaryString(GUICtrlRead($Input1,1)))
            GUICtrlSetData($Label2,"Binary")
                ;ConsoleWrite("_HexToDecimal " & _HexToDecimal(GUICtrlRead($Input1,1)) & @LF)
                ;ConsoleWrite("_HexToBinaryString " & _HexToBinaryString(GUICtrlRead($Input1,1)) & @LF)
                
        Case $msg = $radio3 And BitAND(GUICtrlRead($radio3), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($Label1out,_BinaryToHexString(GUICtrlRead($Input1,1)))
            GUICtrlSetData($Label1,"Hexadecimal")
            GUICtrlSetData($Label2out,_BinaryToDec(GUICtrlRead($Input1,1)))
            GUICtrlSetData($Label2,"Decimal")
                ;ConsoleWrite("_BinaryToHexString " & _BinaryToDec(GUICtrlRead($Input1,1)) & @LF)
                ;ConsoleWrite("_HexToBinaryString " & _HexToBinaryString(GUICtrlRead($Input1,1)) & @LF)  
                
    EndSelect
WEnd

; Conversion Code - Chart  
; DECIMAL 0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16
; HEX     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F    10
; BINARY 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111  10000 


; --------------------- Functions -----------------------------
; Binary to Decimal
Func _BinaryToDec($strBin)
Local $Return
Local $lngResult
Local $intIndex

If StringRegExp($strBin,'[0-1]') then
$lngResult = 0
  For $intIndex = StringLen($strBin) to 1 step -1
    $strDigit = StringMid($strBin, $intIndex, 1)
    Select 
      case $strDigit="0"
        ; do nothing
      case $strDigit="1"
        $lngResult = $lngResult + (2 ^ (StringLen($strBin)-$intIndex))
      case else
        ; invalid binary digit, so the whole thing is invalid
        $lngResult = 0
        $intIndex = 0 ; stop the loop
    EndSelect
  Next

  $Return = $lngResult
    Return $Return
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc
 
; Decimal To Binary
Func _DecToBinary($iDec)
Local $i, $sBinChar = ""

If StringRegExp($iDec,'[[:digit:]]') then
$i = 1

Do
 $x = 16^$i
 $i +=1 
 ; Determine the Octects
Until $iDec < $x
 
For $n = 4*($i-1) To 1 Step -1
    If BitAND(2 ^ ($n-1), $iDec) Then
        $sBinChar &= "1"
    Else
        $sBinChar &= "0"
    EndIf
Next
 Return $sBinChar
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc


; Hex to Decimal Conversion 
Func _HexToDecimal($Input)
Local $Temp, $i, $Pos, $Ret, $Output

If StringRegExp($input,'[[:xdigit:]]') then
$Temp = StringSplit($Input,"")

For $i = 1 to $Temp[0]
    $Pos = $Temp[0] - $i
    $Ret =  Dec (Hex ("0x" & $temp[$i] )) * 16 ^ $Pos
    $Output = $Output + $Ret
Next
    return $Output
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc

; Decimal To Hex Conversion
Func _DecimalToHex($Input)
local $Output, $Ret

If StringRegExp($input,'[[:digit:]]') then
Do
    $Ret = Int(mod($Input,16))
    $Input = $Input/16
    $Output = $Output & StringRight(Hex($Ret),1)
Until Int(mod($Ret,16))= 0

    Return StringMid(_StringReverse($Output),2)
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc


; Binary To Hex
Func _BinaryToHexString($BinaryValue)
    Local $test, $Result = '',$numbytes,$nb

If StringRegExp($BinaryValue,'[0-1]') then
    
    if $BinaryValue = '' Then
        SetError(-2)
        Return
    endif

    Local $bits = "0000|0001|0010|0011|0100|0101|0110|0111|1000|1001|1010|1011|1100|1101|1110|1111"
    $bits = stringsplit($bits,'|')
    #region check string is binary

    $test = stringreplace($BinaryValue,'1','')
    $test = stringreplace($test,'0','')
    if $test <> '' Then
        SetError(-1);non binary character detected
        Return
    endif
    #endregion check string is binary

    #region make binary string an integral multiple of 4 characters
    While 1
        $nb = Mod(StringLen($BinaryValue),4)
        if $nb = 0 then exitloop
        $BinaryValue = '0' & $BinaryValue
    WEnd
    #endregion make binary string an integral multiple of 4 characters

    $numbytes = Int(StringLen($BinaryValue)/4);the number of bytes

    Dim $bytes[$numbytes],$Deci[$numbytes]
    For $j = 0 to $numbytes - 1;for each byte
    ;extract the next byte
        $bytes[$j] = StringMid($BinaryValue,1+4*$j,4)

    ;find what the dec value of the byte is
        for $k = 0 to 15;for all the 16 possible hex values
            if $bytes[$j] = $bits[$k+1] Then
                $Deci[$j] = $k
                ExitLoop
            EndIf
        next
    Next
    
;now we have the decimal value for each byte, so stitch the string together again
    $Result = ''
    for $l = 0 to $numbytes - 1
        $Result &= Hex($Deci[$l],1)
    Next
    return $Result
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc


; Hex To Binary
Func _HexToBinaryString($HexValue)
    Local $Allowed = '0123456789ABCDEF'
    Local $Test,$n
    Local $Result = ''
    if $hexValue = '' then
        SetError(-2)
        Return
    EndIf

    $hexvalue = StringSplit($hexvalue,'')
    for $n = 1 to $hexValue[0]
        if not StringInStr($Allowed,$hexvalue[$n]) Then
            SetError(-1)
            return 0
        EndIf
    Next

    Local $bits = "0000|0001|0010|0011|0100|0101|0110|0111|1000|1001|1010|1011|1100|1101|1110|1111"
    $bits = stringsplit($bits,'|')
    for $n = 1 to $hexvalue[0]
        $Result &=  $bits[Dec($hexvalue[$n])+1]
    Next

    Return $Result

EndFunc