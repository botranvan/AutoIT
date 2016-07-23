#include "IconDock.au3"
#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)

Global $hGui = GUICreate("Set Alpha", 220, 180, 0, 0)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUICtrlCreateLabel("IconDock Transparency", 10, 10, 200, 20)
Global $hSliderAlpha = GUICtrlCreateSlider(10, 30, 200, 20)
GUICtrlSetData($hSliderAlpha, 100)
GUICtrlSetOnEvent($hSliderAlpha, "_SetAlpha")
GUICtrlCreateLabel("Shadow Transparency", 10, 50, 200, 20)
Global $hSliderShadow = GUICtrlCreateSlider(10, 70, 200, 20)
GUICtrlSetOnEvent($hSliderShadow, "_SetAlpha")
Global $hLabelX = GUICtrlCreateLabel("Shadow X Offset: -0.08", 10, 90, 200, 20)
Global $hSliderX = GUICtrlCreateSlider(10, 110, 200, 20)
GUICtrlSetData($hSliderX, 50 - 8)
GUICtrlSetOnEvent($hSliderX, "_SetOffset")
Global $hLabelY = GUICtrlCreateLabel("Shadow Y Offset: -0.12", 10, 130, 200, 20)
Global $hSliderY = GUICtrlCreateSlider(10, 150, 200, 20)
GUICtrlSetData($hSliderY, 50 - 12)
GUICtrlSetOnEvent($hSliderY, "_SetOffset")


Global $iWidth = 700
Global $iHeight = 500
Global $iIconSizeMin = 96
Global $iIconSizeMax = 192

Global $aIcon[8] = [7]
$aIcon[1] = @WindowsDir & "\explorer.exe"
$aIcon[2] = @SystemDir & "\taskmgr.exe"
$aIcon[3] = @SystemDir & "\write.exe"
$aIcon[4] = @SystemDir & "\notepad.exe"
$aIcon[5] = @SystemDir & "\osk.exe"
$aIcon[6] = @SystemDir & "\charmap.exe"
$aIcon[7] = @SystemDir & "\mspaint.exe"

Global $hIconDock = _IconDock_Create(@DesktopWidth / 2 - $iWidth / 2, @DesktopHeight / 2 - $iHeight / 2, $iWidth, $iHeight, _
		BitOR($IconDock_Align_Free, $IconDock_Center), $IconDock_Center, $iIconSizeMin, $iIconSizeMax, False)

Global $aPoints = _EllipsePoints($iWidth - $iIconSizeMax, $iHeight - $iIconSizeMax, $aIcon[0])

_IconDock_BeginUpdate($hIconDock)
For $i = 1 To $aIcon[0]
	_IconDock_IconAddFile($hIconDock, $aIcon[$i], 0, "", 0, "", $iIconSizeMax / 2 + $aPoints[$i][0] - $iIconSizeMin / 2, $iIconSizeMax / 2 + $aPoints[$i][1] - $iIconSizeMin / 2)
Next
_IconDock_EndUpdate($hIconDock)

GUISetState()

While 1
	Sleep(100)
WEnd


Func _SetAlpha()
	Local $fAlpha = GUICtrlRead($hSliderAlpha) / 100
	Local $fShadow = GUICtrlRead($hSliderShadow) / 100
	_IconDock_SetAlpha($hIconDock, $fAlpha, $fShadow)
EndFunc   ;==>_SetAlpha

Func _SetOffset()
	Local $fX = (GUICtrlRead($hSliderX) - 50) / 100
	Local $fY = (GUICtrlRead($hSliderY) - 50) / 100
	GUICtrlSetData($hLabelX, "Shadow X Offset: " & $fX)
	GUICtrlSetData($hLabelY, "Shadow Y Offset: " & $fY)
	_IconDock_SetShadowOffset($hIconDock, $fX, $fY)
EndFunc   ;==>_SetOffset

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
	_IconDock_Destroy($hIconDock)
	Exit
EndFunc   ;==>_Exit