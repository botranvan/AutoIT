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
#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
;~ #include <Misc.au3>

;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{PAUSE}","ActivePauseAuto")				;Pause				- Tạm Dừng Auto
HotKeySet ("{PGUP}","UpDangerPos")					;PageUp				- Tăng Giới Hạn Bơm Máu Cho Thú
HotKeySet ("{PGDN}","DownDangerPos")				;PageDown			- Giảm Giới Hạn Bơm Máu Cho Thú
HotKeySet ("^{PGUP}","UpDelayTime")					;Ctrl+PageUp		- Tăng Giới Thời Gian Đợi
HotKeySet ("^{PGDN}","DownDelayTime")				;Ctrl+PageDown		- Giảm Giới Thời Gian Đợi
HotKeySet ("^+{F7}","ActiveAutoUsePetFood")			;Ctrl+Shilf+F7		- Bắt đầu
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến dùng chung
Global $RunningI=1
Global $Running=False
Global $Waiting=False
Global $ShowMap=False
Global $PauseI=1
Global $Pause=False
Global $GameHandle=""		;Mã số của Game
Global $KeyF="F10"			;Vị trí Máu của thú
Global $KeyListF="F9|F8|F7|F6|F5|F4|F3|F2|F1"
Global $DangerPos=34		;Phần Trăm Máu còn lại khi cần Bơm
Global $DelayTime=2			;Thời gian đợi sau mỗi lần bơm
Global $PetHPPos[2]			;Vị trí Máu của thú nuôi
Global $PetHP=0				;Phần Trăm Máu của thú nuôi
Global $GamePos[2]=[0,0]	;Vị trí Game
Global $WarningPos[2]=[@DesktopWidth/2,0] ;Vị trí của thông báo

Global $Alt2Ctrl=False

;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
If SetLanguage() Then 
	CreateInterface()
	CheckAuto()
EndIf

While 1
	Sleep(34)
	If Not GameRunning() Then 
		DisableButtonStart()
		DisableButtonPause()
		StopAll()
		ContinueLoop
	EndIf
	
	If GUICtrlGetState($Button_Start)=$GUI_DISABLE Then EnableButtonStart()
	If GUICtrlGetState($Button_Pause)=$GUI_DISABLE Then ThenEnableButtonPause()
	
 	If $Running Then CheckShowMap()
	If $Pause Then DisableButtonStart()
		
	SetShotcutSkill()
	ShowDangerPos()
	CheckPetHP()
	ShowPetHP()
	
	If $Pause Then
		PauseAuto()
		ContinueLoop
	EndIf
	Sleep(77)
	
	SetDangerPos()
	SetDelayTime()
	
	If $Waiting Then ;Đợi sau mỗi lần bơm
;~ 		ToolTip($EmtyFoodT,$WarningPos[0],$WarningPos[1])
		Waiting($DelayTime)
		RunningCheck()
	ElseIf $Running Then ;Thực hiện khi bấm Bơm
		DelTooltip()
		GUICtrlSetData($Button_Start,$Button_StartT2)
		AutoUsePetFood()
		RunningCheck()
	Else ;Thực hiện khi không Bơm
		GUICtrlSetData($Button_Start,$Button_StartT1)
		GUICtrlSetData($Lable_Run,"")
	EndIf
	Sleep(77)
WEnd 
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	Local $l = WinList($AutoName)
	Local $CountProcess=$ProcessNumber
	
	If $l[0][0]>$ProcessNumber Then
		GUISetState(@SW_HIDE,$MainGUI)
		MsgBox(0,$AutoName,$AutoName&" đã chạy."&@LF&"Không thể mở thêm!!!")
		Exit
	EndIf
EndFunc

;~ Tạm dừng Auto
Func ActivePauseAuto()
	$Pause=Not $Pause
	If Not $Pause Then DelToolTip()
