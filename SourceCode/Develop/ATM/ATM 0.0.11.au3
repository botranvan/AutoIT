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
#include <TabConstants.au3>		;NoShow
#include <GUIConstantsEx.au3>	;NoShow
#include <NomadMemory.au3>		;NoShow
#Include <Array.au3>			;NoShow


AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("SendCapslockMode",0)
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+r","Reset_Auto")						;Ctrl+Shilf+R		- Khởi động lại Auto và Game
HotKeySet ("^+h","ShowInfoAuto")					;Ctrl+Shilf+H		- Xem thông tin của Auto
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+K		- Xem phím Nóng
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
	If Not $Start Then
		Sleep(72)
	Else
		Sleep(9)
	EndIf

;~ 	Các thao tác kiem tra
	Check_All_Button()
	Game_Check_Info()

;~ 	Hiện các thông số chương trình
	If IsShowTestInfo() Then
		SToolTip(SetTestInfo())
	EndIf

;~ 	Tạm dừng
	If PauseAuto() Then
		Sleep(72)
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
	Global $Mine_AroundI = 1			; Mã số công việc của scan 8 ô xung 1 Mine
	Global $New_FlagI = 1				; Số thứ tự Flag đang quét trong $New_Flag
	Global $Flag_AroundI = 1			; Mã số công việc của scan 8 ô xung 1 Flag
	Global $TestInfoStatus = 4			;1 - Hiện các thông số chương trình
	Global $Scan_Mode = "start"			;1 - Scan từ trên xuống, 0 - Scan từ dưới lên

	Global $Start = 0					;Trạng thái của nút Start Button

	;Các biến của Game
	Global $GameTitle = "Minesweeper"
	Global $GamePos[2] = [-1,-1]
	Global $GameCaretPos[2] = [0,0]
	Global $GameOverAddress = "0x01005000"
	Global $GameWinAddress = "0x01005160"
	Global $GameFlagAddress = "0x01005194"
	Global $GameMineNumberAddress = "0x01005798"
	Global $SpaceOpenAddress = "0x010057A4"
	Global $Space_Size = 16
	Global $ScanSize = 2
	Global $ColorShade = 2
	Global $Color1t = 12632256		;Ô Trắng
	Global $Color0 = 16777215		;Chưa mở
	Global $Color1 = 255
	Global $Color2 = 32768
	Global $Color3 = 16711680
	Global $Color4 = 128
	Global $Color5 = 8388608
	Global $Cur_Space_Number = 'out'	;out - không xác định

	Global $First_Pos[2] = [-1,-1]
	Global $Cur_Space_Pos[2] = [-1,-1]
	Global $Space_Is_Mine[1] = [0]
	Global $New_Flag[1] = [0]
	Global $Space_Is_Flag = 0
	Global $Space_In_Zone = 0
	Global $Space_In_Row = 0
	Global $Mine_New[1] = [0]
	Global $Space_Zone[4] = [1,1,1,1]	;Trang thái cho các zone: dr, dl , ur, rl

	Global $Space_Map[99][99]				;Trang thái cho các zone: dr, dl , ur, rl

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
		Sleep(270)
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
	Global $AutoVersion = "0.0.11"				;Phiên Bản
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

;~ Hàm tạo giao diện
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

;~ Lấy lable của Start_Button
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
	If Not WinExists($GameTitle) Then
		Run("winmine")	;Kích hoạt game
	Else
		WinActivate($GameTitle)
	EndIf
	Game_Set_Mode()
EndFunc

;~ Chọn chế độ chơi
Func Game_Set_Mode()
	Sleep (72)
	$t = Send("!g")
;~ 	$ta = Send("b")
	$ta = Send("i")
	Sleep(720)
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
Func Get_Space_Open()
	Return Game_Read_Memory($SpaceOpenAddress)
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

;~ Kiểm tra xem là thắng hay thua
Func Game_Is_Win()
	If Game_Read_Memory($GameWinAddress) == 3 Then Return 1
	Return 0
EndFunc

