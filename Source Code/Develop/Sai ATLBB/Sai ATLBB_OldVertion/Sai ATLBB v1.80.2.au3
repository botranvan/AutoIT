#cs ==========================================================
- Chương trình
- Thiết kế: Trần Minh Đức
- AutoIT: v3.2.12.1
#ce ==========================================================

;~ -- Cấu Trúc Trương Trình -----------------------------------------------------------------------------------------------------------
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định 
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
;~ Các Hàm Đang Tạo
;~ -- Hết Cấu Trúc Trương Trình -------------------------------------------------------------------------------------------------------

;~ -- Các Include -----------------------------------------------------------------------------------------------------------------------
#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <IE.au3>
 
;~ ------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;~ -- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
AutoItSetOption("SendCapslockMode",0)
HotKeySet("^+k","ShowHotKey")					;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet("{PAUSE}","ActivePauseAuto")			;Pause				- Tạm Dừng Auto
HotKeySet("{PGUP}","UpDangerPos")				;PageUp				- Tăng Giới Hạn Bơm Máu Cho Thú
HotKeySet("{PGDN}","DownDangerPos")				;PageDown			- Giảm Giới Hạn Bơm Máu Cho Thú
HotKeySet("^{PGUP}","UpDelayTime")				;Ctrl+PageUp		- Tăng Giới Thời Gian Đợi
HotKeySet("^{PGDN}","DownDelayTime")			;Ctrl+PageDown		- Giảm Giới Thời Gian Đợi
HotKeySet("^+{F7}","ActiveAutoUsePetFood")		;Ctrl+Shilf+F7		- Bắt đầu
HotKeySet("^+{DEl}","DelTooltip")				;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto

HotKeySet("^+1","ActiveTest1")					;Ctrl+Shilf+1 	- ActiveTest1 Auto
HotKeySet("^+2","ActiveTest2")					;Ctrl+Shilf+2 	- ActiveTest2 Auto
HotKeySet("^+3","ActiveTest3")					;Ctrl+Shilf+3 	- ActiveTest3 Auto
HotKeySet("^+4","ActiveTest4")					;Ctrl+Shilf+3 	- ActiveTest3 Auto
HotKeySet("^+5","ActiveTest5")					;Ctrl+Shilf+3 	- ActiveTest3 Auto
;~ ------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;~ -- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến dùng chung
Global Const $ProcessNumber=1	;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $GameActivace=0				;1 - Game đang ở trên cùng
Global $LoginGame=False				;True - Đang đăng nhập và chọn nhân vật

Global $Running=True				;True - Auto đang hoạt động
Global $HealingPet=False			;True - Đanh canh để cho ăn
Global $HealingPetI=1				;1 - Cách hiện thị thứ nhất của trạng thái Canh để cho ăn
Global $Waiting=False				;True - Đang đợi để kiểm tra xem thú có cần cho ăn hay không
Global $NotFoundPetHP=False			;???
Global $Pause=False					;True - Tạm dừng Auto
Global $ShowPauseNum=1				;1 - Cách hiện thị thứ nhất của trạng thái Pause
Global $Alt2Ctrl=False				;True - Kích hoạt chức năng hiệu chỉnh phím nóng
Global $Hidden=False				;True - Trang thái Thu Gọn Auto
Global $GameHandle=7				;Mã số của Game
Global $GameHandleBK=7				;Mã số của Game dự phòng
Global $GamePos[2]=[0,0]			;Vị trí Game
Global $GameCaretPos[2]=[-7,-7]		;Vị trí Game
Global $KeyF="F10"					;Vị trí Máu của thú
Global $KeyListF="F9|F8|F7|F6|F5|F4|F3|F2|F1"
Global $DangerPos=34				;Phần Trăm Máu còn lại khi cần Bơm
Global $PetHPPos[2]					;Vị trí Máu của thú nuôi
Global $PetHPSpamPos=2				;Tõc độ kiểm tra PetHP
Global $PetHPLocaColor=-7			;Màu ở vị trí cuối ống PetHP
Global $FileName1="color.sai"		;Tên file lưu giá trị của màu ở vị trí cuối PetHP
Global $SaveFileName1=False		;Tên file lưu giá trị của màu ở vị trí cuối PetHP
Global $PetHPPosEnd[2]=[$PetHPPos[0]+99,$PetHPPos[1]-3] ;Vị trí Máu (cuối) của thú nuôi
Global $PetHP="XX"					;Phần Trăm Máu của thú nuôi
Global $WarningPos[2]=[@DesktopWidth/2,0] ;Vị trí của thông báo


Global $TimeA=TimerInit()			;Biến đếm thời gian đợ sau mỗi lần cho ăn
Global $DelayTime=2005				;Thời gian đợi sau mỗi lần cho ăn
Global $TimeSpam=-7;TimerInit()		;Biến đếm sau mỗi lần Spam
Global $DelayTimeSpam=$1s*$spm*61	;Thời gian đợi sau mỗi lần Spam

Global $Test1=False					;Kiểm tra mã màu tìm kiếm PetHP
Global $Test2=False					;Kiểm tra đoạn PetHP
Global $Test3=False					;Kiểm tra Game có ở trên cùng không
Global $Test4=False					;Kiểm tra mã màu đăng nhập game
Global $Test5=False					;Kiểm tra Caret Pos Game
;~ Các Hàm kích hoạt kiểm tra
Func ActiveTest1()
	$Test1=Not $Test1
EndFunc
Func ActiveTest2()
	$Test2=Not $Test2
EndFunc
Func ActiveTest3()
	$Test3=Not $Test3
EndFunc
Func ActiveTest4()
	$Test4=Not $Test4
EndFunc
Func ActiveTest5()
	$Test5=Not $Test5
EndFunc

;~ ------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------
;~ -- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
If SetLanguage() Then
;~ 	Tạo giao diện
	CreateInterface()
	
;~ 	Kiểm tra phiên phản mới, có tạo giao diện	
	CheckVersionAuto()
	
;~ 	Khóa tất cả các đối tượng của ManGUI
	DisableAllButton()
	
;~ 	Hiện ảnh nạp
	ShowLoadImage()

;~ 	Kiểm tra xem Auto chạy đúng số lượng không, chỉ chạy sau khi Gui được tạo
	CheckAuto()

;~ 	Hiển thị MainGUI
	ShowMainGUI()

;~ 	Kiểm tra xem có kết nối Internet không
	CheckInternet()
	
;~ 	Hàm lấy màu ở vị trí cuối của PetHP
	GetPetHPLocaColorFromFile()
	
;~ 	Hiển thị thông báo khi có phiên bản mới
	If $FindNewVersionT<>"" Then ShowHomePage()
	Sleep(1006)

;~ 	Xóa hình ảnh nạp
	HideLoadImage()
	EnableAllButton()
EndIf

While $Running
	Sleep(77)
		
;~ 	If $PetHPLocaColor=-7 Then ScanPetHPLocaColor()
	
;~ 	Hiển thị thông báo tình trạng đang hoạt động của việc Bơm PetHP
	RunningCheck()
	
;~ 	Tự động rao vặt
	AutoSpam()

;~ 	Lấy Tên ô skill chứa Thức ăn của thú từ giao diện Auto
	SetShotcutSkill()
	
;~ 	Hiển thị phần trăm sẽ bơm
	ShowDangerPos()
	
;~ 	Cập nhặt phầm trăm sẽ bơm
	SetDangerPos()
	
