#include "IconDock.au3"

HotKeySet("{ESC}", "_Exit")

Global $iIconSizeMin = 48
Global $iIconSizeMax = 96

Global $aIcon[8] = [7]
$aIcon[1] = @WindowsDir & "\explorer.exe"
$aIcon[2] = @SystemDir & "\taskmgr.exe"
$aIcon[3] = @SystemDir & "\write.exe"
$aIcon[4] = @SystemDir & "\notepad.exe"
$aIcon[5] = @SystemDir & "\osk.exe"
$aIcon[6] = @SystemDir & "\charmap.exe"
$aIcon[7] = @SystemDir & "\mspaint.exe"

Global $hIconDock_1 = _IconDock_Create(0, @DesktopHeight - $iIconSizeMax - $iIconSizeMin, @DesktopWidth, $iIconSizeMax + $iIconSizeMin, BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Up, $iIconSizeMin, $iIconSizeMax, True)
Global $hIconDock_2 = _IconDock_Create(0, 0, 0, 0, BitOR($IconDock_Align_Vertical, $IconDock_Center), BitOR($IconDock_Right, $IconDock_Up), $iIconSizeMin, $iIconSizeMax, True)
Global $hIconDock_3 = _IconDock_Create(0, 0, @DesktopWidth, $iIconSizeMax + $iIconSizeMin, BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Down, $iIconSizeMin, $iIconSizeMax, True)
Global $hIconDock_4 = _IconDock_Create(@DesktopWidth - $iIconSizeMax - $iIconSizeMin, 0, $iIconSizeMax + $iIconSizeMin, @DesktopHeight, BitOR($IconDock_Align_Vertical, $IconDock_Center), $IconDock_Left, $iIconSizeMin, $iIconSizeMax, True)

_IconDock_BeginUpdate($hIconDock_1)
_IconDock_BeginUpdate($hIconDock_2)
_IconDock_BeginUpdate($hIconDock_3)
_IconDock_BeginUpdate($hIconDock_4)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock_1, $aIcon[$i], 0, "_EventFunction", $IconDock_LBUTTONUP)
	_IconDock_IconAddFile($hIconDock_2, $aIcon[$i], 0, "_EventFunction", $IconDock_LBUTTONUP)
	_IconDock_IconAddFile($hIconDock_3, $aIcon[$i], 0, "_EventFunction", $IconDock_LBUTTONUP)
	_IconDock_IconAddFile($hIconDock_4, $aIcon[$i], 0, "_EventFunction", $IconDock_LBUTTONUP)
Next
_IconDock_EndUpdate($hIconDock_1)
_IconDock_EndUpdate($hIconDock_2)
_IconDock_EndUpdate($hIconDock_3)
_IconDock_EndUpdate($hIconDock_4)

While 1
	Sleep(100)
WEnd



Func _EventFunction($hID, $iIconIndex, $iEventMsg)
	Switch $hID
		Case $hIconDock_1
			ConsoleWrite("+ Icondock 1 - Index of active icon: " & $iIconIndex & @CRLF)
			Switch $iEventMsg
				Case $IconDock_LBUTTONUP
					ConsoleWrite(">    EventMsg: left mousebutton up" & @CRLF)
					ConsoleWrite("!       Run: " & $aIcon[$iIconIndex] & @CRLF)
					Run($aIcon[$iIconIndex])
			EndSwitch
		Case $hIconDock_2
			ConsoleWrite("+ Icondock 2 - Index of active icon: " & $iIconIndex & @CRLF)
		Case $hIconDock_3
			ConsoleWrite("+ Icondock 3 - Index of active icon: " & $iIconIndex & @CRLF)
		Case $hIconDock_4
			ConsoleWrite("+ Icondock 4 - Index of active icon: " & $iIconIndex & @CRLF)
	EndSwitch
EndFunc   ;==>_EventFunction


Func _Exit()
	_IconDock_Destroy($hIconDock_1)
	_IconDock_Destroy($hIconDock_2)
	_IconDock_Destroy($hIconDock_3)
	_IconDock_Destroy($hIconDock_4)
	Exit
EndFunc   ;==>_Exit