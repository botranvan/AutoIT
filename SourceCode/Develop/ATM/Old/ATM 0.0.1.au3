#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng tự chơi trò Minesweeper
#ce ==========================================================

;== Cấu Trúc Trương Trình ===========================================================================================================
;~ Các Include
;~ Phím nóng cố định
;~ Các hàm thử nghiệm


;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
;~ SetMainVar() - Hàm tạo biến cố định
;~ CreateMainGUI() - Hàm tạo giao diện
;~ ShowMainGUI() - Hiện thông báo trong Gui
;~ CheckAuto() - Kiểm Tra xem Auto đã chạy chưa
;~ While - Vòng lặp các phiên làm việc
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------


;-- Các Hàm Hoàn Chỉnh --------------------------------------------------------------------------------------------------------------
;~ Func CheckAuto() - Kiểm Tra xem Auto đã chạy chưa
;~ Func ShowHotKey() - Xem phím nóng
;~ Func ShowInfoAuto() - Hàm xuất thông tin chương trình
;~ Func DelTooltip() - Hàm xóa Thông Báo
;~ Func RunningCheck() - Hàm cho biết chức năng tự bơm đang hoạt động
;~ Func HiddenShow() - Hàm ẩn hiện chương trình
;~ Func ActivePauseAuto() - Kích hoạt chức năng Tạm dừng Auto
;~ Func PauseAuto() - Tạm dừng Auto
;~ Func ShowPauseAuto() - Hiển thị thông báo tạm dừng Auto
;~ Func ExitAuto() - Hàm thoát Auto
;~ Func SToolTip($Text,$x = Default,$y = Default) - Hiển thị ToolTip
;~ Func IsShowTestInfo() - Kiểm tra xem có cần xuất thông số chương trình không

;~ Func ShowMainGUI() -  Ẩn/Hiển Thị Giao Diện
;~ Func HideMainGUI()
;~ Func ShowWarningGUI() - Ẩn/Hiện thông báo trong Gui
;~ Func HiddenWarningGUI()
;~ Func ShowWarningGUI() - Ẩn/Hiện thông báo trong Giao Diện
;~ Func HiddenWarningGUI()
;------- Hết Các Hàm Hoàn Chỉnh -----------------------------------------------------------------------------------------------------


;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Func SetString() - Hàm nạp ngôn ngữ hiển thị
;~ Func CreateMainGUI() - Hàm tạo giao diện
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------


;~ Func SetTestInfo() - Tạo chuỗi các biến chương trình
;== Hết Cấu Trúc Trương Trình =======================================================================================================

;-- Các Include và Option -------------------------------------------------------------------------------------------------------------
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>

AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("SendCapslockMode",1)
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+h","ShowInfoAuto")					;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{PAUSE}","ActivePauseAuto")				;Pause				- Tạm Dừng Auto
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Các Hàm thử nghiệm ----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+!1","AtiveTest1")						;Ctrl+Shilf+Alt+1
Func AtiveTest1()
	$Running = Not $Running
EndFunc
;-------- Các Hàm thử nghiệm ----------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
SetMainVar()
SetString()
CreateMainGUI()
ShowMainGUI()
CheckAuto()

;Vòng lặp các phiên làm việc
While 1
;~ 	Hiện các thông số chương trình
	If IsShowTestInfo() Then
		STooltip(SetTestInfo())
	EndIf

	Sleep(77)

;~ 	Tạm dừng
	If PauseAuto() Then
		ShowPauseAuto()
		ContinueLoop
	EndIf

;~ 	Hiển thị thông báo tình trạng đang hoạt động
	RunningCheck()

WEnd
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;~ Hàm tạo biến cố định
Func SetMainVar()
	;~ Biến Thời Gian
	Global $TimeSplit = " - " 	;Phân Cách Thời Gian
	Global $1s = 1000				;Số Mili Giây trên 1 Giây	(1000/1)
	Global Const $spm = 60		;Số Giây trên 1 Phút		(60/1)
	Global Const $mph = 60		;Số Phút trên 1 Giờ			(60/1)
	Global Const $hpd = 24		;Số Giờ trên 1 Ngày			(60/1)

	;~ Biến chương trình
	Global $ShowToolTip = False			;True - Đang hiển thị bằng ToolTip
	Global $ShowHotKey = False			;True - Hiển thị danh sách phím nóng
	Global $ShowInfoAuto = False		;True - Hiển thị thông tin chương trình
	Global $SlidedMainGUI = False		;True - Trang thái Thu Gọn Auto
	Global $Pause = False				;True - Tạm ngưng chương trình
	Global $ShowPauseNum = 1			;1 - Cách hiện thị thứ nhất của trạng thái Pause
	Global $Running = False				;True - Đang thực hiện chức năng
	Global $RunningI = 1				;1 - Cách hiện thị thứ nhất của trạng thái hoạt động
	Global $TestInfoStatus = 4			;1 - Hiện các thông số chương trình
