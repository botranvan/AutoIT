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
;~ #NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <Array.au3>
#include <Misc.au3>
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{F9}","StartWork")
HotKeySet ("{F10}","HiddenShow")

HotKeySet ("{PAUSE}","PauseAuto")					;Pause				- Tạm ngừng Auto
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
;~ Global $ProcessName="AutoIt3.exe"					;Dùng khi Lập Trình
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@CRLF								;Các chức năng của Chương Trình
$Functions=$Functions&"  +Tự thu hoạch vật liệu"

;~ Biến Thời Gian
;~ Global $TimeSplit=" - " 	;Phân Cách Thời Gian
;~ Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
;~ Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
;~ Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
;~ Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến của Game
Global $GameInfo="[TITLE:Dofus; CLASS:ShockwaveFlash]"
Global $GameHandle=""
Global $GameCaretPos[2]
Global $Wheat="Wheat"

;~ Biến chương trình
Global $Time0=TimerInit()		;Thời bắt đầu
Global $Time1=-1				;Thời gian dừng 1

Global $Hidden=False			;Trạng thái tạm dùng
Global $Pause=False				;Trạng thái tạm dùng
Global $Working=False			;Trạng thái hoạt động
Global $Locating=False			;Trạng thái định vị tài nguyên
Global $LocatingWithMouse=False	;Trạng thái định vị tài nguyên
Global $ClickPos[1][2]=[[0,0]]		;Vị trí tài nguyên
Global $MovePos[1]=[0]				;Mã số tọa độ cần di chuyển

Global $WarningPos[2]=[@DesktopWidth/2,0]	;Vị trí thông báo
Global $OkProfessionUpPos[2]=[511,331]			;Vị trí nút OK khi Nghề Thăng Cấp


;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
If SetLanguage() Then 
	CheckAuto()
	CreateInterface()
	CheckAllStatus()
EndIf
While 1
	ShowMousePosInGUI()
	If Not UseMouseGetMovePos() Then UseMouseGetClickPos()
	
;~ 	Sleep(250)
	Sleep(77)
;~ 	If TimerDiff($Time0)=
WEnd 
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	$l = ProcessList()
	$CountProcess=$ProcessNumber
	For $i = 1 to $l[0][0] Step 1
		If $l[$i][0]=$ProcessName And $CountProcess=0 then
			MsgBox(0,$AutoName,$AutoRunT)
			Exit
		EndIf
 		If $l[$i][0]=$ProcessName then $CountProcess-=1
	Next
EndFunc

;~ Xem phím nóng
Func ShowHotKey()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
	$text=$text&"Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
	$text=$text&"Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
	$text=$text&"Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
	$text=$text&"Pause"&@TAB&""&@TAB&@TAB&"-  $PauseT Auto"&@LF&@LF
	$text=$text&"(Ctrl+Shilf+Delete - Tắt Thông Báo)"
	ToolTip($text,$x,$y)
EndFunc

;~  $PauseT Auto
Func PauseAuto()
	$Pause=Not $Pause
	Local $i=1
	While $Pause
		Select 
			Case $i=1
				ToolTip($PauseT&">      <",$WarningPos[0],$WarningPos[1])
			Case $i=2
				ToolTip($PauseT&" >    < ",$WarningPos[0],$WarningPos[1])
			Case $i=3
				ToolTip($PauseT&"  >  <  ",$WarningPos[0],$WarningPos[1])
			Case $i=4
				ToolTip($PauseT&"   ><   ",$WarningPos[0],$WarningPos[1])
			Case $i=5
				ToolTip($PauseT&"   <>   ",$WarningPos[0],$WarningPos[1])
			Case $i=6
				ToolTip($PauseT&"  <  >  ",$WarningPos[0],$WarningPos[1])
			Case $i=7
				ToolTip($PauseT&" <    > ",$WarningPos[0],$WarningPos[1])
			Case $i=8
				ToolTip($PauseT&"<      >",$WarningPos[0],$WarningPos[1])
			Case $i=9
				ToolTip($PauseT&"    <  ",$WarningPos[0],$WarningPos[1])
			Case $i=10
				ToolTip($PauseT&"   <   ",$WarningPos[0],$WarningPos[1])
			Case $i=11
				ToolTip($PauseT&"  <    ",$WarningPos[0],$WarningPos[1])
			Case $i=12
				ToolTip($PauseT&" <     ",$WarningPos[0],$WarningPos[1])
		EndSelect
		
		If $i=8 Then 
			$i=1
		Else
			$i=$i+1
		EndIf
		
		Sleep(77)
	WEnd
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	$x=$MainGUIPos[0]+$MainGUISize[0]+7
	$y=$MainGUIPos[1]
	Local $text=@TAB&"THÔNG TIN CHƯƠNG TRÌNH       "&@LF
	$text=$text&"- Chương Trình: "&$AutoName&@LF
	$text=$text&"- Phiên Bản: "&$AutoVersion&@LF
	$text=$text&"- Thiết kế: "&$Author&@LF
	$text=$text&"- Chức năng: "&$Functions&@LF&@LF
	$text=$text&"(Ctrl+Shilf+Delete - Tắt Thông Báo)"
	ToolTip($text,$x,$y)
