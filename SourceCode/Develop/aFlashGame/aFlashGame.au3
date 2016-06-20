#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Mẫu GUI
#ce ==========================================================

Global $AutoName = "aFlashGame"
Global $AutoVersion = "1.0"
Global $AutoHide = 0
Global $AutoPos[2] = [1,1]
Global $AutoSize[2] = [600,450]
Global $DataFileName = "Data.ini"
Global $HomePage = "http://72ls.net/"

Global $FlashName = "Báu Vật Rừng Xanh"


;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+{DEl}","ToolTipDel")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Ctrl + Shilf + End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)
Opt("GUIResizeMode",576)

#include <IE.au3>		;NoShow
#include <Array.au3>	;NoShow

#include "GUI.au3"
#include "GUIFunction.au3"
#include "Function.au3"

;~ AutoCheckUpdate()
FlashFileInstall()
LoadSetting()
MainGUIFix()
FlashCreateCtrl()

While 1
	Sleep(270)
WEnd