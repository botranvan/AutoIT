#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:        Trần Tiên Thành

 Script Function:
	Xoay hình

#ce ----------------------------------------------------------------------------
;~ #NoTrayIcon
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Các biến cơ bản
Global $X, $Y, $TrongTam_X, $TrongTam_Y, $Mau ;Các biến ngẫu nhiên
Global $Time_VeDT, $TimeRefresh, $TimeDiemTrongTam ;Các biến Time
Global $Pause
Global $Giay=1000
;Các biến GUI
Global $GUI_Main
Global $GUI_Time_DiemTrongTam, $GUI_Time_ReFresh, $GUI_Time_Ngung
Global $GUI_Button_BatDau, $GUI_Button_Thoat
#cs ----------------------------------------------------------------------------
;Các biến thay đổi giá trị hiện hình
Global $Time_DiemTrongTam = 500 ;Thời gian để xuất hiện ngẫu nhiên 1 điểm trọng tâm mới
Global $Time_ReFresh = 4000 ;Thời gian để làm tươi màn hình
Global $Time_Ngung = 10000 ;Thời gian ngừng biểu diễn
Global $WidthPen = Random(1, 10);Độ rộng của nét vẽ
#ce ----------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Các HotKey
HotKeySet("{f9}", "Thoat")
HotKeySet("{esc}", "Thoat")
HotKeySet("{f8}", "Pause")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Các hàm khai báo ban đầu
GUI_Main()
While 1
	Sleep(100)
WEnd
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Gui điều khiển
Func GUI_Main()
	Opt("GUIOnEventMode", 1)
	$GUI_Main = GUICreate("Xoay hinh", 300, 150)
	GUISetOnEvent($GUI_EVENT_CLOSE, "Thoat")
	GUICtrlCreateLabel("Thời gian xuất hiện điểm trọng tâm (ms)", 10, 10)
	$GUI_Time_DiemTrongTam = GUICtrlCreateInput("500", 200, 7, 90)
	GUICtrlCreateLabel("Thời gian làm tươi màn hình (ms)", 10, 40)
	$GUI_Time_ReFresh = GUICtrlCreateInput("4000", 200, 37, 90)
	GUICtrlCreateLabel("Thời gian ngừng biểu diễn (ms)", 10, 70)
	$GUI_Time_Ngung = GUICtrlCreateInput("10000", 200, 67, 90)
	$GUI_Button_BatDau = GUICtrlCreateButton("Bắt đầu", 100, 110, 100)
	GUICtrlSetOnEvent($GUI_Button_BatDau, "BieuDien")
	GUISetState(@SW_SHOW, $GUI_Main)
EndFunc
;Các biến thay đổi giá trị hiện hình
Func KhaiBaoBienTime()
	Global $Time_DiemTrongTam = GUICtrlRead($GUI_Time_DiemTrongTam);Thời gian để xuất hiện ngẫu nhiên 1 điểm trọng tâm mới
	Global $Time_ReFresh = GUICtrlRead($GUI_Time_ReFresh);Thời gian để làm tươi màn hình
	Global $Time_Ngung = GUICtrlRead($GUI_Time_Ngung);Thời gian ngừng biểu diễn
	Global $WidthPen = Random(1, 10);Độ rộng của nét vẽ
EndFunc
;Biểu diễn
Func BieuDien()
	KhaiBaoBienTime()
	While 1
		If TimerDiff($TimeDiemTrongTam)>=$Time_DiemTrongTam Then
			Random_DiemTrongTam()
			$TimeDiemTrongTam = TimerInit()
		EndIf
		If TimerDiff($Time_VeDT)>=0 Then
			Random_Mau()
			Random_DiemBatDau()
			VeDThang($X, $Y, $WidthPen, $Mau, 10)
			$Time_VeDT = TimerInit()
		EndIf
		If TimerDiff($TimeRefresh)>=$Time_ReFresh Then
			TimeRefresh()
			$TimeRefresh = TimerInit()
		EndIf
	WEnd
EndFunc
;Tạm ngừng
Func Pause()
	$Pause = Not $Pause
	If $Pause Then
		_WinAPI_RedrawWindow(_WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)
		Sleep($Time_Ngung)
	EndIf
EndFunc
;Thoát
Func Thoat()
	_WinAPI_RedrawWindow(_WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)
	Exit
EndFunc
;Điểm bắt đầu
Func Random_DiemBatDau()
	$X = Random(0, @DesktopWidth)
	$Y = Random(0, @DesktopHeight)
EndFunc
;Trọng tâm quay
Func Random_DiemTrongTam()
	$TrongTam_X = Random(0, @DesktopWidth)
	$TrongTam_Y = Random(0, @DesktopHeight)
EndFunc
;Màu
Func Random_Mau()
	$Mau = Random(0, 16777215)
EndFunc
;Vẽ đường thẳng
Func VeDThang($start_x, $start_y, $width, $color, $time)
    Local $hDC, $hPen, $obj_orig
	Local $start_x1, $start_y1 ;Điểm cuối
	
    $hDC = _WinAPI_GetWindowDC(0) ; DC of entire screen (desktop)
    $hPen = _WinAPI_CreatePen($PS_SOLID, $width, $color)
    $obj_orig = _WinAPI_SelectObject($hDC, $hPen)
	
	$start_x1 = (@DesktopWidth - $TrongTam_X)*2- $start_x
	$start_y1 = (@DesktopHeight - $TrongTam_Y)*2 - $start_y
    _WinAPI_DrawLine($hDC, $start_x, $start_y, $start_x1, $start_y1)
	Sleep($time) ; show cross over screen for defined seconds
	; clear resources
    _WinAPI_SelectObject($hDC, $obj_orig)
    _WinAPI_DeleteObject($hPen)
    _WinAPI_ReleaseDC(0, $hDC)
EndFunc
;Thời gian refresh màn hình
Func TimeRefresh()
	_WinAPI_RedrawWindow(_WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)
EndFunc