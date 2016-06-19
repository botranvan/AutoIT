#NoTrayIcon
#cs
Tác giả: Trần Tiến Thành
Tên chương trình: Hide Window
Phiên bản: 1.0
#ce
#include <GUIConstantsEx.au3>
Global $Dem = 0
Global $WinOldTitle, $WinNewTitle
Global $WinList = WinList()
Global $ArrayNewTitle[1000]
Global $ArrayOldTitle[1000]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HotKeySet("{F8}", "HideWindow")
HotKeySet("{F9}", "ShowWindow")
HotKeySet("+a", "ShowAllWindow")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GiaoDien()
While 1
   Sleep(100)
WEnd
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func GiaoDien()
   Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode
   $GiaoDien = GUICreate("Hide Window", 220, 130)
   GUISetOnEvent($GUI_EVENT_CLOSE, "Thoat")
   GUICtrlCreateLabel("F8 để ẩn cửa sổ", 10, 10)
   GUICtrlCreateLabel("F9 để hiện cửa sổ bị ẩn lần cuối cùng", 10, 30)
   GUICtrlCreateLabel("Shift + a để hiện toàn bộ cửa sổ đang ẩn", 10, 50)
   GUICtrlCreateLabel("Tác giả: thanhks2002", 10, 70)
   GUICtrlCreateLabel("Email: thanh_mvteasy@yahoo.com", 10, 90)
   GUICtrlCreateLabel("HomePage: http://nghiepdu.net", 10, 110)
   GUISetState(@SW_SHOW)
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func HideWindow()
   $WinOldTitle = WinGetTitle("[Active]")
   $ArrayOldTitle[$Dem] = $WinOldTitle
   $WinNewTitle = $WinOldTitle & " " &$Dem
   $ArrayNewTitle[$Dem] = $WinNewTitle
   WinSetTitle($WinOldTitle, "", $ArrayNewTitle[$Dem])
   WinSetState($ArrayNewTitle[$Dem], "", @SW_HIDE)
   $Dem = $Dem + 1
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func ShowWindow()
   If $Dem>0 Then
      WinSetState($ArrayNewTitle[$Dem-1], "", @SW_RESTORE)
      WinSetTitle($ArrayNewTitle[$Dem-1], "", $ArrayOldTitle[$Dem-1])
      $Dem = $Dem - 1
   Else
      $Dem = 0
   EndIf
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func ShowAllWindow()
   Do
      ShowWindow()
   Until $Dem=0
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func Thoat()
   Exit
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