EndFunc


;~ Hàm kiểm tra xem Dofus chạy chưa
Func CheckDofus()
	If $GameHandle="" Then
		If WinActivate($GameInfo)=1 Then 
			$GameHandle=WinGetHandle($GameInfo)
;~ 			WinSetState($GameHandle,"",@SW_MAXIMIZE)
			$GameCaretPos=WinGetCaretPos()
			Return True
		Else
			Return False
		EndIf
	EndIf
	Return True
EndFunc

;~ Hàm khoanh vùng bằng chuột
Func ZoneByMouse($x,$y,$MoveZone,$Time=7)
	$Speed=1
	For $i=1 To $Time Step 1
		MouseMove($x,$y-$MoveZone,$Speed)
		MouseMove($x-$MoveZone,$y-$MoveZone,$Speed)
		
		MouseMove($x-$MoveZone,$y,$Speed)
		MouseMove($x-$MoveZone,$y+$MoveZone,$Speed)
		
		MouseMove($x,$y+$MoveZone,$Speed)
		MouseMove($x+$MoveZone,$y+$MoveZone,$Speed)
		
		MouseMove($x+$MoveZone,$y,$Speed)
		MouseMove($x+$MoveZone,$y-$MoveZone,$Speed)
	Next
	MouseMove($x,$y,$Speed)
	Sleep(77)
EndFunc