EndFunc

;~ Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	Local $l = WinList("[TITLE:"&$AutoTitle&"; CLASS:AutoIt v3 GUI;]")
	Local $CountProcess=$ProcessNumber

	If $l[0][0] > $ProcessNumber Then
		MsgBox(0,$AutoName,$EnoughAutoT)
		ExitAuto()
	EndIf
EndFunc

;~ Xem phím nóng
Func ShowHotKey()
	If $ShowToolTip And $ShowHotKey Then
		DelTooltip()
	Else
		DelTooltip()
		$ShowHotKey=True
		$ShowToolTip=True
		Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
		$text=$text&"Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
		$text=$text&"Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
		$text=$text&"Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
		$text=$text&"Pause"&@TAB&""&@TAB&@TAB&"- Tạm Dừng Auto"&@LF
		SToolTip($text)
	EndIf
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	If $ShowToolTip And $ShowInfoAuto Then
		DelTooltip()
	Else
		DelTooltip()
		$ShowInfoAuto=True
		$ShowToolTip=True
		Local $text=@TAB&"THÔNG TIN"&@LF
		$text=$text&"- Chương Trình: "&$AutoName&@LF
		$text=$text&"- Phiên Bản: "&$AutoVersion&@LF
		$text=$text&"- Thiết kế: "&$Author&@LF
		$text=$text&"- Chức năng: "&$Functions
		SToolTip($text)
	EndIf
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	$ShowToolTip=False
	$ShowHotKey=False
	$ShowInfoAuto=False
	ToolTip("")
EndFunc

;~ Hàm cho biết chức năng tự bơm đang hoạt động
Func RunningCheck()
	If Not $Running Then
		GUICtrlSetData($Running_Lable,"")
		Return False
	EndIf

	Select
		Case $RunningI=1
			GUICtrlSetData($Running_Lable,"|")
		Case $RunningI=2
			GUICtrlSetData($Running_Lable,"/")
		Case $RunningI=3
			GUICtrlSetData($Running_Lable,"__")
		Case $RunningI=4
			GUICtrlSetData($Running_Lable,"\")
		Case $RunningI=5
			GUICtrlSetData($Running_Lable,"|")
		Case $RunningI=6
			GUICtrlSetData($Running_Lable,"\")
		Case $RunningI=7
			GUICtrlSetData($Running_Lable,"__")
		Case $RunningI=8
			GUICtrlSetData($Running_Lable,"/")
		Case $RunningI=9
			GUICtrlSetData($Running_Lable,"S")
	EndSelect

	If $RunningI=9 Then
		$RunningI=0
	EndIf
	$RunningI += 1
EndFunc

;~ Hàm ẩn hiện chương trình
Func HiddenShow()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[1] = 0 Then
		GUICtrlSetData($Hidden_Button,$Button_ShowT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Vertically,Default,Default,2)
		$SlidedMainGUI = True
	Else
		GUICtrlSetData($Hidden_Button,$Hidden_ButtonT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1],Default,Default,2)
		$SlidedMainGUI = False
	EndIf
EndFunc

;~ Tạm dừng Auto
Func ActivePauseAuto()
	$Pause = Not $Pause
	If $Pause Then
		ShowWarningGUI()
		GUICtrlSetData($Pause_Button,$Pause_ButtonT2)
	Else
		HiddenWarningGUI()
		GUICtrlSetData($Pause_Button,$Pause_ButtonT1)
		GUICtrlSetData($Warning_Lable,"")
	EndIf

EndFunc
;~ Tạm dừng Auto
Func PauseAuto()
	If $Pause Then
		Return True
	EndIf
	Return False
EndFunc
;~ Hiển thị thông báo tạm dừng Auto
Func ShowPauseAuto()
	Select
		Case $ShowPauseNum=1
			GUICtrlSetData($Warning_Lable," >    "&$PauseAutoT&"    < ")
		Case $ShowPauseNum=2
			GUICtrlSetData($Warning_Lable,"  >   "&$PauseAutoT&"   <  ")
		Case $ShowPauseNum=3
			GUICtrlSetData($Warning_Lable,"   >  "&$PauseAutoT&"  <   ")
		Case $ShowPauseNum=4
			GUICtrlSetData($Warning_Lable,"    > "&$PauseAutoT&" <    ")
		Case $ShowPauseNum=5
			GUICtrlSetData($Warning_Lable,"     >"&$PauseAutoT&"<     ")
	EndSelect

	If $ShowPauseNum=5 Then
		$ShowPauseNum=0
	EndIf
	$ShowPauseNum+=1
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Hiển thị ToolTip
Func SToolTip($Text,$x = Default,$y = Default)
	If $x = Default Then $x = $MainGUI_Pos[0] + $MainGUI_Size[0]+2
	If $y = Default Then $y = $MainGUI_Pos[1]
	ToolTip($Text,$x,$y)

	If $Text = "" Then
		$ShowToolTip = False
	Else
		$ShowToolTip = True
	EndIf
EndFunc

;~ Kiểm tra xem có cần xuất thông số chương trình không
Func IsShowTestInfo()
	Local $Status = GUICtrlRead($ShowTestInfo_CheckBox)
	If $Status = 1 Then
		$TestInfoStatus = $Status
		Return 1
	EndIf

	If $Status = 4 And $TestInfoStatus <> 4 Then
		$TestInfoStatus = $Status
		tooltip('',0,0)
	EndIf
		Return 0
EndFunc



;~ Ẩn/Hiển Thị Giao Diện
Func ShowMainGUI()
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc
Func HideMainGUI()
	GUISetState(@SW_HIDE,$MainGUI)
EndFunc

;~ Ẩn/Hiện thông báo trong Giao Diện
Func ShowWarningGUI()
	If $SlidedMainGUI Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Warning_Lable_Size[1]+$Vertically,Default,Default,2)
