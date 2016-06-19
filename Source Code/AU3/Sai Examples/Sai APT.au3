
AutoItSetOption("GUIOnEventMode",1)
#include <array.au3>
#include <GUIConstants.au3>
#include <Constants.au3>
#include <File.au3>
#include <String.au3>
#NoTrayIcon

;Danh Sách Phím Nóng
HotKeySet ("{PGUP}","GetMouseClick_ThuKho")		;Lấy Vị Trí Thủ Kho
HotKeySet ("{PGDN}","GetMouseClick_ThuThap")	;Lấy Vị Trí Nút Thu Thập
HotKeySet ("{PAUSE}","StopTrade")				;Tạm Dừng Auto
HotKeySet ("^+m","GetMouse")					;Lấy thông tin Chuột
HotKeySet ("^{END}","ExitAuto")				;	Thoát Auto

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;Biến Dùng Chung
Global $Vertically=7
Global $Horizontally=7
Global $Pause=False
Global $Trading=False
Global $ThuKhoPos=_ArrayCreate(0,0)			;Vị trí Thủ Kho
Global $ThuThapPos=_ArrayCreate(0,0)		;Vị trí Nút Thu Thập
Global $TempFile="Temp.txt"		;File tạm dùng để lưu dữ liệu
Global $SpeedCheck=25
Global $MouseMove=1
Global $WaitTime=340
Global $GraphicHandle
Global $TempHandle=1
Global $MainHandle=2
Global $ShowHotKey=False
Global $ShowHelp=False

;Biến Mô Tả Chương Trình
Global $AutoName="Sai APT"
Global $AutoClass="AutoIt v3 GUI"
Global $AutoVersion="1.0"
Global $AutoSize=_ArrayCreate(214,268)
Global $AutoPos=_ArrayCreate(@DesktopWidth-$AutoSize[0]-$Vertically,0)
Global $AutoCaret
;Global $ProcessName="AutoIt3.exe"		;Dùng khi lập trình
Global $ProcessName=$AutoName&".exe"	;Dùng khi Xuất Thành EXE


;Biến Mô Tả Game
Global $GameTitle="Phong ThÇn-LËp Quèc Tranh Hïng"
Global $GameClass="FSOnline Class"
Global $GameSize
Global $GameHandle=""
Global $GameCaretPos

;Biến Định Dạng Giao Diện
Global $FontColor=557217
;Font
Global $MainFontSize=9
Global $MainFontWeight=700
;Nút Quét
Global $ScanButtonSize=_ArrayCreate(69,25)
Global $ScanButtonPos=_ArrayCreate($Vertically,$Horizontally)
;Nút Nạp
Global $LoadButtonSize=_ArrayCreate($ScanButtonSize[0],$ScanButtonSize[1])
Global $LoadButtonPos=_ArrayCreate($ScanButtonPos[0],$ScanButtonPos[1]+$ScanButtonSize[1]+$Horizontally)
;Nút Không Chọn
Global $UnCheckButtonSize=_ArrayCreate($ScanButtonSize[0],$ScanButtonSize[1])
Global $UnCheckButtonPos=_ArrayCreate($ScanButtonPos[0],$LoadButtonPos[1]+$LoadButtonSize[1]+$Horizontally)
;Nút Bắt Đầu
Global $StartButtonSize=_ArrayCreate($ScanButtonSize[0],$ScanButtonSize[1])
Global $StartButtonPos=_ArrayCreate($ScanButtonPos[0],$UnCheckButtonPos[1]+$UnCheckButtonSize[1]+$Horizontally)
;Nút Trợ Giúp
Global $HotKeyButtonSize=_ArrayCreate($ScanButtonSize[0],$ScanButtonSize[1])
Global $HotKeyButtonPos=_ArrayCreate($ScanButtonPos[0],$StartButtonPos[1]+$StartButtonSize[1]+$Horizontally)

;Khuôn hiển thỉ Ảnh
Global $EditZoneSize=_ArrayCreate(43)
Global $EditZonePos=_ArrayCreate($ScanButtonPos[0]+$ScanButtonSize[0]+$Vertically,$ScanButtonPos[1])
Global $ZoneSize=_ArrayCreate(7,13)
Global $ZonePos=_ArrayCreate($EditZonePos[0]+$EditZoneSize[0]+$Vertically,$Horizontally*2)

;Vật liệu Thu Thập
Global $FontWidth=70
Global $FontHeight=16

Global $FileManhGiap=False
Global $FileDoanKiem=False
Global $FileHoaVu=False
Global $FileMatQuy=False
Global $FileBangCo=False
Global $FileNgocCot=False

Global $ManhGiap=False
Global $DoanKiem=False
Global $HoaVu=False
Global $MatQuy=False
Global $BangCo=False
Global $NgocCot=False

Global $TradeText=""
Global $ManhGiapCount="<= Nhấn"
Global $DoanKiemCount="<= Nhấn"
Global $HoaVuCount="<= Nhấn"
Global $MatQuyCount="<= Nhấn"
Global $BangCoCount="<= Nhấn"
Global $NgocCotCount="<= Nhấn"

Global $ManhGiapPos=_ArrayCreate($LoadButtonPos[0]+$LoadButtonSize[0]+$Vertically,$LoadButtonPos[1]+$Horizontally)
Global $ManhGiapCountPos=_ArrayCreate($ManhGiapPos[0]+$FontWidth+$Vertically,$ManhGiapPos[1])


Global $DoanKiemPos=_ArrayCreate($ManhGiapPos[0],$ManhGiapPos[1]+$FontHeight+$Horizontally)
Global $DoanKiemCountPos=_ArrayCreate($DoanKiemPos[0]+$FontWidth+$Vertically,$DoanKiemPos[1])


Global $HoaVuPos=_ArrayCreate($DoanKiemPos[0],$DoanKiemPos[1]+$FontHeight+$Horizontally)
Global $HoaVuCountPos=_ArrayCreate($HoaVuPos[0]+$FontWidth+$Vertically,$HoaVuPos[1])


Global $MatQuyPos=_ArrayCreate($HoaVuPos[0],$HoaVuPos[1]+$FontHeight+$Horizontally)
Global $MatQuyCountPos=_ArrayCreate($MatQuyPos[0]+$FontWidth+$Vertically,$MatQuyPos[1])

Global $BangCoPos=_ArrayCreate($MatQuyPos[0],$MatQuyPos[1]+$FontHeight+$Horizontally)
Global $BangCoCountPos=_ArrayCreate($BangCoPos[0]+$FontWidth+$Vertically,$BangCoPos[1])

Global $NgocCotPos=_ArrayCreate($BangCoPos[0],$BangCoPos[1]+$FontHeight+$Horizontally)
Global $NgocCotCountPos=_ArrayCreate($NgocCotPos[0]+$FontWidth+$Vertically,$NgocCotPos[1])

