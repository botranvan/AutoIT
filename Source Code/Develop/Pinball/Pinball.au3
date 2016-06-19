#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Mẫu GUI
#ce ==========================================================

Global $AutoName = ""
Global $AutoVersion = "1.01"
Global $AutoHide = 0
Global $Testing = 10
Global $AutoPos[2] = [1,1]
Global $DataFileName = "Data.ini"
Global $HomePage = "http://hocautoit.com/"

;Các thông số game Fate
Global $GameTitle = "3D Pinball"
Global $GameHandle = 0
Global $GameMem = 0
Global $GoldAd = 0x00B44E4C

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+{DEl}","ToolTipDel")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Shilf + End 	- Thoát Auto
HotKeySet("^+t","TestingSet")						;Ctrl + Shilf + T 		- Trạng Thái Thử Nghiệm
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)
Opt("SendKeyDownDelay",50)

#include <IE.au3>			;NoShow
#include <Array.au3>		;NoShow
#include <NomadMemory.au3>	;NoShow

#include "GUI.au3"
#include "GUIFunction.au3"
#include "Function.au3"

;~ AutoCheckUpdate()
LoadSetting()
MainGUIFix()

While 1
	Sleep(72)
	CheckGame()
	LGold_Set(GameGetScores())
	GameAutoPlay()
WEnd


