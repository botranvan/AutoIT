#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự đăng nhập Lineage2 C4 Việt Hóa
#ce ==========================================================

Global $AutoName = "Sai AL2"
Global $AutoVersion = "1.33"
Global $AutoMini = 0
Global $AutoPos[2] = [1,1]
Global $AutoPass = 1234567
Global $UserListFileName = "UserList.ini"
Global $DataFileName = "Data.ini"
Global $ModInfo
Global $MiniGUI
Global $MiniGUIPos
Global $ListGUI
Global $NoPhoto = "NoPhoto.png"
Global $HomePage = "http://autoit.72ls.net/viewtopic.php?t=1275"
Global $Testing = 0

Global $MemGame
Global $ModNameAd = "0x0CEDE2FC|0"


Global $SearchPage = "http://lineage.pmfun.com/"
Global $SearchKey = "Grave Guardian"
Global $SearchKey = "Gigant Slave"
Global $SearchKey = "Antharas"

Global $SearchType = ""
Global $SearchKeyList = IniRead($DataFileName,"KeyList","Key",$SearchKey)

Global $ProcessName = "l2.exe"
Global $GameName = "l2vn.exe"
Global $GamePid = -1
Global $GamePath = IniRead($DataFileName,"Game","Path",$GameName)
Global $GameClass = "l2UnrealWWindowsViewportWindow"
Global $LauncherTitle = "L2VN Launcher"
Global $LauncherText = "There was at least one error during the updating."
Global $LauncherText = "Ready!"
Global $GameHandle = 0

Global $Enchanting = 0
Global $WeaponPos1[2] = [523,112]
Global $OkButton[2] = [588,423]
Global $HuyButton[2] = [666,422]
Global $ChoiLai[2] = [658,489]
Global $OkChoiLai[2] = [358,333]
Global $BatDau[2] = [397,511]

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+s","Seach_BClick")					;Ctrl + Shilf + S 	- Tìm kiếm
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet ("^+t","TestControl")						;Ctrl + Shilf + T 		- Bật tắt Test
HotKeySet("+{Esc}","MainGUIClose")					;Ctrl + Shilf + End 	- Thoát Auto
HotKeySet("+{Esc}","MainGUIClose")					;Ctrl + Shilf + End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)

#include <ListviewConstants.au3>	;NoShow
#include <GDIPlus.au3> 	;NoShow
#include <Array.au3>	;NoShow
#include <String.au3>	;NoShow
#include <IE.au3>		;NoShow
#include <INet.au3>		;NoShow
#include "NomadMemory.au3"

#include "Function.au3"
#include "GUI.au3"
#include "GUIFunction.au3"

FileInstall("NoPhoto.png","NoPhoto.png")
;~ AutoCheckUpdate()
LoadUserList()
LoadSetting()
GUIFix()
Reload_BClick()
GameOpenMemory()



While 1
	Sleep(72)
	
	If $Testing Then ShowTextTest()
		
	If CharList_C_Get() <> "No Game" Then 
		$SearchKey = GameGetTarget()
		SeachKey_ISet($SearchKey)
	EndIf
	
	If $Enchanting Then EnchantProcess()
WEnd