#include "IconDock.au3"
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $iWidth = 800
Global $iHeight = 200
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

Opt("GUIOnEventMode", 1)

Global $hGui = GUICreate("Resize window", $iWidth, $iHeight, Default, Default, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

Global $hIconDock = _IconDock_Create(0, 0, $iWidth, $iHeight, _
		BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Up, $iIconSizeMin, $iIconSizeMax, True, $hGui)

_IconDock_SetOffset($hIconDock, 10)

GUISetState()

_IconDock_BeginUpdate($hIconDock)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock, $aIcon[$i])
Next
_IconDock_EndUpdate($hIconDock)
ConsoleWrite(@CRLF & ">    Resize window" & @CRLF)

GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

While 1
	Sleep(50)
WEnd


Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	Switch $hWnd
		Case $hGui
			Local $tRect = _WinAPI_GetClientRect($hWnd)

			Local $iX = DllStructGetData($tRect, 1)
			Local $iY = DllStructGetData($tRect, 2)
			Local $iW = DllStructGetData($tRect, 3)
			Local $iH = DllStructGetData($tRect, 4)

			_IconDock_SetPos($hIconDock, $iX, $iY, $iW, $iH)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE


Func WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam)
	Local $MinMax = DllStructCreate("int ptReserved[2]; int ptMaxSize[2]; int ptMaxPosition[2]; int ptMinTrackSize[2]; int ptMaxTrackSize[2];", $lParam)
	DllStructSetData($MinMax, 4, $iIconSizeMin*3, 1)
	DllStructSetData($MinMax, 4, $iIconSizeMax+$iIconSizeMin, 2)
	DllStructSetData($MinMax, 5, 1000, 1)
	DllStructSetData($MinMax, 5, 800, 2)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_GETMINMAXINFO


Func _Exit()
	_IconDock_Destroy($hIconDock)
	Exit
EndFunc   ;==>_Exit