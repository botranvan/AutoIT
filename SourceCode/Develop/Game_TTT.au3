#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Trần Tiến Thành

 Script Function:
	Game TTT

#ce ----------------------------------------------------------------------------

#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <WinAPI.au3>

HotKey()
GUI_Main()
Khai_Bao_Bien()
StartPlay()
While 1
	LuatChoi()
WEnd
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Khai báo HotKey
Func HotKey()
	HotKeySet("{Left}", "Player_Left")
	HotKeySet("{Right}", "Player_Right")
	HotKeySet("{Space}", "StartPlay")
EndFunc
;Khai báo biến
Func Khai_Bao_Bien()
	;Các biến liên quan đến bút vẽ
	Global $hDC, $hPen, $obj_orig
	;Các biến liên quan đên Ván đẩy bóng
	Global $Player_Width = 20
	Global $Player_Color = 1
	Global $Player_VanToc = 30
	Global $Player_x = Int(Random(0, ($GUI_Main_Width - $Player_Width), 1))
	Global $Player_y = Int($GUI_Main_Height - $GUI_Main_Height/10)
	Global $Player_x1 = Int($Player_x + $GUI_Main_Width/10)
	Global $Player_y1
	;Các biến liên quan đến Bóng
	Global $Bong_Width
	Global $Bong_Color = Int(Random(Dec(0), Dec(0xFFFFFF), 1))
	Global $Bong_start_x = Int(($Player_x + $Player_x1)/2)
	Global $Bong_start_y = Int($Player_y - 20)
	Global $Bong_start_x1
	Global $Bong_start_y1
	;Các biến liên quan đến sự di chuyển của bóng
	Global $Dec_x = Random(1, 3, 1) ;Di chuyển theo trục hoành
	Global $Dec_y = Random(1, 3, 1) ;Di chuyển theo trục tung
	;Các biến lưu trữ
	Global $Mem_x, $Mem_y
	;Các biến thời gian
	Global $Time_Refresh = 10
	;Điểm
	Global $Diem = 0
EndFunc
;Giao diện trò chơi
Func GUI_Main()
	;GUI
	Global $GUI_Main, $GUI_Main_Width, $GUI_Main_Height
	Global $GUI_Pos
	Opt("SendKeyDelay", 1)          
	Opt("SendKeyDownDelay", 1)
	Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode 
	$GUI_Main = GUICreate("Game TTT", @DesktopWidth/2, @DesktopHeight/2, -1, -1, $WS_POPUP)
	GUISetOnEvent($GUI_EVENT_CLOSE, "Thoat")
	GUISetState(@SW_SHOW)
	$GUI_Main_Width = _WinAPI_GetWindowWidth($GUI_Main)
	$GUI_Main_Height = _WinAPI_GetWindowHeight($GUI_Main)
	$GUI_Pos = WinGetPos("Game TTT")
EndFunc
;Bút vẽ
Func But_Ve($start_x, $start_y, $start_x1, $start_y1, $width, $color)
    $hDC = _WinAPI_GetWindowDC($GUI_Main) ; DC of entire screen (desktop)
    $hPen = _WinAPI_CreatePen($PS_SOLID, $width, $color)
    $obj_orig = _WinAPI_SelectObject($hDC, $hPen)
	_WinAPI_DrawLine($hDC, $start_x, $start_y, $start_x1, $start_y1)
	_WinAPI_SelectObject($hDC, $obj_orig)
    _WinAPI_DeleteObject($hPen)
    _WinAPI_ReleaseDC(0, $hDC)
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Ván đẩy bóng
Func Player()
	$Player_x1 = Int($Player_x + $GUI_Main_Width/10)
	$Player_y1 = Int($Player_y)
	But_Ve($Player_x, $Player_y, $Player_x1, $Player_y1, $Player_Width, $Player_Color)
EndFunc
;Ván đẩy bóng di chuyển sang trái
Func Player_Left()
	If $Player_x <= (0 + $GUI_Main_Width/10 - $Player_Width/2) Then $Player_x = 0 + $GUI_Main_Width/10 - $Player_Width/2
	$Player_x = $Player_x - $Player_VanToc
	_WinAPI_RedrawWindow($GUI_Main)
	Sleep(10)
EndFunc
;Ván đẩy bóng di chuyển sang phải
Func Player_Right()
	If $Player_x >= ($GUI_Main_Width - 2*$GUI_Main_Width/10 + $Player_Width/2) Then $Player_x = ($GUI_Main_Width - 2*$GUI_Main_Width/10 + $Player_Width/2)
	$Player_x = $Player_x + $Player_VanToc
	_WinAPI_RedrawWindow($GUI_Main)
	Sleep(10)
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bóng
Func Qua_Bong()
	$Bong_Width = 20
	$Bong_Color = Int(Random(Dec(0), Dec(0xFFFFFF), 1))	
	$Bong_start_x1 = $Bong_start_x
	$Bong_start_y1 = $Bong_start_y
	But_Ve($Bong_start_x, $Bong_start_y, $Bong_start_x1, $Bong_start_y1, $Bong_Width, $Bong_Color)
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Thoát
Func Thoat()
	_WinAPI_RedrawWindow($GUI_Main)
	; clear resources
    _WinAPI_SelectObject($hDC, $obj_orig)
    _WinAPI_DeleteObject($hPen)
    _WinAPI_ReleaseDC(0, $hDC)
	Exit
