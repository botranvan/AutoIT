#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Chức năng: Tự động cập nhật lại AutoIT v1.0
- Lưu ý: Tìm những số chia hết cho 7
#ce ==========================================================

$Title = "72ls.net"

;~ Lấy 2 số đầu và cuối
$A = InputBox($Title,"Nhập số đầu tiên",2)
$B = InputBox($Title,"Nhập số đầu tiên",72)


$Text = ""	;Tạo biến chứa dãy số tìm được

;~ Duyện từ $A đến $B
For $i = $A To $B
	If Mod($i,7)==0 Then $Text&= $i & " " 	;Nếu chia hết cho 7 thì thêm vào biến $Text
Next

If $Text == "" Then  	;Xuất kết quả ra
	MsgBox(0,$Title,"Không tìm thấy số nào")
Else
	MsgBox(0,$Title,$Text)
EndIf
