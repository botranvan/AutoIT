#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự đăng nhập Lineage2 C4 Việt Hóa
#ce ==========================================================

Global $AutoName = "Sai AL2"
Global $AutoVersion = "1.2"
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
Global $GameClass="l2UnrealWWindowsViewportWindow"
Global $LauncherTitle = "L2VN Launcher"
Global $LauncherText = "There was at least one error during the updating."
Global $LauncherText = "Ready!"


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

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+s","Seach_BClick")					;Ctrl + Shilf + S 	- Tìm kiếm
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Ctrl + Shilf + End 	- Thoát Auto
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

FileInstall("NoPhoto.png","NoPhoto.png")
;~ AutoCheckUpdate()
LoadUserList()
LoadSetting()
GUIFix()
Reload_BClick()
GameOpenMemory()



While 1
	Sleep(270)

	If CharList_C_Get() <> "No Game" Then
		$SearchKey = GameGetTarget()
		SeachKey_ISet($SearchKey)
	EndIf
WEnd