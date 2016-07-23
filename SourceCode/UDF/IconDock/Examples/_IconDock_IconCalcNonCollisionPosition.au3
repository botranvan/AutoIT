#include "IconDock.au3"

HotKeySet("{ESC}", "_Exit")
HotKeySet("{SPACE}", "_CalcNonCollitionPositions")

Global $iWidth = 500
Global $iHeight = 500
Global $iIconSizeMin = 96
Global $iIconSizeMax = 128

Global $aIcon[8] = [7]
$aIcon[1] = @WindowsDir & "\explorer.exe"
$aIcon[2] = @SystemDir & "\taskmgr.exe"
$aIcon[3] = @SystemDir & "\write.exe"
$aIcon[4] = @SystemDir & "\notepad.exe"
$aIcon[5] = @SystemDir & "\osk.exe"
$aIcon[6] = @SystemDir & "\charmap.exe"
$aIcon[7] = @SystemDir & "\mspaint.exe"

Global $hIconDock = _IconDock_Create(@DesktopWidth / 2 - $iWidth / 2, @DesktopHeight / 2 - $iHeight / 2, $iWidth, $iHeight, _
		BitOR($IconDock_Align_Free, $IconDock_Center), $IconDock_Center, $iIconSizeMin, $iIconSizeMax, True)

_IconDock_BeginUpdate($hIconDock)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock, $aIcon[$i], 0, "_EventFunction", 0, "", $iWidth / 2 + Random(-1, 1), $iHeight / 2 + Random(-1, 1))
Next
_IconDock_EndUpdate($hIconDock)
ConsoleWrite(@CRLF & "! IconDock before CalcNonCollisionPosition" & @CRLF & ">    Press Space to CalcNonCollitionPositions" & @CRLF)


While 1
	Sleep(100)
WEnd


Func _CalcNonCollitionPositions()
	_IconDock_IconCalcNonCollisionPosition($hIconDock)
	ConsoleWrite(@CRLF & "! IconDock after CalcNonCollisionPosition" & @CRLF)
EndFunc   ;==>_CalcNonCollitionPositions


Func _EventFunction($hID, $iIconIndex, $iEventMsg)
	Switch $hID
		Case $hIconDock
			ConsoleWrite("+ Index of active icon: " & $iIconIndex & @CRLF)
			Switch $iEventMsg
				Case $IconDock_LBUTTONDOWN
					ConsoleWrite(">    EventMsg: left mousebutton down" & @CRLF)
				Case $IconDock_LBUTTONUP
					ConsoleWrite(">    EventMsg: left mousebutton up" & @CRLF)
				Case $IconDock_LBUTTONDBLCLK
					ConsoleWrite(">    EventMsg: left mousebutton double click" & @CRLF)
				Case $IconDock_RBUTTONDOWN
					ConsoleWrite(">    EventMsg: right mousebutton down" & @CRLF)
				Case $IconDock_RBUTTONUP
					ConsoleWrite(">    EventMsg: right mousebutton up" & @CRLF)
				Case $IconDock_RBUTTONDBLCLK
					ConsoleWrite(">    EventMsg: right mousebutton double click" & @CRLF)
				Case $IconDock_MBUTTONDOWN
					ConsoleWrite(">    EventMsg: middle mousebutton down" & @CRLF)
				Case $IconDock_MBUTTONUP
					ConsoleWrite(">    EventMsg: middle mousebutton up" & @CRLF)
				Case $IconDock_MBUTTONDBLCLK
					ConsoleWrite(">    EventMsg: middle mousebutton double click" & @CRLF)
			EndSwitch
	EndSwitch
EndFunc   ;==>_EventFunction


Func _Exit()
	_IconDock_Destroy($hIconDock)
	Exit
EndFunc   ;==>_Exit