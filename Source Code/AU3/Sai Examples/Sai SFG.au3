#cs ==========================================================
- Chương trình hỗ trợ Save FlashGame
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
HotKeySet ("^+{F6}","PlayWithKeyboard")				;Ctrl+Shilf+F6		- Chế độ chơi bằng Bàn Phím
HotKeySet ("^+{F7}","SaveFlashGame")				;Ctrl+Shilf+F7		- Lưu SaveFlashGame
HotKeySet ("^+{F8}","LoadFlashGame")				;Ctrl+Shilf+F8		- Nạp SaveFlashGame
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+K		- Xem phím Nóng
;~ HotKeySet ("{PAUSE}","PauseAuto")					;Pause				- Tạm Dừng Auto
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoName="Sai SFG"								;Tên Chương Trình
Global $AutoClass="AutoIt v3 GUI"					;Mã phân loại Chương Trình		
Global $AutoHandle=""								;Mã Chương Trình khi chạy
Global $AutoVersion="1.01 2c1"						;Phiên Bản
Global $Author="Trần Minh Đức"						;Tên (các) Lập Trình Viện
;~ Global $ProcessName="AutoIt3.exe"					;Dùng khi lập trình
Global $ProcessName=$AutoName&".exe"				;Dùng khi Xuất Thành EXE
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@LF&" >>Lưu các Files Save của Flash"	;Các chức năng của Chương Trình
$Functions=$Functions&@LF&" >>Hỗ trợ Governor of Poker"

;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến dùng chung
Global $Pause=False
Global $PlayWithKeyboard=False
Global $FlashFolder=@HomeDrive&@HomePath&"\Application Data\Macromedia" ;Thư mục của Macromedia
Global $SaveFolder
Global $WaitTime=222

;~ Biến của Governor of Poker 
Global $ClassFlash="[MacromediaFlashPlayerActiveX1]"
Global $FoldButtonPos[2]
$FoldButtonPos[0]=232
$FoldButtonPos[1]=646
Global $SkipButtonPos[2]
$SkipButtonPos[0]=403
$SkipButtonPos[1]=646
Global $CheckButtonPos[2]
$CheckButtonPos[0]=583
$CheckButtonPos[1]=646
Global $BetButtonPos[2]
$BetButtonPos[0]=752
$BetButtonPos[1]=646
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
	Local $text=""
	$text=$text&"- Ctrl+Shilf+F6"&@TAB&@TAB&"- Hỗ trợ Governor of Poker"&@LF
	$text=$text&"- Ctrl+Shilf+F7"&@TAB&@TAB&"- Lưu SaveFlashGame"&@LF
	$text=$text&"- Ctrl+Shilf+F8"&@TAB&@TAB&"- Nạp SaveFlashGame"&@LF
	$text=$text&"- Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
	$text=$text&"- Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
	$text=$text&"- Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
	$text=$text&"- Ctrl+Shilf+Delete"&@TAB&"- Tắt Trợ giúp"
;~ 	$text=$text&"- Pause"&@TAB&""&@TAB&@TAB&"- Tạm Dừng Auto"
	ToolTip($text,0,0)
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	Local $text=""
	$text=$text&"- Chương Trình: "&$AutoName&@LF
	$text=$text&"- Phiên Bản: "&$AutoVersion&@LF
	$text=$text&"- Thiết kế: "&$Author&@LF
	$text=$text&"- Chức năng: "&$Functions&@LF&@LF
	$text=$text&"(Ctrl+Shilf+K - Xem Phím Nóng)"
	ToolTip($text,0,0)
EndFunc

;~ Tạm dừng Auto
;~ Func PauseAuto()
;~ 	$Pause=Not $Pause
;~ 	While $Pause
;~ 		ToolTip("Tạm Dừng...",0,0)
;~ 		Sleep($WaitTime)
;~ 	WEnd
;~ 	ToolTip("")
;~ EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	$ShowHotKey=False
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Hàm Lưu SaveGame
Func SaveFlashGame()
	$SaveFolder="Save"&@MON&@MDAY&@HOUR&@MIN&@SEC
	DirCopy($FlashFolder,$SaveFolder,1)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&"",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&".",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&"..",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&"...",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đã lưu XONG. (Cùng chỗ với Chương Trình này)",0,0)
EndFunc

