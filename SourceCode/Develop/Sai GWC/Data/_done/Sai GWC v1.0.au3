#cs ==========================================================
- Chương trình
- Thiết kế: Trần Minh Đức
- AutoIT: v3.2.12.1
#ce ==========================================================

;-- Cấu Trúc Trương Trình -------------------------------------------------------------------------------------------------------------
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định 
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
;~ Các Hàm Đang Tạo
;-- Hết Cấu Trúc Trương Trình ---------------------------------------------------------------------------------------------------------

;-- Các Include và Option -------------------------------------------------------------------------------------------------------------
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <IE.au3>

AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("SendCapslockMode",1)
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+h","ShowInfoAuto")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{PAUSE}","ActivePauseAuto")					;Pause				- Tạm Dừng Auto
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto

HotKeySet ("^+!1","AtiveTest1")						;Ctrl+Shilf+Alt+1
;~ HotKeySet ("^+!2","AtiveTest2")						;Ctrl+Shilf+Alt+1
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Các Hàm thử nghiệm ----------------------------------------------------------------------------------------------------------------
;~ Hàm kiểm tra 1
Func AtiveTest1()
	$Running = Not $Running
EndFunc
;-------- Các Hàm thử nghiệm ----------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoName="Sai"								;Tên Chương Trình
Global $AutoClass="AutoIt v3 GUI"					;Mã phân loại Chương Trình		
Global $AutoHandle=""								;Mã Chương Trình khi chạy
Global $AutoVersion="1.0"							;Phiên Bản
Global $Author="Trần Minh Đức"						;Tên Lập Trình Viện
Global $AutoTitle=$AutoName&" v"&$AutoVersion&" "
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@CRLF								;Các chức năng của Chương Trình
$Functions=$Functions&""

;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến chương trình
Global $ShowToolTip=False			;True - Đang hiển thị bằng ToolTip
Global $ShowHotKey=False			;True - Hiển thị danh sách phím nóng
Global $ShowInfoAuto=False			;True - Hiển thị thông tin chương trình
Global $Hidden=False				;True - Trang thái Thu Gọn Auto
Global $Pause=False					;True - Tạm ngưng chương trình
Global $ShowPauseNum=1				;1 - Cách hiện thị thứ nhất của trạng thái Pause
Global $Running=False				;True - Đang chạy chương trình 1
Global $RunningI=1					;1 - Cách hiện thị thứ nhất của trạng thái hoạt động
Global $RunningTask=False			;True - Đang thực hiện chức năng
Global $RunningTaskI=1				;1 - Cách hiện thị thứ nhất của trạng thái hoạt động
Global $ToolTipPos[2]				;Vị trí bảng thông báo
Global $ConfigName="Config.ini"		;Tên file lưu các thông số của chương trình

Global $oIE 						;Đối tượng Internet
Global $URL	= ""					;Địa chỉ trang truy cập
Global $Content = ""				;Nội dung dạng Text từ trang truy cập
Global $ContentHTML = ""			;Nội dung dạng HTML từ trang truy cập
Global $HTMLFolder = "HTML\"		;Thư mục chứa nội dung dạng HTML
Global $TemFile = "Content.txt"		;Tên file tạm

Global $WebID = 5					;Mã số nhóm dữ liệu trên web
Global $StartNum = 1				;ID đầu tiên sẽ lấy
Global $EndNum = 0					;ID cuối cùng sẽ lấy
Global $URLNumber = 0				;ID đang lấy
Global $TotalURL = 0				;Tổng số ID sẽ lấy
Global $URLCount = 0				;Số thứ tự ID đang lấy
Global $URLDone = 1					;1 - ID hiện tại đã lấy xong
Global $ShowGetContent = 0			;1 - Hiển thị nội dung lấy được và đã định dạng
Global $ShowBrowser = 1				;1 - Hiển thị Trang Web

Global $ArrayState[52] = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois", _
						"Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada", _
						"New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina", _
						"South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming","Puerto Rico"]


;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
SetLanguage()
SettingStart()
CreateMainGUI()
ShowMainGUI()
CheckAuto()


WriteLog("")
WriteLog("\/-\/-\/-\/-\/-\/-\/ Bắt đầu chương trình \/-\/-\/-\/-\/-\/-\/")
WriteLog("")

While 1
	Sleep(77)
	
;~ 	Kiểm tra ID sẽ lấy cuối cùng
	CheckEndNum()

;~ 	Kiểm tra chỗ nhập TotalURL
	CheckAllButton()
	
;~ 	Hiển thị thông báo tình trạng đang hoạt động
	RunningCheck()

;~ 	Tạm dừng
	If PauseAuto() Then 
		ShowPauseAuto()
		ContinueLoop
	EndIf
	
;~ 	Thực hiện công việc
	RunningTask()
	
