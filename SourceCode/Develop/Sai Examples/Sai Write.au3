;~ Chon [File - Encoding - UTF8 with BOM] de xem Tieng Viet
;~ Chương trình tự động Nhập Liệu, hộ trỡ tạo Blog Topic
;~ Phiên bản 1.00 - Tác Giả: Trần Minh Đức

;~ Tạo phím tắc thoát chương trình
HotKeySet("^+{end}]","exitauto") ;Ctrl + Shilf + End
AutoItSetOption("SendCapslockMode",1)

;~ Đếm lùi
For $i=1 to 2 step -1
	ToolTip("Bắt đầu Nhập trong "&$i&" giây",@DesktopWidth/2,@DesktopHeight/2)
	Sleep(777)
Next

;~ Link mẫu
;~ http://emo.huhiho.com/set/yoyocici/231.gif

$add="http://i451.photobucket.com/albums/qq233/saiicons/Heads2/" ;Đường dẫn
$name = ""		;Tên Files
$ext = ".gif"	;Phần mở rộng
$start = 10		;Số đầu tiên
$writes = 80	;Số lần nhập
$mode = 1		;Số lượng con chữ
$cancel = ""	;Những số không cần viết (dấu ;)
;~ $cancel="1;7;14;20;22;24;27;32;34;39;44;45;46;47;49;106;107;108;109;111;114;116;117;124;140;141;143;146;149;151;153;154" 		;Những số không cần viết (dấu ;)

$fontsize="1"			;Cở chữ
$AlignAll = "" 			;Canh Lề tất cả
$AlignImage = "left"	;Canh lền cho 1 ảnh
$alt="www.LeeSai.co.cc" 	;Alt cho Ảnh
$br = ""				;Chèn thêm <br>
$type=1					;2 - Chèn Table
$tdwidth="52"

Run("Notepad.exe")
WinWaitActive("Untitled - Notepad")

;~ Hiệu chỉnh Font
If $type=1 Then
	ClipPut($AlignAll)
	Send("^v")
	ClipPut("<font size="&$fontsize&">")
	Send("^v")
EndIf


StartWrite()
;~ WriteCancel()

SaveHTML()

;~ Copy lại
Send("^a")
Send("^c")

;~ Danh Sách Hàm ==================================================================================================================
;~ Hàm duyệt các số hủy trong Biến $cancel
Func WriteCancel()
	Local $array=StringSplit($cancel,";")	
	
	For $i=1 to $array[0] step 1
		If $i<>$start Then Send("{ENTER}")	
		writetext($array[$i],$mode)
	Next
EndFunc

;~ Hàm duyệt qua các số cần ghi
Func StartWrite()
	For $i=$start to $writes step 1
		If CancelNumber($i,$cancel) Then ContinueLoop ;Lọc các số không cần thiết
		If $i<>$start Then Send("{ENTER}")	
		writetext($i,$mode)
	Next
EndFunc

;~ Hàm ghi mã HTML
Func writetext($i="",$mode=1)
	ToolTip("Nhập: "&$i&"/"&$writes&" ("&$writes-$start+1&")",0,0)
	$i=DefinNumber($i,$mode)
	Local $Link = $add&$name&$i&$ext ;Link cho Opera
	
	Local $LinkForm = StringReplace($Link,".","[B].[/B]") 
	$LinkForm = StringReplace($LinkForm,":","[B]:[/B]") ;Link cho các Forum
	
	If $type=1 Then ClipPut('<hr><img alt="'&$alt&'" align="'&$AlignImage&'" src="'&$link&'"></img>'&$br&'[B]<[/B]img alt="'&$alt&'" src="'&$link&'"[B]><[/B]/img[B]>[/B]<br>[B][[/B]img='&$link&'[B]][[/B]/img[B]][/B]<br>[B][[/B]img[B]][/B]'&$LinkForm&'[B][[/B]/img[B]][/B]<br><br>') ;Đưa Text vào Clip Board
	If $type=2 Then	ClipPut('<hr><table><tr><td align="center" style="width:'&$tdwidth&'px"><img alt="'&$alt&'" src="'&$link&'"></img></td><td><font size="'&$fontsize&'">[B]<[/B]img alt="'&$alt&'" src="'&$link&'"[B]><[/B]/img[B]>[/B]<br>[B][[/B]img='&$link&'[B]][[/B]/img[B]][/B]<br>[B][[/B]img[B]][/B]'&$LinkForm&'[B][[/B]/img[B]][/B]<br><br></td></tr></table>')
	If $type=3 Then	ClipPut('<hr><table><tr><td><img src="'&$link&'"></img><br><font size="'&$fontsize&'">[B]<[/B]img alt="'&$alt&'" src="'&$link&'"[B]><[/B]/img[B]>[/B]<br>[B][[/B]img='&$link&'[B]][[/B]/img[B]][/B]<br>[B][[/B]img[B]][/B]'&$LinkForm&'[B][[/B]/img[B]][/B]<br><br></td></tr></table>')
	Send("^v")
EndFunc

;~ Định dạng số
;~ $i=-1 files không có số
Func DefinNumber($i,$mode)
	If $i=-1 Then Return ""
	If $mode=1 Then Return $i
	$t=$i
	$chars = $mode-StringLen($i&"")
	For $j=1 To $chars Step 1
		$t="0"&$t
	Next
	Return $t
EndFunc

;~ Hàm kiểm tra số
Func CancelNumber($i,$cancel)
	$array=StringSplit($cancel,";")
	For $j=1 To $array[0] Step 1
		If $i=$array[$j] Then Return True
	Next
	Return False
EndFunc

;~ Hàm xuất kết quả 
Func SaveHTML()
;~ 	Lưu HTML
	ClipPut(@DesktopDir&"\1.html")
	Send("^s")
	Sleep(340)
	Send("^v")
	Send("{Enter}")
	Send("!y")
	ShowHTML()
EndFunc

;~ 	Hiển thị HTML
Func ShowHTML()
	WinMinimizeAll()
	Sleep(777)
	Send("#r")
	Send("^v")
	Send("{Enter}")
EndFunc
;~ Thoát chương trình
Func exitauto()
	Exit
EndFunc