#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Mẫu GUI
#ce ==========================================================

Global $AutoName = "aFate"
Global $AutoVersion = "1.012"
Global $AutoHide = 0
Global $Testing = 10
Global $AutoPos[2] = [1,1]
Global $DataFileName = "Data.ini"
Global $HomePage = "http://hocautoit.com/"

;Các thông số game Fate
Global $GameTitle = "[TITLE:FATE; CLASS:FATE]"
Global $GameHandle = 0
Global $GameMem = 0

Global $CurHPAd = 0x0CCAF614
Global $MaxHPAd = $CurHPAd+0x4
Global $GoldAd = $CurHPAd-0x5AC



;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+{DEl}","ToolTipDel")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Shilf + End 	- Thoát Auto
HotKeySet("^+t","TestingSet")						;Ctrl + Shilf + T 		- Trạng Thái Thử Nghiệm
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)

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
	Sleep(270)
	CheckGame()
	LGold_Set(GameGetScores())
	CurHPL_Set(GameGetCurHP())
	MaxHPL_Set(GameGetMaxHP())
	AutoHeal()
WEnd


