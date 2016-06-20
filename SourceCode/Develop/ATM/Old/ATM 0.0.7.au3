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
;~ Func SetString() - Hàm nạp ngôn ngữ hiển thị
;~ Func CreateMainGUI() - Hàm tạo giao diện
;------- Hết Các Hàm Hoàn Chỉnh -----------------------------------------------------------------------------------------------------


;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------

;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------


;~ Func SetTestInfo() - Tạo chuỗi các biến chương trình
;== Hết Cấu Trúc Trương Trình =======================================================================================================

;-- Các Include và Option -------------------------------------------------------------------------------------------------------------
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <GUIConstantsEx.au3>
#include <NomadMemory.au3>
#Include <Array.au3>

AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("SendCapslockMode",1)
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
;~ HotKeySet ("^+s","Start_Button_Toogle")				;Ctrl+Shilf+s		- Bắt đầu chơi game
HotKeySet ("^+h","ShowInfoAuto")					;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{PAUSE}","ActivePauseAuto")				;Pause				- Tạm Dừng Auto
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("{END}","ExitAuto")						;End 				- Thoát Auto
HotKeySet ("{ESC}","ExitAuto")						;Escape 			- Thoát Auto
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
	Sleep(72)

;~ 	Các thao tác kiem tra
	Check_All_Button()
	Game_Check_Info()

;~ 	Hiện các thông số chương trình
	If IsShowTestInfo() Then
		SToolTip(SetTestInfo())
	EndIf

;~ 	Tạm dừng
	If PauseAuto() Then
		ShowPauseAuto()
		ContinueLoop
	EndIf

;~ 	Hiển thị thông báo tình trạng đang hoạt động
	RunningCheck()
	Start_Play_Task()
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
	Global $RunningI = 1				; Mã số trạng thái hoạt động
	Global $TaskI = 1					; Mã số công việc cần thực hiện
	Global $Mine_AroundI = 1				; Mã số công việc của scan 8 ô xung 1 Mine
	Global $TestInfoStatus = 4			;1 - Hiện các thông số chương trình
	Global $Scan_Mode = "dr"			;1 - Scan từ trên xuống, 0 - Scan từ dưới lên

	Global $Start = 0					;Trạng thái của nút Start Button

	;Các biến của Game
	Global $GameTitle = "Minesweeper"
	Global $GamePos[2] = [-1,-1]
	Global $GameCaretPos[2] = [0,0]
	Global $GameModeAddress = "0x01005334"
	Global $GameOverAddress = "0x01005000"
	Global $GameWinAddress = "0x01005160"
	Global $GameFlagAddress = "0x01005194"
	Global $GameMineNumberAddress = "0x01005798"
	Global $Space_Size = 16
	Global $ScanSize = 2
	Global $ColorShade = 2
	Global $Color1t = 12632256		;Ô Trắng
	Global $Color0 = 16777215		;Chưa mở
	Global $Color1 = 255
	Global $Color2 = 32768
	Global $Color3 = 16711680
	Global $Color4 = 128
	Global $Cur_Space_Number = 'out'	;out - không xác định

	Global $First_Pos[2] = [-1,-1]
	Global $Cur_Space_Pos[2] = [-1,-1]
	Global $Space_Is_Mine[1] = [0]
	Global $Mine_New[1] = [0]

EndFunc ;lsmainvar

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
		$text=$text&"End"&@TAB&@TAB&"- Thoát Auto"&@LF
		$text=$text&"ESC"&@TAB&@TAB&"- Thoát Auto"&@LF
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

;~ Hàm nạp chuỗi hiển thị
Func SetString()
;~ Biến Mô Tả Chương Trình
	Global $AutoName = "ATM"					;Tên Chương Trình
	Global $AutoBeta = "[Thử]"					;Chương Trình thử nghiệm
	Global $AutoVersion = "0.0.7"				;Phiên Bản
	Global $AutoVersionCode = ""				;Mã số Phiên Bản
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

	Global $Start_ButtonT1 = "Bắt Đầu"
	Global $Start_ButtonT2 = "Ngưng"
	Global $OpenGame_ButtonT1 = "Mở Game"

	Global $ShowTestInfo_CheckBoxT1 = "Hiệu Chỉnh"
	Global $ShowTestInfo_CheckBoxT1 = "Hiện Thông Số"
	Global $ShowTestInfo_CheckBoxT1 = "Hiện Thông Số"
	Global $ShowTestInfo_CheckBox_Tip = "Ẩn/Hiện các thông số hoạt động của Macro để test"

	Global $EnoughAutoT = $AutoName&" đã chạy đủ."&@LF&"Không thể mở thêm!!!"
	Global $PauseAutoT = "Tạm dừng"
	Return True
