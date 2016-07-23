#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Chức năng: Xuất nhập 1 mảng tự động
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

;~ Xuất chuỗi ra
MsgBox(0,"72ls.NET",$text)