WEnd 
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;~ Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	Local $l = WinList("[TITLE:"&$AutoTitle&"; CLASS:AutoIt v3 GUI;]")
	Local $CountProcess=$ProcessNumber

	If $l[0][0]>$ProcessNumber Then
		MsgBox(0,$AutoName,$EnoughAutoT)
		exit
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
		ToolTip($text,$ToolTipPos[0],$ToolTipPos[1])
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
		ToolTip($text,$ToolTipPos[0],$ToolTipPos[1])
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
;~ 	Nếu không bơm thì không hiển thị cái này nữa và xóa đi
		If GUICtrlRead($Running_Lable)<>"" then GUICtrlSetData($Running_Lable,"")
		Return False
	EndIf

;~ 	Nếu tạm dừng, không tìm thấy PetHP, thì không hiển thị tiếp, nhưng không xóa
	If $Pause Then Return False

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
	$RunningI+=1
EndFunc

;~ Hàm ẩn hiện chương trình
Func HiddenShow()
	Local $Pos=WinGetPos($MainGUI)
	If $Pos[1]=0 Then 
		GUICtrlSetData($Hidden_Button,$Button_ShowT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Horizontally,Default,Default,2)
		$Hidden=True
	Else
		GUICtrlSetData($Hidden_Button,$Hidden_ButtonT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1],Default,Default,2)
		$Hidden=False
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
		If GUICtrlRead($Warning_Lable)<>"" then 
			GUICtrlSetData($Warning_Lable,"")
			GUICtrlSetData($Pause_Button,$Pause_ButtonT1)
		EndIf
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
	SettingEnd()
	WriteLog("/\-/\-/\-/\-/\-/\-/\ Kết thúc chương trình /\-/\-/\-/\-/\-/\-/\")
	WriteLog("")
	Exit
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Hàm tạo giao diện
Func CreateMainGUI()
	Global $Vertically=7 		;Cách khoảng từ trái sang phải
	Global $Horizontally=5 		;Cách khoảng từ trên xuống dưới
	Global $FontColor=0x0077FF 	;Màu chữ
	
;~ 	Khởi tạo Giao Diện
	Global $MainGUI_Size[2] = [250,160] ;Kích thước
	Global $MainGUI_Pos[2] = [@DesktopWidth/2-$MainGUI_Size[1]/2,0] ;Vị trí
	Global $MainGUI_Pos[2] = [0,0] ;Vị trí
	Global $MainGUI=GUICreate($AutoTitle,$MainGUI_Size[0],$MainGUI_Size[1],$MainGUI_Pos[0],$MainGUI_Pos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	GUISetBkColor(0xFFFFFF,$MainGUI)
	
	$MenuTittle_Size=38.5
;~ 	Menu Quản Lý
	$Menu_File=GUICtrlCreateMenu($Menu_FileT)

;~ 	Items của Quản Lý - Thoat
	$Menu_File_Access=GUICtrlCreateMenu($Menu_File_AccessT,$Menu_File)
	$Menu_File_Access_URL1=GUICtrlCreateMenuItem($Menu_File_Access_URL1T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL1,"OpenURL1")
	$Menu_File_Access_URL2=GUICtrlCreateMenuItem($Menu_File_Access_URL2T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL2,"OpenURL2")
	$Menu_File_Access_URL3=GUICtrlCreateMenuItem($Menu_File_Access_URL3T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL3,"OpenURL3")
	$Menu_File_Access_URL4=GUICtrlCreateMenuItem($Menu_File_Access_URL4T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL4,"OpenURL4")
	
	$Menu_File_Exit=GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")

;~ 	Menu Help
	$Menu_Help=GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HotKey=GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_About=GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")

;~ 	Nút thoát
	Global $Exit_Button_Size[2]=[25,22]
	Global $Exit_Button_Pos[2]=[$MainGUI_Size[0]-$Exit_Button_Size[0]-$Vertically,$MainGUI_Size[1]-$Exit_Button_Size[1]-$MenuTittle_Size-$Horizontally]
	Global $Exit_Button=GUICtrlCreateButton($Exit_ButtonT,$Exit_Button_Pos[0],$Exit_Button_Pos[1],$Exit_Button_Size[0],$Exit_Button_Size[1])
	GUICtrlSetOnEvent($Exit_Button,"ExitAuto")
	GUICtrlSetTip($Exit_Button,$Exit_Button_TipT)

;~ 	Nút tạm ngưng
	Global $Pause_Button_Size[2]=[$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Pause_Button_Pos[2]=[$Exit_Button_Pos[0]-$Pause_Button_Size[0],$Exit_Button_Pos[1]]
	Global $Pause_Button=GUICtrlCreateButton($Pause_ButtonT1,$Pause_Button_Pos[0],$Pause_Button_Pos[1],$Pause_Button_Size[0],$Pause_Button_Size[1])
	GUICtrlSetOnEvent($Pause_Button,"ActivePauseAuto")
	GUICtrlSetTip($Pause_Button,$Pause_Button_TipT)
	
;~ 	Nút ẩn hiện
	Global $Hidden_Button_Size[2]=[$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Hidden_Button_Pos[2]=[$Pause_Button_Pos[0]-$Hidden_Button_Size[0],$Pause_Button_Pos[1]]
	Global $Hidden_Button=GUICtrlCreateButton($Hidden_ButtonT,$Hidden_Button_Pos[0],$Hidden_Button_Pos[1],$Hidden_Button_Size[0],$Hidden_Button_Size[1])
	GUICtrlSetOnEvent($Hidden_Button,"HiddenShow")
	GUICtrlSetTip($Hidden_Button,$Hidden_Button_TipT)

;~ 	Nơi hiển thị thông báo
	Global $Warning_Lable_Size[2]=[$MainGUI_Size[0],16]
	Global $Warning_Lable_Pos[2]=[0,$Exit_Button_Pos[1]-$Warning_Lable_Size[1]]
	Global $Warning_Lable=GUICtrlCreateLabel("",$Warning_Lable_Pos[0],$Warning_Lable_Pos[1],$Warning_Lable_Size[0],$Warning_Lable_Size[1],$SS_CENTER)
	GUICtrlSetColor($Warning_Lable,$FontColor)
	GUICtrlSetFont($Warning_Lable,9,777)
	
;~ 	Nơi hiển thị tình trạng hoạt động
	Global $Running_Lable_Size[2]=[9,13.3]
	Global $Running_Lable_Pos[2]=[$Vertically,$Hidden_Button_Pos[1]+$Horizontally]
	Global $Running_Lable=GUICtrlCreateLabel("",$Running_Lable_Pos[0],$Running_Lable_Pos[1],$Running_Lable_Size[0],$Running_Lable_Size[1])
	GUICtrlSetColor($Running_Lable,$FontColor)

;~ 	Nơi hiển thị thông báo hoạt động
	Global $RunningTask_Lable_Size[2]=[151,13.3]
	Global $RunningTask_Lable_Pos[2]=[16,$Hidden_Button_Pos[1]+$Horizontally]
	Global $RunningTask_Lable=GUICtrlCreateLabel("",$RunningTask_Lable_Pos[0],$RunningTask_Lable_Pos[1],$RunningTask_Lable_Size[0],$RunningTask_Lable_Size[1])
	GUICtrlSetColor($RunningTask_Lable,$FontColor)

;~ 	Tiêu đề của chỗ nhập Start Number
	Global $StartNum_Lable_Size[2]=[52,14.2]
	Global $StartNum_Lable_Pos[2]=[$Vertically,$Horizontally+2]
	Global $StartNum_Lable=GUICtrlCreateLabel($StartNum_LableT1,$StartNum_Lable_Pos[0],$StartNum_Lable_Pos[1],$StartNum_Lable_Size[0],$StartNum_Lable_Size[1],$ES_RIGHT)
	GUICtrlSetColor($StartNum_Lable,$FontColor)

;~ 	Chỗ nhập Start Number của URL
	Global $StartNum_Input_Size[2]=[77,20]
	Global $StartNum_Input_Pos[2]=[$Vertically+$StartNum_Lable_Size[0],$Horizontally]
	Global $StartNum_Input=GUICtrlCreateInput($StartNum,$StartNum_Input_Pos[0],$StartNum_Input_Pos[1],$StartNum_Input_Size[0],$StartNum_Input_Size[1],$ES_NUMBER)

;~ 	Tiêu đề của End Number
	Global $EndNum_Lable_Size[2]=[115,14.2]
	Global $EndNum_Lable_Pos[2]=[$Vertically+$StartNum_Input_Pos[0]+$StartNum_Input_Size[0],$StartNum_Lable_Pos[1]]
	Global $EndNum_Lable=GUICtrlCreateLabel($EndNum_LableT1&$EndNum_LableT1a,$EndNum_Lable_Pos[0],$EndNum_Lable_Pos[1],$EndNum_Lable_Size[0],$EndNum_Lable_Size[1])
	GUICtrlSetColor($EndNum_Lable,$FontColor)

;~ 	Tiêu đề của chỗ nhập Total URl
	Global $TotalURL_Lable_Size[2]=[52,14.2]
	Global $TotalURL_Lable_Pos[2]=[$Vertically,$Horizontally*3+$StartNum_Input_Size[1]]
	Global $TotalURL_Lable=GUICtrlCreateLabel($TotalURL_LableT1,$TotalURL_Lable_Pos[0],$TotalURL_Lable_Pos[1],$TotalURL_Lable_Size[0],$TotalURL_Lable_Size[1],$ES_RIGHT)
	GUICtrlSetColor($TotalURL_Lable,$FontColor)

;~ 	Chỗ nhập Total URl
	Global $TotalURL_Input_Size[2]=[77,20]
	Global $TotalURL_Input_Pos[2]=[$Vertically+$TotalURL_Lable_Size[0],$TotalURL_Lable_Pos[1]-2]
	Global $TotalURL_Input=GUICtrlCreateInput($TotalURL,$TotalURL_Input_Pos[0],$TotalURL_Input_Pos[1],$TotalURL_Input_Size[0],$TotalURL_Input_Size[1],$ES_NUMBER)

;~ 	Nút kích hoạt chương trình
	Global $Start_Button_Size[2]=[61,Default]
	Global $Start_Button_Pos[2]=[$Vertically+$TotalURL_Input_Pos[0]+$TotalURL_Input_Size[0],$TotalURL_Input_Pos[1]-2]
	Global $Start_Button=GUICtrlCreateButton($Start_ButtonT1,$Start_Button_Pos[0],$Start_Button_Pos[1],$Start_Button_Size[0],$Start_Button_Size[1])
	GUICtrlSetOnEvent($Start_Button,"StartAuto")

;~ 	Nơi hiển thị thông tin chương trình
;~ 	Global $Info_Lable_Size[2]=[$MainGUI_Size[0],Default]
;~ 	Global $Info_Lable_Pos[2]=[0,77]
;~ 	Global $Info_Lable=GUICtrlCreateLabel("",$Info_Lable_Pos[0],$Info_Lable_Pos[1],$Info_Lable_Size[0],$Info_Lable_Size[1])
 	
;~ Global $WebID = 3
;~ GUICtrlSetBkColor(-1,0xFFAA77)
	
;~ 	Định vị chỗ hiện thông báo
	$ToolTipPos[0]= $MainGUI_Size[0]+$Vertically
	$ToolTipPos[1]= 0

EndFunc

;~ Hiển Thị Giao Diện
Func ShowMainGUI()
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc
;~ Ẩn Giao Diện
Func HideMainGUI()
	GUISetState(@SW_HIDE,$MainGUI)
EndFunc

;~ 2 Hàm Ẩn/Hiện thông báo trong Gui
Func ShowWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Warning_Lable_Size[1]+$Horizontally,Default,Default,2)
EndFunc
Func HiddenWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Horizontally,Default,Default,2)
EndFunc


;~ Hàm nạp ngôn ngữ hiển thị
Func SetLanguage()
;~ Biến Mô Tả Chương Trình
	Global $AutoName="Sai GWC"						;Tên Chương Trình
	Global $AutoBeta="[Thử]"						;Chương Trình thử nghiệm
	Global $AutoClass="AutoIt v3 GUI"				;Mã phân loại Chương Trình	
	Global $AutoVersion="1.0"						;Phiên Bản
	Global $AutoVersionCode="1802"					;Mã số Phiên Bản
	Global $FindNewVersionT=""
	Global $Author="Trần Minh Đức"					;Tên (các) Lập Trình Viện
	Global $BlogName="http://www.LeeSai.co.cc"		;Địa chỉ Blog
	Global $BlogNameFull="http://my.opera.com/saihukaru/blog/"
	Global $LinkDown=""
	
	Global $AutoTitle=$AutoName&" v"&$AutoVersion&" "

	Global $Functions=@LF							;Các chức năng của Chương Trình
	$Functions&="  + Lấy thông tin từ Web"&@LF
	$Functions&="  + Truy xuất Cở Sở Dữ Liệu"&@LF

;~ Biến ngôn ngữ
	Global $Menu_FileT="&Quản Lý"
	Global $Menu_File_AccessT="&Truy Cập"
	Global $Menu_File_Access_URL1T="constructionwork.com"
	Global $Menu_File_Access_URL2T="bidclerk.com"
	Global $Menu_File_Access_URL3T="constructionbidsource.com"
	Global $Menu_File_Access_URL4T="cslb.ca.gov"
	Global $Menu_File_ExitT="&Thoát"
	Global $Menu_HelpT="&Hỗ Trợ"
	Global $Menu_Help_HotKeyT="&Phím Nóng"
	Global $Menu_Help_AboutT="&Thông Tin"

	Global $StartNum_LableT1="Lấy từ ID: "
	Global $EndNum_LableT1="đến"
	Global $EndNum_LableT1a=" khi bấm Ngưng"
	Global $TotalURl_LableT1="Số lượng: "
	Global $Start_ButtonT1="Bắt Đầu"
	Global $Start_ButtonT2="Ngưng"
	Global $URL1_ButtonT="URL1"
	Global $URL2_ButtonT="URL2"
	Global $URL3_ButtonT="URL3"

	Global $Hidden_ButtonT="/\"
	Global $Button_ShowT="\/"
	Global $Hidden_Button_TipT="Thu gọn chương trình"
	Global $Pause_ButtonT1="<  >"
	Global $Pause_ButtonT2="<>"
	Global $Pause_Button_TipT="Tạm ngưng hoạt động"
	Global $Exit_ButtonT="X"
	Global $Exit_Button_TipT="Thoát chương trình"

	Global $EnoughAutoT=$AutoName&" đã chạy đủ."&@LF&"Không thể mở thêm!!!"
	Global $PauseAutoT="Tạm dừng"
	Return True
EndFunc

;~ Kích hoạt chương trình
Func StartAuto()
	GUICtrlSetData($RunningTask_Lable,"")
	If GUICtrlGetState($Start_Button)<>144 Then GUICtrlSetState($Start_Button,$GUI_DISABLE)	
	$Running = Not $Running
	$RunningTask = Not $RunningTask
	If $Running Then 
		$URLCount = 0
		$RunningTaskI = 0
	EndIf
	
EndFunc

;~ Kích hoạt URL
Func OpenURL1()
	Run("C:\Program Files\Mozilla Firefox\firefox.exe -new-window http://www.constructionwork.com/")
EndFunc
;~ Kích hoạt URL
Func OpenURL2()
	Run("C:\Program Files\Mozilla Firefox\firefox.exe -new-window http://www.bidclerk.com/")
EndFunc
;~ Kích hoạt URL
Func OpenURL3()
	Run("C:\Program Files\Mozilla Firefox\firefox.exe -new-window http://www.constructionbidsource.com/")
EndFunc
;~ Kích hoạt URL
Func OpenURL4()
	Run("C:\Program Files\Mozilla Firefox\firefox.exe -new-window http://www2.cslb.ca.gov/OnlineServices/CheckLicense/LicenseDetail.asp?LicNum=7")
EndFunc

;~ Hàm hiệu chỉnh khi Start
Func SettingStart()
	CreateListWebSite()
	LoadData()
;~ 	SpeepUpIE()
EndFunc

;~ Hàm hiệu chỉnh khi End
Func SettingEnd()
	SaveData()
	DeleteTempFile()
;~ 	SpeepDownIE()
EndFunc

Func CreateListWebSite()
	Global $ListWebSite[6][8]
	
;~ [0]	;ID
;~ [1]	;Type Get
;~ [2]	;Web Name
;~ [3]	;Home Page
;~ [4]	;BeforNumber
;~ [5]	;AfterNumber
;~ [6]	;Line start get
;~ [7]	;Line end get
	
	$ListWebSite[0][0]= 0
	
	$ListWebSite[1][0]= 1										
	$ListWebSite[1][1]= "project"								
	$ListWebSite[1][2]= ""										
	$ListWebSite[1][3]= ""										
	$ListWebSite[1][4]= ""										
	$ListWebSite[1][5]= ""										
	$ListWebSite[1][6]= ""										
	$ListWebSite[1][7]= ""										

	$ListWebSite[2][0]= 2
	$ListWebSite[2][1]= "supplier"
	$ListWebSite[2][2]= ""
	$ListWebSite[2][3]= ""
	$ListWebSite[2][4]= ""
	$ListWebSite[2][5]= ""
	
	$ListWebSite[3][0]= 3
	$ListWebSite[3][1]= "contactor"
	$ListWebSite[3][2]= "constructionwork"
	$ListWebSite[3][3]= "http://www.constructionwork.com/"
	$ListWebSite[3][4]= "contractor"
	$ListWebSite[3][5]= "_2_cjm_custom_builders_inc.html"
	$ListWebSite[3][6]= "Get Listed and Find Project Leads"
	$ListWebSite[3][7]= "Back"

	$ListWebSite[4][0]= 4
	$ListWebSite[4][1]= "mbe"
	$ListWebSite[4][2]= ""
	$ListWebSite[4][3]= ""
	$ListWebSite[4][4]= ""
	$ListWebSite[4][5]= ""

	$ListWebSite[5][0]= 5
	$ListWebSite[5][1]= "contractor"
	$ListWebSite[5][2]= "cslb.ca.gov"
	$ListWebSite[5][3]= "http://www2.cslb.ca.gov/"
	$ListWebSite[5][4]= "OnlineServices/CheckLicense/LicenseDetail.asp?LicNum="
	$ListWebSite[5][5]= ""
	$ListWebSite[5][6]= "Due to workload, there may be relevant information that has not yet been entered onto the Board's license database. "
	$ListWebSite[5][7]= "  Back to Top | Help | Contact Us | Site Map"
EndFunc

Func SpeepUpIE()
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\MULTIMEDIA\PICTS","CheckedValue","REG_SZ","no")
EndFunc

;~ Hàm lưu các thông số chương trình
Func LoadData()
	$WebID = IniRead($ConfigName,"WebSite","$WebID",$WebID)*1
	$StartNum = IniRead($ConfigName,$WebID,"$StartNum",$StartNum)*1
	$TotalURL = IniRead($ConfigName,$WebID,"$TotalURL",$TotalURL)*1
	$ShowGetContent = IniRead($ConfigName,$WebID,"$ShowGetContent",$ShowGetContent)*1
	$ShowBrowser = IniRead($ConfigName,$WebID,"$ShowBrowser",$ShowBrowser)*1
EndFunc

;~ Hàm lưu các thông số chương trình
Func SaveData()
	$StartNum = GUICtrlRead($StartNum_Input)
	$TotalURL = GUICtrlRead($TotalURL_Input)

	IniWriteSection($ConfigName,"WebSite","")
	IniWrite($ConfigName,"WebSite","$WebID",$WebID)

	IniWriteSection($ConfigName,$WebID,"")
	IniWrite($ConfigName,$WebID,$ListWebSite[$WebID][1],$ListWebSite[$WebID][2])
	IniWrite($ConfigName,$WebID,"$StartNum",$StartNum)
	IniWrite($ConfigName,$WebID,"$TotalURL",$TotalURL)
	IniWrite($ConfigName,$WebID,"$ShowGetContent",$ShowGetContent)
	IniWrite($ConfigName,$WebID,"$ShowBrowser",$ShowBrowser)
EndFunc

;~ Xóa Các File Tạm
Func DeleteTempFile()
	FileDelete($TemFile)
EndFunc

Func SpeepDownIE()
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\MULTIMEDIA\PICTS","CheckedValue","REG_SZ","yes")
EndFunc
	
;~ Hàm khi dấu
Func WriteLog($Line)
	$Line = @HOUR&":"&@MIN&":"&@SEC&" "&@MDAY&"/"&@MON&"/"&@YEAR&" | "&$Line
	$Log = FileOpen("log.txt",1+32)
	FileWriteLine($Log,$Line)
	FileClose($Log)
EndFunc

Func RunningTask()
	If Not $Running Then $RunningTask = False
	If Not $RunningTask Then Return
	$URLDone=0
	
	Select
		Case $RunningTaskI=1
			SetURL()
			If Not $Running Then 
				GUICtrlSetData($RunningTask_Lable,"Đã hoàn tất hết")
				Return
			EndIf
			WriteLog("Bắt đầu với "&$URLNumber)
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang tạo URL.")
			WriteLog("Tạo URL: "&@TAB&$URL)
		Case $RunningTaskI=2
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang truy cập.")
			OpenURL()
		Case $RunningTaskI=3
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang kiểm tra nội dung.")
			Execute("CheckContent"&$WebID&"()")
		Case $RunningTaskI=4
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang lưu nội dung.")
			SaveContent()
		Case $RunningTaskI=5
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": tắt trình duyệt.")
			CloseURL($oIE)
		Case $RunningTaskI=6
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": lấy vùng nội dung cần.")
			FiltContent()
		Case $RunningTaskI=7
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": định dạng vùng nội dung.")
			Execute("FormatContent"&$WebID&"()")
		Case $RunningTaskI=8
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang lưu nội dung.")
			MoveContent($URLNumber)
			$URLDone=1			
		Case $RunningTaskI=9
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": Hoàn tất.")
			WriteLog("Kết thúc với "&$URLNumber)
			WriteLog("")
	EndSelect
		
	If $RunningTaskI=9 Then 
		$RunningTaskI=0
	EndIf
	$RunningTaskI+=1