;~ Lấy số lượng cờ còn lại
Func Game_Get_Flag()
	Return Game_Read_Memory($GameFlagAddress)
EndFunc

;~ Kiểm tra chế độ chơi của game
Func Game_Get_Mode()
	Local $Mode[2] = [0,0]
	$Mode[0] = Game_Get_Width()
	$Mode[1] = Game_Get_Height()
	Return $Mode
EndFunc

Func Game_Get_Width()
	return Game_Read_Memory("0x01005334")
EndFunc


Func Game_Get_Height()
	return Game_Read_Memory("0x01005338")
EndFunc

;~ Tìm ô có số
Func Game_Next_Space()
	Game_Next_Space_By_Step()
EndFunc

;~ Chuyển sang Space tiếp theo bằng cơ chế Step By Step in Zone
Func Game_Next_Space_By_Step()
	Game_Next_Zone()
	Local $Span = 1;Random(1,1,1)
	Switch $Scan_Mode
		Case "dr"
			$Cur_Space_Pos[0]+=$Span
			If $Cur_Space_Pos[0] > Game_Get_Width()-1 Then
				$Cur_Space_Pos[0] = $First_Pos[0]
				$Cur_Space_Pos[1]+= 1
			Else
				$Space_In_Row+=1
			EndIf

		Case "dl"
			$Cur_Space_Pos[0]-=$Span
			If $Cur_Space_Pos[0] < 0 Then
				$Cur_Space_Pos[0] = $First_Pos[0]-1
				$Cur_Space_Pos[1]+= 1
			EndIf

		Case "ur"
			If $First_Pos[1] = $Cur_Space_Pos[1] Then
				$Cur_Space_Pos[1]-=1
			Else
				$Cur_Space_Pos[0]+=$Span
			EndIf

			If $Cur_Space_Pos[0] > Game_Get_Width()-1 Then
				$Cur_Space_Pos[0] = $First_Pos[0]
				$Cur_Space_Pos[1]-= 1
			EndIf

		Case "ul"
			If $First_Pos[1] = $Cur_Space_Pos[1] Then
				$Cur_Space_Pos[1]-=1
			Else
				$Cur_Space_Pos[0]-=$Span
			EndIf

			If $Cur_Space_Pos[0] < 0 Then
				$Cur_Space_Pos[0] = $First_Pos[0]
				$Cur_Space_Pos[1]-= 1
			EndIf
	EndSwitch

EndFunc

;~ Chuyển sang vùng tiếp theo của Game
Func Game_Next_Zone($Zone = "")
	If $Cur_Space_Pos[1] > Game_Get_Height()-1 OR $Cur_Space_Pos[1] < 0 Then
		Select
			Case $Scan_Mode == "dr"
				$Scan_Mode = "dl"
				Reset_First_Pos()
				$First_Pos[0]+=1
				$First_Pos[1]-=1

				If $Space_In_Zone < 1 Then
					$Space_Zone[0] = 0
				EndIf
				If Not $Space_Zone[1] Then ContinueCase
			Case $Scan_Mode == "dl"
				$Scan_Mode = "ur"
				Reset_First_Pos()
				$First_Pos[0]-=1
				$First_Pos[1]+=1

				If $Space_In_Zone < 1 Then
					$Space_Zone[1] = 0
				EndIf
				If Not $Space_Zone[2] Then ContinueCase
			Case $Scan_Mode == "ur"
				$Scan_Mode = "ul"
				Reset_First_Pos()
				$First_Pos[0]+=1
				$First_Pos[1]+=1

				If $Space_In_Zone < 1 Then
					$Space_Zone[2] = 0
				EndIf
				If Not $Space_Zone[3] Then ContinueCase
			Case $Scan_Mode == "ul"
				$Scan_Mode = "done"

				If $Space_In_Zone < 1 Then
					$Space_Zone[3] = 0
				EndIf
		EndSelect
		$Space_In_Zone = 0
		$Cur_Space_Pos = $First_Pos
	EndIf
	If $Scan_Mode == "start" Then
		If $Space_Zone[0] Then
			$Scan_Mode = "dr"
			Reset_First_Pos()
			$First_Pos[0]-=1
			$First_Pos[1]-=1
		ElseIf $Space_Zone[1] Then
			$Scan_Mode = "dl"
			Reset_First_Pos()
			$First_Pos[0]+=1
			$First_Pos[1]-=1
		ElseIf $Space_Zone[2] Then
			$Scan_Mode = "ur"
			Reset_First_Pos()
			$First_Pos[0]-=1
			$First_Pos[1]+=1
		ElseIf $Space_Zone[3] Then
			$Scan_Mode = "ul"
			Reset_First_Pos()
			$First_Pos[0]+=1
			$First_Pos[1]+=1
		Else
			$Scan_Mode = "start"
		EndIf

		$Cur_Space_Pos = $First_Pos
		$Space_In_Zone = 0
	EndIf
