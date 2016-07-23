#include "IconDock.au3"

HotKeySet("{ESC}", "_Exit")

Global $iIconSizeMin = 64
Global $iIconSizeMax = 128

Global $aIcon[8] = [7]
$aIcon[1] = @WindowsDir & "\explorer.exe"
$aIcon[2] = @SystemDir & "\taskmgr.exe"
$aIcon[3] = @SystemDir & "\write.exe"
$aIcon[4] = @SystemDir & "\notepad.exe"
$aIcon[5] = @SystemDir & "\osk.exe"
$aIcon[6] = @SystemDir & "\charmap.exe"
$aIcon[7] = @SystemDir & "\mspaint.exe"

Global $hIconDock = _IconDock_Create(0, @DesktopHeight - $iIconSizeMax - $iIconSizeMin, @DesktopWidth, $iIconSizeMax + $iIconSizeMin, BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Up, $iIconSizeMin, $iIconSizeMax, True)
_IconDock_SetOnActiveChange($hIconDock, "_MouseLeave")

_IconDock_BeginUpdate($hIconDock)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock, $aIcon[$i], 0, "_EventFunction", $IconDock_LBUTTONUP)
Next
_IconDock_EndUpdate($hIconDock)


Global $iFade = 1

While 1
	Sleep(100)
	If Not $iFade And MouseGetPos(1) >= @DesktopHeight - 2 Then _IconDock_Fade($hIconDock, $iFade)
WEnd


Func _MouseLeave($hID, $iIconIndex)
	If $iFade And $iIconIndex = 0 Then _IconDock_Fade($hIconDock, $iFade)
EndFunc   ;==>_MouseLeave

Func _Exit()
	_IconDock_Destroy($hIconDock)
	Exit
EndFunc   ;==>_Exit