EndFunc
Func HiddenWarningGUI()
	If $SlidedMainGUI Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Vertically,Default,Default,2)
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------


;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Hàm nạp chuỗi hiển thị
Func SetString()
;~ Biến Mô Tả Chương Trình
	Global $AutoName = "ATM"					;Tên Chương Trình
	Global $AutoBeta = "[Thử]"					;Chương Trình thử nghiệm
	Global $AutoVersion = "0.0.1"				;Phiên Bản
	Global $AutoVersionCode = "001"				;Mã số Phiên Bản
	Global $FindNewVersionT = ""
	Global $Author = "Cộng Đồng AutoIT Việt"	;Tên (các) Lập Trình Viện
	Global $Website = "http://72ls.net"			;Địa chỉ Blog
	Global $Forum = "http://autoit.72ls.net"
	Global $LinkDown = ""

	Global $AutoTitle = $AutoName&" v"&$AutoVersion&" "&$AutoBeta
	Global Const $ProcessNumber = 1					;Số lượng Chương Trình được phép chạy cùng 1 lúc

	Global $Functions = @LF							;Các chức năng của Chương Trình
	$Functions &= "  +Tự chơi Minesweeper"&@LF

;~ Biến ngôn ngữ
	Global $Menu_FileT = "&Quản Lý"
	Global $Menu_File_ExitT = "&Thoát"
	Global $Menu_HelpT = "&Hỗ Trợ"
	Global $Menu_Help_HotKeyT = "&Phím Nóng"
	Global $Menu_Help_AboutT = "&Thông Tin"

	Global $Hidden_ButtonT = "/\"
	Global $Button_ShowT = "\/"
	Global $Hidden_Button_TipT = "Thu gọn chương trình"
	Global $Pause_ButtonT1 = "<  >"
	Global $Pause_ButtonT2 = "<>"
	Global $Pause_Button_TipT = "Tạm ngưng hoạt động"
	Global $Exit_ButtonT = "X"
	Global $Exit_Button_TipT = "Thoát chương trình"

	Global $Option_TabT1 = "Hiệu Chỉnh"
	Global $ShowTestInfo_CheckBoxT1="Hiện Thông Số"
	Global $ShowTestInfo_CheckBox_Tip="Ẩn/Hiện các thông số hoạt động của Macro để test"

	Global $EnoughAutoT = $AutoName&" đã chạy đủ."&@LF&"Không thể mở thêm!!!"
	Global $PauseAutoT = "Tạm dừng"
	Return True
EndFunc

;~ Hàm tạo giao diện leesaigui
Func CreateMainGUI()
	Global $Font_Color = 0x0077FF 	;Cách khoảng từ trái sang phải
	Global $Tab_Size[2] = [0,25]	;Kích thức của Tab Menu

	Global $Horizontally = 7 	;Cách khoảng từ trái sang phải (ngang)
	Global $Vertically = 5 		;Cách khoảng từ trên xuống dưới (dọc)

;~ 	Khởi tạo Giao Diện
	Global $MainGUI_Size[2] = [200,200] ;Kích thước
	Global $MainGUI_Pos[2] = [0,0] ;Vị trí
	Global $MainGUI = GUICreate($AutoTitle,$MainGUI_Size[0],$MainGUI_Size[1],$MainGUI_Pos[0],$MainGUI_Pos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)

	$MenuTittle_Size = 38.5
;~ 	Menu Quản Lý
	$Menu_File = GUICtrlCreateMenu($Menu_FileT)

;~ 	Items của Quản Lý - Thoat
	$Menu_File_Exit = GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")