EndFunc

;~ Hàm tạo giao diện lsgui
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

;~ 	== Tab Chính ====================================================================================================================
	Global $MainTab_Size[2]=[$MainGUI_Size[0],$MainGUI_Size[1]-90]
	Global $MainTab = GUICtrlCreateTab(0,0,$MainTab_Size[0],$MainTab_Size[1])

;~ 	Tab hiệu chỉnh các thông số =====================================================================================================
	Global $Control_Tab =GUICtrlCreateTabItem("Điều Khiển")
	Local $Button_Size[2] = [52,25]

;~ 	Chỗ chọn hiển thị thông số chương trình
	Global $Start_Button_Size[2] = [$Button_Size[0],$Button_Size[1]]
	Global $Start_Button_Pos[2] = [$Horizontally,$Tab_Size[1]]
	Global $Start_Button = GUICtrlCreateButton($Start_ButtonT1,$Start_Button_Pos[0],$Start_Button_Pos[1],$Start_Button_Size[0],$Start_Button_Size[1])
	GUICtrlSetOnEvent($Start_Button,"Start_Button_Func")
	GUICtrlSetState($Start_Button,$GUI_DISABLE)

;~ 	Chỗ chọn hiển thị thông số chương trình
	Global $OpenGame_Button_Size[2] = [$Button_Size[0],$Button_Size[1]]
	Global $OpenGame_Button_Pos[2] = [$Start_Button_Pos[0] + $Start_Button_Size[0] + $Horizontally,$Start_Button_Pos[1]]
	Global $OpenGame_Button = GUICtrlCreateButton($OpenGame_ButtonT1,$OpenGame_Button_Pos[0],$OpenGame_Button_Pos[1],$OpenGame_Button_Size[0],$OpenGame_Button_Size[1])
	GUICtrlSetOnEvent($OpenGame_Button,"OpenGame_Button_Func")


;~ 	Tab hiệu chỉnh các thông số =====================================================================================================
	Global $Option_Tab = GUICtrlCreateTabItem("Hiệu Chỉnh")

;~ 	Chỗ chọn hiển thị thông số chương trình
	Global $ShowTestInfo_CheckBox_Size[2]=[Default,14.2]
	Global $ShowTestInfo_CheckBox_Pos[2]= [$Horizontally,$Tab_Size[1]]
	Global $ShowTestInfo_CheckBox=GUICtrlCreateCheckbox($ShowTestInfo_CheckBoxT1,$ShowTestInfo_CheckBox_Pos[0],$ShowTestInfo_CheckBox_Pos[1],$ShowTestInfo_CheckBox_Size[0],$ShowTestInfo_CheckBox_Size[1])
	GUICtrlSetColor($ShowTestInfo_CheckBox,$Font_Color)
	GUICtrlSetTip($ShowTestInfo_CheckBox,$ShowTestInfo_CheckBox_Tip)
;~ 	GUICtrlSetState($ShowTestInfo_CheckBox,$GUI_CHECKED)

;~  	GUICtrlSetBkColor(-1,0xFFAA77)
EndFunc ;lsguiend




;~ Kích hoạt nút Start
Func Start_Button_Enable()
	If GUICtrlGetState($Start_Button) <> 80 Then GUICtrlSetState($Start_Button,$GUI_ENABLE)
EndFunc

;~ Khóa nút Start
Func Start_Button_Disable()
	If GUICtrlGetState($Start_Button) == 80 Then GUICtrlSetState($Start_Button,$GUI_DISABLE)
EndFunc

;~ Hiệu chỉnh lable của Start_Button
Func Start_Button_Set_Lable($Lable)
	Local $Old = Start_Button_Get_Lable()
	If $Old <> $Lable Then GUICtrlSetData($Start_Button,$Lable)
EndFunc

;~ Hiệu chỉnh lable của Start_Button
Func Start_Button_Get_Lable()
	return GUICtrlRead($Start_Button)
EndFunc

;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------


;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Kiểm tra các thông số của game
Func Game_Check_Info()
	Game_Get_CaretPos()
EndFunc

;~ Kiểm tra trạng thái tất cả các nút
Func Check_All_Button()
	Check_Start_Button()
EndFunc

;~ Kiểm tra trạng thái nút Start
Func Check_Start_Button()
	If WinExists($GameTitle) And $GameCaretPos[0] Then
		Start_Button_Enable()
	Else
		Start_Button_Disable()
	EndIf
EndFunc