EndFunc

Func Reset_First_Pos()
	$First_Pos[0] = Floor(Game_Get_Width()/2)
	$First_Pos[1] = Floor(Game_Get_Height()/2)
EndFunc


;~ Click 1 Mine bất kỳ
Func Game_Click_Random_Space()
	Local $Mines_Size = Game_Get_Mode()
	Local $Pos[2] = [0,0]
	$Pos[0] = Random(2,$Mines_Size[0]-2,1)
	$Pos[1] = Random(2,$Mines_Size[1]-2,1)
	Local $Space_Number = Space_Get_Number($Pos[0],$Pos[1])

	If $Space_Number = 0 Then
		Game_Click_Mine($Pos[0],$Pos[1])
	EndIf
	Return $Pos
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

Func Space_Get_Number_From_Map($x,$y)
;~ 	msgbox(0,"",$Space_Map[$x][$y])
;~ 	If $x >= 0 And $y >= 0 Then Return $Space_Map[$x][$y]
	Return False
EndFunc

;~ Kiểm tra xem vị trí thuộc loại Mine gì
Func Space_Get_Number($x,$y)
	Local $Number = Space_Get_Number_From_Map($x,$y)
	If $Number Then Return $Number

	$Number = Space_Get_Number_By_Pixel($x,$y)
;~ 	If $Number = "c" Then Add_New_Space($x,$y)
	If $x > -1 AND $x < 9 AND $Number <> 0 Then
		$Space_Map[$y][$x] = $Number
	EndIf

	Return $Number
EndFunc

;~ Xác định số của Space bằng Pixel
Func Space_Get_Number_By_Pixel2($x,$y)

	Local $Space = Mine_Get_Coor($x,$y)
	If $Space[0] = -1 Then Return "out"

	Local $ColorSeach
	If PixelGetColor($Space[0],$Space[1]+1) = 0 Then return "c"
	If PixelGetColor($Space[0],$Space[1]-8) = $Color0 Then Return 0

	$ColorSeach = PixelGetColor($Space[0],$Space[1])
	If $ColorSeach = $Color1 Then Return 1
	If $ColorSeach = $Color2 Then Return 2
	If $ColorSeach = $Color3 Then Return 3
	If $ColorSeach = $Color4 Then Return 4
	If $ColorSeach = $Color5 Then Return 5
	Return -1
EndFunc
Func Space_Get_Number_By_Pixel($x,$y)

	Local $Space = Mine_Get_Coor($x,$y)
	If $Space[0] = -1 Then Return "out"

	Local $ColorSeach
;~ 	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color1,$ColorShade)
;~ 	If Not @error Then Return 1
	$ColorSeach = PixelGetColor($Space[0]-$ScanSize,$Space[1]-$ScanSize)
	If $ColorSeach = $Color1 Then Return 1

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color2,$ColorShade)
	If Not @error Then Return 2

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color3,$ColorShade)
	If Not @error Then
		$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,0,$ColorShade)
		If Not @error Then Return "c"
		Return 3
	EndIf

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color4,$ColorShade)
	If Not @error Then Return 4

	$ColorSeach = PixelSearch($Space[0]-$ScanSize,$Space[1]-$ScanSize,$Space[0]+$ScanSize,$Space[1]+$ScanSize,$Color5,$ColorShade)
	If Not @error Then Return 5

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
			If IsNumber($Number) Then tooltip($Number,$Pos[0]+4,$Pos[1]+4)
		Case $mode = 'move'
			If $Pos[0] <> -1 Then MouseMove($Pos[0],$Pos[1],0)
		Case Else
