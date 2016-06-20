#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Chức năng: Tự động cập nhật lại AutoIT v1.0
- Lưu ý: Copy file cái đặt vào cùng thư mục với Tool này
#ce ==========================================================

$Title = "72ls.net"
$Title1 = "[TITLE:AutoIt; CLASS:#32770]"
$FileName = "autoit-v3-setup.exe"
$Wait = 720		;Mili giây

$Path = InputBox($Title,"Nhập đường dẫn hiện tại của AutoIT vào","D:\Program Files\AutoIt3")	;Lấy đường dẫn

;Thực thi file cài đặt
Run($FileName)
If @error Then
	msgbox(0,$Title,"Không tìm thấy File cài đặt "&$FileName&@LF&"Hãy copy file cài đặt vào cùng thư mục với Tool này")
	Exit
EndIf

;~ Bắt đầu quá trình tự cài
WinWait ( $Title1, "Next")
Sleep($Wait)
Send("{enter}") 	;Next
Sleep($Wait)
Send("{enter}")		;I Agree
Sleep($Wait)
Send("{enter}")		;Next
WinWait ( $Title1, "Edit the script")
Sleep($Wait)
Send("{tab}")		;Chuyển qua Edit Mode
Send("{space}")
Sleep($Wait)
Send("{enter}")		;Next
Sleep($Wait)
Send("{enter}")		;Next
Sleep($Wait)
Send($Path)			;Nhập đường dẫn
Sleep($Wait)
Send("{enter}")		;Install
WinWait ( $Title1, "Finish")
Sleep($Wait)
Send("{tab}")		;Bỏ chọn xem thông tin cập nhật
Send("{tab}")
Send("{tab}")
Send("{space}")
Sleep($Wait)
Send("{enter}")		;Finish
msgbox(0,$Title,"Đã cài xong",2)