Func OpenGame_Button_Func()
	If Not WinExists($GameTitle) Then Run("winmine")	;Kích hoạt game
EndFunc

;~ Bắt đầu tự chơi
Func Start_Button_Func()
	Start_Button_Toogle()
EndFunc

;~ Bật tắc các trạng thái của nút Start
Func Start_Button_Toogle($Mode = -1)
	If $Mode == -1 Then
		$Start = not $Start
	Else
		$Start = $Mode
	EndIf

	$Running = $Start
	If $Start Then
		$TaskI = 1
		Game_Set_Open_Mine()
		Start_Button_Set_Lable($Start_ButtonT2)
	Else
		Start_Button_Set_Lable($Start_ButtonT1)
	EndIf
EndFunc

;~ Hàm lấy tọa độ khung của game
Func Game_Get_CaretPos()
	If Game_Is_Move() Then
		If WinActivate($GameTitle) Then
			$GameCaretPos = WinGetCaretPos()
		EndIf
	EndIf
	If $GameCaretPos[0] <> -1 Then Return 1
	Return 0
EndFunc

;~ Hàm kiểm tra xem game có bị di chuyển không
Func Game_Is_Move()
	Local $Pos = WinGetPos($GameTitle)

	If @error Then
		Start_Button_Toogle(0)
		Return 0
	EndIf

	If $Pos[0] == $GamePos[0] And $Pos[1] == $GamePos[1] Then
		return 0
	Else
		$GamePos = $Pos
		Return 1
	EndIf
EndFunc


;~ Kiểm tra số ô vừa được mở
Func Game_Get_Open_Mine()
	Return Game_Read_Memory($GameMineNumberAddress)
EndFunc

;~ Kiểm tra số ô vừa được mở
Func Game_Set_Open_Mine($Data = 0)
	Game_Write_Memory($GameMineNumberAddress,$Data)
EndFunc

;~ Mở Memory của game
Func Game_Open_Memory()
	Local $iv_Pid = WinGetProcess($GameTitle)
	Return _MemoryOpen($iv_Pid)
EndFunc

;~ Đọc Memory của game
Func Game_Read_Memory($iv_Address)
	Local $ah_Handle = Game_Open_Memory()
	Local $Data = _MemoryRead($iv_Address, $ah_Handle)
	_MemoryClose($ah_Handle)
	Return $Data
EndFunc

;~ Ghi Memory của game
Func Game_Write_Memory($iv_Address,$Data)
	Local $ah_Handle = Game_Open_Memory()
	_MemoryWrite($iv_Address, $ah_Handle,$Data)
	_MemoryClose($ah_Handle)
	Return $Data
EndFunc

;~ Kiểm tra xem có dẫm phải bom không
Func Game_Is_Over()
	If Game_Read_Memory($GameOverAddress) == 16 Then Return 1
	Return 0
EndFunc

;~ Lấy số lượng cờ còn lại
Func Game_Get_Flag()
	Return Game_Read_Memory($GameFlagAddress)
EndFunc

;~ Kiểm tra chế độ chơi của game
Func Game_Get_Mode()
	Local $Mode[2] = [0,0]
	$Mode[0] = Game_Read_Memory($GameModeAddress)
	$Mode[1] = Game_Read_Memory("0x01005338")
	Return $Mode
EndFunc

;~ Tìm ô có số
Func Game_Next_Space()
	Switch $Scan_Mode
		Case "dr"
			$Cur_Space_Pos[0]+=1
			If $Cur_Space_Pos[0] > 8 Then
				$Cur_Space_Pos[0] = $First_Pos[0]
				$Cur_Space_Pos[1]+= 1
			EndIf
		Case "dl"
			$Cur_Space_Pos[0]-=1
			If $Cur_Space_Pos[0] < 0 Then
				$Cur_Space_Pos[0] = $First_Pos[0]-1
				$Cur_Space_Pos[1]+= 1
			EndIf
		Case "ur"
			$Cur_Space_Pos[0]+=1
			If $Cur_Space_Pos[0] > 8 Then
				$Cur_Space_Pos[0] = $First_Pos[0]
				$Cur_Space_Pos[1]-= 1
			EndIf
		Case "ul"
			$Cur_Space_Pos[0]-=1
			If $Cur_Space_Pos[0] < 0 Then
				$Cur_Space_Pos[0] = $First_Pos[0]-1
				$Cur_Space_Pos[1]-= 1
			EndIf
	EndSwitch


	If $Cur_Space_Pos[1] > 8 And $Scan_Mode = 'dr' Then
		$Scan_Mode = 'dl'
		$Cur_Space_Pos = $First_Pos
		$Cur_Space_Pos[0] = $First_Pos[0]-1
	EndIf

	If $Cur_Space_Pos[1] > 8 And $Scan_Mode = 'dl' Then
		$Scan_Mode = 'ur'
		$Cur_Space_Pos = $First_Pos
		$Cur_Space_Pos[1] = $First_Pos[1]-1
	EndIf

	If $Cur_Space_Pos[1] < 0 And $Scan_Mode = 'ur' Then
		$Scan_Mode = 'ul'
		$Cur_Space_Pos = $First_Pos
		$Cur_Space_Pos[0] = $First_Pos[0]-1
		$Cur_Space_Pos[1] = $First_Pos[1]-1
	EndIf

	If $Cur_Space_Pos[1] < 0 Then
		$Scan_Mode = 'dr'
		$Cur_Space_Pos = $First_Pos
	EndIf
