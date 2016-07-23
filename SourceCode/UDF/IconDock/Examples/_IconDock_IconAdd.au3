#include "IconDock.au3"

HotKeySet("{ESC}", "_Exit")

Global $iIconSizeMin = 80
Global $iIconSizeMax = 128

Global $hIconDock = _IconDock_Create(0, @DesktopHeight / 2, @DesktopWidth, $iIconSizeMax + $iIconSizeMin, _
		BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Center, $iIconSizeMin, $iIconSizeMax, True)

_IconDock_SetAlpha($hIconDock, 1, 0.2)
_IconDock_SetShadowOffset($hIconDock, -0.18, 0.22)

_IconDock_BeginUpdate($hIconDock)

Global $hIcon_1 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\PlayPrevious.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_1, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_2 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\FastRew.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_2, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_3 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Stop.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_3, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_4 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Play.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_4, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_5 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\FastForward.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_5, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_6 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Next.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_6, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_7 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Record.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock, $hIcon_7, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)

_IconDock_EndUpdate($hIconDock)


GUISetState()

While 1
	Sleep(100)
WEnd



Func _EventFunction($hID, $iIconIndex, $iEventMsg)
	Switch $hID
		Case $hIconDock
			Switch $iIconIndex
				Case 1
					ConsoleWrite("! Previous" & @CRLF)
				Case 2
					ConsoleWrite("! Fast Rewind" & @CRLF)
				Case 3
					ConsoleWrite("! Stop" & @CRLF)
				Case 4
					ConsoleWrite("! Play" & @CRLF)
				Case 5
					ConsoleWrite("! Fast Forward" & @CRLF)
				Case 6
					ConsoleWrite("! Next" & @CRLF)
				Case 7
					ConsoleWrite("! Record" & @CRLF)
			EndSwitch
	EndSwitch
EndFunc   ;==>_EventFunction


Func _Exit()
	_IconDock_Destroy($hIconDock)
	_WinAPI_DestroyIcon($hIcon_1)
	_WinAPI_DestroyIcon($hIcon_2)
	_WinAPI_DestroyIcon($hIcon_3)
	_WinAPI_DestroyIcon($hIcon_4)
	_WinAPI_DestroyIcon($hIcon_5)
	_WinAPI_DestroyIcon($hIcon_6)
	_WinAPI_DestroyIcon($hIcon_7)
	Exit
EndFunc   ;==>_Exit

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellExtractIcon
; Description....: Extracts the icon with the specified dimension from the specified file.
; Syntax.........: _WinAPI_ShellExtractIcon ( $sIcon, $iIndex, $iWidth, $iHeight )
; Parameters.....: $sIcon   - Path and name of the file from which the icon are to be extracted.
;                  $iIndex  - Index of the icon to extract.
;                  $iWidth  - Horizontal icon size wanted.
;                  $iHeight - Vertical icon size wanted.
; Return values..: Success  - Handle to the extracted icon.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the icon with the specified dimension is not found in the file, it will choose the nearest appropriate icon and
;                  change to the specified dimension. When you are finished using the icon, destroy it using the _WinAPI_DestroyIcon()
;                  function.
; Related........:
; Link...........: @@MsdnLink@@ SHExtractIcons
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellExtractIcon($sIcon, $iIndex, $iWidth, $iHeight)
	Local $Ret = DllCall('shell32.dll', 'int', 'SHExtractIconsW', 'wstr', $sIcon, 'int', $iIndex, 'int', $iWidth, 'int', $iHeight, 'ptr*', 0, 'ptr*', 0, 'int', 1, 'int', 0)
	If (@error) Or (Not $Ret[0]) Or (Not $Ret[5]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_ShellExtractIcon