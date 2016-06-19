#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tính trị tuyệt đối
#ce ==========================================================

;~ Lấy giá trị từ bàn phím
$Var = InputBox("72ls.NET","Nhập 1 số bất kỳ",-27)

;~ Nếu giá trị là âm thì nhân với -1
If $Var < 0 Then $Var = $Var * -1
	
MsgBox(0,"72ls.NET",$Var) 
