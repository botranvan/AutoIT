#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tính tổng 1 dãy số
#ce ==========================================================

$Title = "72ls.net"

;~ Nhập số tận cùng vào
$End = InputBox($Title,"Nhập số cuối cùng vào",27)

;~ Chạy từ 1 đến số vừa nhập
$Tong = 0
For $i = 1 To $End Step 1
	$Tong += $i
Next

;~ Xuất kết quả ra
MsgBox(0,$Title,"Tống từ 1 đến "&$End&" là: "&$Tong)