EndFunc
;~ Tạm dừng Auto
Func PauseAuto()
	Select 
		Case $PauseI=1
			ToolTip($PauseAutoT&" >    < ",$WarningPos[0],$WarningPos[1])
		Case $PauseI=2
			ToolTip($PauseAutoT&"  >  <  ",$WarningPos[0],$WarningPos[1])
		Case $PauseI=3
			ToolTip($PauseAutoT&"   ><   ",$WarningPos[0],$WarningPos[1])
		Case $PauseI=4
			ToolTip($PauseAutoT&"   <>   ",$WarningPos[0],$WarningPos[1])
		Case $PauseI=5
			ToolTip($PauseAutoT&"  <  >  ",$WarningPos[0],$WarningPos[1])
		Case $PauseI=6
			ToolTip($PauseAutoT&" <    > ",$WarningPos[0],$WarningPos[1])
		Case $PauseI=7
			ToolTip($PauseAutoT&"<      >",$WarningPos[0],$WarningPos[1])
		Case $PauseI=8
	EndSelect
		
	If $PauseI=7 Then 
		$PauseI=0
	EndIf
	$PauseI+=1
EndFunc

;~ Kiểm tra xem Máp có mở không 0xDD9933
Func CheckShowMap()
	Local $CheckColorPos[2]=[$PetHPPos[0]+99,$PetHPPos[1]]
	Local $Color1=PixelGetColor($CheckColorPos[0],$CheckColorPos[1])
	ToolTip($Color1,$CheckColorPos[0],$CheckColorPos[1])
	
	If ($Color1<>65793) Then ;Nếu bị che thì dừng ($Color1<>16513893)or
		$Pause=True
		$ShowMap=True
		Return True
	EndIf
	
	
	If $ShowMap Then ;Nếu không bị che thì thôi
		$Pause=False
		$ShowMap=False
	EndIf
	Return False
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Xem Địa chỉ tải
Func ShowHomePage()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"ĐỊA CHỈ TRANG CHỦ & NƠI TẢI TRƯƠNG TRÌNH"&@LF&@LF
	$text=$text&" - LeeSaiBlog: "&@TAB&$BlogName&@LF
	$text=$text&" - Hoặc: "&@TAB&"NgoiSaoBlog.com/ShockBoy007"&@LF&@LF
	$text=$text&" - Nơi tải: "&$LinkDown&@LF
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
	$text=$text&" - Chương trình chỉ Hỗ Trợ chứ không Auto hoàn toàn."&@LF
	$text=$text&" - Do được 1 người làm nên cần cập nhật sữa lỗi nhiều."&@LF
	$text=$text&" - Chương trình chưa hỗ trợ cho nhiều tài khoản 1 lúc."&@LF&@LF
	$text=$text&@TAB&"ƯU ĐIỂM CỦA CHƯƠNG TRÌNH"&@LF
	$text=$text&" - Không bao giờ có Keylog hay Virus. (^_^ )"&@LF
	ToolTip($text,$x,$y)
EndFunc

;Hàm láy vị trí ống máu của thú
Func GetPetHPPos()
	;Lấy vị trí của Game
	Local $Pos=WinGetPos($GameHandle)
	
	;Xác định vị trí ống máu của Thú khi Game bị di chuyển
	If ($Pos[0]<>$GamePos[0])And($Pos[1]<>$GamePos[1]) Then
		WinActivate($GameHandle)
		Global $GameCaretPos=WinGetCaretPos()
		$PetHPPos[0]=$GameCaretPos[0]+64.6
		$PetHPPos[1]=$GameCaretPos[1]+69.1
		$GamePos=$Pos
	EndIf
EndFunc
	
;Hàm kiểm tra máu của Thú	
Func CheckPetHP()
	GetPetHPPos()
	For $i=$PetHPPos[0] To $PetHPPos[0]+99 Step 1
		$PetHPColor=PixelGetColor($i,$PetHPPos[1])
;~ 		ToolTip(".",$i,$PetHPPos[1])
		If ($PetHPColor<16700000) Then ExitLoop
	Next
	$Percent=$i-$PetHPPos[0]
	$PetHP=$Percent
	Return True
EndFunc

;Hàm tự động bơm máu cho Thú
Func ActiveAutoUsePetFood()
	$Running = Not $Running
EndFunc
;Hàm tự động bơm máu cho Thú
Func AutoUsePetFood()
	If $PetHP=-7 Then 
		$Running=False
		ToolTip($GameNotFoundT,$WarningPos[0],$WarningPos[1])
		Sleep(2*$1s)
		Return
	EndIf
	
	If $PetHP<=$DangerPos Then 
		GUICtrlSetColor($Lable_PetHP,0xFF0000)
		Send("{"&$KeyF&"}")
		$Waiting=True
		Global $TimeA=TimerInit()
	Else
		GUICtrlSetColor($Lable_PetHP,0x0077FF)
	EndIf
