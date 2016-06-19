#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tìm 1 giá trị trong mảng
#ce ==========================================================

$max = 7
Dim $mang[$max]	;Tạo 1 mảng dữ liệu với 7 phần tử

;Gán 1 số nguyên dương bất kỳ từ 2 đến 72 cho các phần tử của mảng
For $i=0 To $max-1 Step 1
	$mang[$i] = Random(2,72,1)
Next

;Xuất mảng ra
$text = ""		;Tạo 1 chuỗi rỗng
For $i=0 To $max-1 Step 1
	$text&=$mang[$i]&" "		;Nối dần các giá trị trong mảng vào chuỗi
Next

;~ Xuất chuỗi chứa các số trong mảng ra và lấy số cần tìm


;~ Lấy số cần tìm
$So = InputBox("72ls.NET","Mảng vừa tạo là: "&$text&@LF&"Nhập số muốn tìm",27)

;~ Thực hiện việc tìm
$TimThay = False
For $i=0 To $max-1 Step 1
	If $mang[$i] = $so Then 
		$TimThay = True
		ExitLoop
	EndIf
Next

;~ Xuất kết quả tìm kiếm
If $TimThay = True Then
	MsgBox(0,"72ls.NET","Tìm thấy")
Else
	MsgBox(0,"72ls.NET","Không tìm thấy")
EndIf