;Check Xem Phím Nóng
Global $ShowHelpCheckSize=_ArrayCreate(Default,$FontHeight)
Global $ShowHelpCheckPos=_ArrayCreate($ScanButtonPos[0],$NgocCotPos[1]+$FontHeight+$Horizontally)
;Thông Tin dưới
Global $Lable1Size=_ArrayCreate($AutoSize[0]-$Vertically*2,Default)
Global $Lable1Pos=_ArrayCreate($Vertically,$ShowHelpCheckPos[1]+$ShowHelpCheckSize[1]+$Horizontally)
;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------


;Chuẩn bị trước khi chạy
CheckAuto()
If FocusWindow($GameTitle,$GameClass) Then
	$GameCaretPos=WinGetCaretPos()	
Else
	MsgBox(0,$AutoName,"Bạn phải chọn Game mới có thể chạy Auto!!!")
	Exit
EndIf

FindFileScan()
SetInterface(1,1)
$AutoCaret=WinGetCaretPos()
GUICtrlSetState($Start_BUTTON,$GUI_DISABLE)
GUICtrlSetState($ShowHelp_CHECK,$GUI_UNCHECKED)
	
While 1
	Sleep(777)
	;CheckTimeRun()
	ShowHelp()
WEnd 

;-- Các hàm Sự Kiện -----------------------------------------------------------------------------------------------------------------
;Sự Kiện Quét
Func EventScanNewZone()
	ToolTip("")
	$ZoneSize[0]=GUICtrlRead($EditZone_COMBO)
	If FocusWindow($GameTitle,$GameClass) Then
		SetInterface()
		Local $Text=""
		$Text=$Text&"Hãy nhập tên File sẽ lưu kết quả Đọc!"&@LF
		$Text=$Text&"Tên File tương ứng:"&@LF
		$Text=$Text&@TAB&"Mảnh Giáp "&@TAB&"- ManhGiap"&@LF
		$Text=$Text&@TAB&"Đoản Kiếm "&@TAB&"- DoanKiem"&@LF
		$Text=$Text&@TAB&"Hỏa Vũ  "&@TAB&"- HoaVu"&@LF
		$Text=$Text&@TAB&"Mặt Quỹ "&@TAB&"- MatQuy"&@LF
		$Text=$Text&@TAB&"Băng Cơ "&@TAB&"- BangCo"&@LF
		$Text=$Text&@TAB&"Ngọc Cốt "&@TAB&"- NgocCot"&@LF
		$FileDes=InputBox($Autoname,$Text,"ManhGiap",Default,340,214)
		If $FileDes="" Then 
			FileDelete($TempFile)
		Else
			FileMove($TempFile,"Data\"&$ZoneSize[0]&$FileDes&".txt",1+8)
		EndIf
	Else
		MsgBox(0,$AutoName,"Game đã không được kích hoạt!!!")
	EndIf
	Sleep($WaitTime)
	EventUnCheck()
	FindFileScan()
	CheckButtons()
	CheckStart()
EndFunc

;Sự Kiện Quét
Func EventFindFileScan()
	ToolTip("")
	$ZoneSize[0]=GUICtrlRead($EditZone_COMBO)
	FindFileScan()
	CheckButtons(340)
	CheckStart()
EndFunc
;Sự Kiện Mảnh Giáp
Func EventManhGiap()
	ToolTip("Mảnh Giáp",0,0)
	FindFileScan()
	$ManhGiap=Not $ManhGiap
	If $ManhGiap Then $ManhGiapCount=GetItemsNumber()
	If $ManhGiapCount="" Or $ManhGiapCount=0 Then $ManhGiap=False
	SetInterface(1)
	If  $DoanKiem Or $ManhGiap Then
		$FileHoaVu=False
		$FileMatQuy=False
		$FileBangCo=False
		$FileNgocCot=False
		CheckButtons()
	EndIf
	CheckStart()
EndFunc
;Sự Kiện Đoản Kiếm
Func EventDoanKiem()
	ToolTip("Đoản Kiếm",0,0)
	FindFileScan()
	$DoanKiem=Not $DoanKiem
	If $DoanKiem Then $DoanKiemCount=GetItemsNumber()
	If $DoanKiemCount="" Or $DoanKiemCount=0 Then $DoanKiem=False
	SetInterface(1)
	If $DoanKiem Or $ManhGiap Then
		$FileHoaVu=False
		$FileMatQuy=False
		$FileBangCo=False
		$FileNgocCot=False
	EndIf
	CheckButtons()
	CheckStart()
EndFunc
;Sự Kiện Hỏa Vũ
Func EventHoaVu()
	ToolTip("Hỏa Vũ",0,0)
	FindFileScan()
	$HoaVu=Not $HoaVu
	If $HoaVu Then 	$HoaVuCount=GetItemsNumber()
	If $HoaVuCount="" Or $HoaVuCount=0 Then $HoaVu=False
	SetInterface(1)
	If  $HoaVu Or $MatQuy Then
		$FileManhGiap=False
		$FileDoanKiem=False
		$FileBangCo=False
		$FileNgocCot=False
		CheckButtons()
	EndIf
	CheckStart()
EndFunc
;Sự Kiện Mặt Quỷ
Func EventMatQuy()
	ToolTip("Mặt Quỷ",0,0)
	FindFileScan()
	$MatQuy=Not $MatQuy
	If $MatQuy Then $MatQuyCount=GetItemsNumber()
	If $MatQuyCount="" Or $MatQuyCount=0 Then $MatQuy=False
	SetInterface(1)
	If  $HoaVu Or $MatQuy Then
		$FileManhGiap=False
		$FileDoanKiem=False
		$FileBangCo=False
		$FileNgocCot=False
		CheckButtons()
	EndIf
	CheckStart()
EndFunc
;Sự Kiện Băng Cơ
Func EventBangCo()
	ToolTip("Băng Cơ",0,0)
	FindFileScan()
	$BangCo=Not $BangCo
	If $BangCo Then $BangCoCount=GetItemsNumber()
	If $BangCoCount="" Or $BangCoCount=0 Then $BangCo=False
	SetInterface(1)
	If  $BangCo Or $NgocCot Then
		$FileManhGiap=False
		$FileDoanKiem=False
		$FileHoaVu=False
		$FileMatQuy=False
		CheckButtons()
	EndIf
	CheckStart()
EndFunc
;Sự Kiện Ngọc Cốt
Func EventNgocCot()
	ToolTip("Ngọc Cốt",0,0)
	FindFileScan()
	$NgocCot=Not $NgocCot
	If $NgocCot Then $NgocCotCount=GetItemsNumber()
	If $NgocCotCount="" Or $NgocCotCount=0 Then $NgocCot=False
	SetInterface(1)
	If  $BangCo Or $NgocCot Then
		$FileManhGiap=False
		$FileDoanKiem=False
		$FileHoaVu=False
		$FileMatQuy=False
		CheckButtons()
	EndIf
	CheckStart()
EndFunc


;Sự Bắt Đầu
Func EventStart()
	ToolTip("Bắt đầu đổi đồ",0,0)
	If $Pause Then Return
	If $Trading Then Return

	$Trading=True
	WinActivate($GameHandle)
	While $Trading
		Sleep($WaitTime)
		GUICtrlSetState($ShowHelp_CHECK,$GUI_UNCHECKED)
		$ShowHelp=False
		CheckStart()
		If TradeByCount()=False Then TradeByScan()
		If CheckItems()=False Then $Trading=False
	WEnd
	$ThuKhoPos=_ArrayCreate(0,0)
	$ThuThapPos=_ArrayCreate(0,0)
	CheckFiles()
	ToolTip("Ngưng Trao Đổi",0,0)
EndFunc

;Sự kiện Không Chọn
Func EventUnCheck()
	ToolTip("Không chọn gì hết",0,0)
	Global $ManhGiap=False
	Global $DoanKiem=False
	Global $HoaVu=False
	Global $MatQuy=False
	Global $BangCo=False
	Global $NgocCot=False
	FindFileScan()
	SetInterface(1)
EndFunc

;Sự Kiện Xem Phím Nóng
Func EventHotKey()
	GUICtrlSetState($ShowHelp_CHECK,$GUI_UNCHECKED)
	$ShowHelp=False
	ShowHotKey()
EndFunc

;Sự kiện bấm ShowHelp
Func EventShowHelp()
	If GUICtrlRead($ShowHelp_CHECK)=1 Then
		$ShowHelp=True
		;FocusWindow($AutoName,$AutoClass)
	Else
		$ShowHelp=False
		ToolTip("123",$AutoCaret[0]&"/"&$AutoCaret[1])
	EndIf
EndFunc
;------- Hết Các hàm Sự Kiện --------------------------------------------------------------------------------------------------------





;Hàm tạo Giao Diện
Func SetInterface($NoScanZone=0,$New=0)
	TempInterface($NoScanZone)
	If $New=0 Then GUIDelete($MainHandle)
	$MainHandle=$TempHandle
	
	;Kiểm tra nút Xem Hướng Dẫn
	If $ShowHelp Then 
		GUICtrlSetState($ShowHelp_CHECK,$GUI_CHECKED)
	Else
		GUICtrlSetState($ShowHelp_CHECK,$GUI_UNCHECKED)
	EndIf
EndFunc

;Hàm tạo Giao Diện tạm
Func TempInterface($NoScanZone=0)
	;Tạo Giao Diện
	$TempHandle=GUICreate($AutoName,$AutoSize[0],$AutoSize[1],$AutoPos[0],$AutoPos[1],Default,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	GUISetOnEvent($GUI_EVENT_CLOSE,"ExitAuto")
	GUISetFont($MainFontSize,$MainFontWeight)
	GUISetBkColor(16707215,$TempHandle)

	;Nút Quét
	Global $Scan_BUTTON=GUICtrlCreateButton("Đọc Lại",$ScanButtonPos[0],$ScanButtonPos[1],$ScanButtonSize[0],$ScanButtonSize[1],$BS_CENTER)
	GUICtrlSetOnEvent($Scan_BUTTON,"EventScanNewZone")
	;Nút Nạp
	Global $Load_BUTTON=GUICtrlCreateButton("Nạp Lại",$LoadButtonPos[0],$LoadButtonPos[1],$LoadButtonSize[0],$LoadButtonSize[1],$BS_CENTER)
	GUICtrlSetOnEvent($Load_BUTTON,"EventFindFileScan")
	;Nút Bỏ Chọn
	Global $UnCheck_BUTTON=GUICtrlCreateButton("Bỏ Chọn",$UnCheckButtonPos[0],$UnCheckButtonPos[1],$UnCheckButtonSize[0],$UnCheckButtonSize[1],$BS_CENTER)
	GUICtrlSetOnEvent($UnCheck_BUTTON,"EventUnCheck")
	;Nút Bắt Đầu
	Global $Start_BUTTON=GUICtrlCreateButton("Bắt Đầu",$StartButtonPos[0],$StartButtonPos[1],$StartButtonSize[0],$StartButtonSize[1],$BS_CENTER)
	GUICtrlSetOnEvent($Start_BUTTON,"EventStart")
	GUICtrlSetState($Start_BUTTON,$GUI_DISABLE)
	;Nút Trợ Giúp
	Global $HotKey_BUTTON=GUICtrlCreateButton("Phím Nóng",$HotKeyButtonPos[0],$HotKeyButtonPos[1],$HotKeyButtonSize[0],$HotKeyButtonSize[1],$BS_CENTER)
	GUICtrlSetOnEvent($HotKey_BUTTON,"EventHotKey")
	
	;Check Xem Phím Nóng
	Global $ShowHelp_CHECK=GUICtrlCreateCheckbox("Xem Hướng Dẫn",$ShowHelpCheckPos[0],$ShowHelpCheckPos[1],$ShowHelpCheckSize[0],$ShowHelpCheckSize[1],$BS_CENTER)
	GUICtrlSetOnEvent($ShowHelp_CHECK,"EventShowHelp")
	
	;Thông Báo Dưới
	Local $Text=""
	$Text=$Text&"-------------------------------------------------"&@LF
	$Text=$Text&"Phiên Bản: "&$AutoVersion&@LF
	$Text=$Text&"Chức Năng: "&@LF
	$Text=$Text&" - Đổi đồ thu thập."&@LF
	Global $Lable1_LABLE=GUICtrlCreateLabel($Text,$Lable1Pos[0],$Lable1Pos[1],$Lable1Size[0],$Lable1Size[1])
	;GUICtrlSetBkColor(-1,2526)
	
	;Chữ khi chưa Scan
	If $NoScanZone=0 Then 
		ScanZone()
	Else
		Global $Zone_LABLE=GUICtrlCreateLabel("Chưa Đọc",$ZonePos[0]-1,$ZonePos[1]-1,$ZoneSize[0]+2,$ZoneSize[1]+2,$SS_CENTER)
		GUICtrlSetColor($Zone_LABLE,$FontColor)
	EndIf
		
	;Nơi hiệu chỉnh kích thước vùng Scan
	Global $EditZone_COMBO=GUICtrlCreateCombo($ZoneSize[0],$EditZonePos[0],$EditZonePos[1],$EditZoneSize[0])
	GUICtrlSetData($EditZone_COMBO,"16|34|61")
	
	;Nút Mảnh Giáp
	If $ManhGiap Then
		Global $ManhGiap_LABLE=GUICtrlCreateLabel("Mảnh Giáp",$ManhGiapPos[0],$ManhGiapPos[1],$FontWidth,$FontHeight,$SS_CENTER+$SS_SUNKEN)
		GUICtrlSetColor(-1,$FontColor)
	Else
		Global $ManhGiap_LABLE=GUICtrlCreateLabel("Mảnh Giáp",$ManhGiapPos[0],$ManhGiapPos[1],$FontWidth,$FontHeight,$SS_CENTER)
	EndIf
	Global $ManhGiapCount_LABLE=GUICtrlCreateLabel($ManhGiapCount,$ManhGiapCountPos[0],$ManhGiapCountPos[1],$FontWidth,$FontHeight)
	GUICtrlSetColor(-1,$FontColor)
		
	;Nút Đoản Kiếm
	If $DoanKiem Then
		Global $DoanKiem_LABLE=GUICtrlCreateLabel("Đoản Kiếm",$DoanKiemPos[0],$DoanKiemPos[1],$FontWidth,$FontHeight,$SS_CENTER+$SS_SUNKEN)
		GUICtrlSetColor(-1,$FontColor)
	Else
		Global $DoanKiem_LABLE=GUICtrlCreateLabel("Đoản Kiếm",$DoanKiemPos[0],$DoanKiemPos[1],$FontWidth,$FontHeight,$SS_CENTER)
	EndIf
	Global $DoanKiemCount_LABLE=GUICtrlCreateLabel($DoanKiemCount,$DoanKiemCountPos[0],$DoanKiemCountPos[1],$FontWidth,$FontHeight)
	GUICtrlSetColor(-1,$FontColor)

	;Nút Hỏa Vũ
	If $HoaVu Then
		Global $HoaVu_LABLE=GUICtrlCreateLabel("Hỏa Vũ",$HoaVuPos[0],$HoaVuPos[1],$FontWidth,$FontHeight,$SS_CENTER+$SS_SUNKEN)
		GUICtrlSetColor(-1,$FontColor)
	Else
		Global $HoaVu_LABLE=GUICtrlCreateLabel("Hỏa Vũ",$HoaVuPos[0],$HoaVuPos[1],$FontWidth,$FontHeight,$SS_CENTER)
	EndIf
	Global $HoaVuCount_LABLE=GUICtrlCreateLabel($HoaVuCount,$HoaVuCountPos[0],$HoaVuCountPos[1],$FontWidth,$FontHeight)
	GUICtrlSetColor(-1,$FontColor)
	
	;Nút Mặt Quỷ
	If $MatQuy Then
		Global $MatQuy_LABLE=GUICtrlCreateLabel("Mặt Quỹ",$MatQuyPos[0],$MatQuyPos[1],$FontWidth,$FontHeight,$SS_CENTER+$SS_SUNKEN)
		GUICtrlSetColor(-1,$FontColor)
	Else
		Global $MatQuy_LABLE=GUICtrlCreateLabel("Mặt Quỹ",$MatQuyPos[0],$MatQuyPos[1],$FontWidth,$FontHeight,$SS_CENTER)
	EndIf
	Global $MatQuyCount_LABLE=GUICtrlCreateLabel($MatQuyCount,$MatQuyCountPos[0],$MatQuyCountPos[1],$FontWidth,$FontHeight)
	GUICtrlSetColor(-1,$FontColor)
	
	;Nút Băng Cơ
	If $BangCo Then
		Global $BangCo_LABLE=GUICtrlCreateLabel("Băng Cơ",$BangCoPos[0],$BangCoPos[1],$FontWidth,$FontHeight,$SS_CENTER+$SS_SUNKEN)
		GUICtrlSetColor(-1,$FontColor)
	Else	
		Global $BangCo_LABLE=GUICtrlCreateLabel("Băng Cơ",$BangCoPos[0],$BangCoPos[1],$FontWidth,$FontHeight,$SS_CENTER)
	EndIf
	Global $BangCoCount_LABLE=GUICtrlCreateLabel($BangCoCount,$BangCoCountPos[0],$BangCoCountPos[1],$FontWidth,$FontHeight)
	GUICtrlSetColor(-1,$FontColor)
	
	;Nút Ngọt Cốt
	If $NgocCot Then
		Global $NgocCot_LABLE=GUICtrlCreateLabel("Ngọc Cốt",$NgocCotPos[0],$NgocCotPos[1],$FontWidth,$FontHeight,$SS_CENTER+$SS_SUNKEN)
		GUICtrlSetColor(-1,$FontColor)
	Else	
		Global $NgocCot_LABLE=GUICtrlCreateLabel("Ngọc Cốt",$NgocCotPos[0],$NgocCotPos[1],$FontWidth,$FontHeight,$SS_CENTER)
	EndIf
	Global $NgocCotCount_LABLE=GUICtrlCreateLabel($NgocCotCount,$NgocCotCountPos[0],$NgocCotCountPos[1],$FontWidth,$FontHeight)
	GUICtrlSetColor(-1,$FontColor)
	
	;Đặt thuộc tính sự kiện
	GUICtrlSetOnEvent($ManhGiap_LABLE,"EventManhGiap")
	GUICtrlSetOnEvent($DoanKiem_LABLE,"EventDoanKiem")
	GUICtrlSetOnEvent($HoaVu_LABLE,"EventHoaVu")
	GUICtrlSetOnEvent($MatQuy_LABLE,"EventMatQuy")
	GUICtrlSetOnEvent($BangCo_LABLE,"EventBangCo")
	GUICtrlSetOnEvent($NgocCot_LABLE,"EventNgocCot")
	
	;Đặt thuộc tính cho Nút
	CheckButtons()
	GUISetState(@SW_SHOW,$TempHandle)
EndFunc

;Hàm thoát Auto
Func ExitAuto()
	FileDelete($TempFile)
	Exit
EndFunc

;Hàm lấy Kích Hoạt Game
Func FocusWindow($Title="",$Class="",$Text="")
	;Kiễm Tra Game
	;Nếu chỉ có 1 Game
	If $GameHandle="" Then
		$List=WinList("[TITLE:"&$Title&"; CLASS:"&$Class&"]")
		If $List[0][0]=1 Then
			$GameHandle=$List[1][1]
		EndIf
	EndIf
	
	;Nếu đã chọn
	If $GameHandle<>"" Then
		WinActivate($GameHandle)
		WinMove($GameHandle,"",0,0)
		Return True
	EndIf
	
	;Đợi Game
	$i=7
	ToolTip("Bạn có "&$i&" giây để chọn Game",@DesktopWidth/2,@DesktopHeight/2)
	While $i>0
		If WinWaitActive("[TITLE:"&$Title&"; CLASS:"&$Class&"]","",1)=1 Then ExitLoop
		$i-=1
		ToolTip("Bạn có "&$i&" Giây để chọn Game",@DesktopWidth/2,@DesktopHeight/2)
	WEnd
	ToolTip("")
	If $i<=0 Then Return False
	$GameHandle=WinGetHandle("[TITLE:"&$Title&"; CLASS:"&$Class&"]")
	$GameSize=WinGetClientSize("[TITLE:"&$Title&"; CLASS:"&$Class&"]")
	
	WinMove($GameHandle,"",0,0)
	Return True
EndFunc

;Hàm Lấy màu đã Quét
Func FindFileScan()
	;Tìm file lưu Bản Đọc của 6 vật liệu
	$ListFile=FileFindFirstFile("Data\*.txt")
	If $ListFile=-1 Then Return False	
	$FileManhGiap=False
	$FileDoanKiem=False	
	$FileHoaVu=False			
	$FileMatQuy=False		
	$FileBangCo=False	
	$FileNgocCot=False
		
	While 1
		$File = FileFindNextFile($ListFile) 
		If @error Then ExitLoop
		Select
			Case $File=$ZoneSize[0]&"ManhGiap.txt"
				$FileManhGiap=True
			Case $File=$ZoneSize[0]&"DoanKiem.txt"
				$FileDoanKiem=True	
			Case $File=$ZoneSize[0]&"HoaVu.txt"
				$FileHoaVu=True			
			Case $File=$ZoneSize[0]&"MatQuy.txt"
				$FileMatQuy=True		
			Case $File=$ZoneSize[0]&"BangCo.txt"
				$FileBangCo=True	
			Case $File=$ZoneSize[0]&"NgocCot.txt"
				$FileNgocCot=True
		EndSelect	
	WEnd
EndFunc
	
;Hàm lấy vị trí Thủ Kho
Func GetMouseClick_ThuKho()
	$ThuKhoPos=MouseGetPos()
	MouseClick("Left",$ThuKhoPos[0],$ThuKhoPos[1],1,1)
	CheckStart()
EndFunc

;Hàm lấy vị trí Nút Thu Nhập
Func GetMouseClick_ThuThap()
	$ThuThapPos=MouseGetPos()
	MouseClick("Left",$ThuThapPos[0],$ThuThapPos[1],1,1)
	CheckStart()
EndFunc

;Hàm Kiểm Tra Trước khi Chạy Auto
Func CheckAuto($CountProcess=1)
	$l=ProcessList()
	$Count=$CountProcess
	For $i=1 to $l[0][0] Step 1
		If $l[$i][0]=$ProcessName And $Count=0 then
			ToolTip("")
			MsgBox(0,$AutoName,"Đã có "&$CountProcess&" chương trình "&$AutoName&" đang chạy."&@LF&"Không thể mở thêm!!!")
			Exit
		EndIf
		If $l[$i][0]=$ProcessName then $Count-=1
	Next
	TraySetState(1)
EndFunc

;Hàm Kiểm Tra Nút
Func CheckButtons($Time=0)
	If $FileManhGiap then 
		GUICtrlSetState($ManhGiap_LABLE,$GUI_ENABLE)
	Else
		GUICtrlSetState($ManhGiap_LABLE,$GUI_DISABLE)
	EndIf
	Sleep($Time)

	If $FileDoanKiem Then 
		GUICtrlSetState($DoanKiem_LABLE,$GUI_ENABLE)
	Else
		GUICtrlSetState($DoanKiem_LABLE,$GUI_DISABLE)
	EndIf
	Sleep($Time)
	
	If $FileHoaVu Then 
		GUICtrlSetState($HoaVu_LABLE,$GUI_ENABLE)
	Else
		GUICtrlSetState($HoaVu_LABLE,$GUI_DISABLE)
	EndIf
	Sleep($Time)

	If $FileMatQuy Then 
		GUICtrlSetState($MatQuy_LABLE,$GUI_ENABLE)
	Else
		GUICtrlSetState($MatQuy_LABLE,$GUI_DISABLE)
	EndIf
	Sleep($Time)
	
	If $FileBangCo Then 
		GUICtrlSetState($BangCo_LABLE,$GUI_ENABLE)
	Else
		GUICtrlSetState($BangCo_LABLE,$GUI_DISABLE)
	EndIf
	Sleep($Time)
	
	If $FileNgocCot Then 
		GUICtrlSetState($NgocCot_LABLE,$GUI_ENABLE)
	Else
		GUICtrlSetState($NgocCot_LABLE,$GUI_DISABLE)
	EndIf
	Sleep($Time)

EndFunc

;Hàm kiễm tra trước khi đổi đồ
Func CheckStart()
	If $ThuKhoPos[0]=0 And $ThuThapPos[0]=0 Then
		GUICtrlSetState($Start_Button,$GUI_DISABLE)
		Return False
	EndIf
	If $ThuKhoPos[0]<>0 And $ThuThapPos[0]<>0 Then 
		If $Trading=False Then ToolTip("Có thể đổi đồ",0,0)
		If $FileManhGiap=False And $FileDoanKiem=False And $FileHoaVu=False And $FileMatQuy=False And $FileBangCo=False And $FileNgocCot=False Then
			ToolTip("Không có đủ dữ liệu."&@LF&"Hãy dùng nút [Đọc Lại] để tạo dữ liệu.",0,0)
			Return False
		EndIf
		If $ManhGiap=False And $DoanKiem=False And $HoaVu=False And $MatQuy=False And $BangCo=False And $NgocCot=False Then
			ToolTip("Chưa chọn loại vật liệu nào."&@LF&"Hãy chọn ít nhất 1 loại Vật Liệu.",0,0)
			Return False
		EndIf
		
		If $ManhGiap And $FileManhGiap Then 
			$TradeText="ManhGiap"
			GUICtrlSetState($Start_Button,$GUI_ENABLE)
			Return True
		Else
			GUICtrlSetState($Start_Button,$GUI_DISABLE)
		EndIf
		If $DoanKiem And $FileDoanKiem Then 
			$TradeText="DoanKiem"
			GUICtrlSetState($Start_Button,$GUI_ENABLE)
			Return True
		Else
			GUICtrlSetState($Start_Button,$GUI_DISABLE)
		EndIf
		
		If $HoaVu And $FileHoaVu Then 
			$TradeText="HoaVu"
			GUICtrlSetState($Start_Button,$GUI_ENABLE)
			Return True
		Else
			GUICtrlSetState($Start_Button,$GUI_DISABLE)
		EndIf
		If $MatQuy And $FileMatQuy Then	
			$TradeText="MatQuy"
			GUICtrlSetState($Start_Button,$GUI_ENABLE)
			Return True
		Else
			GUICtrlSetState($Start_Button,$GUI_DISABLE)
		EndIf

		If $BangCo And $FileBangCo Then	
			$TradeText="BangCo"
			GUICtrlSetState($Start_Button,$GUI_ENABLE)
			Return True
		Else
			GUICtrlSetState($Start_Button,$GUI_DISABLE)
		EndIf
		If $NgocCot And $FileNgocCot Then 
			$TradeText="NgocCot"
			GUICtrlSetState($Start_Button,$GUI_ENABLE)
			Return True
		Else
			GUICtrlSetState($Start_Button,$GUI_DISABLE)
		EndIf
	EndIf	
EndFunc

;Hàm Dừng Trao Đổ {PAUSE}
Func StopTrade()
	$Trading=False
	CheckButtons()
	CheckStart()
	ProcessSetPriority($ProcessName,2)
	ToolTip("")
EndFunc

;Hàm thông báo tình trạng Trao Đổi
Func ShowTrading($Show)
	Select
		Case $Show=1
			ToolTip("Đang trao đổi....   ",0,0)
			Sleep($WaitTime)
		Case $Show=2
			ToolTip("Đang trao đổi...o   ",0,0)
			Sleep($WaitTime)
		Case $Show=3
			ToolTip("Đang trao đổi...O   ",0,0)
			Sleep($WaitTime)
		Case $Show=4
			ToolTip("Đang trao đổi...o   ",0,0)
			Sleep($WaitTime)
		Case $Show=5
			ToolTip("Đang trao đổi....   ",0,0)
			Sleep($WaitTime)
	EndSelect
EndFunc

;Hàm Quét 1 vùng màng hình
Func ScanZone($ScanPos="",$GraphicSize="")
	Sleep(7)
	ProcessSetPriority($ProcessName,5)
	If $GameCaretPos="" then $GameCaretPos=WinGetCaretPos()	
	$FileScan=FileOpen($TempFile,2)
	
	If $ScanPos="" Then $ScanPos=_ArrayCreate($GameCaretPos[0]+442,$GameCaretPos[1]+191)
	If $GraphicSize="" Then $GraphicSize=$ZoneSize
	
	$GraphicPos=$ZonePos
	;Tạo thêm 1 Graphic trong Giao Diện
	$Graphic1=GUICtrlCreateGraphic($GraphicPos[0],$GraphicPos[1],$GraphicSize[0],$GraphicSize[1])
	For $i=$ScanPos[0] To $ScanPos[0]+$GraphicSize[0] Step 1
	For $j=$ScanPos[1] To $ScanPos[1]+$GraphicSize[1] Step 1
		ShowTrading($j)
		$Pixel=PixelGetColor($i,$j)
		GUICtrlSetGraphic($Graphic1,$GUI_GR_COLOR,$Pixel)
		GUICtrlSetGraphic($Graphic1,$GUI_GR_PIXEL,$i-$ScanPos[0],$j-$ScanPos[1])
		FileWriteLine($FileScan,$Pixel)
	Next
	Next
	;MouseMove($ScanPos[0],$ScanPos[1])
	;MouseMove($ScanPos[0]+$GraphicSize[0],$ScanPos[1]+$GraphicSize[1])
	FileClose($FileScan)
	ProcessSetPriority($ProcessName,2)
EndFunc

;Hàm hiển thị Phím Nóng
Func ShowHotKey()
	$ShowHotKey=Not $ShowHotKey
	Local $Text=""
	$Text=$Text&"[PageUp]"&@TAB&"- Lấy vị trí Thủ Kho"&@LF
	$Text=$Text&"[PageDown]"&@TAB&"- Lấy vị trí Nút Thu Thập"&@LF
	$Text=$Text&"[Pause] "&@TAB&"- Ngưng đổi đồ"&@LF
	$Text=$Text&"Ctrl+[End]"&@TAB&"- Thoát Auto"
	IF $ShowHotKey Then
		ToolTip($Text,$AutoPos[0],$AutoSize[1],"DANH SÁCH PHÍM NÓNG",1)
		GUICtrlSetData($HotKey_BUTTON,"Đóng")
	Else
		ToolTip("")
		GUICtrlSetData($HotKey_BUTTON,"Phím Nóng")
	EndIf
EndFunc

;Hàm giảm số lương
Func GiamSoLuong($String)
	Select
	Case $String="ManhGiap"
		$ManhGiapCount-=10
		If $ManhGiapCount<10 Then
			$ManhGiapCount=$ManhGiapCount&" (Thiếu)"
			If Int($ManhGiapCount)=0 Then $ManhGiapCount="Hết"
			$ManhGiap=False
		EndIf
	Case $String="DoanKiem"
		$DoanKiemCount-=10
		If $DoanKiemCount<10 Then
			$DoanKiemCount=$DoanKiemCount&" (Thiếu)"
			If Int($DoanKiemCount)=0 Then $DoanKiemCount="Hết"
			$DoanKiem=False
		EndIf
	Case $String="HoaVu"
		$HoaVuCount-=10
		If $HoaVuCount<10 Then
			$HoaVuCount=$HoaVuCount&" (Thiếu)"
			If Int($HoaVuCount)=0 Then $HoaVuCount="Hết"
			$HoaVu=False
		EndIf
	Case $String="MatQuy"
		$MatQuyCount-=10
		If $MatQuyCount<10 Then
			$MatQuyCount=$MatQuyCount&" (Thiếu)"
			If Int($MatQuyCount)=0 Then $MatQuyCount="Hết"
			$MatQuy=False
		EndIf
	Case $String="BangCo"
		$BangCoCount-=10
		If $BangCoCount<10 Then
			$BangCoCount=$BangCoCount&" (Thiếu)"
			If Int($BangCoCount)=0 Then $BangCoCount="Hết"
			$BangCo=False
		EndIf
	Case $String="NgocCot"
		$NgocCotCount-=10
		If $NgocCotCount<10 Then
			$NgocCotCount=$NgocCotCount&" (Thiếu)"
			If Int($NgocCotCount)=0 Then $NgocCotCount="Hết"
			$NgocCot=False
		EndIf
	EndSelect
EndFunc

;Hàm kiểm tra đồ có đủ không
Func CheckItems()
	For $i=1 To 6 Step 1
		If Eval($TradeText&"Count")>9 Then ExitLoop
		CheckStart()
	Next
	If Eval($TradeText&"Count")<10 Then Return False
	Return True
EndFunc

;Hàm lấy số lượng đồ cần đổi
Func GetItemsNumber()
	Local $Text=""
	$Text=$Text&"Nhập Số lượng cần đổi."&@LF
	$Text=$Text&"Ví dụ: 100*35+7 là đổi 3507 món"
	$Count=InputBox($AutoName,$Text,"100*35+7","",Default,133)
	If $Count="" Then Return
	Return Execute($Count)
EndFunc

;Hàm đổi đồ loại kiểm tra hình ảnh
Func TradeByScan()
	If $Trading=False Then Return
	Do
		MouseClick("Left",$ThuKhoPos[0]+Random(-2,2),$ThuKhoPos[1]+Random(-16,25),1,1)
		;MouseMove($ThuThapPos[0],$ThuThapPos[1]-34,7)
		;MouseMove($ThuThapPos[0],$ThuThapPos[1]-61,7)
		Sleep(777)
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then ExitLoop
		EndIf	
		EndIf	
		If $Trading=False Then	Return
		
	Until False
	
	If $Trading=False Then Return
	;MouseMove($ThuThapPos[0],$ThuThapPos[1],$MouseMove)
	MouseClick("Left",$ThuThapPos[0],$ThuThapPos[1],1,1)
	If $Trading=False Then	Return
	Sleep($WaitTime)
	MouseClick("Left",$ThuThapPos[0]+16,$ThuThapPos[1],1,1)
	If $Trading=False Then	Return
	Sleep($WaitTime)
	SetInterface()
	If $Trading=False Then	Return
	WinActivate($GameHandle)
	
	If CheckFiles() Then 
		ToolTip("Xác Định",$ThuThapPos[0],$ThuThapPos[1]+77)
		GiamSoLuong($TradeText)
		;Send("{ESC}")
		Send("{ENTER}")
		Execute('GUICtrlSetData($'&$TradeText&'Count_LABLE,$'&$TradeText&'Count)')
		If $Trading=False Then Return
		;Return True
		
		Do
			Sleep(777)
			MouseClick("Left",$ThuKhoPos[0]+Random(-2,2),$ThuKhoPos[1]+Random(-16,25),1,1)
			If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
			If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
			If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then ExitLoop
			EndIf	
			EndIf	
			If $Trading=False Then	Return
		Until False		
		If $Trading=False Then Return
		
		;MouseMove($ThuThapPos[0],$ThuThapPos[1],$MouseMove)
		MouseClick("Left",$ThuThapPos[0],$ThuThapPos[1],1,1)
		If $Trading=False Then Return
		Sleep($WaitTime)
		Send("{ENTER}")
		Sleep($WaitTime)
		Send("{ESC}")
		ToolTip("Giao",$ThuThapPos[0],$ThuThapPos[1]+77)
		If $Trading=False Then Return		
	Else
		ToolTip("Hủy",$ThuThapPos[0],$ThuThapPos[1]+77)
		Send("{ESC}")
	EndIf
	FileDelete($TempFile)
EndFunc

;Hàm giao đồ loại theo Số lượng
Func TradeByCount()
	$Count=_ArrayCreate(0)
	If $ManhGiap And $FileManhGiap Then
		$Count[0]+=1
		_ArrayAdd($Count,"ManhGiap")
	EndIf
	If $DoanKiem And $FileDoanKiem Then
		$Count[0]+=1
		_ArrayAdd($Count,"DoanKiem")
	EndIf
	
	If $HoaVu And $FileHoaVu Then
		$Count[0]+=1
		_ArrayAdd($Count,"HoaVu")
	EndIf
	If $MatQuy And $FileMatQuy Then
		$Count[0]+=1
		_ArrayAdd($Count,"MatQuy")
	EndIf
	
	If $BangCo And $FileBangCo Then
		$Count[0]+=1
		_ArrayAdd($Count,"BangCo")
	EndIf
	If $NgocCot And $FileNgocCot Then
		$Count[0]+=1
		_ArrayAdd($Count,"NgocCot")
	EndIf
	
	If $Count[0]=1 Then Return False
	
	If $Trading=False Then Return
	Do
		Sleep(777)
		MouseClick("Left",$ThuKhoPos[0]+Random(-2,2),$ThuKhoPos[1]+Random(-16,25),1,1)
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then ExitLoop
		EndIf	
		EndIf	
		If $Trading=False Then	Return
	Until False
		
	If $Trading=False Then Return
	;MouseMove($ThuThapPos[0],$ThuThapPos[1],$MouseMove)
	MouseClick("Left",$ThuThapPos[0],$ThuThapPos[1],1,1)
	If $Trading=False Then	Return
	Sleep($WaitTime)
	MouseClick("Left",$ThuThapPos[0]+16,$ThuThapPos[1],6,1)
	Sleep($WaitTime)
	SetInterface()
	WinActivate($GameHandle)
	
	Sleep($WaitTime)
	$Temp=FileOpen($TempFile,0)
	$j=0
	ProcessSetPriority($ProcessName,5)
	For $j=1 To $Count[0] Step 1
		$File=FileOpen("Data\"&$ZoneSize[0]&$Count[$j]&".txt",0)
		$i=0
		While $File
			$i+=$SpeedCheck
			FileReadLine($Temp,$i)
			If @error=-1 Then
				Send("{ENTER}")
				;Send("{ESC}")
				$Count[0]=0
				ExitLoop
			EndIf
			If FileReadLine($Temp,$i)=FileReadLine($File,$i) then ContinueLoop
			If FileReadLine($Temp,$i)<>FileReadLine($File,$i) then 
				ExitLoop
			EndIf
			If $Trading=False Then	Return False
		WEnd
		FileClose($File)
		If $Count[0]=0 Then ExitLoop
	Next
	ProcessSetPriority($ProcessName,2)	
	FileClose($Temp)
	FileDelete($Temp)
	
	If $j>2 Then Return True
	GiamSoLuong($Count[$j])
	Execute('GUICtrlSetData($'&$Count[$j]&'Count_LABLE,$'&$Count[$j]&'Count)')
	
	If $Trading=False Then Return
	;Return True
	
	Do
		Sleep(777)
		MouseClick("Left",$ThuKhoPos[0]+Random(-2,2),$ThuKhoPos[1]+Random(-16,25),1,1)
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then
		If PixelGetColor($ThuThapPos[0]+Random(1,6),$ThuThapPos[1]-Random(34,61))=PixelGetColor($ThuThapPos[0]+Random(7,16),$ThuThapPos[1]-Random(34,61)) Then ExitLoop
		EndIf	
		EndIf	
		If $Trading=False Then	Return
	Until False
		
	;MouseMove($ThuThapPos[0],$ThuThapPos[1],$MouseMove)
	MouseClick("Left",$ThuThapPos[0],$ThuThapPos[1],1,1)
	If $Trading=False Then Return
	Sleep($WaitTime)
	Send("{ENTER}")
	Sleep($WaitTime)
	Send("{ESC}")
	Return True
EndFunc

;Hàm so sách File Dữ Liệu
Func CheckFiles($FileCheck="")
	$Temp=FileOpen($TempFile,0)
	;Kiểm Tra từ dưới lên
	$File=False
	If $FileCheck="" Then
		;MsgBox(0,"1","")		
		If $NgocCot And $FileNgocCot Then $File=FileOpen("Data\"&$ZoneSize[0]&"NgocCot.txt",0)
		If $BangCo And $FileBangCo Then	$File=FileOpen("Data\"&$ZoneSize[0]&"BangCo.txt",0)
		
		If $MatQuy And $FileMatQuy Then	$File=FileOpen("Data\"&$ZoneSize[0]&"MatQuy.txt",0)
		If $HoaVu And $FileHoaVu Then $File=FileOpen("Data\"&$ZoneSize[0]&"HoaVu.txt",0)
		
		If $DoanKiem And $FileDoanKiem Then	$File=FileOpen("Data\"&$ZoneSize[0]&"DoanKiem.txt",0)
		If $ManhGiap And $FileManhGiap Then	$File=FileOpen("Data\"&$ZoneSize[0]&"ManhGiap.txt",0)
	Else
		;MsgBox(0,"2","")		
		$File=FileOpen($FileCheck,0)	
	EndIf
	
	;So Sánh 2 File
	$i=0
	ProcessSetPriority($ProcessName,5)
	While $File
		$i+=$SpeedCheck
		FileReadLine($File,$i)
		If @error=-1 Then 
			FileClose($File)
			FileClose($Temp)
			Return True
		EndIf
		If FileReadLine($Temp,$i)=FileReadLine($File,$i) then ContinueLoop
		If FileReadLine($Temp,$i)<>FileReadLine($File,$i) then 
			FileClose($File)
			FileClose($Temp)
			Return False
		EndIf
		If $Trading=False Then
			FileClose($File)
			FileClose($Temp)
			Return False
		EndIf
	WEnd
	ProcessSetPriority($ProcessName,2)
EndFunc

;Hàm lấy vị trí chuột
Func GetMouse()
	$Pos=MouseGetPos()
	$Type=MouseGetCursor()
	$Color=PixelGetColor($Pos[0],$Pos[1])
	ToolTip("Chuột "&$Type&" : "&$Pos[0]&"/"&$Pos[1]&" - Màu:"&$Color,0,0)
EndFunc

;Hàm hiệu chỉnh phiên bản
Func CheckTimeRun()
	$FisrtRun=RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{5t26409c0-ea84i-11d1-bl16e-0805fce9216}\EventClasses", "ConfigSystem")	
	If $FisrtRun="" Then ;Nếu chua có gì tức là chạy lần đầu -> Ghi dữ liệu
		RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{5t26409c0-ea84i-11d1-bl16e-0805fce9216}\EventClasses", "ConfigSystem","REG_SZ",Random(1571781581,384759827345))
		RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{5t26409c0-ea84i-11d1-bl16e-0805fce9216}\Subscriptions","5e0i61e8a34l9s27","REG_SZ",TimerInit())
		Return
	EndIf
	$TimeLimit=5*60*60*1000
	$TimeStar=RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{5t26409c0-ea84i-11d1-bl16e-0805fce9216}\Subscriptions","5e0i61e8a34l9s27")
	$TimeRun=TimerDiff($TimeStar)
	IF $TimeRun<$TimeLimit Then Return
	
	RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{5t26409c0-ea84i-11d1-bl16e-0805fce9216}")
	FileDelete($AutoName&".AU3")
	Exit
EndFunc

;Hàm xem hướng dẫn
Func ShowHelp()
	If Not $ShowHelp Then Return
	;Hướng dẫn khi không có File nào	
	If $FileManhGiap=False And $FileDoanKiem=False And $FileHoaVu=False And $FileMatQuy=False And $FileBangCo=False And $FileNgocCot=False Then
		$Title="Giúp đọc các chữ  Mảnh Giáp, Đoản Kiếm,..."
		Local $Text=""
		$Text=$Text&"Không có đủ dữ liệu về chữ. "&@LF
		$Text=$Text&"Việc tạo Dữ Liệu chỉ cần làm 1 lần. "&@LF
		$Text=$Text&"Cách thức: "&@LF
		$Text=$Text&" - Đến gặp bất kỳ Thủ Khố nào. "&@LF
		$Text=$Text&" - Làm hiện các chữ Mảnh Giáp,...(Màu Đỏ) lên. "&@LF
		$Text=$Text&" - Bấm nút [Đọc Lại] này, nhập tên. "&@LF
		ToolTip($Text,$AutoCaret[0]+$ScanButtonPos[0]+$ScanButtonSize[0]/2,$AutoCaret[1]+$ScanButtonPos[1]+$ScanButtonSize[1]/2,$Title,1,3)
		Return
	EndIf
	
	;Hướng dẫn khi không chọn loại nào
	If $ManhGiap=False And $DoanKiem=False And $HoaVu=False And $MatQuy=False And $BangCo=False And $NgocCot=False Then
		;ToolTip($AutoCaret[0]&"/"&$AutoCaret[1],0,0)
		$Title="Giúp chọn vật liệu"
		Local $Text=""
		$Text=$Text&"Chưa có Vật Liệu nào được chọn. "&@LF
		$Text=$Text&"Cách chọn: "&@LF
		$Text=$Text&" - Bấm vào bất kỳ vật liệu nào. "&@LF
		$Text=$Text&" - Nhập số lượng mà bạn có. "&@LF
		ToolTip($Text,$AutoCaret[0]+$NgocCotPos[0]+$FontWidth/2,$AutoCaret[1]+$NgocCotPos[1]+$FontHeight,$Title,1,3)		
		Return
	EndIf
	
	;Hướng dẫn lấy vị trí Thủ Khố 
	If $ThuKhoPos[0]=0 Then
		;ToolTip($AutoCaret[0]&"/"&$AutoCaret[1],0,0)
		$Title="Giúp lấy vị trí Thủ Khố"
		Local $Text=""
		$Text=$Text&"Chưa lấy vị trí Thủ Khố. "&@LF
		$Text=$Text&"Cách lấy: "&@LF
		$Text=$Text&" - Đưa chuột lên người Thủ Khố. "&@LF
		$Text=$Text&" - Bấm Phím Nóng [Page Up] để lấy. "&@LF
		$Text=$Text&"Lưu Ý: "&@LF
		$Text=$Text&" - Nên để chính giữ Người Thủ Thố. "&@LF
		ToolTip($Text,$GameCaretPos[0],$GameCaretPos[1],$Title,1)		
		Return	
	EndIf
		
	;Hướng dẫn lấy vị trí Nút Thu Thập 
	If $ThuThapPos[0]=0 Then
		;ToolTip($AutoCaret[0]&"/"&$AutoCaret[1],0,0)
		$Title="Giúp lấy vị trí Nút Thu Thập"
		Local $Text=""
		$Text=$Text&"Chưa lấy vị trí Nút Thu Thập. "&@LF
		$Text=$Text&"Cách lấy: "&@LF
		$Text=$Text&" - Nói chuyện Thủ Khố để thấy Nút Thu Thập. "&@LF
		$Text=$Text&" - Đưa chuột lên Nút Thu Thập. "&@LF
		$Text=$Text&" - Bấm Phím Nóng [Page Down] để lấy. "&@LF
		$Text=$Text&"Lưu Ý: "&@LF
		$Text=$Text&" - Nên trả hết Nhiệm Vụ Thu Thập trước. "&@LF
		ToolTip($Text,$GameCaretPos[0],$GameCaretPos[1],$Title,1)		
		Return	
	EndIf
	
	;ToolTip($AutoCaret[0]&"/"&$AutoCaret[1],0,0)
	$Title="Bắt Đầu Đổi Đồ"
	Local $Text=""
	$Text=$Text&"Đã sẵn sàng đổi đồ. "&@LF
	$Text=$Text&"Cách bắt đầu: "&@LF
	$Text=$Text&" - Bấm Nút Bắt Đầu trong Auto. "&@LF
	$Text=$Text&"Lưu Ý: "&@LF
	$Text=$Text&" - Việc đổi sẽ Lỗi khi Thu Khố bị che nhiều. "&@LF
	$Text=$Text&" - Nên đứng sát Thủ Khố để tránh Lỗi trên. "&@LF
	$Text=$Text&" - Việc đổi sẽ dừng khi số lượng Đồ hết. "&@LF
	$Text=$Text&" - Việc đổi sẽ dừng khi bấm phím nóng [Pause]. "&@LF
	$Text=$Text&" - Việc đổi sẽ dừng khi Thoát Auto. "&@LF
	$Text=$Text&" - Để Thoát Auto dùng phím nóng [Ctrl+End]. "&@LF
	ToolTip($Text,$GameCaretPos[0],$GameCaretPos[1],$Title,1)		
	;GUICtrlSetState($ShowHelp_CHECK,$GUI_UNCHECKED)
EndFunc