EndFunc
	
;~ Lấy địa chỉ trang web cần truy cập
Func SetURL()
	$URLNumber = $StartNum+$URLCount
	$URL = $ListWebSite[$WebID][3]&$ListWebSite[$WebID][4]&$URLNumber&$ListWebSite[$WebID][5]
	If (($URLCount < $TotalURL) OR ($TotalURL=0)) Then
		$URLCount+=1
	Else
		$Running = False
	EndIf
EndFunc

;~ Truy cập trang web và lấy Content
Func OpenURL()
	WriteLog("Truy Cập: "&@TAB&$URL)
	$oIE = _IECreate($URL,0,$ShowBrowser,1,1)
	$Content = _IEBodyReadText($oIE)
	$ContentHTML = _IEBodyReadHTML($oIE)
EndFunc

;~ Đóng IE
Func CloseURL($oIE)
	WriteLog("Đóng URL: "&@TAB&$URL)
	_IEQuit($oIE)
EndFunc	

;~ Hàm kiểm tra nội dung lấy được
Func CheckContent5()
	Local $Search1 = "License Number does not exist"
	If StringInStr($Content,$Search1) Then
		GUICtrlSetData($RunningTask_Lable,$URLNumber&": không có Contractor.")
		WriteLog("Không tìm thấy thông tin của Contractor.")
		WriteLog("Kết thúc với "&$URLNumber)
		WriteLog("")
		NextURLNumber()
	Else
		WriteLog("Tìm thấy thông tin của Contractor")
	EndIf
