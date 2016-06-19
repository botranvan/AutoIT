#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự up ảnh cho trang Flixya
#ce ==========================================================

Global $AutoName = "FYImage"
Global $AutoVersion = "1.0"
Global $AutoHide = 0
Global $AutoPos[2] = [1,1]
Global $DataFileName = "Data.ini"
Global $HomePage = "http://72ls.net/"

Global $ImageList[1] = [0]
Global $CurImage = 0

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+{DEl}","ToolTipDel")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Shilf + End 	- Thoát Auto
HotKeySet("{Insert}","StartUpload")					;Insert 	- Bắt đầu
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)

#include <IE.au3>		;NoShow
#include <Array.au3>	;NoShow
#include <EditConstants.au3>	;NoShow
#include <array.au3>	;NoShow

#include "GUI.au3"
#include "GUIFunction.au3"
#include "Function.au3"

;~ AutoCheckUpdate()
LoadSetting()
MainGUIFix()
ImageGetBClick()

While 1
	Sleep(270)
WEnd