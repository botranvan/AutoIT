;~ Chon [File - Encoding - UTF8 with BOM] de xem Tieng Viet
;~ Chương trình tự động Down hình về bằng
;~ Phiên bản 1.00 - Tác Giả: Trần Minh Đức

;~ Yêu cầu: Kích hoạt Internet Download Manager trước
;~ Yêu cầu: Nhập đường dẫn cần Downdload và Check khi nhớ Đường dẫn

;~ Tạo phím tắc thoát chương trình
HotKeySet("^+{end}]","exitauto") ;Ctrl + Shilf + End
Func exitauto()
	Exit
EndFunc

;~ Tạo phím tắc dừng chương trình
HotKeySet("{PAUSE}]","pauseauto")
$pause=False
Func pauseauto()
	$pause=Not $pause
	While $pause
		ToolTip("Pause ---",0,0)
		Sleep(222)
		ToolTip("Pause  \",0,0)
		Sleep(222)
		ToolTip("Pause  |",0,0)
		Sleep(222)
		ToolTip("Pause  /",0,0)
		Sleep(222)
	WEnd
	ToolTip("")
EndFunc


;~ Link mẫu
;~ http://emo.huhiho.com/set/onion/pic183.gif
;~ http://emo.huhiho.com/set/yoyocici/235.gif
;~ z23.gif

;Địa chỉ Down
$link="http://s683.photobucket.com/albums/vv196/cariga113/" 	

;Tên File
$name="z" 		
;Phần mở rộng
$ext=".gif" 	

;Số đầu tiên
$start=1 		
;Số cuối cùng
$end=100		

;Số lượng chữ số
$mode=2			

;Địa chỉ Lưu file down về
;~ $save="D:\Pictures\Gif\Kid\"		
$save=@DesktopDir&'\tra\'
;~ Thên "\" vào cuối chuỗi nếu chưa có
If StringRight($save,1)<>"\" Then $save = StringReplace($save,StringRight($save,1),StringRight($save,1)&"\")

;~ Đếm lùi
For $i=2 to 1 step -1
	ToolTip("Bắt đầu Down trong "&$i&" giây",@DesktopWidth/2,@DesktopHeight/2)
	Sleep(1000)
Next
ToolTip("") 

;~ Bắt đầu Down
DirCreate($save)
ProgressOn("DownLoad", "Đang tải ??? về.", "0 percent",Default,Default,16)
Dim $TextError=""
Dim $CountError=0
Dim $Hour = @HOUR
Dim $Min = @MIN
Dim $Sec = @SEC
For $i=0 to $end-$start step 1
	
	$number=$i+$Start
	$number=DefineNumber($number,$mode)
	Local $LinkDown = $link&$name&$number&$ext
	Local $LinkSave = $save&$name&$number&$ext
	ProgressSet(($i)/$end*100,"Đã tải: "&($i)&"/"&$end-$start+1&" ("&Int(($i)/$end*100)&" %)   -   Lỗi: "&$CountError&@LF&@LF&"Lưu vào: "&$LinkSave,"Đang tải "&$name&$number&$ext&" về.")
	
;~ 	Lấy file từ Internet về
	If InetGetSize($LinkDown) Then
		InetGet($LinkDown,$LinkSave,1,1)
	Else
;~ 		Thông báo nếu Down lỗi
		$TextError&=$LinkDown&@LF
		ToolTip($TextError,0,0,"LỖI TẢI VỀ")
		$CountError+=1
		If Mod($CountError,7)=0 Then $TextError=""
	EndIf
	Sleep(777)
Next

ProgressSet(($i)/$end*100,"Đã tải: "&($i)&"/"&$end-$start&" ("&Int(($i)/$end*100)&" %)   -   Lỗi: "&$CountError&@LF&@LF&"Lưu vào: "&$LinkSave,"Đang tải "&$name&$number&$ext&" về.")
Sleep(777)
ProgressOff()
Exit

;~ Hàm định dạng số
Func DefineNumber($i,$mode)
	$t=$i
	For $j=1 To $mode-StringLen($i) Step 1
		$t="0"&$t
	Next
	Return $t
EndFunc