EndFunc

;~ Hàm bỏ qua URL Number hiện tại
Func NextURLNumber()
	$RunningTaskI=0
	CloseURL($oIE)
	$URLDone=1
EndFunc

;~ Lưu nội dung text lấy được và file tạm
Func SaveContent($FileName = $TemFile)
	WriteLog("Lưu nội dung vào File tạm với tên "&$FileName)
	$File = FileOpen($FileName,2+8)
	FileWriteLine($File,$Content)
	FileClose($File)
	
	$File = FileOpen($HTMLFolder&$URLNumber&".txt",2+8)
	FileWriteLine($File,$ContentHTML)
	FileClose($File)
EndFunc

;~ Di chuyển file đến vị trí đúng của nó
Func MoveContent($FileName)
	$source = $TemFile
	$dest = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"&$ListWebSite[$WebID][2]&"\"&$FileName&".txt"
	WriteLog("Chuyển file "&$source&" thành "&$dest)
	FileMove($source,$dest,1+8)
EndFunc

;~ Lọc lấy những nội dung cần leesai7
Func FiltContent()
	WriteLog("Lọc lấy vùng nội dung cần trong File "&$TemFile)
	
	$Content = ""

	Local $File = FileOpen($TemFile,0)
	Local $Get = False
	
	While 1
		Local $Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
			
		If StringInStr($Line,$ListWebSite[$WebID][7]) Then $Get = False

		If $Get And $Line Then
			Local $TLine = StringReplace($Line," ","")
			If $TLine Then $Content&=$Line&@CRLF
		EndIf
		
		If StringInStr($Line,$ListWebSite[$WebID][6]) Then $Get = True
			
		If $ShowGetContent Then ToolTip($Content,$ToolTipPos[0],$ToolTipPos[1],$URLNumber&": Nội dung lấy được")
	WEnd

	SaveContent()
	FileClose($File)