EndFunc

;~ Click 1 Mine bất kỳ
Func Game_Click_Random_Space()
	Local $Mines_Size = Game_Get_Mode()
	$Cur_Space_Pos[0] = Random(1,$Mines_Size[0]-1,1)
	$Cur_Space_Pos[1] = Random(1,$Mines_Size[1]-1,1)
	Local $Space_Number = Space_Get_Number($Cur_Space_Pos[0],$Cur_Space_Pos[1])

	If $Space_Number = 0 Then
		Game_Click_Mine($Cur_Space_Pos[0],$Cur_Space_Pos[1])
	EndIf
EndFunc

;~ Hàm quét tìm Mine tại 1 điểm
Func Game_Get_Space($x,$y)
	Local $Space[3] = [-1,-1,0]
	Local $Coor = Mine_Get_Coor($x,$y)
	$Space[0] = $Coor[0]
	$Space[1] = $Coor[1]
	$Space[2] = Space_Get_Number($x,$y)
	Return $Space
EndFunc

;~ Lấy tọa đồ chuột của một quả bom
Func Mine_Get_Coor($x,$y)
	Local $Pos[2] = [-1,-1]

	Local $GameMode = Game_Get_Mode()
	If $x < 0 Or $y < 0 or $x > $GameMode[0] Or $y > $GameMode[1] Then Return $Pos

	Local $Game_First_Space_Pos = Game_Fist_Space_Pos()

	If $Game_First_Space_Pos[0] == -1 Then Return $Pos
	Local $SpanX = $x*$Space_Size
	Local $SpanY = $y*$Space_Size

	$Pos[0] = $Game_First_Space_Pos[0]+$SpanX
	$Pos[1] = $Game_First_Space_Pos[1]+$SpanY
	Return $Pos
EndFunc

;~ Lấy vị trí của quả bom đầu tiện
Func Game_Fist_Space_Pos()
	Local $Pos[2] = [-1,-1]
	If Not Game_Get_CaretPos() Then return $Pos
	Local $Span = Round($Space_Size/2)
	Local $Pos[2] = [$GameCaretPos[0]+$Span+12,$GameCaretPos[1]+$Span+55]
	Return $Pos
EndFunc

;~ Kiểm tra xem vị trí thuộc loại Mine gì
Func Space_Get_Number($x,$y)
	Local $Space = Mine_Get_Coor($x,$y)
	If $Space[0] = -1 Then Return "out"

	Local $ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color1,$ColorShade)
	If Not @error Then Return 1

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color2,$ColorShade)
	If Not @error Then Return 2

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color3,$ColorShade)
	If Not @error Then Return 3

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color4,$ColorShade)
	If Not @error Then Return 4

	$Space[1]-=8
	$ColorSeach = PixelSearch($Space[0],$Space[1],$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color0)
	If Not @error Then Return 0

	Return -1
EndFunc

;~ Bấm vào vào ô hiện tại
Func Game_Click_Mine($x,$y,$mode = "left")
	Local $Pos = Mine_Get_Coor($x,$y)

	Switch $mode
		Case $mode = 'tooltip'
			Local $Number = Space_Get_Number($x,$y)
			tooltip($Number,$Pos[0],$Pos[1])
		Case $mode = 'move'
			MouseMove($Pos[0],$Pos[1])
		Case Else
			MouseClick($mode,$Pos[0],$Pos[1])
	EndSwitch
EndFunc

