Func _DecToBin($dec)
    if (not IsInt($dec)) or ($dec < 0) Then return -1
    $bin = ""
    If $dec=0 Then Return "0"
    While $dec<>0
        $bin= BitAND ($dec, 1)&$bin
        $dec = BitShift ( $dec,1 )
    WEnd
    Return $bin
EndFunc

Func _BinToDec($bin)
     if (not IsString($bin))  Then return -1
     $end=StringLen($bin)
     $dec=0
     for $cpt=1 to $end
         $char=stringmid($bin,$end+1-$cpt,1)
         Select
         case $char="1"
            $dec=BitXOR($dec,bitshift(1,-($cpt-1)))
        Case $char="0"
        ; nothing
        Case Else
        ;error
            return -1
        EndSelect
    Next
    return $dec
EndFunc

Func _CharToBin($char)
    If (Not IsString($char)) Or (StringLen($char)<>1) Then Return -1
    $val=asc($char)
    Return _DecToBin($val)
EndFunc

Func _BinToChar($bin)
    If (Not IsString($bin)) Or (StringLen($bin)<1) Or (StringLen($bin)>8) Then Return -1
    $dec=_BinToDec($bin)
    if $dec<>-1 Then Return chr($dec)
    return -1
EndFunc

$bin=_DecToBin(125)
MsgBox(0,"bin",$bin)
$val=_BinToDec($bin)
MsgBox(0,"dec",$val)
$char="a"
$bin=_CharToBin($char)
MsgBox(0,"bin",$bin)
$char= _BinToChar($bin)
MsgBox(0,"char",$char)