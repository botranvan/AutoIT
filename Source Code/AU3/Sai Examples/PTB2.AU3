;~ Nhập liệu
$cosoa = InputBox("Phương Trình Bậc 2","Hệ số a:", Default, Default, Default, 100)
$cosob = InputBox("Phương Trình Bậc 2","Hệ số b:", Default, Default, Default, 100)
$cosoc = InputBox("Phương Trình Bậc 2","Hệ số c:", Default, Default, Default, 100)

;~ Tính Denta
$bbinh = $cosob * $cosob
$ac = $cosoa * $cosoc

$denta = $bbinh - ($ac + $ac +$ac +$ac)

IF $denta>0 Then
	$nghiem1 = (-$cosob- sqrt($denta)) / ($cosoa + $cosoa)
	$nghiem2 = -($cosob / $cosoa) - $nghiem1
	MsgBox(0,"Phương Trình Bậc 2","Nhiệm 1: "&$nghiem1&@CRLF&"Nhiệm 2: "&$nghiem2)
ElseIf $denta=0 Then
	$nghiem = -$cosob / ($cosoa + $cosoa)
	MsgBox(0,"Phương Trình Bậc 2","Nhiệm : "&$nghiem)
ElseIf $denta<0 Then
	MsgBox(0,"Phương Trình Bậc 2","Phương Trình Vô Nhiệm")
EndIf