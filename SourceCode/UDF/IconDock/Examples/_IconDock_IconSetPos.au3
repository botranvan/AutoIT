#include "IconDock.au3"
#include <GUIConstantsEx.au3>

HotKeySet("{ESC}", "_Exit")

Global $iWidth = 600
Global $iHeight = 400
Global $iIconSizeMin = 64
Global $iIconSizeMax = 96

Global $aIcon[8] = [7]
$aIcon[1] = @WindowsDir & "\explorer.exe"
$aIcon[2] = @SystemDir & "\taskmgr.exe"
$aIcon[3] = @SystemDir & "\write.exe"
$aIcon[4] = @SystemDir & "\notepad.exe"
$aIcon[5] = @SystemDir & "\osk.exe"
$aIcon[6] = @SystemDir & "\charmap.exe"
$aIcon[7] = @SystemDir & "\mspaint.exe"

Global $hIconDock_1 = _IconDock_Create(@DesktopWidth / 2 - $iWidth / 2, @DesktopHeight / 2 - $iHeight / 2, $iWidth, $iHeight, _
		BitOR($IconDock_Align_Free, $IconDock_Center), $IconDock_Center, $iIconSizeMin, $iIconSizeMax, False)

Global $hIconDock_2 = _IconDock_Create(@DesktopWidth / 2 - $iWidth / 2, @DesktopHeight / 2 + $iHeight / 2 - $iIconSizeMax, $iWidth, $iIconSizeMax + $iIconSizeMin, _
		BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Center, $iIconSizeMin, $iIconSizeMax, True)

Global $aPoints = _EllipsePoints($iWidth - $iIconSizeMax * 2, $iHeight - $iIconSizeMax * 2, $aIcon[0])

_IconDock_BeginUpdate($hIconDock_1)
_IconDock_BeginUpdate($hIconDock_2)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock_1, $aIcon[$i], 0, "", 0, "", $iIconSizeMax / 2 + $aPoints[$i][0], $iIconSizeMax / 2 + $aPoints[$i][1])
Next

Global $hIcon_1 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\PlayRev.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock_2, $hIcon_1, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_2 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Plus.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock_2, $hIcon_2, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_3 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Minus.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock_2, $hIcon_3, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
Global $hIcon_4 = _WinAPI_ShellExtractIcon(@ScriptDir & "\Buttons\Play.ico", 0, $iIconSizeMax, $iIconSizeMax)
_IconDock_IconAdd($hIconDock_2, $hIcon_4, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)

_IconDock_EndUpdate($hIconDock_1)
_IconDock_EndUpdate($hIconDock_2)

GUISetState()

While 1
	Sleep(100)
WEnd



Func _EventFunction($hID, $iIconIndex, $iEventMsg)
	Local Static $iIndex = $aIcon[0]
	Switch $hID
		Case $hIconDock_2
			Switch $iIconIndex
				Case 1
					_IconDock_IconSetIndex($hIconDock_1, 1, $iIndex)
				Case 2
					Local $sFile = FileOpenDialog("Select Iconfile", "", "(*.exe;*.dll;*.ico)", 1, "", $hID)
					If Not @error And FileExists($sFile) Then
						$iIndex += 1
						$aPoints = _EllipsePoints($iWidth - $iIconSizeMax * 2, $iHeight - $iIconSizeMax * 2, $iIndex)
						_IconDock_IconAddFile($hIconDock_1, $sFile)
						For $i = 1 To $aPoints[0][0]
							_IconDock_IconSetPos($hIconDock_1, $i, $iIconSizeMax / 2 + $aPoints[$i][0], $iIconSizeMax / 2 + $aPoints[$i][1])
						Next
					EndIf
				Case 3
					If $iIndex > 2 Then
						Local $iNumber = InputBox("enter IconIndex to remove", "enter a number between 1 and " & $iIndex, 1, "", 300, 100, 0, 0, 0, $hID)
						If $iNumber > 0 And $iNumber <= $iIndex Then
							$iIndex -= 1
							$aPoints = _EllipsePoints($iWidth - $iIconSizeMax * 2, $iHeight - $iIconSizeMax * 2, $iIndex)
							Local $iCnt = 0
							For $i = 1 To $aPoints[0][0]
								$iCnt += 1
								If $i = $iNumber Then $iCnt += 1
								_IconDock_IconSetPos($hIconDock_1, $iCnt, $iIconSizeMax / 2 + $aPoints[$i][0], $iIconSizeMax / 2 + $aPoints[$i][1])
							Next
							_IconDock_IconRemove($hIconDock_1, $iNumber)
						EndIf
					EndIf
				Case 4
					_IconDock_IconSetIndex($hIconDock_1, $iIndex, 1)
			EndSwitch
	EndSwitch