EndFunc

;~ Định dạng nội dung cần cho WebID 3
Func FormatContent3()
	WriteLog("Định dạng nội dung cho "&$ListWebSite[$WebID][2]&" của "&$ListWebSite[$WebID][1])
	
	$Content = ""

	Local $File = FileOpen($TemFile,0)
	Local $HaveName = False
	Local $HaveLocation = False
	While 1
		$Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
			
		$ArrayLine = StringSplit($Line,":")
		
		If Not $HaveName Then
			If $ArrayLine[0]=1 Then 
				$Content&="#companyname:"&$ArrayLine[1]
				$HaveName = True
				ContinueLoop
			EndIf
		Else		
			Switch $ArrayLine[1]
				Case "address"
					$Content&=@CRLF&"#address:"&$ArrayLine[2]
					
					$Line = FileReadLine($File)
					If @error = -1 Then ExitLoop
					$Content&=GetCityStateZip($Line)
					#CS
					$ArrayLine = StringSplit($Line," ")
					
					$strcity = StringReplace($ArrayLine[1],",","")
					$Content&=@CRLF&"#city:"&$strcity
					
					$Content&=@CRLF&"#state:"&$ArrayLine[2]
					#CE
				Case "phone"
					$Content&=@CRLF&"#phone:"&$ArrayLine[2]
				Case "fax"
					$Content&=@CRLF&"#fax:"&$ArrayLine[2]
				Case "Year Established"
					$Content&=@CRLF&"#yearestablished:"&$ArrayLine[2]
				Case "Project Type"
					$Content&=@CRLF&"#projecttype:"&$ArrayLine[2]
				Case "Typical Project Size"
					$Content&=@CRLF&"#typicalprojectsize:"&$ArrayLine[2]
				Case "Labor Affiliation"
					$Content&=@CRLF&"#laboraffiliation:"&$ArrayLine[2]
				Case "Company Description"
					$Content&=@CRLF&"#companydescription:"&$ArrayLine[2]
				Case "Project History"
					$Content&=@CRLF&"#projecthistory:"&$ArrayLine[2]
				Case "Other Categories"
					$Content&=@CRLF&"#workcategory:"&$ArrayLine[2]
			EndSwitch
		EndIf
		If $ShowGetContent Then ToolTip($Content,$ToolTipPos[0],$ToolTipPos[1],$URLNumber&": Nội dung đã định dạng")
		
	WEnd
	SaveContent()
	FileClose($File)