;~ Kích hoạt chức năng tự chơi lstask
Func Start_Play_Task()
	If Not $Start Then Return

	Switch $TaskI
		Case 1 ;Kích hoạt Mine cho đến khi tìm trúng Mạch, đánh dấu $First_Pos
			Game_Click_Random_Space()
			If Game_Is_Over() Then Send("{F2}")
			If Game_Get_Open_Mine() > 7 Then
				$TaskI = 2
				$First_Pos = $Cur_Space_Pos
			EndIf
		Case 2
			Sleep(222)
			Game_Next_Space()
			$Cur_Space_Number = Space_Get_Number($Cur_Space_Pos[0],$Cur_Space_Pos[1])
			Game_Click_Mine($Cur_Space_Pos[0],$Cur_Space_Pos[1],'move')
			If $Cur_Space_Number > 0 Then
				$TaskI = 3
			EndIf
		Case 3
			Local $Pos = Game_Find_Mine()
			If $Pos[0] <> -1 AND Space_Get_Number($Pos[0],$Pos[1]) == 0 Then
				_ArrayAdd($Space_Is_Mine,$Pos[0]&"x"&$Pos[1])
				$Space_Is_Mine[0]+=1
				Game_Click_Mine($Pos[0],$Pos[1],'tooltip')
			EndIf
		Case 4

		Case Else
			$TaskI = 1
	EndSwitch
EndFunc

;~ Tìm Mine xung quanh 1 con số
Func Game_Find_Mine()
	Local $Pos[2] = [-1,-1]
	$Pos = Mine_Get_Around($Mine_AroundI)

	$Mine_AroundI+=1
	If $Mine_AroundI == 9 Then
		$Mine_AroundI = 1
		$Pos[0] = -1
;~ 		_ArrayDisplay($Space_Is_Mine)
		$TaskI = 2
	EndIf
	Return $Pos
EndFunc

;~ Lấy tọa độ của 8 ô xung manh 1 Mine
Func Mine_Get_Around($Number,$Pos = 'null')
	If $Pos == 'null' Then $Pos = $Cur_Space_Pos
	Switch $Number
		Case 1
			$Pos[0]-=1
			$Pos[1]-=1
		Case 2
			$Pos[1]-=1
		Case 3
			$Pos[0]+=1
			$Pos[1]-=1
		Case 4
			$Pos[0]+=1
		Case 5
			$Pos[0]+=1
			$Pos[1]+=1
		Case 6
			$Pos[1]+=1
		Case 7
			$Pos[0]-=1
			$Pos[1]+=1
		Case 8
			$Pos[0]-=1
	EndSwitch

	If $Pos[0] < 0 or $Pos[0] > 8 Then $Pos[0] = -1
	If $Pos[1] < 0 or $Pos[1] > 8 Then $Pos[1] = -1

	Return $Pos
EndFunc


Func Reset_Auto()
	$TaskI = 1
	$Mine_AroundI = 1
	Send("{F2}")
	DelTooltip()
	ReDim $Mine_New[1]
	$Mine_New[0] = 0
EndFunc
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------


;~ Tạo chuỗi các biến chương trình
Func SetTestInfo()

	Local $Pos = MouseGetPos()
	Local $Color = PixelGetColor($Pos[0],$Pos[1])
	Local $GameMode = Game_Get_Mode()
	Local $GameOver = Game_Is_Over()
	Local $GameFlag = Game_Get_Flag()
	Local $GameOnOpen = Game_Get_Open_Mine()
	GUICtrlSetBkColor($Running_Lable,$Color)
	Game_Get_CaretPos()

	Local $Test01 = ""
	$Test01&= "$GameOver: "&$GameOver&@LF
	$Test01&= "$GameFlag: "&$GameFlag&@LF
	$Test01&= "$GameOnOpen: "&$GameOnOpen&@LF
	$Test01&= "$RunningI: "&$RunningI&@LF
	$Test01&= "$TaskI: "&$TaskI&@LF
	$Test01&= "$Mine_AroundI: "&$Mine_AroundI&@LF
	$Test01&= "$Cur_Space_Number: "&$Cur_Space_Number&@LF
	$Test01&= "$GameMode: "&$GameMode[0]&" / "&$GameMode[1]&@LF
	$Test01&= "$First_Pos: "&$First_Pos[0]&" / "&$First_Pos[1]&@LF
	$Test01&= "$Cur_Space_Pos: "&$Cur_Space_Pos[0]&" / "&$Cur_Space_Pos[1]&@LF
	$Test01&= "$GamePos: "&$GamePos[0]&" / "&$GamePos[1]&@LF
	$Test01&= "$GameCaretPos: "&$GameCaretPos[0]&" / "&$GameCaretPos[1]&@LF
	$Test01&= "$MouseGetPos: "&$Pos[0]&" / "&$Pos[1]&@LF
	$Test01&= "$PixelGetColor: "&$Color&@LF

	Return $Test01
EndFunc