;~ 	Lấy thời gian chờ sau mỗi lần bơm từ giao diện Auto
	SetDelayTime()
	
;~ 	Hàm lấy vị trí của Game
;~ 	GetGamePos()

;~ 	Hàm lấy tạo độ trong của Game và vị trí PetHP
	GetCaretPosGame()	
	
;~ 	Lấy phần trăm PetHP
	GetPetHP()
	
;~ 	Hiển thị % Hp của Pet
	ShowPetHP()
	
;~ 	Kiểm tra chữ trong nút Bơm
	CheckTextButtonStart()
		
;~ 	Tạm dừng
	If PauseAuto() Then 
		ShowPauseAuto()
		ContinueLoop
	EndIf
		
;~ 	CheckActiveGame() 
	If Not CheckActiveGame() Then ContinueLoop

;~ 	Kiểm tra thoát Auto
	If Not $Running Then ExitLoop

;~ 	Kiểm tra xem đã đăng nhập chưa
;~ 	If Not IsLoginGame() Then ContinueLoop
	
;~  Tìm xem PetHP có bị che khi đang Bơm hay không
	If NotFindPetHP() Then ContinueLoop

;~ 	Kiểm tra thoát Auto
	If Not $Running Then ExitLoop
	
;~ 	Đợi sau mỗi lần cho ăn
	If $Waiting Then 
		Waiting($DelayTime)
		ContinueLoop
	EndIf

;~ 	Thực hiện khi kích hoạt chức năng tự Cho Ăn
	If $HealingPet Then AutoUsePetFood()
WEnd 
;~ ------ Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;~ -- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;~ Hàm tự động bơm máu cho Thú
Func ActiveAutoUsePetFood()
;~ 	Nếu chưa lấy Game Handle thì thoát
	If $GameHandleBK=7 Then Return False
		
	Local $F=0
	$HealingPet = Not $HealingPet
	If $HealingPet Then 
		$F=WinActivate($GameHandleBK)
		DelToolTip()
	EndIf
	
	If $F=0 Then $GameHandleBK=7
EndFunc
;~ Hàm tự động bơm máu cho Thú
Func AutoUsePetFood()
		If $PetHP<=$DangerPos Then 
		GUICtrlSetColor($Lable_PetHP,0xFF0000)
		If $GameHandle<>7 Then 
			WinActive($GameHandle)
			Send("{"&$KeyF&"}")
			
		EndIf
		$Waiting=True
		$TimeA=TimerInit()
	Else
		GUICtrlSetColor($Lable_PetHP,0x0077FF)
	EndIf
EndFunc

;~ Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	Local $l = WinList("[TITLE:"&$AutoTitle&"; CLASS:AutoIt v3 GUI;]")
	Local $CountProcess=$ProcessNumber

	If $l[0][0]>$ProcessNumber Then
		MsgBox(0,$AutoName,$EnoughAutoT)
		ExitAuto()
	EndIf
EndFunc

;~ Tạm dừng Auto
Func ActivePauseAuto()
	$Pause = Not $Pause
	If $Pause Then 
		ShowWarningGUI()
		GUICtrlSetData($Button_Pause,$Button_PauseT2)
	Else
		HiddenWarningGUI()
		GUICtrlSetData($Button_Pause,$Button_PauseT1)
		GUICtrlSetData($Lable_Warning,"")
	EndIf
		
	If $NotFoundPetHP Then
		$NotFoundPetHP=False
		$HealingPet=False
	EndIf
EndFunc
;~ Tạm dừng Auto
Func PauseAuto()
	If $Pause Then
		DisableButtonStart()
		Return True
	EndIf
	EnableButtonStart()			
	Return False
EndFunc
;~ Hiển thị thông báo tạm dừng Auto
Func ShowPauseAuto()
	Select
		Case $ShowPauseNum=1
			GUICtrlSetData($Lable_Warning,$PauseAutoT&" >    < ")