EndFunc

;~ Định dạng nội dung cần cho WebID 5
Func FormatContent5()
	WriteLog("Định dạng nội dung cho "&$ListWebSite[$WebID][2]&" của "&$ListWebSite[$WebID][1])
	
	$Content = ""

	Local $File = FileOpen($TemFile,0)
	While 1
		Local $Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
			
		$ArrayLine = StringSplit($Line,":")
		
		Switch $ArrayLine[1]
			Case "License Number"
				Local $License = StringReplace($ArrayLine[2],"Extract Date","")
				$Content&="#license:"&$License
			Case "Business Information"
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
				Local $TCompanyName= $Line
				Local $TCompanyName2 = StringTrimLeft($TCompanyName,1)
				Local $CompanyName = StringTrimRight($TCompanyName2,1)

				Local $ContentHTML = GetContentHTML($URLNumber)
				Local $TCompanyName = GetStringInHTML($ContentHTML,"<P><STRONG>Business Information:</STRONG></P>",70,"<P><STRONG>Entity:</STRONG></P></TD>",125)
				$ACompanyName = StringSplit($TCompanyName,"<BR>",1)

				$Content&=@CRLF&"#companyname:"&$CompanyName
				For $i =2 To $ACompanyName[0] Step +1
					Local $Line = FileReadLine($File)
					If @error = -1 Then ExitLoop
					$Add = StringTrimRight($Line,1)
					$Content&=" "&$Add	
				Next
				
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
				Local $TAddress = $Line
				Local $Address = StringTrimRight($TAddress,1)
				$Content&=@CRLF&"#address:"&$Address
				
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
				$Content&=GetCityStateZip($Line)
			Case "Business Phone Number"
				Local $TPhone = $ArrayLine[2]
				Local $Phone = StringTrimLeft($TPhone,1)				
				$Content&=@CRLF&"#phone:"&$Phone
			Case "License Status"
				Local $LicenseStatus1 = $ArrayLine[2]
				Local $LicenseStatus2 = StringTrimLeft($LicenseStatus1,1)
				Local $LicenseStatus = StringTrimRight($LicenseStatus2,1)
				$Content&=@CRLF&"#licensestatus:"&$LicenseStatus
			Case "Classifications"
				Local $ContentHTML = GetContentHTML($URLNumber)
				Local $SpecialClass = GetSpecialClass5($ContentHTML)
				
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
				Local $SpecialDescription = StringReplace($Line,$SpecialClass,"",1)
				
				Local $Special = $SpecialClass&" "&$SpecialDescription
				$Content&=@CRLF&"#special:"&$Special
				$Content&=@CRLF&"#typework:"&$SpecialDescription
			EndSwitch
		If $ShowGetContent Then ToolTip($Content,$ToolTipPos[0],$ToolTipPos[1],$URLNumber&": Nội dung đã định dạng")
	WEnd
	SaveContent()
	FileClose($File)