EndFunc

;Hàm tăng giới hạn Bơm Máu cho Thứ
Func UpDangerPos()
	GUICtrlSetData($Input_DangerPos,GUICtrlRead($Input_DangerPos)+7)
	SetDangerPos()
EndFunc

;Hàm giảm giới hạn Bơm Máu cho Thứ
Func DownDangerPos()
	GUICtrlSetData($Input_DangerPos,GUICtrlRead($Input_DangerPos)-7)
	SetDangerPos()
EndFunc

;Hàm tăng thời gian đợi
Func UpDelayTime()
	GUICtrlSetData($Input_DelayTime,GUICtrlRead($Input_DelayTime)+0.7)
	SetDelayTime()
EndFunc

;Hàm giảm thời gian đợi
Func DownDelayTime()
	GUICtrlSetData($Input_DelayTime,GUICtrlRead($Input_DelayTime)-0.7)
	SetDelayTime()
EndFunc
	
;~ Hàm tạo giao diện
Func CreateInterface()
	AutoItSetOption("GUIOnEventMode",1)
	
	Global $Vertically=7 ;Cách khoảng từ trái sang phải
	Global $Horizontally=5 ;Cách khoảng từ trên xuống dưới
	
	Global $MainGUISize[2]=[167,187] ;Kích thước giao diện
	Global $MainGUIPos[2]=[0,0] ;Vị trí giao diện
	
	;Giao diện
	Global $MainGUI=GUICreate($AutoName&" v"&$AutoVersion&" "&$AutoBeta,$MainGUISize[0],$MainGUISize[1],$MainGUIPos[0],$MainGUIPos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	
	$MenuTittle_Size=38.5
	;Menu File
	$Menu_File=GUICtrlCreateMenu($Menu_FileT)
	$Menu_File_Sai=GUICtrlCreateMenu($Menu_File_SaiT,$Menu_File)
	Global $Menu_File_Sai_FixAlt=GUICtrlCreateMenuItem($Menu_File_Sai_FixAltT1,$Menu_File_Sai)
	GUICtrlSetOnEvent($Menu_File_Sai_FixAlt,"FixAlt2Ctrl")
	$Menu_File_Exit=GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")
	
	;Menu Help
	$Menu_Help=GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HomePage=GUICtrlCreateMenuItem($Menu_Help_HomePageT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HomePage,"ShowHomePage")
	$Menu_Help_HotKey=GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_Attention=GUICtrlCreateMenuItem($Menu_Help_AttentionT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_Attention,"ShowAttentionAuto")
	$Menu_Help_About=GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")
	
	;Menu Clear
	$Menu_Clear=GUICtrlCreateMenu($Menu_ClearT)
	$Menu_Clear_ToolTip=GUICtrlCreateMenuItem($Menu_Clear_ToolTip,$Menu_Clear)
	GUICtrlSetOnEvent($Menu_Clear_ToolTip,"ClearAll")
	
	;Tạo 1 nền Tab
	$TabTittle_Size=21.4
	Global $MainTab_Size[2]=[$MainGUISize[0],$MainGUISize[1]-$MenuTittle_Size] ;Kích thước của nền Tab
	Global $MainTab_Pos[2]=[0,0] ;Vị trí của Nền Tab
	$MainTab=GUICtrlCreateTab($MainTab_Pos[0],$MainTab_Pos[1],$MainTab_Size[0],$MainTab_Size[1])

	;Nút thoát
	Global $Button_Exit_Size[2]=[25,22]
	Global $Button_Exit_Pos[2]=[$MainTab_Size[0]-$Button_Exit_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Exit_Size[1]-$Horizontally]
	Global $Button_Exit=GUICtrlCreateButton($Button_ExitT,$Button_Exit_Pos[0],$Button_Exit_Pos[1],$Button_Exit_Size[0],$Button_Exit_Size[1])
	GUICtrlSetOnEvent($Button_Exit,"ExitAuto")
	GUICtrlSetTip($Button_Exit,$Button_Exit_TipT)

	;Nút tạm ngưng
	Global $Button_Pause_Size[2]=[25,$Button_Exit_Size[1]]
	Global $Button_Pause_Pos[2]=[$Button_Exit_Pos[0]-$Button_Pause_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Pause_Size[1]-$Horizontally]
	Global $Button_Pause=GUICtrlCreateButton($Button_PauseT,$Button_Pause_Pos[0],$Button_Pause_Pos[1],$Button_Pause_Size[0],$Button_Pause_Size[1])
	GUICtrlSetOnEvent($Button_Pause,"ActivePauseAuto")
	GUICtrlSetTip($Button_Pause,$Button_Pause_TipT)
	
	;Nút ẩn hiện
	Global $Button_Hidden_Size[2]=[25,$Button_Exit_Size[1]]
	Global $Button_Hidden_Pos[2]=[$Button_Pause_Pos[0]-$Button_Hidden_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Hidden_Size[1]-$Horizontally]
	Global $Button_Hidden=GUICtrlCreateButton($Button_HiddenT,$Button_Hidden_Pos[0],$Button_Hidden_Pos[1],$Button_Hidden_Size[0],$Button_Hidden_Size[1])
	GUICtrlSetOnEvent($Button_Hidden,"HiddenShow")
	GUICtrlSetTip($Button_Hidden,$Button_HiddenShow_TipT)

	;Tạo Tab chức năng thu hoạch
	Global $Tab_Pet=GUICtrlCreateTabItem($Tab_PetT)
	
	;Nút bắt đầu làm việc
	Global $Button_Start_Size[2]=[43,25]
	Global $Button_Start_Pos[2]=[$Vertically,$Horizontally+$TabTittle_Size]
	Global $Button_Start=GUICtrlCreateButton($Button_StartT1,$Button_Start_Pos[0],$Button_Start_Pos[1],$Button_Start_Size[0],$Button_Start_Size[1])
	GUICtrlSetOnEvent($Button_Start,"ActiveAutoUsePetFood")
	GUICtrlSetTip($Button_Start,$Button_Start_TipT)
	
	;Chú thích điểm sẽ bơm máu cho thú
	Global $Lable_InutDangerPos_Size[2]=[52,16]
	Global $Lable_InutDangerPos_Pos[2]=[$Button_Start_Pos[0]+$Button_Start_Size[0]+$Vertically,$Button_Start_Pos[1]+$Button_Start_Size[1]/4]
	Global $Lable_InutDangerPos=GUICtrlCreateLabel($Lable_InutDangerPosT1,$Lable_InutDangerPos_Pos[0],$Lable_InutDangerPos_Pos[1],$Lable_InutDangerPos_Size[0],$Lable_InutDangerPos_Size[1],$SS_RIGHT)
	GUICtrlSetFont($Lable_InutDangerPos,9,777)
	GUICtrlSetTip($Lable_InutDangerPos,$Lable_DangerPos_TipT)
	
	;Chỗ nhập phần trăm còn khi bơm
	Global $Input_DangerPos_Size[2]=[18.7,16]
	Global $Input_DangerPos_Pos[2]=[$Lable_InutDangerPos_Pos[0]+$Lable_InutDangerPos_Size[0]+$Vertically,$Lable_InutDangerPos_Pos[1]]
	Global $Input_DangerPos=GUICtrlCreateInput($DangerPos,$Input_DangerPos_Pos[0],$Input_DangerPos_Pos[1],$Input_DangerPos_Size[0],$Input_DangerPos_Size[1])
	GUICtrlSetTip($Input_DangerPos,$Lable_DangerPos_TipT)

	;Chữ phần trăm
	Global $Lable_Percentage_Size[2]=[11,16]
	Global $Lable_Percentage_Pos[2]=[$Input_DangerPos_Pos[0]+$Input_DangerPos_Size[0],$Input_DangerPos_Pos[1]]
	Global $Lable_Percentage=GUICtrlCreateLabel("%",$Lable_Percentage_Pos[0],$Lable_Percentage_Pos[1],$Lable_Percentage_Size[0],$Lable_Percentage_Size[1])
	GUICtrlSetFont($Lable_Percentage,11,777)
	
	;Chữ bên dưới nút Start
	Global $Lable_UnderStart_Size[2]=[$MainGUISize[0]/2,16]
	Global $Lable_UnderStart_Pos[2]=[$Button_Start_Pos[0],$Button_Start_Pos[1]+$Button_Start_Size[1]+$Horizontally]
	Global $Lable_UnderStart=GUICtrlCreateLabel($Lable_UnderStartT1,$Lable_UnderStart_Pos[0],$Lable_UnderStart_Pos[1],$Lable_UnderStart_Size[0],$Lable_UnderStart_Size[1])
	GUICtrlSetFont($Lable_UnderStart,9,777)
	GUICtrlSetTip($Lable_UnderStart,$Lable_UnderStart_TipT1)
	
	;Chỗ nhập thời gian đợi
	Global $Input_DelayTime_Size[2]=[34,16]
	Global $Input_DelayTime_Pos[2]=[$Lable_UnderStart_Pos[0]+$Lable_UnderStart_Size[0]+$Vertically,$Lable_UnderStart_Pos[1]]
	Global $Input_DelayTime=GUICtrlCreateInput($DelayTime,$Input_DelayTime_Pos[0],$Input_DelayTime_Pos[1],$Input_DelayTime_Size[0],$Input_DelayTime_Size[1],$SS_RIGHT)
	GUICtrlSetTip($Input_DelayTime,$Lable_UnderStart_TipT1)
	
	;Chữ giây
	Global $Lable_Second_Size[2]=[25,16]
	Global $Lable_Second_Pos[2]=[$Input_DelayTime_Pos[0]+$Input_DelayTime_Size[0]+$Vertically,$Input_DelayTime_Pos[1]]
	Global $Lable_Second=GUICtrlCreateLabel($SecondT,$Lable_Second_Pos[0],$Lable_Second_Pos[1],$Lable_Second_Size[0],$Lable_Second_Size[1])
	GUICtrlSetFont($Lable_Second,9,777)
	
	;Chú thích nhập ô chứ thức ăn
	Global $Lable_ShortcutSkill_Size[2]=[$MainGUISize[0]/3.4,16]
	Global $Lable_ShortcutSkill_Pos[2]=[$Lable_UnderStart_Pos[0],$Lable_UnderStart_Pos[1]+$Lable_UnderStart_Size[1]+$Horizontally*2]
	Global $Lable_ShortcutSkill=GUICtrlCreateLabel($Lable_ShortcutSkillT1,$Lable_ShortcutSkill_Pos[0],$Lable_ShortcutSkill_Pos[1],$Lable_ShortcutSkill_Size[0],$Lable_ShortcutSkill_Size[1])
	GUICtrlSetFont($Lable_ShortcutSkill,9,777)
	GUICtrlSetTip($Lable_ShortcutSkill,$Lable_ShortcutSkill_TipT1)
	
	;Combo chọn phím nóng của skill
	Global $Combo_ShortcutSkill_Size[2]=[43,16]
	Global $Combo_ShortcutSkill_Pos[2]=[$Lable_ShortcutSkill_Pos[0]+$Lable_ShortcutSkill_Size[0]+$Vertically,$Lable_ShortcutSkill_Pos[1]-$Combo_ShortcutSkill_Size[1]/7]
	Global $Combo_ShortcutSkill=GUICtrlCreateCombo($KeyF,$Combo_ShortcutSkill_Pos[0],$Combo_ShortcutSkill_Pos[1],$Combo_ShortcutSkill_Size[0],$Combo_ShortcutSkill_Size[1],$SS_RIGHT)
	GUICtrlSetData($Combo_ShortcutSkill,$KeyListF)
	GUICtrlSetTip($Combo_ShortcutSkill,$Lable_ShortcutSkill_TipT1)
	
	;Thông tin về phần trăm máu sẽ bơm
	Global $Lable_DangerPos_Size[2]=[30.4,13.3]
	Global $Lable_DangerPos_Pos[2]=[$Button_Hidden_Pos[0]-$Lable_DangerPos_Size[0],$Button_Hidden_Pos[1]+$Horizontally]
	Global $Lable_DangerPos=GUICtrlCreateLabel("0%",$Lable_DangerPos_Pos[0],$Lable_DangerPos_Pos[1],$Lable_DangerPos_Size[0],$Lable_DangerPos_Size[1])
	GUICtrlSetColor($Lable_DangerPos,0x0077FF)
	GUICtrlSetTip($Lable_DangerPos,$Lable_DangerPos_TipT)
	
	;Thông tin về máu của Pet	
	Global $Lable_PetHP_Size[2]=[20.5,13.3]
	Global $Lable_PetHP_Pos[2]=[$Lable_DangerPos_Pos[0]-$Lable_PetHP_Size[0],$Lable_DangerPos_Pos[1]]
	Global $Lable_PetHP=GUICtrlCreateLabel("0 / ",$Lable_PetHP_Pos[0],$Lable_PetHP_Pos[1],$Lable_PetHP_Size[0],$Lable_PetHP_Size[1],$SS_RIGHT)
	GUICtrlSetColor($Lable_PetHP,0x0077FF)
	GUICtrlSetTip($Lable_PetHP,$Lable_PetHP_TipT)
	
	;Thông cho biết Chức năng tự bơm máu có chạy hay không
	Global $Lable_Run_Size[2]=[9,13.3]
	Global $Lable_Run_Pos[2]=[$Vertically,$Lable_PetHP_Pos[1]]
	Global $Lable_Run=GUICtrlCreateLabel("",$Lable_Run_Pos[0],$Lable_Run_Pos[1],$Lable_Run_Size[0],$Lable_Run_Size[1])
	GUICtrlSetColor($Lable_Run,0x0077FF)
	
;~ 	GUICtrlSetBkColor(-1,0xFFAABC)
	
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc

;~ Hàm nạp ngôn ngữ hiển thị
Func SetLanguage()
;~ Biến Mô Tả Chương Trình
	Global $AutoName="Sai ATLBB"					;Tên Chương Trình
	Global $AutoBeta=""					;Chương Trình thử nghiệm
	Global $AutoClass="AutoIt v3 GUI"				;Mã phân loại Chương Trình		
	Global $AutoVersion="1.791"						;Phiên Bản
	Global $Author="Trần Minh Đức"					;Tên (các) Lập Trình Viện
	Global $BlogName="LeeSai.co.cc"
	Global $BlogNameFull="http://my.opera.com/saihukaru/blog/"
	Global $LinkDown="http://my.opera.com/saihukaru/blog/auto-saiatlbb"
	Global Const $ProcessNumber=2					;Số lượng Chương Trình được phép chạy cùng 1 lúc

	Global $Functions=@CRLF							;Các chức năng của Chương Trình
	$Functions=$Functions&"   +Tự Bơm Máu Cho Thú"

;~ Biến ngôn ngữ
	Global $Menu_FileT="&Quản Lý"
	Global $Menu_File_SaiT="&Sai"
	Global $Menu_File_Sai_FixAltT1="On  &Alt2Ctrl"
	Global $Menu_File_Sai_FixAltT2="Off &Alt2Ctrl"
	Global $Menu_File_ExitT="&Thoát"
	Global $Menu_HelpT="&Hỗ Trợ"
	Global $Menu_Help_HomePageT="&Trang Chủ"
	Global $Menu_Help_HotKeyT="&Phím Nóng"
	Global $Menu_Help_AttentionT="&Các Lưu Ý"
	Global $Menu_Help_AboutT="&Thông Tin"
	Global $Menu_ClearT="&Dọn Dẹp"
	Global $Menu_Clear_ToolTip="&Thông Báo"
	
	Global $Tab_PetT="Thú Nuôi"
	
	Global $Button_StartT1="Bơm"
	Global $Button_StartT2="Ngưng"
	Global $Button_Start_TipT="Bắt đầu bơm máu cho Thú nuôi."
	Global $Lable_InutDangerPosT1="khi còn"
	Global $Lable_DangerPos_TipT="Nếu máu của thú ít hơn chừng này % thì cho ăn"
	Global $Lable_UnderStartT1="Thời gian đợi: "
	Global $Lable_UnderStart_TipT1="Ăn mà chưa no thì vài giây sau mới cho tiếp"
	Global $SecondT="Giây"
	Global $Lable_ShortcutSkillT1="Ô chứa: "
	Global $Lable_ShortcutSkill_TipT1="Ô này sẽ chứa thức ăn của thú"
	Global $Lable_PetHP_TipT="Phần trăm máu của thú nuôi hiện giờ"
	
	Global $Button_HiddenT="/\"
	Global $Button_ShowT="\/"
	Global $Button_HiddenShow_TipT="Thu gọn chương trình"
	Global $Button_PauseT="< >"
	Global $Button_Pause_TipT="Tạm ngưng hoạt động"
	Global $Button_ExitT="X"
	Global $Button_Exit_TipT="Thoát chương trình"

	Global $EmtyFoodT="Thức Ăn"
	Global $GameNotFoundT="Không tìm thấy Game"
	Global $PauseAutoT="Tạm dừng"
	Return True
EndFunc

;~ Hàm ẩn hiện chương trình
Func HiddenShow()
;~ 	$MainGUISize[2]=[160,178]
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

;~ Hàm lấy phần trăm sẽ bơm
Func SetDangerPos()
	If GUICtrlRead($Input_DangerPos)<1 Then GUICtrlSetData($Input_DangerPos,1)
	If GUICtrlRead($Input_DangerPos)>99 Then GUICtrlSetData($Input_DangerPos,99)
	$DangerPos=GUICtrlRead($Input_DangerPos)
EndFunc

;~ Hàm hiển thị phần trăm sẽ bơm
Func ShowDangerPos()
	GUICtrlSetData($Lable_DangerPos,$DangerPos&"%")
EndFunc

;~ Hàm lấy thời gian chờ
Func SetDelayTime()
	If GUICtrlRead($Input_DelayTime)<0.001 Then GUICtrlSetData($Input_DelayTime,0.001)
	If GUICtrlRead($Input_DelayTime)>99 Then GUICtrlSetData($Input_DelayTime,99)
	$DelayTime=GUICtrlRead($Input_DelayTime)
EndFunc

;~ Hàm lấy phím nóng ô thức ăn
Func SetShotcutSkill()
	$KeyF=GUICtrlRead($Combo_ShortcutSkill)
EndFunc

;~ Hàm hiển thị máu của thú nuôi
Func ShowPetHP()
	GUICtrlSetData($Lable_PetHP,$PetHP&"/")
EndFunc

;~ Hàm cho biết chức năng tự bơm đang hoạt động
Func RunningCheck()
	Select
		Case $RunningI=1
			GUICtrlSetData($Lable_Run,"|")
		Case $RunningI=2
			GUICtrlSetData($Lable_Run,"/")
		Case $RunningI=3
			GUICtrlSetData($Lable_Run,"|")
		Case $RunningI=4
			GUICtrlSetData($Lable_Run,"\")
	EndSelect
	
	If $RunningI=4 Then 
		$RunningI=0
	EndIf
	$RunningI+=1
EndFunc

;~ Hàm đợi giúp delay thời gian bơm
Func Waiting($DelayTime)
	If TimerDiff($TimeA)>($DelayTime*$1s) Then $Waiting=False
EndFunc
	
;~ Hàm dọn dẹp tất cả
Func ClearAll()
	DelTooltip()
EndFunc

;~ Hàm kiểm tra xem game có chạy không
Func GameRunning()
	$GameHandle=WinGetHandle("[TITLE:Thien Long Bat Bo; CLASS:TianLongBaBu WndClass;]")
	If $GameHandle="" Then Return False
	Return True
EndFunc

;~ Hàm dừng mọi hoạt động
Func StopAll()
	$Running=False
	$Waiting=False
	$ShowMap=False
	$Pause=False
EndFunc

;~ Hàm khóa nút Start
Func DisableButtonStart()
	GUICtrlSetState($Button_Start,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt nút Start
Func EnableButtonStart()
	GUICtrlSetState($Button_Start,$GUI_ENABLE)
EndFunc

;~ Hàm khóa nút Pause
Func DisableButtonPause()
	GUICtrlSetState($Button_Pause,$GUI_DISABLE)
EndFunc
;~ Hàm kích hoạt nút Pause
Func EnableButtonPause()
	GUICtrlSetState($Button_Pause,$GUI_ENABLE)
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Hàm kích hoạng các phím Alt bằng Ctrl
Func FixAlt2Ctrl()
	$Alt2Ctrl=Not $Alt2Ctrl
	If $Alt2Ctrl Then
		GUICtrlSetData($Menu_File_Sai_FixAlt,$Menu_File_Sai_FixAltT2)
		HiddenShow()
		WinActivate($GameHandle)
		HotKeySet("^c","AltC")
		HotKeySet("^x","AltS")
		HotKeySet("^z","AltX")
		HotKeySet("^s","AltQ")
		HotKeySet("^a","AltA")
	Else
		GUICtrlSetData($Menu_File_Sai_FixAlt,$Menu_File_Sai_FixAltT1)
		HotKeySet("^c")
		HotKeySet("^x")
		HotKeySet("^z")
		HotKeySet("^s")
		HotKeySet("^a")
	EndIf
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
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------