EndFunc   ;==>_EventFunction



Func _EllipsePoints($iW, $iH, $iP)
	Local $iCnt = 0
	Local $pi = ATan(1) * 4
	Local $degToRad = $pi / 180
	Local $aPoints[$iP + 1][3] = [[$iP]]
	For $i = 1 To $iP
		$aPoints[$i][2] = $i * 360 / $iP
		$aPoints[$i][0] = Cos($aPoints[$i][2] * $degToRad) * $iW / 2 + $iW / 2
		$aPoints[$i][1] = Sin($aPoints[$i][2] * $degToRad) * $iH / 2 + $iH / 2
	Next
	Local $iD1, $iD2, $iX1, $iY1, $iX2, $iY2, $iMax, $iMin, $iDiff, $fW = 1
	Do
		$iCnt += 1
		$iDiff = $iMax - $iMin
		$iMax = 0
		$iMin = $iW
		For $i = 1 To $iP
			Switch $i
				Case 1
					$iX1 = $aPoints[$iP][0]
					$iY1 = $aPoints[$iP][1]
					$iX2 = $aPoints[$i + 1][0]
					$iY2 = $aPoints[$i + 1][1]
				Case $iP
					$iX1 = $aPoints[$i - 1][0]
					$iY1 = $aPoints[$i - 1][1]
					$iX2 = $aPoints[1][0]
					$iY2 = $aPoints[1][1]
				Case Else
					$iX1 = $aPoints[$i - 1][0]
					$iY1 = $aPoints[$i - 1][1]
					$iX2 = $aPoints[$i + 1][0]
					$iY2 = $aPoints[$i + 1][1]
			EndSwitch
			$iD1 = Sqrt(Abs($iX1 - $aPoints[$i][0]) ^ 2 + Abs($iY1 - $aPoints[$i][1]) ^ 2)
			$iD2 = Sqrt(Abs($iX2 - $aPoints[$i][0]) ^ 2 + Abs($iY2 - $aPoints[$i][1]) ^ 2)
			If $iD1 > $iMax Then $iMax = $iD1
			If $iD2 > $iMax Then $iMax = $iD2
			If $iD1 < $iMin Then $iMin = $iD1
			If $iD2 < $iMin Then $iMin = $iD2
			If $iD1 > $iD2 Then
				$aPoints[$i][2] -= $fW
			Else
				$aPoints[$i][2] += $fW
			EndIf
			$aPoints[$i][0] = Round(Cos($aPoints[$i][2] * $degToRad) * $iW / 2) + $iW / 2
			$aPoints[$i][1] = Round(Sin($aPoints[$i][2] * $degToRad) * $iH / 2) + $iH / 2
		Next
		$fW /= 1.01
	Until $iMax - $iMin = $iDiff Or $iCnt > 500
	Return $aPoints
EndFunc   ;==>_EllipsePoints


Func _Exit()
	_IconDock_Destroy($hIconDock_1)
	_IconDock_Destroy($hIconDock_2)
	_WinAPI_DestroyIcon($hIcon_1)
	_WinAPI_DestroyIcon($hIcon_2)
	_WinAPI_DestroyIcon($hIcon_3)
	_WinAPI_DestroyIcon($hIcon_4)
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