EndFunc
;________________________________________________________________________________________________________
;Giao bóng
Func StartPlay()
	$Dec_x = Random(1, 3)
	$Dec_y = Random(1, 3)
	$Bong_start_x = Int(($Player_x + $Player_x1)/2)
	$Bong_start_y = Int($Player_y - 20)
	Do
		Memory()
		$Bong_start_x = Int($Bong_start_x - $Dec_x)
		$Bong_start_y = Int($Bong_start_y + $Dec_y)
		Time_Refresh()
	Until ($Bong_start_x<=0 Or $Bong_start_y>=Int($Player_y-$Player_Width))
EndFunc
;Luật chơi
Func LuatChoi()
	Select
	;Bóng chạm cạnh trên
	Case $Bong_start_y<=0 
		If $Mem_x<$Bong_start_x Then ;Trái lên
			Do
				Memory()
				$Bong_start_x = Int($Bong_start_x + $Dec_x)
				$Bong_start_y = Int($Bong_start_y + $Dec_y)
				Time_Refresh()
			Until ($Bong_start_x>=$GUI_Main_Width Or $Bong_start_y>=Int($Player_y-$Player_Width))
		Else ;Phải lên
			Do
				Memory()
				$Bong_start_x = Int($Bong_start_x - $Dec_x)
				$Bong_start_y = Int($Bong_start_y + $Dec_y)
				Time_Refresh()
			Until ($Bong_start_x<=0 Or $Bong_start_y>=Int($Player_y-$Player_Width))	
		EndIf
	;Bóng chạm cạnh phải
	Case $Bong_start_x >= $GUI_Main_Width
		If $Mem_y<$Bong_start_y Then ;Trên xuống
			Do
				Memory()
				$Bong_start_x = Int($Bong_start_x - $Dec_x)
				$Bong_start_y = Int($Bong_start_y + $Dec_y)
				Time_Refresh()
			Until ($Bong_start_x<=0 Or $Bong_start_y>=Int($Player_y-$Player_Width))	
		Else ;Dưới lên
			Do
				Memory()
				$Bong_start_x = Int($Bong_start_x - $Dec_x)
				$Bong_start_y = Int($Bong_start_y - $Dec_y)
				Time_Refresh()
			Until ($Bong_start_x<=0 Or $Bong_start_y<=0)	
		EndIf
	;Bóng chạm cạnh trái
	Case $Bong_start_x <= 0
		If $Mem_y<$Bong_start_y Then ;Phải xuống
			Do
				Memory()
				$Bong_start_x = Int($Bong_start_x + $Dec_x)
				$Bong_start_y = Int($Bong_start_y + $Dec_y)
				Time_Refresh()
			Until ($Bong_start_x>=$GUI_Main_Width Or $Bong_start_y>=Int($Player_y-$Player_Width))
		Else ;Dưới lên
			Do
				Memory()
				$Bong_start_x = Int($Bong_start_x + $Dec_x)
				$Bong_start_y = Int($Bong_start_y - $Dec_y)
				Time_Refresh()
			Until ($Bong_start_x>=$GUI_Main_Width Or $Bong_start_y<=0)
		EndIf
	;Bóng chạm ván
	Case $bong_start_y >= Int($Player_y-$Player_Width)
		If ($Player_x-$Player_Width/2)<=$bong_start_x Then
			If $bong_start_x<=($Player_x1+$Player_Width/2) Then
				ToolTip("Trúng kìa thêm điểm: "&$Diem, $GUI_Pos[0], $GUI_Pos[1])
				ChamVan()
				$Diem = $Diem + 1
			Else
				ChamVan()
				$Diem = $Diem - 5
				ToolTip("Trượt kìa trừ điểm: "&$Diem, $GUI_Pos[0], $GUI_Pos[1])
			EndIf
		Else
			MsgBox(0, "Thong bao", "Có quả bóng mà cũng không đỡ được, gà vật vã!!!")
			Thoat()
		EndIf
	Case Else	
		MsgBox(0, "Thong bao", "Có quả bóng mà cũng không đỡ được, gà vật vã!!!")
		Thoat()
	EndSelect
EndFunc
;Chạm ván
Func ChamVan()
	If $Mem_x<$Bong_start_x Then ;Trái xuống
		Do
			Memory()
			$Dec_x = 1001*$Dec_x/1000
			$Dec_y = 1001*$Dec_y/1000
			$Bong_start_x = Int($Bong_start_x + $Dec_x)
			$Bong_start_y = Int($Bong_start_y - $Dec_y)
			Time_Refresh()
		Until ($Bong_start_x>=$GUI_Main_Width Or $Bong_start_y<=0)	
	Else ;Phải xuống
		Do
			Memory()
			$Dec_x = 1001*$Dec_x/1000
			$Dec_y = 1001*$Dec_y/1000
			$Bong_start_x = Int($Bong_start_x - $Dec_x)
			$Bong_start_y = Int($Bong_start_y - $Dec_y)
			Time_Refresh()
		Until ($Bong_start_x<=0 Or $Bong_start_y<=0)		
	EndIf
EndFunc
;Memory
Func Memory()
	Player()
	Qua_Bong()
	$Mem_x = $Bong_start_x 
	$Mem_y = $Bong_start_y
EndFunc
;Tần suất làm tươi
Func Time_Refresh()
	Sleep($Time_Refresh)
	_WinAPI_RedrawWindow($GUI_Main)
EndFunc