;~ 			MouseClick($mode,$Pos[0],$Pos[1],1)
			ControlClick($GameTitle,"","",$mode,1,20 + $x * 16,60 + $y*16)
	EndSwitch
	If Game_Is_Over() Then Reset_Auto()
EndFunc

;~ Kích hoạt chức năng tự chơi lstask
Func Start_Play_Task()
	If Not $Start Then Return

	Switch $TaskI
		Case 1 ;Kích hoạt Mine cho đến khi tìm trúng Mạch, đánh dấu $First_Pos
			$Cur_Space_Pos = Game_Click_Random_Space()
			If Game_Is_Over() Or Game_Is_Win() Then
 				Auto_Next_Task("GameOver")
				ContinueCase
			EndIf

			If Get_Space_Open() > 7 Then
;~ 			If Game_Get_Open_Mine() > 7 Then
				Auto_Next_Task()
				Reset_First_Pos()
			EndIf

		Case 2 ;Chuyển sang Space tiếp theo
			If Get_Space_Open() < 7 Then ;Or Not Game_Get_Flag()
				Auto_Next_Task("GameOver")
				Return
			EndIf

			Game_Next_Space()

			$Cur_Space_Number = Space_Get_Number($Cur_Space_Pos[0],$Cur_Space_Pos[1])
			If $Cur_Space_Pos[0] < Game_Get_Width() AND $Cur_Space_Pos[1] < Game_Get_Height() AND _
			   $Cur_Space_Pos[0] > -1 AND $Cur_Space_Pos[1] > -1 AND $Cur_Space_Number == 0 Then
				$Space_In_Zone+=1
;~ 				msgbox(0,$Space_In_Zone,$Cur_Space_Number&": "&$Cur_Space_Pos[0]&"/"&$Cur_Space_Pos[1])
			EndIf
			If $Cur_Space_Number > 0 Then Auto_Next_Task()

			If $Scan_Mode = "done" Then
				If $New_Flag[0] > 0 Then
					Auto_Next_Task("ScanFlag")
;~ 					HiddenShow()
				Else
;~ 					MsgBox(0,$AutoName,"Hết Đường",2)
;~ 					Auto_Next_Task("GameOver")
				EndIf
;~ 				$Scan_Mode = "start"
			EndIf

;~ 			Game_Click_Mine($Cur_Space_Pos[0],$Cur_Space_Pos[1],'move')
;~ 			Game_Click_Mine($Cur_Space_Pos[0],$Cur_Space_Pos[1],'tooltip')

		Case 3 ;Tìm Ô Trống và Mine ơ Space hiện tại
			Local $Pos = Game_Find_Mine()
;~ 			If $Pos[0] = -1 Then Auto_Next_Task(2)
			Local $Number = Space_Get_Number($Pos[0],$Pos[1])

			If ($Number == 0 OR $Number == "c") Then ;$Pos[0] <> -1 AND
				If ($Number == 0) Then
					_ArrayAdd($Space_Is_Mine,$Pos[0]&"x"&$Pos[1])
;~ 					If $Mine_AroundI > 8 Then _ArrayDisplay($Space_Is_Mine)
				Else
					_ArrayAdd($Space_Is_Mine,$Pos[0]&"x"&$Pos[1]&"xc")
					$Space_Is_Flag+=1
				EndIf
				$Space_Is_Mine[0]+=1
			EndIf
