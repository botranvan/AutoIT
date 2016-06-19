;~ Các ví dụ về Tray Icon
#Include <Constants.au3>
#NoTrayIcon

;~ Phím nóng thoát chương trình
HotKeySet("{ESC}","ExitAuto")
Func ExitAuto()
	Exit
EndFunc

AutoItSetOption("TrayOnEventMode",1)
AutoItSetOption("TrayMenuMode",1) ;Lệnh bỏ dòng Script Paused/Exit đi

;~ Lệnh làm co Tray Icon chỉ có thể kích hoạt bằng R-Click
TraySetClick(16)

;~ Tạo 1 GUI 
$MainGUI = GUICreate("Tray Icon")
GUISetState()

$MainTray	= TrayCreateMenu("GUI")

;~ Tray Menu hiện giao diện
$MainTray_ShowGUI	= TrayCreateItem("Hiện GUI", $MainTray)
TrayItemSetOnEvent($MainTray_ShowGUI,"ShowGUI")
Func ShowGUI()
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc

;~ Tray Menu ẩn giao diện
$MainTray_HidenGUI	= TrayCreateItem("Ẩn GUI", $MainTray)
TrayItemSetOnEvent($MainTray_HidenGUI,"HideGUI")
Func HideGUI()
	GUISetState(@SW_HIDE,$MainGUI)
EndFunc

;~ Tạo dòng ngăn cách
TrayCreateItem("")

;~ Tạo Tray Menu thoát
$MainTray_ExitGUI	= TrayCreateItem("Thoát")
TrayItemSetOnEvent($MainTray_ExitGUI,"ExitAuto")

TraySetState()

;~ Tạo dòng thông báo ở Tray Icon
TrayTip("Tray Icon","Phải cuột ở đây",7,1)

While 1
	Sleep(77)
WEnd