EndFunc

;~ Hàm lấy SpecialClass từ nội dung dạng HTML
Func GetStringInHTML($HTML,$Search1,$MoveRight,$Search2,$MoveLeft)
	Local $StartPos = StringInStr($HTML,$Search1,1)+$MoveRight
	

	Local $EndPos = StringInStr($HTML,$Search2,1)-$MoveLeft
	
	Local $ArrayHTML = StringSplit($HTML,"")

	Local $String = ""
	For $i=$StartPos To $EndPos Step +1
		$String&=$ArrayHTML[$i]
	Next
	Return $String
EndFunc

;~ Hàm lấy SpecialClass từ nội dung dạng HTML
Func GetSpecialClass5($HTML)
	Local $Search1 = '<TH style="WIDTH: 84%">Description</TH></TR>'
	Local $StartPos = StringInStr($HTML,$Search1,1)+55
	

	Local $Search2 = '</P></TD><TD><P><A href="'
	Local $EndPos = StringInStr($HTML,$Search2,1)-1
	
	Local $ArrayHTML = StringSplit($HTML,"")

	Local $Class = ""
	For $i=$StartPos To $EndPos Step +1
		$Class&=$ArrayHTML[$i]
	Next
	Return $Class
EndFunc

;~ Hàm lấy nội dung dạng HTML của trang hiện tại
Func GetContentHTML($FileName)
	$FileName&=".txt"
	Local $Content = ""
	Local $File = FileOpen($HTMLFolder&$FileName,0)
	While 1
		Local $Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
		$Content&=$Line
	WEnd
	FileClose($File)
	Return $Content
