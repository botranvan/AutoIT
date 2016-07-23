#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Chương trình đóng mở CD
#ce ==========================================================

Global $ListRom = ScanCDRom()

#include <GUI.au3>
#include <Function.au3>

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			ExitTool()
		Case $Open
			ToogleCD("open")
		Case $Close
			ToogleCD("close")
	EndSwitch
WEnd


