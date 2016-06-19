Func _GiaiThua($n)
    Local $Struct = DllStructCreate("double GiaiThua"), $Temp
    If $n=1 Or IsInt($n)=0 Then
        $Temp = 1
    Else
        DllStructSetData($Struct, "GiaiThua", $n*_GiaiThua($n-1))
        $Temp = DllStructGetData($Struct, 1)
    EndIf
    Return $Temp
EndFunc