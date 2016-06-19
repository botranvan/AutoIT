#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự up dữ liệu lên website Hoàng Gia Cát
#ce ==========================================================

Global $AutoName = "aCollector"
Global $AutoVersion = "1.1"
Global $AutoHide = 0
Global $Testing = 0
Global $AutoPos[2] = [1,1]
Global $DataFileName = "Data.ini"
Global $HomePage = "http://72ls.net/"

Global $Finding = 0
Global $ImagePerPage = 18
Global $FindingStart = $ImagePerPage * 0

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+{DEl}","ToolTipDel")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Shilf + End 	- Thoát Auto
HotKeySet("^+t","TestingSet")						;Ctrl + Shilf + T 		- Trạng Thái Thử Nghiệm
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)

#include <IE.au3>		;NoShow
#include <Array.au3>	;NoShow
#include <String.au3>	;NoShow

#include "GUI.au3"
#include "GUIFunction.au3"
#include "Function.au3"

;~ AutoCheckUpdate()
LoadSetting()
MainGUIFix()

While 1
	Sleep(270)
		
	If $Finding Then DownloadProcess()
WEnd