;~ 			Game_Click_Mine($Cur_Space_Pos[0],$Cur_Space_Pos[1],'move')
			Game_Click_Mine($Cur_Space_Pos[0],$Cur_Space_Pos[1],'tooltip')

			If $Mine_AroundI > 8 Then
				If $Space_Is_Mine[0] == $Cur_Space_Number AND $Cur_Space_Number <> 0 Then
;~ 					_ArrayDisplay($Space_Is_Mine)
					Space_Set_Flag($Space_Is_Mine)
				EndIf
				If $Space_Is_Flag == $Cur_Space_Number AND $Space_Is_Flag > 0 Then
;~ 					_ArrayDisplay($Space_Is_Mine)
					Space_Open($Space_Is_Mine)
				EndIf


				If Game_Is_Win() Then
					Auto_Next_Task("WinGame")
					Return
				Else
					$Mine_AroundI = 1
					$TaskI = 2

					ReDim $Space_Is_Mine[1]
					$Space_Is_Mine[0] = 0
					$Space_Is_Flag = 0
				EndIf
			EndIf

		Case "ScanFlag"
			If $New_FlagI > $New_Flag[0] Then
				$New_FlagI = 1
				$Scan_Mode = "start"
				$TaskI = 2
				ReDim $New_Flag[1]
				$New_Flag[0] = 0
				Return
			EndIf

			Local $Pos = Get_Pos_From_String($New_Flag[$New_FlagI])
			$Cur_Space_Pos = Mine_Get_Around($Flag_AroundI,$Pos)

			$Flag_AroundI+=1
			If $Flag_AroundI > 8 Then
				$Flag_AroundI = 1
				$New_FlagI+=1
			EndIf

			$Cur_Space_Number = Space_Get_Number($Cur_Space_Pos[0],$Cur_Space_Pos[1])
			$TaskI = 3

		Case "GameOver"
			If WinExists("[CLASS:#32770]","") Then
				Sleep(72)
				ControlSetText("[CLASS:#32770]","","[CLASS:Edit; INSTANCE:1]","72ls.net")
				Sleep(72)
				ControlClick("[CLASS:#32770]","","[CLASS:Button; INSTANCE:1]")
				Sleep(72)
				ControlClick("[CLASS:#32770]","","[CLASS:Button; INSTANCE:1]")
			EndIf
			Reset_Auto()
			Return
		Case Else
			$TaskI = 1
	EndSwitch
EndFunc

Func Get_Pos_From_String($string)
	Local $Pos = StringSplit($string,"x")
	Local $NewPos[2] = [$Pos[1],$Pos[2]]
	Return $NewPos
EndFunc

Func Auto_Next_Task($Task = "")
	If $Task == "" Then
		$TaskI+=1
	Else
		$TaskI = $Task
	EndIf
EndFunc

Func Add_New_Space($x,$y)
	_ArrayAdd($New_Flag,$x&"x"&$y)
	$New_Flag[0]+=1
EndFunc

Func Space_Set_Flag($Space_Is_Mine)
	For $i = 1 To $Space_Is_Mine[0] Step 1
		Local $Pos = StringSplit($Space_Is_Mine[$i],"x")
		If $Pos[0] <> 3 Then
			Game_Click_Mine($Pos[1],$Pos[2],'right')
			Add_New_Space($Pos[1],$Pos[2])
			$Space_Map[$Pos[2]][$Pos[1]] = "C"
;~ 			$First_Pos[0] = $Pos[1]
;~ 			$First_Pos[1] = $Pos[2]
;~ 			$Space_In_Zone-= 1
		EndIf
	Next
EndFunc

Func Space_Open($Space_Is_Mine)

	For $i = 1 To $Space_Is_Mine[0] Step 1
		Local $Pos = StringSplit($Space_Is_Mine[$i],"x")
		If $Pos[0] = 2 Then
			Game_Click_Mine($Pos[1],$Pos[2])
;~ 			$Space_In_Zone-= Game_Get_Open_Mine()
;~ 			msgbox(0,"",Game_Get_Open_Mine())

;~ 			msgbox(0,$Space_Is_Mine[0]&"/"&$Space_Is_Flag,$Space_Is_Mine[$i])
		EndIf
	Next