;~ 			ToolTip($PauseAutoT&" >    < ",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=2
			GUICtrlSetData($Lable_Warning,$PauseAutoT&"  >  <  ")
;~ 			ToolTip($PauseAutoT&"  >  <  ",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=3
			GUICtrlSetData($Lable_Warning,$PauseAutoT&"   ><   ")
;~ 			ToolTip($PauseAutoT&"   ><   ",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=4
			GUICtrlSetData($Lable_Warning,$PauseAutoT&"   <>   ")
;~ 			ToolTip($PauseAutoT&"   <>   ",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=5
			GUICtrlSetData($Lable_Warning,$PauseAutoT&"  <  >  ")
;~ 			ToolTip($PauseAutoT&"  <  >  ",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=6
			GUICtrlSetData($Lable_Warning,$PauseAutoT&" <    > ")
;~ 			ToolTip($PauseAutoT&" <    > ",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=7
			GUICtrlSetData($Lable_Warning,$PauseAutoT&"<      >")
;~ 			ToolTip($PauseAutoT&"<      >",$WarningPos[0],$WarningPos[1])
		Case $ShowPauseNum=8
	EndSelect
		
	If $ShowPauseNum=7 Then 
		$ShowPauseNum=0
	EndIf
	$ShowPauseNum+=1
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	GUIDelete($LoadWin)
	GUIDelete($MainGUI)
	$Running=False
	Exit 7
EndFunc

;~ Hàm tăng giới hạn Bơm Máu cho Thú
Func UpDangerPos()
	GUICtrlSetData($Input_DangerPos,GUICtrlRead($Input_DangerPos)+7)
	SetDangerPos()
EndFunc
;~ Hàm giảm giới hạn Bơm Máu cho Thú
Func DownDangerPos()
	GUICtrlSetData($Input_DangerPos,GUICtrlRead($Input_DangerPos)-7)
	SetDangerPos()
EndFunc
;~ Hàm lấy phần trăm sẽ bơm
Func SetDangerPos()
	If GUICtrlRead($Input_DangerPos)<1 Then GUICtrlSetData($Input_DangerPos,1)
	If GUICtrlRead($Input_DangerPos)>99 Then GUICtrlSetData($Input_DangerPos,99)
	$DangerPos=GUICtrlRead($Input_DangerPos)
EndFunc

;~ Hàm tăng thời gian đợi
Func UpDelayTime()
	GUICtrlSetData($Input_DelayTime,GUICtrlRead($Input_DelayTime)+77)
	SetDelayTime()
EndFunc
;~ Hàm giảm thời gian đợi
Func DownDelayTime()
	GUICtrlSetData($Input_DelayTime,GUICtrlRead($Input_DelayTime)-77)
	SetDelayTime()
EndFunc
;~ Hàm lấy thời gian chờ
Func SetDelayTime()
	If (GUICtrlRead($Input_DelayTime)<1)or(GUICtrlRead($Input_DelayTime)="") Then GUICtrlSetData($Input_DelayTime,1)
	If (GUICtrlRead($Input_DelayTime)>9999)or(GUICtrlRead($Input_DelayTime)="") Then GUICtrlSetData($Input_DelayTime,9999)
	If $DelayTime<>GUICtrlRead($Input_DelayTime) Then
		$DelayTime=GUICtrlRead($Input_DelayTime)
		GUICtrlSetTip($Lable_UnderStart,$Lable_UnderStart_TipT1)
	EndIf
EndFunc

;~ Hàm tạo giao diện
Func CreateInterface()
	AutoItSetOption("GUIOnEventMode",1)
	
	Global $Vertically=7 ;Cách khoảng từ trái sang phải
	Global $Horizontally=5 ;Cách khoảng từ trên xuống dưới
	
	Global $MainGUISize[2]=[167,187] ;Kích thước giao diện
	Global $MainGUIPos[2]=[$WarningPos[0]-$MainGUISize[0]-$Vertically,0] ;Vị trí giao diện
	
;~ 	Giao diện
	Global $MainGUI=GUICreate($AutoTitle,$MainGUISize[0],$MainGUISize[1],$MainGUIPos[0],$MainGUIPos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	
	$MenuTittle_Size=38.5
;~ 	Menu Quản Lý
	Global $Menu_File=GUICtrlCreateMenu($Menu_FileT)
	
;~ 	Menu nhỏ của Quản Lý - Game
	$Menu_File_Game=GUICtrlCreateMenu($Menu_File_GameT1,$Menu_File)	
	Global $Menu_File_Game_CloseGame=GUICtrlCreateMenuItem($Menu_File_Game_CloseGameT1,$Menu_File_Game)
	GUICtrlSetOnEvent($Menu_File_Game_CloseGame,"CloseGame")

;~ 	Menu nhỏ của Quản Lý - Truy cập
	$Menu_File_Browser=GUICtrlCreateMenu($Menu_File_BrowserT1,$Menu_File)	
	$Menu_File_Browser_HomePage=GUICtrlCreateMenuItem($Menu_File_Browser_HomePageT1,$Menu_File_Browser)	
	GUICtrlSetOnEvent($Menu_File_Browser_HomePage,"NavigateLeeSaiBlog")
	$Menu_File_Browser_PortPage=GUICtrlCreateMenuItem($Menu_File_Browser_PortPageT1,$Menu_File_Browser)	
	GUICtrlSetOnEvent($Menu_File_Browser_PortPage,"NavigatePortAuto")
	$Menu_File_Browser_LoginFPT=GUICtrlCreateMenuItem($Menu_File_Browser_LoginFPTT1,$Menu_File_Browser)	
	GUICtrlSetOnEvent($Menu_File_Browser_LoginFPT,"NavigateLoginFPT")
	
;~ 	Menu nhỏ của Quản Lý - Hiệu Chỉnh
	$Menu_File_Option=GUICtrlCreateMenu($Menu_File_OptionT,$Menu_File)
;~ 	Global $Menu_File_Option_FixAlt ;Dùng để thay đổi text khi kích hoạt
	Global $Menu_File_Option_FixAlt=GUICtrlCreateMenuItem($Menu_File_Option_FixAltT1,$Menu_File_Option)
	GUICtrlSetOnEvent($Menu_File_Option_FixAlt,"ActiveFixAlt2Ctrl")
	
;~ 	Items của Quản Lý - Thoat
	$Menu_File_Exit=GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")
	
;~ 	Menu Help
	Global $Menu_Help=GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HomePage=GUICtrlCreateMenuItem($Menu_Help_HomePageT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HomePage,"ShowHomePage")
	$Menu_Help_HotKey=GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_Attention=GUICtrlCreateMenuItem($Menu_Help_AttentionT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_Attention,"ShowAttentionAuto")
	$Menu_Help_About=GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")
	
;~ 	Menu Clear
	Global $Menu_Clear=GUICtrlCreateMenu($Menu_ClearT)
	$Menu_Clear_ToolTip=GUICtrlCreateMenuItem($Menu_Clear_ToolTip,$Menu_Clear)
	GUICtrlSetOnEvent($Menu_Clear_ToolTip,"ClearAll")
	
;~ 	Tạo 1 nền Tab
	$TabTittle_Size=21.4
	Global $MainTab_Size[2]=[$MainGUISize[0],$MainGUISize[1]-$MenuTittle_Size]
	Global $MainTab_Pos[2]=[0,0]
	Global $MainTab=GUICtrlCreateTab($MainTab_Pos[0],$MainTab_Pos[1],$MainTab_Size[0],$MainTab_Size[1])

;~ 	Nút thoát
	Global $Button_Exit_Size[2]=[25,22]
	Global $Button_Exit_Pos[2]=[$MainTab_Size[0]-$Button_Exit_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Exit_Size[1]-$Horizontally]
	Global $Button_Exit=GUICtrlCreateButton($Button_ExitT,$Button_Exit_Pos[0],$Button_Exit_Pos[1],$Button_Exit_Size[0],$Button_Exit_Size[1])
	GUICtrlSetOnEvent($Button_Exit,"ExitAuto")
	GUICtrlSetTip($Button_Exit,$Button_Exit_TipT)

;~ 	Nút tạm ngưng
	Global $Button_Pause_Size[2]=[25,$Button_Exit_Size[1]]
	Global $Button_Pause_Pos[2]=[$Button_Exit_Pos[0]-$Button_Pause_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Pause_Size[1]-$Horizontally]
	Global $Button_Pause=GUICtrlCreateButton($Button_PauseT1,$Button_Pause_Pos[0],$Button_Pause_Pos[1],$Button_Pause_Size[0],$Button_Pause_Size[1])
	GUICtrlSetOnEvent($Button_Pause,"ActivePauseAuto")
	GUICtrlSetTip($Button_Pause,$Button_Pause_TipT)
	
;~ 	Nút ẩn hiện
	Global $Button_Hidden_Size[2]=[25,$Button_Exit_Size[1]]
	Global $Button_Hidden_Pos[2]=[$Button_Pause_Pos[0]-$Button_Hidden_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Hidden_Size[1]-$Horizontally]
	Global $Button_Hidden=GUICtrlCreateButton($Button_HiddenT,$Button_Hidden_Pos[0],$Button_Hidden_Pos[1],$Button_Hidden_Size[0],$Button_Hidden_Size[1])
	GUICtrlSetOnEvent($Button_Hidden,"HiddenShow")
	GUICtrlSetTip($Button_Hidden,$Button_HiddenShow_TipT)

;~ 	Hiển thị thông báo vào thông tin thử nghiệm
	Global $Lable_Warning_Size[2]=[$MainGUISize[0]-$Vertically,16]
	Global $Lable_Warning_Pos[2]=[$Vertically,$Button_Exit_Pos[1]-$Lable_Warning_Size[1]]
	Global $Lable_Warning=GUICtrlCreateLabel("",$Lable_Warning_Pos[0],$Lable_Warning_Pos[1],$Lable_Warning_Size[0],$Lable_Warning_Size[1],$SS_CENTER)
	GUICtrlSetColor($Lable_Warning,0x0077FF)
	GUICtrlSetFont($Lable_Warning,9,777)

;~ 	Tạo Tab chức năng bơm PetHP
	Global $Tab_Pet=GUICtrlCreateTabItem($Tab_PetT)
	
;~ 	Nút bắt đầu làm việc
	Global $Button_Start_Size[2]=[43,25]
	Global $Button_Start_Pos[2]=[$Vertically,$Horizontally+$TabTittle_Size]
	Global $Button_Start=GUICtrlCreateButton($Button_StartT1,$Button_Start_Pos[0],$Button_Start_Pos[1],$Button_Start_Size[0],$Button_Start_Size[1])
	GUICtrlSetOnEvent($Button_Start,"ActiveAutoUsePetFood")
	GUICtrlSetTip($Button_Start,$Button_Start_TipT)
	
;~ 	Chú thích điểm sẽ bơm máu cho thú
	Global $Lable_InutDangerPos_Size[2]=[52,16]
	Global $Lable_InutDangerPos_Pos[2]=[$Button_Start_Pos[0]+$Button_Start_Size[0]+$Vertically,$Button_Start_Pos[1]+$Button_Start_Size[1]/4]
	Global $Lable_InutDangerPos=GUICtrlCreateLabel($Lable_InutDangerPosT1,$Lable_InutDangerPos_Pos[0],$Lable_InutDangerPos_Pos[1],$Lable_InutDangerPos_Size[0],$Lable_InutDangerPos_Size[1],$SS_RIGHT)
	GUICtrlSetFont($Lable_InutDangerPos,9,777)
	GUICtrlSetTip($Lable_InutDangerPos,$Lable_DangerPos_TipT)
	
;~ 	Chỗ nhập phần trăm còn khi bơm
	Global $Input_DangerPos_Size[2]=[18.7,16]
	Global $Input_DangerPos_Pos[2]=[$Lable_InutDangerPos_Pos[0]+$Lable_InutDangerPos_Size[0]+$Vertically,$Lable_InutDangerPos_Pos[1]]
	Global $Input_DangerPos=GUICtrlCreateInput($DangerPos,$Input_DangerPos_Pos[0],$Input_DangerPos_Pos[1],$Input_DangerPos_Size[0],$Input_DangerPos_Size[1])
	GUICtrlSetTip($Input_DangerPos,$Lable_DangerPos_TipT)

;~ 	Chữ phần trăm
	Global $Lable_Percentage_Size[2]=[11,16]
	Global $Lable_Percentage_Pos[2]=[$Input_DangerPos_Pos[0]+$Input_DangerPos_Size[0],$Input_DangerPos_Pos[1]]
	Global $Lable_Percentage=GUICtrlCreateLabel("%",$Lable_Percentage_Pos[0],$Lable_Percentage_Pos[1],$Lable_Percentage_Size[0],$Lable_Percentage_Size[1])
	GUICtrlSetFont($Lable_Percentage,11,777)
	
;~ 	Chữ bên dưới nút Start
	Global $Lable_UnderStart_Size[2]=[$MainGUISize[0]/2,16]
	Global $Lable_UnderStart_Pos[2]=[$Button_Start_Pos[0],$Button_Start_Pos[1]+$Button_Start_Size[1]+$Horizontally]
	Global $Lable_UnderStart=GUICtrlCreateLabel($Lable_UnderStartT1,$Lable_UnderStart_Pos[0],$Lable_UnderStart_Pos[1],$Lable_UnderStart_Size[0],$Lable_UnderStart_Size[1])
	GUICtrlSetFont($Lable_UnderStart,9,777)
	GUICtrlSetTip($Lable_UnderStart,$Lable_UnderStart_TipT1)
	
;~ 	Chỗ nhập thời gian đợi
	Global $Input_DelayTime_Size[2]=[34,16]
	Global $Input_DelayTime_Pos[2]=[$Lable_UnderStart_Pos[0]+$Lable_UnderStart_Size[0]+$Vertically,$Lable_UnderStart_Pos[1]]
	Global $Input_DelayTime=GUICtrlCreateInput($DelayTime,$Input_DelayTime_Pos[0],$Input_DelayTime_Pos[1],$Input_DelayTime_Size[0],$Input_DelayTime_Size[1],$SS_RIGHT)
	GUICtrlSetTip($Input_DelayTime,$Lable_UnderStart_TipT1)
	
;~ 	Chữ giây
	Global $Lable_Second_Size[2]=[25,16]
	Global $Lable_Second_Pos[2]=[$Input_DelayTime_Pos[0]+$Input_DelayTime_Size[0]+$Vertically,$Input_DelayTime_Pos[1]]
	Global $Lable_Second=GUICtrlCreateLabel($SecondT,$Lable_Second_Pos[0],$Lable_Second_Pos[1],$Lable_Second_Size[0],$Lable_Second_Size[1])
	
;~ 	Chú thích nhập ô chứ Thức ăn
	Global $Lable_ShortcutSkill_Size[2]=[$MainGUISize[0]/3.4,16]
	Global $Lable_ShortcutSkill_Pos[2]=[$Lable_UnderStart_Pos[0],$Lable_UnderStart_Pos[1]+$Lable_UnderStart_Size[1]+$Horizontally*2]
	Global $Lable_ShortcutSkill=GUICtrlCreateLabel($Lable_ShortcutSkillT1,$Lable_ShortcutSkill_Pos[0],$Lable_ShortcutSkill_Pos[1],$Lable_ShortcutSkill_Size[0],$Lable_ShortcutSkill_Size[1])
	GUICtrlSetFont($Lable_ShortcutSkill,9,777)
	GUICtrlSetTip($Lable_ShortcutSkill,$Lable_ShortcutSkill_TipT1)
	
;~ 	Combo chọn phím nóng của skill
	Global $Combo_ShortcutSkill_Size[2]=[43,16]
	Global $Combo_ShortcutSkill_Pos[2]=[$Lable_ShortcutSkill_Pos[0]+$Lable_ShortcutSkill_Size[0]+$Vertically,$Lable_ShortcutSkill_Pos[1]-$Combo_ShortcutSkill_Size[1]/7]
	Global $Combo_ShortcutSkill=GUICtrlCreateCombo($KeyF,$Combo_ShortcutSkill_Pos[0],$Combo_ShortcutSkill_Pos[1],$Combo_ShortcutSkill_Size[0],$Combo_ShortcutSkill_Size[1],$SS_RIGHT)
	GUICtrlSetData($Combo_ShortcutSkill,$KeyListF)
	GUICtrlSetTip($Combo_ShortcutSkill,$Lable_ShortcutSkill_TipT1)
	
;~ 	Nút xác nhận PetHP kg bị che
	Global $Button_SavePetColor_Size[2]=[43,20]
	Global $Button_SavePetColor_Pos[2]=[$Combo_ShortcutSkill_Pos[0]+$Combo_ShortcutSkill_Size[0]+$Vertically,$Combo_ShortcutSkill_Pos[1]]
	Global $Button_SavePetColor=GUICtrlCreateButton($Button_SavePetColorT1,$Button_SavePetColor_Pos[0],$Button_SavePetColor_Pos[1],$Button_SavePetColor_Size[0],$Button_SavePetColor_Size[1])
	GUICtrlSetOnEvent($Button_SavePetColor,"ScanPetHPLocaColor")
	GUICtrlSetTip($Button_SavePetColor,$Button_SavePetColor_TipT)
	GUICtrlSetState($Button_SavePetColor,$GUI_HIDE)
	
;~ 	Thông tin về phần trăm máu sẽ bơm
	Global $Lable_DangerPos_Size[2]=[30.4,13.3]
	Global $Lable_DangerPos_Pos[2]=[$Button_Hidden_Pos[0]-$Lable_DangerPos_Size[0],$Button_Hidden_Pos[1]+$Horizontally]
	Global $Lable_DangerPos=GUICtrlCreateLabel("0%",$Lable_DangerPos_Pos[0],$Lable_DangerPos_Pos[1],$Lable_DangerPos_Size[0],$Lable_DangerPos_Size[1])
	GUICtrlSetColor($Lable_DangerPos,0x0077FF)
	GUICtrlSetTip($Lable_DangerPos,$Lable_DangerPos_TipT)
	
;~ 	Thông tin về máu của Pet	
	Global $Lable_PetHP_Size[2]=[20.5,13.3]
	Global $Lable_PetHP_Pos[2]=[$Lable_DangerPos_Pos[0]-$Lable_PetHP_Size[0],$Lable_DangerPos_Pos[1]]
	Global $Lable_PetHP=GUICtrlCreateLabel("0 / ",$Lable_PetHP_Pos[0],$Lable_PetHP_Pos[1],$Lable_PetHP_Size[0],$Lable_PetHP_Size[1],$SS_RIGHT)
	GUICtrlSetColor($Lable_PetHP,0x0077FF)
	GUICtrlSetTip($Lable_PetHP,$Lable_PetHP_TipT)
	
;~ 	Thông cho biết Chức năng tự bơm máu có chạy hay không
	Global $Lable_Run_Size[2]=[9,13.3]
	Global $Lable_Run_Pos[2]=[$Vertically,$Lable_PetHP_Pos[1]]
	Global $Lable_Run=GUICtrlCreateLabel("",$Lable_Run_Pos[0],$Lable_Run_Pos[1],$Lable_Run_Size[0],$Lable_Run_Size[1])
	GUICtrlSetColor($Lable_Run,0x0077FF)

;~ 	Tạo Tab chức năng rao vặt
	Global $Tab_Spam=GUICtrlCreateTabItem($Tab_SpamT)
	
;~ 	Tự động Spam
	Global $CheckBox_AutoSpam_Size[2]=[$MainGUISize[0],25]
	Global $CheckBox_AutoSpam_Pos[2]=[$Vertically,$Horizontally+$TabTittle_Size]
	Global $CheckBox_AutoSpam=GUICtrlCreateCheckbox($CheckBox_AutoSpamT1,$CheckBox_AutoSpam_Pos[0],$CheckBox_AutoSpam_Pos[1],$CheckBox_AutoSpam_Size[0],$CheckBox_AutoSpam_Size[1])
	GUICtrlSetState($CheckBox_AutoSpam,$GUI_CHECKED)
	
	Global $CheckBox_AutoSpam2_Size[2]=[$MainGUISize[0],25]
	Global $CheckBox_AutoSpam2_Pos[2]=[$Vertically,$CheckBox_AutoSpam_Pos[1]+25]
	Global $CheckBox_AutoSpam2=GUICtrlCreateLabel($CheckBox_AutoSpamT2,$CheckBox_AutoSpam2_Pos[0],$CheckBox_AutoSpam2_Pos[1],$CheckBox_AutoSpam2_Size[0],$CheckBox_AutoSpam2_Size[1])

;~ 	GUICtrlSetBkColor(-1,0xFFAABC)
EndFunc

;~ Hàm khóa tất cả các tương tác
Func DisableAllButton()
	DisableMainGUI()
	DisableMenuFile()
	DisableMenuHelp()
	DisableMenuClear()
	DisableMainTab()
	DisableButtonStart()
	DisableButtonPause()
	DisableButtonExit()
	DisableButtonHidden()
EndFunc
;~ Hàm khóa tất cả các tương tác
Func EnableAllButton()
	EnableMainGUI()
	EnableMenuFile()
	EnableMenuHelp()
	EnableMenuClear()
	EnableMainTab()
	EnableButtonStart()
	EnableButtonPause()
	EnableButtonExit()
	EnableButtonHidden()
EndFunc

;~ Hàm hiển thị giao diện
Func ShowMainGUI()
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc
;~ Hàm ẩn thị giao diện
Func HideMainGUI()
	GUISetState(@SW_HIDE,$MainGUI)
EndFunc
;~ Hàm khóa giao diện
Func DisableMainGUI()
	GUISetState(@SW_DISABLE,$MainGUI)
EndFunc
;~ Hàm kích hoạt giao diện
Func EnableMainGUI()
	GUISetState(@SW_ENABLE,$MainGUI)
EndFunc

;~ Hàm khóa Menu File
Func DisableMenuFile()
	GUICtrlSetState($Menu_File,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt Menu File
Func EnableMenuFile()
	GUICtrlSetState($Menu_File,$GUI_ENABLE)
EndFunc

;~ Hàm khóa Menu Help
Func DisableMenuHelp()
	GUICtrlSetState($Menu_Help,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt Menu Help
Func EnableMenuHelp()
	GUICtrlSetState($Menu_Help,$GUI_ENABLE)
EndFunc

;~ Hàm khóa Menu Clear
Func DisableMenuClear()
	GUICtrlSetState($Menu_Clear,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt Menu Clear
Func EnableMenuClear()
	GUICtrlSetState($Menu_Clear,$GUI_ENABLE)
EndFunc

;~ Hàm khóa MainTab
Func DisableMainTab()
	GUICtrlSetState($MainTab,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt MainTab
Func EnableMainTab()
	GUICtrlSetState($MainTab,$GUI_ENABLE)
EndFunc

;~ Hàm khóa nút Start
Func DisableButtonStart()
	If GUICtrlGetState($Button_Start)=80 Then GUICtrlSetState($Button_Start,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt nút Start
Func EnableButtonStart()
	If GUICtrlGetState($Button_Start)=144 Then GUICtrlSetState($Button_Start,$GUI_ENABLE)
EndFunc

;~ Hàm khóa nút Pause
Func DisableButtonPause()
	GUICtrlSetState($Button_Pause,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt nút Pause
Func EnableButtonPause()
	GUICtrlSetState($Button_Pause,$GUI_ENABLE)
EndFunc

;~ Hàm khóa nút Exit
Func DisableButtonExit()
	GUICtrlSetState($Button_Exit,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt nút Exit
Func EnableButtonExit()
	GUICtrlSetState($Button_Exit,$GUI_ENABLE)
EndFunc

;~ Hàm khóa nút Hidden
Func DisableButtonHidden()
	GUICtrlSetState($Button_Hidden,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt nút Hidden
Func EnableButtonHidden()
	GUICtrlSetState($Button_Hidden,$GUI_ENABLE)
EndFunc

;~ Hàm khóa nút SavePetColor
Func DisableButtonSavePetColor()
	GUICtrlSetState($Button_SavePetColor,$GUI_HIDE)
EndFunc
;~ Hàm kích hoạt nút SavePetColor
Func EnableButtonSavePetColor()
	GUICtrlSetState($Button_SavePetColor,$GUI_SHOW)
EndFunc


;~ Hàm ẩn hiện chương trình
Func HiddenShow()
	Local $Pos=WinGetPos($MainGUI)
	If $Pos[1]=0 Then 
		GUICtrlSetData($Button_Hidden,$Button_ShowT)
		WinMove($MainGUI,"",$MainGUIPos[0],$MainGUIPos[1]-$MainGUISize[1]+$Button_Hidden_Size[1]+$Horizontally,Default,Default,2)
		$Hidden=True
	Else
		GUICtrlSetData($Button_Hidden,$Button_HiddenT)
		WinMove($MainGUI,"",$MainGUIPos[0],$MainGUIPos[1],Default,Default,2)
		$Hidden=False
	EndIf
EndFunc

;~ Hàm hiển thị phần trăm sẽ bơm
Func ShowDangerPos()
	If GUICtrlRead($Lable_DangerPos)<>$DangerPos Then GUICtrlSetData($Lable_DangerPos,$DangerPos&"%")
EndFunc

;~ Hàm lấy phím nóng ô Thức ăn
Func SetShotcutSkill()
	$KeyF=GUICtrlRead($Combo_ShortcutSkill)
EndFunc

;~ Hàm hiển thị máu của thú nuôi
Func ShowPetHP()
	GUICtrlSetData($Lable_PetHP,$PetHP&"/")
EndFunc

;~ Hàm cho biết chức năng tự bơm đang hoạt động
Func RunningCheck()
	If Not $HealingPet Then 
;~ 	Nếu không bơm thì không hiển thị cái này nữa và xóa đi
		GUICtrlSetData($Lable_Run,"")
		Return False
	EndIf

;~ 	Nếu tạm dừng, không tìm thấy PetHP, thì không hiển thị tiếp, nhưng không xóa
	If $Pause or $NotFoundPetHP or Not $GameActivace or $GameHandle=7 Then Return False

	Select
		Case $HealingPetI=1
			GUICtrlSetData($Lable_Run,"|")
		Case $HealingPetI=2
			GUICtrlSetData($Lable_Run,"/")
		Case $HealingPetI=3
			GUICtrlSetData($Lable_Run,"__")
		Case $HealingPetI=4
			GUICtrlSetData($Lable_Run,"\")
		Case $HealingPetI=5
			GUICtrlSetData($Lable_Run,"|")
		Case $HealingPetI=6
			GUICtrlSetData($Lable_Run,"\")
		Case $HealingPetI=7
			GUICtrlSetData($Lable_Run,"__")
		Case $HealingPetI=8
			GUICtrlSetData($Lable_Run,"/")
		Case $HealingPetI=9
			GUICtrlSetData($Lable_Run,"S")
	EndSelect
	
	If $HealingPetI=9 Then 
		$HealingPetI=0
	EndIf
	$HealingPetI+=1
EndFunc

;~ Hàm đợi giúp delay thời gian bơm
Func Waiting($DelayTime)
	If TimerDiff($TimeA)>($DelayTime) Then $Waiting=False
EndFunc
	
;~ Hàm dọn dẹp tất cả
Func ClearAll()
	DelTooltip()
EndFunc

;~ Hàm kiểm tra xem game có chạy không
Func GetGameHandle()
	$GameHandle=WinGetHandle("[TITLE:Thien Long Bat Bo; CLASS:TianLongBaBu WndClass;]")
	
	If @error Then 
		$GameHandle=7 
		Return False
	EndIf
	
	$GameHandleBK=$GameHandle
	Return True
EndFunc

;~ Hàm dừng mọi hoạt động
Func StopAll()
	$HealingPet=False
	$Waiting=False
	$NotFoundPetHP=False
	$Pause=False
EndFunc

;~ Hàm Cho phép kích hoạt chức năng đổi các phím nóng Alt bằng Ctrl
Func ActiveFixAlt2Ctrl()
	$Alt2Ctrl=Not $Alt2Ctrl
	If $Alt2Ctrl Then 
		GUICtrlSetData($Menu_File_Option_FixAlt,$Menu_File_Option_FixAltT2)
		EnableFixAlt2Ctrl()
	Else
		GUICtrlSetData($Menu_File_Option_FixAlt,$Menu_File_Option_FixAltT1)
		DisableFixAlt2Ctrl()
	EndIf
EndFunc
;~ Hàm kích hoạt chức năng đổi các phím nóng Alt bằng Ctrl
Func EnableFixAlt2Ctrl()
	AutoItSetOption("SendCapslockMode",0)
	HotKeySet("^c","AltC")
	HotKeySet("^x","AltS")
	HotKeySet("^z","AltX")
	HotKeySet("^s","AltQ")
	HotKeySet("^a","AltA")
EndFunc
;~ Hàm tắt chức năng đổi các phím nóng Alt bằng Ctrl
Func DisableFixAlt2Ctrl()
	AutoItSetOption("SendCapslockMode",1)
	HotKeySet("^c")
	HotKeySet("^x")
	HotKeySet("^z")
	HotKeySet("^s")
	HotKeySet("^a")
EndFunc

Func AltC()
	Send("!c")
EndFunc
Func AltS()
	Send("!s")
EndFunc
Func AltX()
	Send("!x")
EndFunc
Func AltQ()
	Send("!q")
EndFunc
Func AltA()
	Send("!a")
EndFunc

;~ Hàm kiểm tra phiên bản của Chuong trình
Func CheckVersionAuto()
	CreateLoadImage()
	InetGetSize("http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/SaiATLBB/"&$AutoVersionCode&".gif")
	If @error Then $FindNewVersionT=@LF&@LF&@TAB&@TAB&$FoundNewVersionT
EndFunc
;~ Hàm tạo hình nạp khi hhởi động
Func CreateLoadImage()
	_IEErrorHandlerRegister ()
	$oIE = _IECreateEmbedded ()
	Global $LoadWin_Size[2]=[196,115]
;~ 	Global $LoadWin_Pos[2]=[@DesktopWidth/2-$LoadWin_Size[0]/2, @DesktopHeight/2-$LoadWin_Size[1]/2]
	Global $LoadWin_Pos[2]=[@DesktopWidth/2-$LoadWin_Size[0]/2, @DesktopHeight/7-$LoadWin_Size[1]/2]
	Global $LoadWin=GUICreate("Đang nạp",$LoadWin_Size[0],$LoadWin_Size[1],$LoadWin_Pos[0],$LoadWin_Pos[1],$WS_POPUPWINDOW,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW,$MainGUI)
	$GUIActiveX = GUICtrlCreateObj($oIE, -16, -43, 250, 196)
;~ 	If FileGetSize(@ScriptDir&"/load.sai") Then 
		_IENavigate ($oIE,"file:///"&@ScriptDir&"/load.sai")
;~ 	Else
;~ 		_IENavigate ($oIE,"http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/SaiATLBB/load1801.gif")
;~ 	EndIf
EndFunc
;~ Hàm hiển thị hình khởi động
Func ShowLoadImage()
	GUISetState(@SW_SHOW,$LoadWin)
EndFunc
;~ Hàm ẩn thị hình khởi động
Func HideLoadImage()
	GUISetState(@SW_HIDE,$LoadWin)
;~ 	GUISwitch($MainGUI)
EndFunc	
	
;~ Hàm kiểm tra kết nối internet
Func CheckInternet()
	InetGetSize("http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/SaiATLBB/net.gif")
	If @error Then 
		MsgBox(0,$AutoName,$InternetNotFoundT)
		ExitAuto()
	EndIf
EndFunc

;~ Hàm truy cập LeeSaiBlog để tải Auto
Func NavigateLeeSaiBlog()
	_IECreate("http://my.opera.com/saihukaru/blog/",0,1,0,1)
	HiddenShow()
EndFunc

;~ Hàm truy cập LeeSaiBlog để tải Auto
Func NavigatePortAuto()
	_IECreate("http://my.opera.com/saihukaru/blog/auto-saiatlbb",0,1,0,1)
	HiddenShow()
EndFunc

;~ Hàm truy cập LeeSaiBlog để tải Auto
Func NavigateLoginFPT()
	_IECreate("https://psp.gate.vn/",0,1,0,1)
	HiddenShow()
EndFunc

;~ Hàm lấy vị trí trong của Game
Func GetCaretPosGame()

	If $GameActivace Then $GameCaretPos=WinGetCaretPos()
	If $Test5 Then ToolTip(".",$GameCaretPos[0],$GameCaretPos[1])
;~ 	Lấy vị trí PetHP
	$PetHPPos[0]=$GameCaretPos[0]+64.6
	$PetHPPos[1]=$GameCaretPos[1]+69.1

EndFunc

;~ Hàm kiểm tra chữ trong nút Bơm
Func CheckTextButtonStart()
	If $HealingPet Then
		If GUICtrlRead($Button_Start)=$Button_StartT1 Then GUICtrlSetData($Button_Start,$Button_StartT2)
	Else 
		If GUICtrlRead($Button_Start)=$Button_StartT2 Then GUICtrlSetData($Button_Start,$Button_StartT1)
	EndIf
EndFunc

;~ 	Kiểm tra xem game có ở trên cùng không
Func CheckActiveGame()
	$GameActivace=WinActive($GameHandle)
	If $Test3 Then ToolTip($GameActivace&" - Handle: "&$GameHandle,0,0)

;~ 	Kiểm tra để lấy vị trí trong của Game
	If $GameActivace=1 Then 
;~ 		Kiểm tra để lấy Handle của Game 
		If $GameHandle=7 Then 
			GetGameHandle()

;~ 			Kiểm tra để Reset Auto khi chưa chạy Auto vì chưa có $GameHandleBK
			If $GameHandleBK=7 Then
				$HealingPet=False
				$Pause=False
			EndIf			
			Return False
		EndIf
		If $Alt2Ctrl Then EnableFixAlt2Ctrl()
		Return True
	Else
		If $Alt2Ctrl Then DisableFixAlt2Ctrl()
		$GameHandle=7
		$GameHandleBK=7
		GetGameHandle()
		Return False
	EndIf
EndFunc

;~ 2 Hàm Ẩn/Hiện thông báo trong Gui
Func ShowWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUIPos[0],$MainGUIPos[1]-$MainGUISize[1]+$Button_Hidden_Size[1]+$Lable_Warning_Size[1]+$Horizontally,Default,Default,2)
EndFunc
Func HiddenWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUIPos[0],$MainGUIPos[1]-$MainGUISize[1]+$Button_Hidden_Size[1]+$Horizontally,Default,Default,2)
EndFunc

;~ Hàm đóng nhanh Game
Func CloseGame()
	Local $PID = WinGetProcess($GameHandle)
	ProcessClose($PID)
EndFunc

;~ Hàm kiểm tra máu của Thú	
Func GetPetHP()
;~ 	Những kiểm tra khi PetHP bị che
	If $Pause or $NotFoundPetHP or Not $GameActivace or $GameHandle=7 Then
		$PetHP="XX"
		Return False
	EndIf

;~ 	Dò tìm giao điểm Đỏ và Đen của PetHP
	For $i=$PetHPPos[0]+$PetHP-$PetHPSpamPos To $PetHPPos[0]+99 Step 1
		If $i<$PetHPPos[0] Then $i=$PetHPPos[0]
		$PetHPColor=PixelGetColor($i,$PetHPPos[1])
		If $Test2 Then ToolTip($PetHPSpamPos,$i,$PetHPPos[1])
;~ 		If $Test2 Then ToolTip($PetHPColor,$i,$PetHPPos[1])
		If ($PetHPColor<16700000) Then 
			$PetHPSpamPos+=7
			ExitLoop
		Else
			$PetHPSpamPos=2
		EndIf
	Next
	$Percent=$i-$PetHPPos[0]

	$PetHP=$Percent
	Return True
EndFunc

;~ Kiểm tra xem có gì che PetHP không
Func NotFindPetHP()
	Local $CheckColorPos[2]=[$PetHPPos[0]+99,$PetHPPos[1]-3]
	Local $Color1=PixelGetColor($CheckColorPos[0],$CheckColorPos[1])
 	If $Test1 Then ToolTip($Color1&"/"&$PetHPLocaColor,$CheckColorPos[0],$CheckColorPos[1])

;~ 	Kiểm tra xem PetCó bị che không
	If ($Color1<>$PetHPLocaColor) Then 
		GetPetHPLocaColorFromFile()
		$NotFoundPetHP=True

;~ 		Nếu màu không đúng thì hiển nút sửa lỗi
		If $PetHPLocaColor=-7 Then EnableButtonSavePetColor()

;~ 		Nếu màu nạp từ file mà sai thì xóa file
		If $PetHPLocaColor<>-7 Then 
			FileDelete($FileName1)
			$SaveFileName1=False
		EndIf
		Return True
	EndIf
	
;~ 	Lưa màu ở vị trí cuối PetHP xuống file
	If Not $NotFoundPetHP And Not $SaveFileName1 Then
		Local $SFile=FileOpen($FileName1,2+8+128)
		FileWriteLine($SFile,$PetHPLocaColor)
		FileWriteLine($SFile,"Sửa cái số ở đây là phải xóa File này đi đó nha (-.-)")
		FileClose($SFile)
		FileSetAttrib($FileName1,"+SR")
		$SaveFileName1=True
	EndIf
	
;~ 	Ẩn nút sửa lỗi
	DisableButtonSavePetColor()
	
	$NotFoundPetHP=False
	Return False
EndFunc

;~ Hàm lấy Màu vị trí cuối của PetHP từ Game, để xác định xem PetHP có bị che không
Func ScanPetHPLocaColor()
	WinActivate($GameHandle)
	GetCaretPosGame()
	Local $CheckColorPos[2]=[$PetHPPos[0]+99,$PetHPPos[1]-3]
	$PetHPLocaColor=PixelGetColor($CheckColorPos[0],$CheckColorPos[1])
EndFunc

;~ Hàm lấy màu ở vị trí cuối của PetHP từ File
Func GetPetHPLocaColorFromFile()
	Local $OFile=FileOpen($FileName1,0)
	$PetHPLocaColor=FileReadLine($OFile)
	FileClose($OFile)
	If $PetHPLocaColor="" Then 
		$PetHPLocaColor=-7
	Else
		$SaveFileName1=True
	EndIf
EndFunc


;~ Xem Địa chỉ tải
Func ShowHomePage()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"ĐỊA CHỈ TRANG CHỦ & NƠI TẢI TRƯƠNG TRÌNH"
	$text=$text&$FindNewVersionT&@LF&@LF
	$text=$text&" - LeeSaiBlog: "&@TAB&$BlogName&@LF
	$text=$text&" - Hoặc: "&@TAB&"NgoiSaoBlog.com/ShockBoy007"&@LF&@LF
	$text=$text&" - Link tải: "&$LinkDown
	ToolTip($text,$x,$y)
EndFunc

;~ Xem phím nóng
Func ShowHotKey()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
	$text=$text&"  Pause"&@TAB&""&@TAB&@TAB&"- Tạm Dừng Chương Trình"&@LF
	$text=$text&"  PageUp"&@TAB&@TAB&"- Tăng Giới Hạn Máu"&@LF
	$text=$text&"  PageDown"&@TAB&@TAB&"- Giảm Giới Hạn Máu"&@LF
	$text=$text&"  Ctrl+PageUp"&@TAB&@TAB&"- Tăng Thời Gian Đợi"&@LF
	$text=$text&"  Ctrl+PageDown"&@TAB&"- Giảm Thời Gian Đợi"&@LF
	$text=$text&"  Ctrl+Shilf+F7"&@TAB&@TAB&"- Bắt Đầu Bơm"&@LF
	$text=$text&"  Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
	$text=$text&"  Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
	$text=$text&"  Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Chương Trình"&@LF
	ToolTip($text,$x,$y)
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"THÔNG TIN CHƯƠNG TRÌNH"&@LF
	$text=$text&" - Chương Trình: "&$AutoName&" v"&$AutoVersion&@LF
	$text=$text&" - Thiết kế: "&$Author&@LF
	$text=$text&" - Chức năng: "&$Functions&@LF
	ToolTip($text,$x,$y)
EndFunc

;~ Hàm xuất thông tin lưu ý
Func ShowAttentionAuto()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"HẠN CHẾ CỦA CHƯƠNG TRÌNH"&@LF
;~ 	$text=$text&" - Chương trình chỉ Hỗ Trợ chứ không Auto hoàn toàn."&@LF
	$text=$text&" - Do được 1 người làm nên cần cập nhật sữa lỗi nhiều."&@LF
	$text=$text&" - Chương trình chưa hỗ trợ cho nhiều tài khoản 1 lúc."&@LF&@LF
	$text=$text&@TAB&"ƯU ĐIỂM CỦA CHƯƠNG TRÌNH"&@LF
	$text=$text&" - Không bao giờ có Keylog hay Virus. (^_^ )"&@LF&@LF
	$text=$text&@TAB&"CHỨC NĂNG TỰ CHO THÚ ĂN"&@LF
	$text=$text&" - Chỉ bấm nút Sửa Lỗi khi đã gọi Thú Nuôi."&@LF
	$text=$text&" - Nếu lỡ bấm thì xóa File [color.sai] đi."&@LF
	ToolTip($text,$x,$y)
EndFunc

;~ Hàm nạp ngôn ngữ hiển thị
Func SetLanguage()
;~ Biến Mô Tả Chương Trình
	Global $AutoName="Sai ATLBB"					;Tên Chương Trình
	Global $AutoBeta="[Thử]"						;Chương Trình thử nghiệm
	Global $AutoClass="AutoIt v3 GUI"				;Mã phân loại Chương Trình		
	Global $AutoVersion="1.80.2"					;Phiên Bản
	Global $AutoVersionCode="1802"					;Mã số Phiên Bản
	Global $FindNewVersionT=""
	Global $Author="Trần Minh Đức"					;Tên (các) Lập Trình Viện
	Global $BlogName="http://www.LeeSai.co.cc"		;Địa chỉ Blog
	Global $BlogNameFull="http://my.opera.com/saihukaru/blog/"
	Global $LinkDown="http://my.opera.com/saihukaru/blog/auto-saiatlbb"
	
	Global $AutoTitle=$AutoName&" v"&$AutoVersion&" "&$AutoBeta

	Global $Functions=@CRLF							;Các chức năng của Chương Trình
	$Functions=$Functions&"   +Tự cho Thú ăn"&@CRLF
	$Functions=$Functions&"   +Tự rao mua/bán (Thử nghiệm)"

;~ Biến ngôn ngữ
	Global $Menu_FileT="&Quản Lý"
	Global $Menu_File_GameT1="&Thiên Long"
	Global $Menu_File_Game_CloseGameT1="&Tắt Nhanh Game"
	Global $Menu_File_BrowserT1="&Truy Cập"
	Global $Menu_File_Browser_HomePageT1="&Blog của Tác Giả"
	Global $Menu_File_Browser_PortPageT1="&Nơi tải "&$AutoName
	Global $Menu_File_Browser_LoginFPTT1="&Nơi Reset giờ chơi"
	Global $Menu_File_OptionT="&Tùy Chọn"
	Global $Menu_File_Option_FixAltT1="&Hiệu Chỉnh Phím Nóng (Bật lên)"
	Global $Menu_File_Option_FixAltT2="&Hiệu Chỉnh Phím Nóng (Tắt đi)"
	Global $Menu_File_Option_CloseGameT1="&Tắt Game"
	Global $Menu_File_ExitT="&Thoát"
	Global $Menu_HelpT="&Hỗ Trợ"
	Global $Menu_Help_HomePageT="&Trang Chủ"
	Global $Menu_Help_HotKeyT="&Phím Nóng"
	Global $Menu_Help_AttentionT="&Các Lưu Ý"
	Global $Menu_Help_AboutT="&Thông Tin"
	Global $Menu_ClearT="&Dọn Dẹp"
	Global $Menu_Clear_ToolTip="&Tắt Thông Báo"
	
	Global $Tab_PetT="Thú Nuôi"
	
	Global $Button_StartT1="Bơm"
	Global $Button_StartT2="Ngưng"
	Global $Button_Start_TipT="Bắt đầu canh để bơm máu cho Thú"
	Global $Lable_InutDangerPosT1="khi còn"
	Global $Lable_DangerPos_TipT="Nếu máu của thú ít hơn chừng này % thì cho ăn"
	Global $Lable_UnderStartT1="Thời gian đợi: "
	Global $Lable_UnderStart_TipT1="Thời gian đợi sau mỗi lần cho Thú ăn."&@LF&"Tình bằng mili giây: "&$DelayTime&"ms ~ "&int($DelayTime/$1s)&"giây"
	Global $SecondT="ms"
	Global $Lable_ShortcutSkillT1="Ô chứa: "
	Global $Lable_ShortcutSkill_TipT1="Ô này sẽ chứa Thức ăn của thú"
	Global $Button_SavePetColorT1="Sửa Lỗi"
	Global $Button_SavePetColor_TipT="Chỉ bấm khi nào đã gọi thú lên."
	Global $Lable_PetHP_TipT="Phần trăm máu của thú nuôi hiện giờ"
	
	Global $Tab_SpamT="Rao Vặt"
	
	Global $CheckBox_AutoSpamT1="Tự động Quảng cáo"
	Global $CheckBox_AutoSpamT2="(Thử nghiệm tự rao mua/bán)"
	Global $AutoSpamT1="#33#33#33#33#33#33#33 #WTải chương trình #G"&$AutoName&" v"&$AutoVersion&"#W có chức năng tự cho Pet ăn, miễn Phí 100% từ Blog #G"&$BlogName&"#W bảo đảm không có Keylog #33#33#33#33#33#33#33"
	Global $AutoSpamT2="#51#51#51#51#51#51#51 Cảnh báo về Hacker Thiên Long, kẻ đã lấy được rất nhiều tài khoản của các Pro bằng Websize #Ywww.tlvn.biz#W. Để xem thông tin chi tiết hãy vào Blog #G"&$BlogName&"#W"
	
	Global $Button_HiddenT="/\"
	Global $Button_ShowT="\/"
	Global $Button_HiddenShow_TipT="Thu gọn chương trình"
	Global $Button_PauseT1="<  >"
	Global $Button_PauseT2="<>"
	Global $Button_Pause_TipT="Tạm ngưng hoạt động"
	Global $Button_ExitT="X"
	Global $Button_Exit_TipT="Thoát chương trình"

	Global $EnoughAutoT=$AutoName&" đã chạy đủ."&@LF&"Không thể mở thêm!!!"
	Global $InternetNotFoundT="Không có kết nối Internet"
	Global $FoundNewVersionT=" (ĐÃ CÓ PHIÊN BẢN MỚI)"
	Global $GameNotFoundT="Không tìm thấy Game"
	Global $PauseAutoT="Tạm dừng"
	Return True
EndFunc

;~ ------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;~ -- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Hàm Spam
Func AutoSpam()
;~ 	Nếu chưa Check hoặc chưa thấy Game Thì không làm
	If (GUICtrlRead($CheckBox_AutoSpam)=4)or($GameHandle=7)or(Not $HealingPet)or($Pause)or(Not $GameActivace) Then Return False

	If TimerDiff($TimeSpam)>$DelayTimeSpam or $TimeSpam=-7 Then
		$TimeSpam=TimerInit()
		Execute("ClipPut($AutoSpamT"&Random(1,2,1)&")")
		Send("^v")
		Send("{Enter}")
	EndIf
EndFunc
;~ ------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------