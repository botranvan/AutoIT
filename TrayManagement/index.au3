; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


; Opt('TrayOnEventMode', 1) ;0=disable, 1=enable
Opt('TrayMenuMode', 1) ;0=append, 1=no default menu, 2=no automatic check, 4=menuitemID  not return
TraySetClick($TRAY_DBLCLICK_PRIMARY) ; Sets the clickmode of the tray icon - what mouseclicks will display the tray menu
TraySetIcon("../icons/formstudio_icon.ico") ;Loads/Sets a specified tray icon
Local  $trayControl = TrayCreateItem("Hướng dẫn")
Local  $trayTools = TrayCreateItem("Công cụ...")
Local  $trayTranserCode = TrayCreateItem("Chuyển mã nhanh")
TrayCreateItem("")
Local  $trayEnableSpellingTest = TrayCreateItem("Bật kiểm tra chính tả")
Local  $trayEnableFastEnter = TrayCreateItem('Bật tính năng gõ tắt')
Local  $trayTableFastEnter = TrayCreateItem("Soạn bảng gõ tắt...")

Local  $trayTypeEnter = TrayCreateMenu("Kiểu gõ")
Local  $traySubTypeEnter_Telex = TrayCreateItem("Telex", $trayTypeEnter)
Local  $traySubTypeEnter_VNI = TrayCreateItem("VNI", $trayTypeEnter)
Local  $traySubTypeEnter_VIQR = TrayCreateItem("VIQR", $trayTypeEnter)
Local  $traySubTypeEnter_Microsof = TrayCreateItem("Microsoft VI Layout", $trayTypeEnter)
Local  $traySubTypeEnter_TypeRandom = TrayCreateItem("Kiểu tự định nghĩa", $trayTypeEnter)
TrayCreateItem("")
Local  $trayUnicode = TrayCreateItem("Unicode dựng sẵn")
Local  $trayTCVNB = TrayCreateItem("TCVN (ABC)")
Local  $trayVNI_Windows = TrayCreateItem("VNI Windows")

Local  $trayTableDiff = TrayCreateMenu("Bảng mã khác")

TrayCreateItem("")
Local  $trayTable = TrayCreateItem("Bảng điều khiển...")
Local  $trayExit = TrayCreateItem("Kết thúc")
TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu
While True
	Switch TrayGetMsg()
		Case $trayExit
			Exit
		Case $trayEnableSpellingTest
			TrayItemSetState($trayEnableSpellingTest, $TRAY_CHECKED)
	EndSwitch
WEnd
