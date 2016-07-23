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

Global $hGuiMove = GUICreate("Move", $iIconSizeMin, $iIconSizeMin, 0, 0, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_LAYERED, $WS_EX_TOPMOST, $WS_EX_TRANSPARENT))
GUISetBkColor(0x000000, $hGuiMove)
_WinAPI_SetLayeredWindowAttributes($hGuiMove, 0, 0xAA, 3)
GUISetState(@SW_HIDE, $hGuiMove)

Global $hGui = GUICreate("Drag and move icons with the right mousebutton", $iWidth, $iHeight)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

Global $hIconDock = _IconDock_Create(0, 0, $iWidth, $iHeight, _
		BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Up, $iIconSizeMin, $iIconSizeMax, True, $hGui)

_IconDock_SetOnActiveChange($hIconDock, "_MouseLeave")
_IconDock_SetOffset($hIconDock, 10)

GUISetState()

_IconDock_BeginUpdate($hIconDock)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock, $aIcon[$i], 0, "_EventFunction", BitOR($IconDock_LBUTTONUP, $IconDock_RBUTTONUP, $IconDock_RBUTTONDOWN), "", 0, 0, $IconDock_LBUTTONUP)
Next
_IconDock_EndUpdate($hIconDock)
ConsoleWrite(@CRLF & ">    Drag and move icons with the right mousebutton" & @CRLF)

Global $bMove = False
Global $iCurrent = 0
Global $hBitmap

While 1
	If $bMove Then _DrawMoveIcon()
	Sleep(50)
WEnd

Func _DrawMoveIcon()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGuiMove)
	WinMove($hGuiMove, "", MouseGetPos(0) - $iIconSizeMin / 2, MouseGetPos(1) - $iIconSizeMin / 2)
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iIconSizeMin, $iIconSizeMin)
	_GDIPlus_GraphicsDispose($hGraphics)
EndFunc   ;==>_DrawMoveIcon

Func _MouseLeave($hID, $iIconIndex)
	If $iIconIndex = 0 Then ; leave
		GUISetState(@SW_HIDE, $hGuiMove)
		_GDIPlus_BitmapDispose($hBitmap)
		$bMove = False
	EndIf
EndFunc   ;==>_MouseLeave

Func _EventFunction($hID, $iIconIndex, $iEventMsg)
	Switch $hID
		Case $hIconDock
			Switch $iEventMsg
				Case $IconDock_RBUTTONDOWN
					GUISetState(@SW_SHOW, $hGuiMove)
					$iCurrent = $iIconIndex
					$hBitmap = _IconDock_IconGetBitmap($hIconDock, $iCurrent, $GDIP_PXF32ARGB)
					$bMove = True
				Case $IconDock_RBUTTONUP
					GUISetState(@SW_HIDE, $hGuiMove)
					If $bMove Then _IconDock_IconSetIndex($hIconDock, $iCurrent, $iIconIndex)
					_GDIPlus_BitmapDispose($hBitmap)
					$bMove = False
			EndSwitch
	EndSwitch
EndFunc   ;==>_EventFunction


Func _Exit()
	_IconDock_Destroy($hIconDock)
	Exit
EndFunc   ;==>_Exit