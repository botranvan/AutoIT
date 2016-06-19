#cs ==========================================================
- Chương trình
- Thiết kế: Trần Minh Đức
- AutoIT: v3.2.12.0
#ce ==========================================================

;-- Cấu Trúc Trương Trình -----------------------------------------------------------------------------------------------------------
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định 
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
;~ Các Hàm Đang Tạo
;-- Hết Cấu Trúc Trương Trình -------------------------------------------------------------------------------------------------------

;-- Các Include -----------------------------------------------------------------------------------------------------------------------

;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("{F7}","OpenFolder")						;Ctrl+Shilf+F7		- Mở Thư Mục Save
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoName="Sai ADF"								;Tên Chương Trình
Global $AutoClass="AutoIt v3 GUI"					;Mã phân loại Chương Trình		
Global $AutoHandle=""								;Mã Chương Trình khi chạy
Global $AutoVersion="1.0"							;Phiên Bản
Global $Author="Trần Minh Đức"						;Tên (các) Lập Trình Viện
Global $ProcessName=$AutoName&".exe"				;Dùng khi Xuất Thành EXE
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@CRLF								;Các chức năng của Chương Trình
;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
CheckAuto()
ShowHotKey()
While 1
	Sleep(777)
WEnd 
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	$l = ProcessList()
	$CountProcess=$ProcessNumber
	For $i = 1 to $l[0][0] Step 1
		If $l[$i][0]=$ProcessName And $CountProcess=0 then
			MsgBox(0,$AutoName,$AutoName&" đã chạy."&@LF&"Không thể mở thêm!!!")
			Exit
		EndIf
 		If $l[$i][0]=$ProcessName then $CountProcess-=1
	Next
	TraySetState(1)
EndFunc

;~ Xem phím nóng
Func ShowHotKey()
	Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
	$text=$text&"F7"&@TAB&@TAB&@TAB&"- Mở Thư Mục Save"&@LF
	$text=$text&"Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
	$text=$text&"Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
	ToolTip($text,0,0)
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
Func OpenFolder()
	Run("explorer.exe C:\Documents and Settings\"&@UserName&"\Application Data\Macromedia\Flash Player\#SharedObjects\")
EndFunc
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------