EndFunc

;~ Hàm lấy City State ZipCode từ chuỗi [City], [State] [ZipCode]
Func GetCityStateZip($Line)
	Local $Content = ""
	Local $ArrayLine = StringSplit($Line,",")
	
	If $ArrayLine[0] >0 Then 
		Local $City = $ArrayLine[1]
		$Content&=@CRLF&"#city:"&$City
	EndIf
	
	If $ArrayLine[0] >1 Then 
		Local $Line2 = StringTrimLeft($ArrayLine[2],1)
		
		Local $ArrayLine = StringSplit($Line2," ")
		If $ArrayLine[0] >0 Then 
			Local $State = $ArrayLine[1]
			$Content&=@CRLF&"#state:"&$State
		EndIf
		
		If $ArrayLine[0] >1 Then 
			Local $ZipCode = $ArrayLine[2]
			$Content&=@CRLF&"#zipcode:"&$ZipCode
		EndIf
	EndIf
	
	Return $Content
EndFunc

;~ Kiểm tra số lương URL sẽ lấy
Func CheckEndNum()
	Local $Total = GUICtrlRead($TotalURL_Input)*1
	$StartNum = GUICtrlRead($StartNum_Input)*1
	$TotalURL = $Total
	If $Total Then
		$EndNum = $TotalURL+$StartNum-1
		If GUICtrlRead($EndNum_Lable)<>$EndNum_LableT1&" "&$EndNum Then GUICtrlSetData($EndNum_Lable,$EndNum_LableT1&" "&$EndNum)
	Else
		If GUICtrlRead($EndNum_Lable)<>$EndNum_LableT1&$EndNum_LableT1a Then GUICtrlSetData($EndNum_Lable,$EndNum_LableT1&$EndNum_LableT1a)
	EndIf
EndFunc

;~ Kiểm tra tình trạng các nút bấm
Func CheckAllButton()
	CheckStartButton()
EndFunc

;~ Kiểm tra tình trạng nút Start
Func CheckStartButton()
	If $Running Then
		If GUICtrlRead($Start_Button)<>$Start_ButtonT2 Then GUICtrlSetData($Start_Button,$Start_ButtonT2)
	Else
		If GUICtrlRead($Start_Button)<>$Start_ButtonT1 Then GUICtrlSetData($Start_Button,$Start_ButtonT1)
	EndIf
	If GUICtrlGetState($Start_Button)<>80 Then GUICtrlSetState($Start_Button,$GUI_ENABLE)
EndFunc
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------




