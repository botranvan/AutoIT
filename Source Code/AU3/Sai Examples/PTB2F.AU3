#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Xuất chuỗi bằng MsgBox
#ce ==========================================================

$Title = "72ls.NET"

;~ Nhập liệu
$cosoa = InputBox($Title,"Hệ số a:", Default, Default, Default, 100)
$cosob = InputBox($Title,"Hệ số b:", Default, Default, Default, 100)
$cosoc = InputBox($Title,"Hệ số c:", Default, Default, Default, 100)

$Data = "Với: "&$cosoa&"x² + "&$cosob&"x + "&$cosoc&" = 0"&@CRLF

;~ Tính Denta
$bbinh = $cosob * $cosob
$ac = $cosoa * $cosoc
$denta = $bbinh - ($ac + $ac + $ac + $ac)

;~ Kiểm tra Denta rối tính nghiệm
IF $denta>0 Then
	$nghiem1 = (-$cosob- sqrt($denta)) / ($cosoa + $cosoa)
	$nghiem2 = -($cosob / $cosoa) - $nghiem1
	$String = "Nghiệm 1: "&$nghiem1&@CRLF&"Nghiệm 2: "&$nghiem2
	$Data &= $String&@CRLF
	MsgBox(0,$Title,$String)
ElseIf $denta=0 Then
	$nghiem = -$cosob / ($cosoa + $cosoa)
	$String = "Nghiệm kép: "&$nghiem
	$Data &= $String&@CRLF
	MsgBox(0,$Title,$String)
ElseIf $denta<0 Then
	$String = "Phương Trình Vô Nghiệm"
	$Data &= $String&@CRLF
	MsgBox(0,$Title,$String)
EndIf

;~ Ghi xuống file
$File = FileOpen("PTB2.txt",1+128)
$Data &= "=================="&@CRLF&@CRLF
FileWrite($File,$Data)
FileClose($File)