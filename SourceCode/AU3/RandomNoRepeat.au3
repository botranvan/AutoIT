; yahoo liên hệ : boyshocktimgirlhot1994
;~ _RandomList từ min đến max
;~ 		+ Min : giới hạn nhỏ nhất
;~ 		+ Max : giới hạn lớn nhất
;		+ Flag : nếu = 1 thì integer ngựoc lại nếu bằng 0 thì floating
;	Return 
;		@error = 1 khi max nhỏ hơn $min
Func _RandomList($Min,$Max)
	Local $CheckNumber[$Max+1]
	Local $ListNumber
	If $Max < $Min Then Return SetError(1) 
	for $i = $Min To $Max Step +1
		while 1
			$Random = Random($Min,$Max,1)
			If $CheckNumber[$Random] = 0 Then
				$CheckNumber[$Random] = 1
				$ListNumber &= $Random&"|"
				ExitLoop
			EndIf
		WEnd
	Next
	Return StringLeft($ListNumber,StringLen($ListNumber)-1)
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$_Max = InputBox("Thông Báo","Nhấp số giới hạn random",15)
$List = _RandomList(0,$_Max)
MsgBox(0,"Thông Báo",$List)