;~ Hàm Nạp SaveGame
Func LoadFlashGame()
	ToolTip("Lưu dự phòng Files hiện tại của Flash",0,0)
	DirCopy($FlashFolder,"Backup\"&$SaveFolder,1)
	ToolTip("Lưu dự phòng Files hiện tại của Flash.",0,0)
	Sleep($WaitTime)
	ToolTip("Lưu dự phòng Files hiện tại của Flash..",0,0)
	Sleep($WaitTime)
	ToolTip("Lưu dự phòng Files hiện tại của Flash...",0,0)
	
	$SaveFolder=InputBox($AutoName,"Nhập tên Thư Mục (Folder) muốn nạp."&@LF&@LF&"Ví dụ: Save0706152756",$SaveFolder,"",250,151)
	If $SaveFolder="" Then Return
	DirCopy($SaveFolder,$FlashFolder,1)
	ToolTip("Đã Nạp Files",0,0)
EndFunc

;~ Hàm Lưu SaveCheat
Func SaveCheat()
	Local $SaveFolder="SaveCheat"
	DirCopy($FlashFolder,$SaveFolder,1)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&"",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&".",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&"..",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đang lưu vào: "&$SaveFolder&"...",0,0)
	Sleep($WaitTime)
	ToolTip("Các Files đã lưu XONG. (Cùng chỗ với Chương Trình này)",0,0)
EndFunc

;~ Hàm Nạp SaveCheat
Func LoadCheat()
	Local $SaveFolder="SaveCheat"
	DirCopy($SaveFolder,$FlashFolder,1)
	ToolTip($SaveFolder&" đang nạp",0,0)
	Sleep($WaitTime)
	ToolTip($SaveFolder&" đang nạp.",0,0)
	Sleep($WaitTime)
	ToolTip($SaveFolder&" đang nạp..",0,0)
	Sleep($WaitTime)
	ToolTip($SaveFolder&" đang nạp...",0,0)
	Sleep($WaitTime)
	ToolTip($SaveFolder&" đã nạp XONG",0,0)
EndFunc

;~ Hàm lấy vị trí nút Fold
Func GetFold()
	$FoldButtonPos=MouseGetPos()
	ToolTip("Lấy vị trí nút Fold",0,0)
EndFunc
;~ Hàm bấm nút Fold
Func ClickFold()
	MouseMove($FoldButtonPos[0],$FoldButtonPos[1],5)
	MouseClick("left",$FoldButtonPos[0],$FoldButtonPos[1],1,1)
	ToolTip("Fold",0,0)
EndFunc

;~ Hàm lấy vị trí nút Skip
Func GetSkip()
	$SkipButtonPos=MouseGetPos()
	ToolTip("Lấy vị trí nút Skip",0,0)
EndFunc
;~ Hàm bấm nút Fold
Func ClickSkip()
	MouseMove($SkipButtonPos[0],$SkipButtonPos[1],5)
	MouseClick("left",$SkipButtonPos[0],$SkipButtonPos[1],1,1)
	ToolTip("Skip",0,0)
EndFunc

;~ Hàm lấy vị trí nút Check
Func GetCheck()
	$CheckButtonPos=MouseGetPos()
	ToolTip("Lấy vị trí nút Check(Call)",0,0)
EndFunc
;~ Hàm bấm nút Fold
Func ClickCheck()
	MouseMove($CheckButtonPos[0],$CheckButtonPos[1],5)
	MouseClick("left",$CheckButtonPos[0],$CheckButtonPos[1],1,1)
	ToolTip("Check(Call)",0,0)
EndFunc

;~ Hàm lấy vị trí nút Bet
Func GetBet()
	$BetButtonPos=MouseGetPos()
	ToolTip("Lấy vị trí nút Bet(Raise)",0,0)
EndFunc
;~ Hàm bấm nút Fold
Func ClickBet()
	MouseMove($BetButtonPos[0],$BetButtonPos[1],5)
	MouseClick("left",$BetButtonPos[0],$BetButtonPos[1],1,1)
	ToolTip("Bet(Raise)",0,0)
EndFunc

;~ Hàm trợ giúp trong chế độ chơi bằng bàn phím
Func HelpWithKeyboard()
	Local $text=""
	$text=$text&" Governor of Poker"&@LF
	$text=$text&" Chơi bằng Bàn Phím: Bật"&@LF
	$text=$text&" Các nút đã được cài sẵn ở chế độ Fullgreen (F11)"&@LF
	$text=$text&" Ctrl+Shilf+Delete - Tắt Trợ giúp"&@LF&@LF
	$text=$text&" Z - Bấm Fold"&@TAB&@TAB&"| Ctrl+Shilf+Z - Lấy Vị Trí Fold"&@LF
	$text=$text&" X - Bấm Fold&Skip"&@TAB&"| Ctrl+Shilf+X - Lấy Vị Trí Fold&Skip"&@LF
	$text=$text&" C - Bấm Check(Call)"&@TAB&"| Ctrl+Shilf+C - Lấy Vị Trí Check(Call)"&@LF
	$text=$text&" V - Bấm Bet(Raise)"&@TAB&"| Ctrl+Shilf+V - Lấy Vị Trí Bet(Raise)"
	ToolTip($text,0,0)	
EndFunc

;~ Hàm kích hoạt chức năng chơi bằng bàn phím
Func PlayWithKeyboard()
	$PlayWithKeyboard=Not $PlayWithKeyboard
	If $PlayWithKeyboard Then
		HotKeySet ("{F9}","SaveCheat")			;F9
		HotKeySet ("{F10}","LoadCheat")			;F10
		HotKeySet ("{F1}","HelpWithKeyboard")	;F1	- Trợ Giúp với Keyboard
		HotKeySet ("z","ClickFold")				;Z	- Click Fold
		HotKeySet ("x","ClickSkip")				;X	- Click Fold&Skip
		HotKeySet ("c","ClickCheck")			;C	- Click Check
		HotKeySet ("v","ClickBet")				;V	- Click Bet(Raise)
		HotKeySet ("^+z","GetFold")				;Ctrl+Shilf+Z	- Lấy Vị Trí Fold
		HotKeySet ("^+x","GetSkip")				;Ctrl+Shilf+X	- Lấy Vị Trí Fold&Skip
		HotKeySet ("^+c","GetCheck")			;Ctrl+Shilf+C	- Lấy Vị Trí Check
		HotKeySet ("^+v","GetBet")				;Ctrl+Shilf+V	- Lấy Vị Trí Bet(Raise)
		ToolTip("Governor of Poker"&@LF&"Chơi bằng Bàn Phím: Bật"&@LF&"(F1 - Trợ Giúp)",0,0)
	Else
		HotKeySet ("{F9}")
		HotKeySet ("{F10}")
		HotKeySet ("{F1}")
		HotKeySet ("z")
		HotKeySet ("x")
		HotKeySet ("c")
		HotKeySet ("v")
		HotKeySet ("^+z")
		HotKeySet ("^+x")
		HotKeySet ("^+c")
		HotKeySet ("^+v")
		ToolTip("Chơi bằng Bàn Phím: Tắt",0,0)
	EndIf
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------