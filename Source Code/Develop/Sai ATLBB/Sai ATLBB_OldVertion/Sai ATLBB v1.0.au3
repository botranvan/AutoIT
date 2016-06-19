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
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("^+{F7}","AutoUsePetFood")				;Ctrl+Shilf+F7		- Bắt đầu
HotKeySet ("{PAUSE}","PauseAuto")					;Pause				- Tạm Dừng Auto
HotKeySet ("{PGUP}","UpDangerPos")					;PageUp				- Tăng Giới Hạn Bơm Máu Cho Thú
HotKeySet ("{PGDN}","DownDangerPos")				;PageDown			- Giảm Giới Hạn Bơm Máu Cho Thú
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto
;~ HotKeySet ("m","GetColor")
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoName="Sai ATLBB"						;Tên Chương Trình
Global $AutoClass="AutoIt v3 GUI"					;Mã phân loại Chương Trình		
;~ Global $AutoHandle=""							;Mã Chương Trình khi chạy
Global $AutoVersion="1.0"							;Phiên Bản
Global $Author="Trần Minh Đức"						;Tên (các) Lập Trình Viện
Global $ProcessName="AutoIt3.exe"					;Dùng khi lập trình
;~ Global $ProcessName=$AutoName&".exe"				;Dùng khi Xuất Thành EXE
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@CRLF								;Các chức năng của Chương Trình
$Functions=$Functions&"   +Tự Bơm Máu Cho Thú"

;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến dùng chung
Global $Running=False
Global $Pause=False
Global $GameHandle=""		;Mã số của Game
Global $GamePos[2]			;Vị trí Game
$GamePos[0]=0
$GamePos[1]=0
Global $PetHPPos[2]			;Vị trí Máu của thú
Global $F10Pos[2]			;Vị trí Skill F10
Global $DangerPos=30		;Phần Trăm Máu còn lại khi cần Bơm
;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
CheckAuto()
ShowInfoAuto()
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
	$text=$text&"  Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
	$text=$text&"  Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
	$text=$text&"  Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
	$text=$text&"  Ctrl+Shilf+F7"&@TAB&@TAB&"- Bắt Đầu Bơm"&@LF
	$text=$text&"  PageUp"&@TAB&@TAB&"- Tăng Giới Hạn"&@LF
	$text=$text&"  PageDown"&@TAB&@TAB&"- Giảm Giới Hạn"&@LF
	$text=$text&"  Pause"&@TAB&""&@TAB&@TAB&"- Tạm Dừng Auto"
	ToolTip($text,0,0)
EndFunc

;~ Tạm dừng Auto
Func PauseAuto()
	$Pause=Not $Pause
	Local $i=1
	While $Pause
		Select 
			Case $i=1
				ToolTip("Tạm Dừng >     ",0,0)
			Case $i=2
				ToolTip("Tạm Dừng  >    ",0,0)
			Case $i=3
				ToolTip("Tạm Dừng   >   ",0,0)
			Case $i=4
				ToolTip("Tạm Dừng    >  ",0,0)
			Case $i=5
				ToolTip("Tạm Dừng    >  ",0,0)
			Case $i=6
				ToolTip("Tạm Dừng     > ",0,0)
			Case $i=7
				ToolTip("Tạm Dừng      >",0,0)
			Case $i=8
				ToolTip("Tạm Dừng     < ",0,0)
			Case $i=9
				ToolTip("Tạm Dừng    <  ",0,0)
			Case $i=10
				ToolTip("Tạm Dừng   <   ",0,0)
			Case $i=11
				ToolTip("Tạm Dừng  <    ",0,0)
			Case $i=12
				ToolTip("Tạm Dừng <     ",0,0)
		EndSelect
		
		If $i=12 Then 
			$i=1
		Else
			$i=$i+1
		EndIf
		
		Sleep(77)
	WEnd
	ToolTip("")
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	Local $text="THÔNG TIN CHƯƠNG TRÌNH"&@LF
	$text=$text&" - Chương Trình: "&$AutoName&@LF
	$text=$text&" - Phiên Bản: "&$AutoVersion&@LF
	$text=$text&" - Thiết kế: "&$Author&@LF
	$text=$text&" - Chức năng: "&$Functions&@LF&@LF
	$text=$text&"(Ctrl+Shilf+K - Trợ Giúp)"
	ToolTip($text,0,0)
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;Hàm lấy mả số của Game
Func GetGameHandle()
	For $i=1 To 16 Step 1
		ToolTip("Bạn có "&$i&" giây để chọn Game.",0,0)
		Global $GameHandle=WinGetHandle("[TITLE:Thien Long Bat Bo; CLASS:TianLongBaBu WndClass;]")
		If $GameHandle<>"" Then ExitLoop
	Next
EndFunc

;Hàm láy vị trí ống máu của thú
Func GetPetHPPos()
	;Kiểm tra vị trí của Game
	If $GameHandle="" Then $GameHandle=WinGetHandle("[TITLE:Thien Long Bat Bo; CLASS:TianLongBaBu WndClass;]")
	Local $Pos=WinGetPos($GameHandle)
	
	;Xác định vị trí ống máu của Thú khi Game bị di chuyển
	If ($Pos[0]<>$GamePos[0])And($Pos[1]<>$GamePos[1]) Then
		WinActivate($GameHandle)
		Global $GameCaretPos=WinGetCaretPos()
		$PetHPPos[0]=$GameCaretPos[0]+64.6
		$PetHPPos[1]=$GameCaretPos[1]+69.1
		$F10Pos[0]=$GameCaretPos[0]+556
		$F10Pos[1]=$GameCaretPos[1]+556
		$GamePos=$Pos
	EndIf
EndFunc
	
;Hàm kiểm tra máu của Thú	
Func CheckPetHP()
	GetPetHPPos()
	For $i=$PetHPPos[0] To $PetHPPos[0]+99 Step 1
		$PetHPColor=PixelGetColor($i,$PetHPPos[1])
;~  		Sleep(2)
;~ 		ToolTip($PetHPColor,$i,$PetHPPos[1])
		If ($PetHPColor<16700000) Then ExitLoop
		GetPetHPPos()
	Next
	$Percent=$i-$PetHPPos[0]
	Return $Percent
EndFunc

;Hàm tự động bơm máu cho Thú
Func AutoUsePetFood()
	$Running=Not $Running
	While $Running
		$PetHP=CheckPetHP()
		If $PetHP<=$DangerPos Then 
			Send("{F10}")
			Sleep(2005)
		EndIf
		ToolTip("Bơm khi còn "&$DangerPos&" %"&@LF&"Máu hiện tại: "&$PetHP&" %",0,0)
		Sleep(77)
	WEnd 
	ShowInfoAuto()
EndFunc

;Hàm tăng giới hạn Bơm Máu cho Thứ
Func UpDangerPos()
	$DangerPos=$DangerPos+5
	If $DangerPos>99 Then $DangerPos=99
	ToolTip("Bơm khi còn "&$DangerPos&" %",0,0)
EndFunc

;Hàm tăng giới hạn Bơm Máu cho Thứ
Func DownDangerPos()
	$DangerPos=$DangerPos-5
	If $DangerPos<1 Then $DangerPos=1
	ToolTip("Bơm khi còn "&$DangerPos&" %",0,0)
EndFunc
	
;Hàm lấy màu
Func GetColor()
GetPetHPPos()
$Pos=MouseGetPos()
ToolTip(PixelGetColor($Pos[0],$Pos[1]),$F10Pos[0],$F10Pos[1])
EndFunc
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------