;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;~ Hàm tạo giao diện
Func CreateInterface()
	AutoItSetOption("GUIOnEventMode",1)
	
	Global $Vertically=7 ;Cách khoảng từ trái sang phải
	Global $Horizontally=5 ;Cách khoảng từ trên xuống dưới
	
	Global $MainGUISize[2]=[160,187] ;Kích thước giao diện
	Global $MainGUIPos[2]=[0,0] ;Vị trí giao diện
	
	;Giao diện
	Global $MainGUI=GUICreate($AutoName,$MainGUISize[0],$MainGUISize[1],$MainGUIPos[0],$MainGUIPos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	
	$MenuTittle_Size=38.5
	;Menu File
	$Menu_File=GUICtrlCreateMenu($Menu_FileT)
	$Menu_File_Exit=GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")
	
	;Menu Help
	$Menu_Help=GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HotKey=GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_About=GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")
	
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
	GUICtrlSetOnEvent($Button_Pause,"PauseAuto")
	GUICtrlSetTip($Button_Pause,$Button_Pause_TipT)
	GUICtrlSetState($Button_Pause,$GUI_DISABLE)
	
	;Nút ẩn hiện
	Global $Button_Hidden_Size[2]=[25,$Button_Exit_Size[1]]
	Global $Button_Hidden_Pos[2]=[$Button_Pause_Pos[0]-$Button_Hidden_Size[0]-$Vertically,$MainTab_Size[1]-$Button_Hidden_Size[1]-$Horizontally]
	Global $Button_Hidden=GUICtrlCreateButton($Button_HiddenT,$Button_Hidden_Pos[0],$Button_Hidden_Pos[1],$Button_Hidden_Size[0],$Button_Hidden_Size[1])
	GUICtrlSetOnEvent($Button_Hidden,"HiddenShow")
	GUICtrlSetTip($Button_Hidden,$Button_HiddenShow_TipT)

	;Vị trí chuột
	Global $Lable_InfoMousePosY_Size[2]=[30.4,13.3]
	Global $Lable_InfoMousePosY_Pos[2]=[$Button_Hidden_Pos[0]-$Lable_InfoMousePosY_Size[0],$Button_Hidden_Pos[1]+$Horizontally]
	Global $Lable_InfoMousePosY=GUICtrlCreateLabel("0",$Lable_InfoMousePosY_Pos[0],$Lable_InfoMousePosY_Pos[1],$Lable_InfoMousePosY_Size[0],$Lable_InfoMousePosY_Size[1])
	GUICtrlSetBkColor(-1,0xFFFFFF)
	Global $Lable_InfoMousePosX_Size[2]=[30.4,13.3]
	Global $Lable_InfoMousePosX_Pos[2]=[$Lable_InfoMousePosY_Pos[0]-$Lable_InfoMousePosX_Size[0],$Lable_InfoMousePosY_Pos[1]]
	Global $Lable_InfoMousePosX=GUICtrlCreateLabel("0/",$Lable_InfoMousePosX_Pos[0],$Lable_InfoMousePosX_Pos[1],$Lable_InfoMousePosX_Size[0],$Lable_InfoMousePosX_Size[1],$SS_RIGHT)
	GUICtrlSetBkColor(-1,0xFFFFFF)
	
	;Tạo Tab chức năng thu hoạch
	Global $Tab_Work=GUICtrlCreateTabItem($Tab_WorkT)
	;Nút bắt đầu làm việc
	Global $Button_Start_Size[2]=[43,25]
	Global $Button_Start_Pos[2]=[$Vertically,$Horizontally+$TabTittle_Size]
	Global $Button_Start=GUICtrlCreateButton($Button_StartT,$Button_Start_Pos[0],$Button_Start_Pos[1],$Button_Start_Size[0],$Button_Start_Size[1])
	GUICtrlSetOnEvent($Button_Start,"StartWork")
	GUICtrlSetTip($Button_Start,$Button_Start_TipT)
	
	;Nút định vị tài nguyên
	Global $Button_Locate_Size[2]=[$Button_Start_Size[0],$Button_Start_Size[1]]
	Global $Button_Locate_Pos[2]=[$Button_Start_Pos[0]+$Button_Locate_Size[0]+$Vertically,$Button_Start_Pos[1]]
	Global $Button_Locate=GUICtrlCreateButton($Button_LocateT1,$Button_Locate_Pos[0],$Button_Locate_Pos[1],$Button_Locate_Size[0],$Button_Locate_Size[1])
	GUICtrlSetOnEvent($Button_Locate,"LocateResources")
	GUICtrlSetTip($Button_Locate,$Button_Locate_TipT)
	
	;Nút xóa tất cả vị trí tài nguyên
	Global $Button_Delete_Size[2]=[$Button_Start_Size[0],$Button_Start_Size[1]]
	Global $Button_Delete_Pos[2]=[$Button_Locate_Pos[0]+$Button_Delete_Size[0]+$Vertically,$Button_Start_Pos[1]]
	Global $Button_Delete=GUICtrlCreateButton($Button_DeleteT1,$Button_Delete_Pos[0],$Button_Delete_Pos[1],$Button_Delete_Size[0],$Button_Delete_Size[1])
	GUICtrlSetOnEvent($Button_Delete,"DelAllResourcesPos")
	GUICtrlSetTip($Button_Delete,$Button_Delete_TipT1)
	
	;Tiêu đề Thông báo số lượng tài nguyên tìm được 
	Global $Lable_TittleResourcesCount_Size[2]=[$MainGUISize[0]/2.5,16]
;~ 	Global $Lable_TittleResourcesCount_Pos[2]=[$Button_Start_Pos[0],$CheckBox_LocateByMouse_Pos[1]+$CheckBox_LocateByMouse_Size[1]+$Horizontally]
	Global $Lable_TittleResourcesCount_Pos[2]=[$Vertically,$Button_Delete_Pos[1]+$Button_Delete_Size[1]+$Horizontally]
	Global $Lable_TittleResourcesCount=GUICtrlCreateLabel($TittleResourcesCountT1,$Lable_TittleResourcesCount_Pos[0],$Lable_TittleResourcesCount_Pos[1],$Lable_TittleResourcesCount_Size[0],$Lable_TittleResourcesCount_Size[1],$SS_RIGHT)
	;Số lượng tài nguyên tìm được
	Global $Lable_NumberResourcesCount_Size[2]=[$MainGUISize[0]-$Lable_TittleResourcesCount_Size[0],16]
	Global $Lable_NumberResourcesCount_Pos[2]=[$Button_Start_Pos[0]+$Lable_TittleResourcesCount_Size[0],$Lable_TittleResourcesCount_Pos[1]]
	Global $Lable_NumberResourcesCount=GUICtrlCreateLabel($ClickPos[0][0],$Lable_NumberResourcesCount_Pos[0],$Lable_NumberResourcesCount_Pos[1],$Lable_NumberResourcesCount_Size[0],$Lable_NumberResourcesCount_Size[1])
	
	;Tùy chọn định vị bằng chuột
	Global $CheckBox_LocateByMouse_Size[2]=[$MainGUISize[0],16]
	Global $CheckBox_LocateByMouse_Pos[2]=[$Vertically,$Lable_TittleResourcesCount_Pos[1]+$Lable_TittleResourcesCount_Size[1]+$Horizontally]
	Global $CheckBox_LocateByMouse=GUICtrlCreateCheckbox($LableLocateByMouseT1,$CheckBox_LocateByMouse_Pos[0],$CheckBox_LocateByMouse_Pos[1],$CheckBox_LocateByMouse_Size[0],$CheckBox_LocateByMouse_Size[1])
	GUICtrlSetState($CheckBox_LocateByMouse,$GUI_CHECKED)
	GUICtrlSetTip($CheckBox_LocateByMouse,$CheckBox_LocateByMouse_TipT1)
	
	;Tùy chọn ẩn khi bắt đầu làm việc
	Global $CheckBox_HiddenAuto_Size[2]=[$MainGUISize[0],16]
	Global $CheckBox_HiddenAuto_Pos[2]=[$Vertically,$CheckBox_LocateByMouse_Pos[1]+$CheckBox_LocateByMouse_Size[1]+$Horizontally]
	Global $CheckBox_HiddenAuto=GUICtrlCreateCheckbox($LableHiddenOnStartT1,$CheckBox_HiddenAuto_Pos[0],$CheckBox_HiddenAuto_Pos[1],$CheckBox_HiddenAuto_Size[0],$CheckBox_HiddenAuto_Size[1])
	GUICtrlSetState($CheckBox_HiddenAuto,$GUI_CHECKED)
	GUICtrlSetTip($CheckBox_HiddenAuto,$CheckBox_HiddenAuto_TipT1)
	
	;Tạo Tab chức năng tự rao
	Global $Tab_Spam=GUICtrlCreateTabItem($Tab_SpamT)
	
	GUISetState(@SW_SHOW,$MainGUI)
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

;~ Hàm định vị tài nguyên
Func LocateResources()
	If Not CheckDofus() Then 
		MsgBox(0,$AutoName,$UnFindDofusT,7)
		Return False
	EndIf
	
	$Locating = Not $Locating
	IF $Locating Then
		ToolTip($PressGetClickPosT1&@CRLF&$PressGetClickPosT2,$WarningPos[0],$WarningPos[1])
		HotKeySet("=","GetClickPos")
		HotKeySet("-","DelResourcesPos")
		GUICtrlSetData($Button_Locate,$Button_LocateT2)
;~ 		GUICtrlSetState($Button_Start,$GUI_DISABLE)
	Else
		HotKeySet("=")
		HotKeySet("-")	
		ToolTip("")
		GUICtrlSetData($Button_Locate,$Button_LocateT1)
		CheckAllStatus()
	EndIf
EndFunc

;~ Hàm lấy vị trí tài nguyên bằng vị trí chuột
;~ $mode=0 vị trí tài nguyên
;~ $mode=1 vị trí di chuyển
Func GetClickPos($mode="0")
	Local $Pos=MouseGetPos()
	$ClickPos[0][0]+=1
	ReDim $ClickPos[$ClickPos[0][0]+1][2]
	$ClickPos[$ClickPos[0][0]][0] = $Pos[0]
	$ClickPos[$ClickPos[0][0]][1] = $Pos[1]
	If $mode=1 Then GetMovePos($ClickPos[0][0])
	SetNumberResources()
EndFunc

;~ Hàm đánh dấu tọa đội dùng để di chuyển
Func GetMovePos($i)
	_ArrayAdd($MovePos,$i)
	$MovePos[0]+=1
EndFunc

;~ Hàm xóa vị trí tài nguyên vừa lấy
Func DelResourcesPos()
	$ClickPos[0][0]-=1
	If $ClickPos[0][0]<=0 Then 
		$ClickPos[0][0]=0
	Else
		_ArrayDelete($ClickPos,$ClickPos[0][0]+1)
	EndIf
	SetNumberResources()
EndFunc

;~ Hàm xóa vị trí tài nguyên vừa lấy
Func DelAllResourcesPos()
	$ClickPos[0][0]=0
	ReDim $ClickPos[1][2]
	CheckAllStatus()
EndFunc

;~ Hàm tự gặt Wheat
Func StartWork()
	;Kiểm tra xem Dofuc chạy chưa
	If Not CheckDofus() Then 
		MsgBox(0,$AutoName,$UnFindDofusT,7)
		Return False
	EndIf

	If $ClickPos[0][0]=0 Then
		ToolTip("")
		Sleep(77)
		ToolTip($UnFindResourcesT,$WarningPos[0],$WarningPos[1])
		Sleep(77)
		ToolTip("")
		Sleep(77)
		ToolTip($UnFindResourcesT,$WarningPos[0],$WarningPos[1])
		Return False
	EndIf

	$Working= Not $Working
	If $Locating Then LocateResources()
	GUICtrlSetState($Button_Start,$GUI_DISABLE)
	GUICtrlSetState($Button_Locate,$GUI_DISABLE)
	GUICtrlSetState($Button_Delete,$GUI_DISABLE)
;~ 	GUICtrlSetState($CheckBox_LocateByMouse,$GUI_DISABLE)
	If (GUICtrlRead($CheckBox_HiddenAuto)=1)And($Working) Then HiddenShow()
	If (Not $Working) And $Hidden Then HiddenShow()
	
	$Start=1 ;Vị trí bắt đầu
	$Org_UnitT1 = $UnitT1 ;Lưu dự phòng giá trị đơn vị
	While $Working ;Bắt đầu gặt Wheat
		ToolTip($StartWorkT,$WarningPos[0],$WarningPos[1])
		$UnitT1 = $Org_UnitT1 ;Phục hồi giá trị đơn vị
		
		;Bấm Ok khi Tăng Cấp Độ Nghề Nghiệp
		CheckProfessionUp()
		
		
		;Hiển thị tiến độ công việc
		$UnitT1&=" ("&$Start&")"
		SetNumberResources()
		
		Local $Move=False
		For $i=1 To $MovePos[0] Step 1
			If $MovePos[$i]=$Start Then 
				$Move=True
				ExitLoop
			EndIf
		Next
		
		If $Move Then
			MoveToPos($Start)
		Else
			ExploitResources($Start)
		EndIf
				
		$Start+=1		
		If $Start=UBound($ClickPos) Then $Start=1
	WEnd
	
	GUICtrlSetState($Button_Start,$GUI_ENABLE)
	GUICtrlSetState($Button_Locate,$GUI_ENABLE)
	GUICtrlSetState($Button_Delete,$GUI_ENABLE)
	GUICtrlSetState($CheckBox_LocateByMouse,$GUI_ENABLE)
	$UnitT1 = $Org_UnitT1
	ToolTip($StopWorkT,$WarningPos[0],$WarningPos[1])
	CheckAllStatus()
EndFunc

;~ Hàm kiểm tra xem cấp độ nghề nghiệp có tăng không
Func CheckProfessionUp()
	Local $ChechZone=16
	Local $Pos=PixelSearch($OkProfessionUpPos[0]-$ChechZone,$OkProfessionUpPos[1]-$ChechZone,$OkProfessionUpPos[0]+$ChechZone,$OkProfessionUpPos[1]+$ChechZone,0xFF6100,2) ;Tìm màu cam
	If IsArray($Pos) Then MouseClick("left",$Pos[0],$Pos[1],2,1)
EndFunc

Func MoveToPos($Start)
	MouseClick("left",$ClickPos[$Start][0],$ClickPos[$Start][1],2,1)
	WaitForDone()
EndFunc

;~ Hàm khai thác tài nguyên
Func ExploitResources($Start)
	
	Local $ChechZone=34
	If CheckResources($Start) Then
		MouseClick("left",$ClickPos[$Start][0],$ClickPos[$Start][1],2,1)
		Sleep(347)
	Else
		Return False
	EndIf
	
;~ 	Dò vị trí thường có
	MouseMove($ClickPos[$Start][0]+16,$ClickPos[$Start][1]+34,1)
	Sleep(106)
	Local $Pos=MouseGetPos()
	PixelSearch($Pos[0]-$ChechZone,$Pos[1]-$ChechZone,$Pos[0]+$ChechZone,$Pos[1]+$ChechZone,16737792,2) ;Tìm màu cam
	If @error<>1 Then 
		MouseClick("left")
		MouseMove($WarningPos[0],$WarningPos[1],1)
		If WaitForDone() Then Return True
	EndIf
	
;~ 	Dò từ trên xuống tìm dòng màu cam
	Local $i=-34
	While $i<106
		MouseMove($ClickPos[$Start][0]+16,$ClickPos[$Start][1]+$i,1)
		Sleep(106)
		Local $Pos=MouseGetPos()
		PixelSearch($Pos[0]-$ChechZone,$Pos[1]-$ChechZone,$Pos[0]+$ChechZone,$Pos[1]+$ChechZone,16737792,2) ;Tìm màu cam
		If @error<>1 Then 
			MouseClick("left",$ClickPos[$Start][0]+16,$ClickPos[$Start][1]+$i,1,1)
			MouseMove($WarningPos[0],$WarningPos[1],1)
			If WaitForDone() Then Return True
		EndIf
		$i+=16
	WEnd	
EndFunc

;~ Hàm kiểm tra xem có tài nguyên không
Func CheckResources($Start)
	$Check1=PixelChecksum($ClickPos[$Start][0]-16,$ClickPos[$Start][1]-16,$ClickPos[$Start][0]+16,$ClickPos[$Start][1]+16,1)
	Sleep(1006)
	MouseMove($ClickPos[$Start][0],$ClickPos[$Start][1],1)
	$Check2=PixelChecksum($ClickPos[$Start][0]-16,$ClickPos[$Start][1]-16,$ClickPos[$Start][0]+16,$ClickPos[$Start][1]+16,1)
	If $Check1=$Check2 Then Return False
	Return True
EndFunc

;~ Hàm kiểm tra xem có phải là Tài Nguyên không
Func WaitForDone()
	Local $TimeA=TimerInit()
	While $Working
		Sleep(347)
		If TimerDiff($TimeA)>14200 Then Return True
	WEnd
EndFunc

;~ Hàm kiểm tra tất cả trạng thái
Func CheckAllStatus()
	SetNumberResources()
EndFunc

;~ Cập nhật số lượng tài nguyên
Func SetNumberResources()
	GUICtrlSetData($Lable_NumberResourcesCount,$ClickPos[0][0]&" "&$UnitT1)
EndFunc

;~ Hàm hiển thị vị trí chuột trong giao diện
Func ShowMousePosInGUI()
	$Pos=MouseGetPos()
	GUICtrlSetData($Lable_InfoMousePosX,$Pos[0]&"/")
	GUICtrlSetData($Lable_InfoMousePosY,$Pos[1])
EndFunc

;~ Hàm dùng chuột đế lấy vị trí Tài Nguyên (Ctrl+Left)
Func UseMouseGetClickPos()
	If Not $Locating Then Return False ;Thực hiện khi đang định vị
	If GUICtrlRead($CheckBox_LocateByMouse)=4 Then Return False ;Thực hiện khi chọn định vị bằng chuột
;~ 	MsgBox(0,"",GUICtrlRead($CheckBox_LocateByMouse))
	If (_IsPressed(01,DllOpen("user32.dll")))And(_IsPressed(11,DllOpen("user32.dll"))) Then 
		Sleep(250)
		GetClickPos()
		Local $Pos=MouseGetPos()
		ToolTip($DoneT,$Pos[0]+9,$Pos[1]+9)
		MouseClick("left",$Pos[0]+7,$Pos[1]+7,1,1)		
		MouseMove($Pos[0],$Pos[1],1)
		Sleep(347)
		ToolTip("")
		Return True
	EndIf
	Return False
EndFunc

;~ Hàm dùng chuột đế lấy vị trí di (Ctrl+Shift+Left)
Func UseMouseGetMovePos()
	If Not $Locating Then Return False ;Thực hiện khi đang định vị
	If GUICtrlRead($CheckBox_LocateByMouse)=4 Then Return False ;Thực hiện khi chọn định vị bằng chuột
;~ 	MsgBox(0,"",GUICtrlRead($CheckBox_LocateByMouse))
	If (_IsPressed(01,DllOpen("user32.dll")))And(_IsPressed(10,DllOpen("user32.dll")))And(_IsPressed(11,DllOpen("user32.dll"))) Then 
		Sleep(250)
		GetClickPos(1)
		Local $Pos=MouseGetPos()
		MouseClick("left",$Pos[0]-16,$Pos[1],1,1)		
		Sleep(77)
		MouseMove($Pos[0],$Pos[1],1)
		ToolTip("")
		Return True
	EndIf
	Return False
EndFunc

;~ Hàm nạp ngôn ngữ hiển thị
Func SetLanguage()
	Global $Menu_FileT="&Quản Lý"
	Global $Menu_File_ExitT="&Thoát"
	Global $Menu_HelpT="&Hỗ Trợ"
	Global $Menu_Help_HotKeyT="&Phím Nóng"
	Global $Menu_Help_AboutT="&Thông Tin"

	Global $Tab_WorkT="Khai Thác"
	Global $Button_StartT="Làm"
	Global $Button_Start_TipT="Bắt đầu khai thác"
	Global $Button_LocateT1="Tìm"
	Global $Button_LocateT2="Xong"
	Global $Button_Locate_TipT="Định vị tài nguyên"
	Global $Button_DeleteT1="Xóa"
	Global $Button_Delete_TipT1="Xóa tất cả vị trí tài nguyên"
	Global $LableLocateByMouseT1="Định vị bằng Chuột"
	Global $CheckBox_LocateByMouse_TipT1="Bấm Ctrl với Trái Chuột lên Tài Nguyên để định vị"
	$CheckBox_LocateByMouse_TipT1&=@LF&"Bấm Ctrl + Shift với Trái Chuột lên chỗ cần di chuyển"
	Global $LableHiddenOnStartT1="Ẩn khi bắt đầu làm"
	Global $CheckBox_HiddenAuto_TipT1="Chương trình sẽ ẩn khi bấm nút Làm hoặc F9"
	Global $TittleResourcesCountT1="Số lượng: "
	Global $UnitT1="Cây"
	Global $Button_HiddenT="/\"
	Global $Button_ShowT="\/"
	Global $Button_HiddenShow_TipT="Ẩn/Hiện chương trình"
	Global $Button_PauseT="< >"
	Global $Button_Pause_TipT="Tạm ngưng hoạt động"
	Global $Button_ExitT="X"
	Global $Button_Exit_TipT="Thoát chương trình"

	Global $Tab_SpamT="Nói Nhảm"

	Global $AutoRunT=$AutoName&" đã chạy."&@LF&"Không thể mở thêm!!!"
	Global $UnFindDofusT="Không tìm thấy Game Dofus !!!"
	Global $UnFindResourcesT="Chưa định vị Tài Nguyên !!!"
	Global $PauseT="Tạm dừng"
	Global $StartWorkT="Bấm F9 để ngưng làm việc"
	Global $StopWorkT="Ngưng làm việc"
	Global $PressGetClickPosT1="Bấm nút [+] để xác định vị trí tài nguyên bằng vị trí chuột"
	Global $PressGetClickPosT2="Bấm nút [-] để bỏ vị trí tài nguyên vừa lấy"
	Global $DoneT="Xong"
	Return True
EndFunc
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------