;~ 	Menu Help
	$Menu_Help = GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HotKey = GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_About = GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")

;~ 	Nút thoát
	Global $Exit_Button_Size[2] = [25,22]
	Global $Exit_Button_Pos[2] = [$MainGUI_Size[0]-$Exit_Button_Size[0]-$Horizontally,$MainGUI_Size[1]-$Exit_Button_Size[1]-$MenuTittle_Size-$Vertically]
	Global $Exit_Button = GUICtrlCreateButton($Exit_ButtonT,$Exit_Button_Pos[0],$Exit_Button_Pos[1],$Exit_Button_Size[0],$Exit_Button_Size[1])
	GUICtrlSetOnEvent($Exit_Button,"ExitAuto")
	GUICtrlSetTip($Exit_Button,$Exit_Button_TipT)

;~ 	Nút tạm ngưng
	Global $Pause_Button_Size[2] = [$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Pause_Button_Pos[2] = [$Exit_Button_Pos[0]-$Pause_Button_Size[0],$Exit_Button_Pos[1]]
	Global $Pause_Button = GUICtrlCreateButton($Pause_ButtonT1,$Pause_Button_Pos[0],$Pause_Button_Pos[1],$Pause_Button_Size[0],$Pause_Button_Size[1])
	GUICtrlSetOnEvent($Pause_Button,"ActivePauseAuto")
	GUICtrlSetTip($Pause_Button,$Pause_Button_TipT)

;~ 	Nút ẩn hiện
	Global $Hidden_Button_Size[2] = [$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Hidden_Button_Pos[2] = [$Pause_Button_Pos[0]-$Hidden_Button_Size[0],$Pause_Button_Pos[1]]
	Global $Hidden_Button = GUICtrlCreateButton($Hidden_ButtonT,$Hidden_Button_Pos[0],$Hidden_Button_Pos[1],$Hidden_Button_Size[0],$Hidden_Button_Size[1])
	GUICtrlSetOnEvent($Hidden_Button,"HiddenShow")
	GUICtrlSetTip($Hidden_Button,$Hidden_Button_TipT)

;~ 	Nơi hiển thị thông báo
	Global $Warning_Lable_Size[2] = [$MainGUI_Size[0],16]
	Global $Warning_Lable_Pos[2] = [$Horizontally,$Exit_Button_Pos[1]-$Warning_Lable_Size[1]]
	Global $Warning_Lable = GUICtrlCreateLabel("",$Warning_Lable_Pos[0],$Warning_Lable_Pos[1],$Warning_Lable_Size[0],$Warning_Lable_Size[1],$SS_CENTER)
	GUICtrlSetColor($Warning_Lable,$Font_Color)
	GUICtrlSetFont($Warning_Lable,9,777)

;~ 	Nơi hiển thị tình trạng hoạt động
	Global $Running_Lable_Size[2] = [9,13.3]
	Global $Running_Lable_Pos[2] = [$Horizontally,$Hidden_Button_Pos[1]+$Vertically]
	Global $Running_Lable = GUICtrlCreateLabel("",$Running_Lable_Pos[0],$Running_Lable_Pos[1],$Running_Lable_Size[0],$Running_Lable_Size[1])
	GUICtrlSetColor($Running_Lable,$Font_Color)

;~ 	Tab Chính
	Global $MainTab_Size[2]=[$MainGUI_Size[0],$MainGUI_Size[1]-90]
	Global $MainTab = GUICtrlCreateTab(0,0,$MainTab_Size[0],$MainTab_Size[1])

;~ 	Tab hiệu chỉnh các thông số =====================================================================================================
	Global $Option_Tab =GUICtrlCreateTabItem($Option_TabT1)

;~ 	Chỗ chọn hiển thị thông số chương trình
	Global $ShowTestInfo_CheckBox_Size[2]=[Default,14.2]
	Global $ShowTestInfo_CheckBox_Pos[2]=[$Horizontally,$Tab_Size[1]]
	Global $ShowTestInfo_CheckBox=GUICtrlCreateCheckbox($ShowTestInfo_CheckBoxT1,$ShowTestInfo_CheckBox_Pos[0],$ShowTestInfo_CheckBox_Pos[1],$ShowTestInfo_CheckBox_Size[0],$ShowTestInfo_CheckBox_Size[1])
	GUICtrlSetColor($ShowTestInfo_CheckBox,$Font_Color)
	GUICtrlSetTip($ShowTestInfo_CheckBox,$ShowTestInfo_CheckBox_Tip)

;~  	GUICtrlSetBkColor(-1,0xFFAA77)
EndFunc ;leesaiegui

;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------


;~ Tạo chuỗi các biến chương trình
Func SetTestInfo()
	Local $Test01 = ""
	$Test01&= "Note me: "

	Return $Test01
EndFunc
