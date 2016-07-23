#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Chức năng: Tính số ngày trong năm
#ce ==========================================================

$Title = "72ls.NET"

;~ Lấy số năm
$Nam = InputBox($Title,"Nhập số năm vào",2007)

;~ Kiểm tra số năm
If Mod($Nam,400) = 0 Or Mod($Nam,4) = 0 And Mod($Nam,100) <> 0 Then
	MsgBox(0,"","Năm "& $Nam & " có 366 ngày")
Else
	MsgBox(0,"","Năm "& $Nam & " có 365 ngày")
EndIf