#include-once
#include <Misc.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>

; Thanks for Melba23 about rectangle example

Func _IMGSearch_Create_BMP($Filename)
	Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
	Local $UserDLL = DllOpen("user32.dll")

	; Create transparent GUI with Cross cursor
	Local $hCross_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, 0x80000000, BitAND(0x00000080, 0x00000008))
	WinSetTrans($hCross_GUI, "", 8)
	GUISetState(@SW_SHOW, $hCross_GUI)
	GUISetCursor(3, 1, $hCross_GUI)

	Local $hRectangle_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, 0x80000000, BitAND(0x00000080, 0x00000008))
	GUISetBkColor(0x000000)

	; Wait until mouse button pressed
	While Not _IsPressed("01", $UserDLL)
		If _IsPressed("1B", $UserDLL) Then
			GUIDelete($hRectangle_GUI)
			GUIDelete($hCross_GUI)
			DllClose($UserDLL)
			Return -2
		EndIf

		Sleep(10)
	WEnd

	; Get first mouse position
	Local $aMouse_Pos = MouseGetPos()
	Local $iX1 = $aMouse_Pos[0]
	Local $iY1 = $aMouse_Pos[1]
	; Draw rectangle while mouse button pressed
	While _IsPressed("01", $UserDLL)

		$aMouse_Pos = MouseGetPos()

		$hMaster_Mask = _WinAPI_CreateRectRgn(0, 0, 0, 0)
		$hMask = _WinAPI_CreateRectRgn($iX1, $aMouse_Pos[1], $aMouse_Pos[0], $aMouse_Pos[1] + 1) ; Bottom of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		$hMask = _WinAPI_CreateRectRgn($iX1, $iY1, $iX1 + 1, $aMouse_Pos[1]) ; Left of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		$hMask = _WinAPI_CreateRectRgn($iX1 + 1, $iY1 + 1, $aMouse_Pos[0], $iY1) ; Top of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		$hMask = _WinAPI_CreateRectRgn($aMouse_Pos[0], $iY1, $aMouse_Pos[0] + 1, $aMouse_Pos[1]) ; Right of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		; Set overall region
		_WinAPI_SetWindowRgn($hRectangle_GUI, $hMaster_Mask)

		If WinGetState($hRectangle_GUI) < 15 Then GUISetState()
		Sleep(10)

	WEnd

	; Get second mouse position
	$iX2 = $aMouse_Pos[0]
	$iY2 = $aMouse_Pos[1]

	; Set in correct order if required
	If $iX2 < $iX1 Then
		$iTemp = $iX1
		$iX1 = $iX2
		$iX2 = $iTemp
	EndIf
	If $iY2 < $iY1 Then
		$iTemp = $iY1
		$iY1 = $iY2
		$iY2 = $iTemp
	EndIf
	GUIDelete($hRectangle_GUI)
	GUIDelete($hCross_GUI)
	DllClose($UserDLL)
	Local $mouse = MouseGetPos() ; remove mouse to other
	MouseMove($mouse[0] + 10, $mouse[1] + 10)
	Sleep(1000)
	_GDIPlus_Startup()
	Local $hHBitmap = _ScreenCapture_Capture("", $iX1, $iY1, $iX2, $iY2)
	$hImage1 = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
	_GDIPlus_ImageSaveToFile($hImage1, $Filename)
	_GDIPlus_Shutdown()
;~ 	$hHBitmap = _ScreenCapture_Capture("test3.bmp", $iX1, $iY1, $iX2, $iY2)
EndFunc   ;==>_IMGSearch_Create_BMP
