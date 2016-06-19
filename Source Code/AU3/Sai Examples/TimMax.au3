#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tìm giá trị lớn mất trong Array
#ce ==========================================================

$max = 7
Dim $mang[$max]	;Tạo 1 mảng dữ liệu với 7 phần tử

;Gán 1 số nguyên dương bất kỳ từ 2 đến 72 cho các phần tử của mảng
For $i=0 To $max-1 Step 1
	$mang[$i] = Random(2,72,1)
Next

;~ Tìm trong mảng
$MaxNumber = $mang[0]		;Giả sử giá trị lớn nhất là phần tử đầu tiên của mảng
$text = ""			;Tạo 1 chuỗi rỗng để xuất mảng
For $i=0 To $max-1 Step 1
	$text &= $mang[$i] & " "		;Nối dần các giá trị trong mảng vào chuỗi
	
	;Nếu giá trị của $MaxNumber nhỏ hơn giá trị hiện tại của mảng thì đổi giá trị của $MaxNumber
	If ($MaxNumber < $mang[$i]) Then $MaxNumber = $mang[$i]	
Next

;~ Xuất chuỗi ra
MsgBox(0,"72ls.NET","Các phẩn tử trong mảng là: "&$text&@LF&"Phần tử lớn nhất là: "&$MaxNumber)