EndFunc

;~ Tìm Mine xung quanh 1 con số
Func Game_Find_Mine()
	Local $Pos[2] = [-1,-1]
	$Pos = Mine_Get_Around($Mine_AroundI)

	$Mine_AroundI+=1
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

	If $Pos[0] < 0 or $Pos[0] > Game_Get_Width()-1 Then $Pos[0] = -1
	If $Pos[1] < 0 or $Pos[1] > Game_Get_Height()-1 Then $Pos[0] = -1 ;leesai

	Return $Pos
EndFunc


Func Reset_Auto()
	Game_Set_Open_Mine()
	$Space_Is_Flag = 0
	Global $Space_Zone[4] = [1,1,1,1]

	ReDim $Space_Is_Mine[1]
	$Space_Is_Mine[0] = 0

	ReDim $Mine_New[1]
	$Mine_New[0] = 0
	$Mine_AroundI = 1

	ReDim $New_Flag[1]
	$New_Flag[0] = 0
	$New_FlagI = 1

	$Space_In_Zone = 0
	$Scan_Mode = "dr"

	ReDim $Space_Map[1]
	$Space_Map[0] = ""
	ReDim $Space_Map[99][99]

	WinActivate($GameTitle)
	Send("{F2}")
	$TaskI = 1
EndFunc
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------


;~ Tạo chuỗi các biến chương trình
Func SetTestInfo()

	Local $Pos = MouseGetPos()
	Local $Color = PixelGetColor($Pos[0],$Pos[1])
	Local $GameMode = Game_Get_Mode()
	Local $GameOver = Game_Is_Over()
	Local $GameFlag = Game_Get_Flag()
	Local $MineOnOpen = Game_Get_Open_Mine()
	GUICtrlSetBkColor($Running_Lable,$Color)
	Game_Get_CaretPos()

	Local $Test01 = ""
	$Test01&= "Game_Is_Over(): "&Game_Is_Over()&@LF
	$Test01&= "Game_Is_Win(): "&Game_Is_Win()&@LF
	$Test01&= "$GameFlag: "&$GameFlag&@LF
	$Test01&= "Game_Get_Open_Mine: "&Game_Get_Open_Mine()&@LF
	$Test01&= "$MineOnOpen: "&$MineOnOpen&@LF
	$Test01&= "Get_Space_Open: "&Get_Space_Open()&@LF
	$Test01&= "$RunningI: "&$RunningI&@LF
	$Test01&= "$TaskI: "&$TaskI&@LF
	$Test01&= "$Mine_AroundI: "&$Mine_AroundI&@LF
	$Test01&= "$New_Flag[0]: "&$New_Flag[0]&@LF
	$Test01&= "$New_FlagI: "&$New_FlagI&@LF
	$Test01&= "$Space_In_Zone: "&$Space_In_Zone&@LF
	$Test01&= "$Scan_Mode: "&$Scan_Mode&@LF
	$Test01&= "$Space_Zone: "&$Space_Zone[0]&" "&$Space_Zone[1]&" "&$Space_Zone[2]&" "&$Space_Zone[3]&@LF
	$Test01&= "$GameMode: "&$GameMode[0]&" / "&$GameMode[1]&@LF
	$Test01&= "$First_Pos: "&$First_Pos[0]&" / "&$First_Pos[1]&@LF
	$Test01&= "$Cur_Space_Pos: "&$Cur_Space_Pos[0]&" / "&$Cur_Space_Pos[1]&@LF
	$Test01&= "$Cur_Space_Number: "&$Cur_Space_Number&@LF
	$Test01&= "$GamePos: "&$GamePos[0]&" / "&$GamePos[1]&@LF
	$Test01&= "$GameCaretPos: "&$GameCaretPos[0]&" / "&$GameCaretPos[1]&@LF
	$Test01&= "$MouseGetPos: "&$Pos[0]&" / "&$Pos[1]&@LF
	$Test01&= "$PixelGetColor: "&$Color&@LF

	Return $Test01
EndFunc
