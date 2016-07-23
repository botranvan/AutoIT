#include-once
#include <WindowsConstants.au3>
#include <ToolTipConstants.au3>
#include <FontConstants.au3>
#include <Constants.au3>

Global Const $CW_USEDEFAULT   = 0x80000000
Global Const $TOOLTIPS_CLASSA = "tooltips_class32"
Global Const $TTDT_AUTOPOP = 2
Global Const $SHRT_MAX = 32767

Global $hToolTip = False
Global $TOOLINFO
Global $LastHwnd

Global $aControl[1]       = [0]
Global $aText[1]          = [0]
Global $aTitle[1]      	  = [0]
Global $aIcon[1]          = [0]
Global $aTextColor[1]     = [0]
Global $aBkColor[1]       = [0]
Global $aFontSize[1]      = [0]
Global $aFontWeight[1]    = [0]
Global $aFontAtrrib[1]    = [0]
Global $aFont[1]          = [0]

Global $TimerProcHandle = DllCallbackRegister("_TimerProc", "none", "hwnd;int;int;dword")

Global $TimerCall = DllCall("user32.dll", "int", "SetTimer", "hwnd", 0, "int", 0, "int", 100, _
							"ptr", DllCallbackGetPtr($TimerProcHandle))
$TimerCall = $TimerCall[0]

; #FUNCTION# =============================================================
; Name............: _ToolTip_SetText
; Description.....: Sets the tooltip text associated with a control
; Syntax..........: _ToolTip_SetText($hControl, $sText, $sTitle = "", $sIcon = 0)
; Parameter(s)....: $hControl - The control identifier or handle
;					$sText    - Tip text that will be displayed when the mouse is hovered over the control
;					$sTitle	  - [optional] The title for the tooltip Requires IE5+
;					$sIcon	  - [optional] The icon for the tooltip
;					+0 = No icon, 1 = Info icon, 2 = Warning icon, 3 = Error icon 7 = Question icon Requires IE5+
; Return value(s).: Success - None
;					Failure - Sets @error to 1 and returns 0 if $sText param contains a empty string
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_SetText($hControl, $sText, $sTitle = "", $sIcon = 0)
	If $sText = "" Then Return SetError(1, 0, 0)
	
	If $hToolTip = False Then $hToolTip = _ToolTip_Create()
	If Not IsHWnd($hControl) Then $hControl = GUICtrlGetHandle($hControl)
	
	Local $iElement = _FindControl($hControl)
	
	$aTitle[$iElement] = $sTitle
	$aIcon[$iElement] = $sIcon
	
	Local $tBuffer = DllStructCreate("char[256]")
	DllStructSetData($tBuffer, 1, $sText)
	
	DllStructSetData($TOOLINFO, "uId", $hControl)
	DllStructSetData($TOOLINFO, "lpszText", DllStructGetPtr($tBuffer))
	
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $hToolTip, "int", $TTM_ADDTOOL, "int", 0, _
	        "ptr", DllStructGetPtr($TOOLINFO))
EndFunc

; #FUNCTION# =============================================================
; Name............: _ToolTip_SetTextColor
; Description.....: Sets the color of text in the tooltip
; Syntax..........: _ToolTip_SetTextColor($hControl, $sColor)
; Parameter(s)....: $hControl - The control identifier or handle
;					$sColor   - The color expression in HEX value
; Return value(s).: Success - None
;					Failure - Sets @error to 1 and returns 0 if $sColor param contains a empty string
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_SetTextColor($hControl, $sColor)
	$sColor = Number($sColor)
	
	If $hToolTip = False Then $hToolTip = _ToolTip_Create()
	If Not IsHWnd($hControl) Then $hControl = GUICtrlGetHandle($hControl)
	
	Local $iElement = _FindControl($hControl)
	$aTextColor[$iElement] = _RGB2BGR($sColor)
EndFunc

; #FUNCTION# =============================================================
; Name............: _ToolTip_SetBkColor
; Description.....: Sets the background color of the tooltip window
; Syntax..........: _ToolTip_SetBkColor($hControl, $sColor)
; Parameter(s)....: $hControl - The control identifier or handle
;					$sColor   - The color expression in HEX value
; Return value(s).: Success - None
;					Failure - Sets @error to 1 and returns 0 if $sColor param contains a empty string
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_SetBkColor($hControl, $sColor)
	$sColor = Number($sColor)
	
	If $hToolTip = False Then $hToolTip = _ToolTip_Create()
	If Not IsHWnd($hControl) Then $hControl = GUICtrlGetHandle($hControl)
	
	Local $iElement = _FindControl($hControl)
	$aBkColor[$iElement] = _RGB2BGR($sColor)
EndFunc

; #FUNCTION# =============================================================
; Name............: _ToolTip_SetFont
; Description.....: Sets the font size, weight, attributes and font name for a tooltip text
; Syntax..........: _ToolTip_SetFont($hControl, $sFontSize, $sFontWeight = 400, $sFontAtrribute = 0, $sFont = "")
; Parameter(s)....: $hControl       - The control identifier or handle
;					$sFontSize      - Fontsize (default is 10)
;					$sFontWeight    - [optional] Font weight (default 400 = normal)
;					$sFontAtrribute - [optional] To define italic:2 underlined:4 strike:8 char formats
;					$sFont          - [optional] The name of the font to use
; Return value(s).: Success - None
;					Failure - Sets @error to 1 and returns 0 if $sFontSize param contains a empty or not numeric string
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_SetFont($hControl, $sFontSize, $sFontWeight = 400, $sFontAtrribute = 0, $sFont = "")
	If ($sFontSize = "") Or (IsNumber($sFontSize) = 0) Then Return SetError(1, 0, 0)
	
	If $hToolTip = False Then $hToolTip = _ToolTip_Create()
	If Not IsHWnd($hControl) Then $hControl = GUICtrlGetHandle($hControl)
	
	Local $iElement = _FindControl($hControl)
	
	$aFontSize[$iElement]   = $sFontSize
	$aFontWeight[$iElement] = $sFontWeight
	$aFontAtrrib[$iElement] = $sFontAtrribute
	$aFont[$iElement]       = $sFont
EndFunc

; #FUNCTION# =============================================================
; Name............: _ToolTip_SetShowTime
; Description.....: Sets time the tooltip should be displayed
; Syntax..........: _ToolTip_SetShowTime($sTime)
; Parameter(s)....: $hControl - The control identifier or handle
;					$sTime    - Estimate of the time (in miliseconds) the tooltip should be displayed
; Return value(s).: Success - None
;					Failure - Sets @error to 1 and returns 0 if $sTime param contains a empty or not numeric string
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_SetShowTime($sTime)
	If ($sTime = "") Or (IsNumber($sTime) = 0) Then Return SetError(1, 0, 0)
	If $sTime > $SHRT_MAX Then $sTime = $SHRT_MAX
	If $hToolTip = False Then $hToolTip = _ToolTip_Create()
	
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $hToolTip, "int", $TTM_SETDELAYTIME, "dword", $TTDT_AUTOPOP, _
			"int", $sTime)
EndFunc

; #FUNCTION# =============================================================
; Name............: _ToolTip_SetBaloonStyle
; Description.....: Sets tooltips as balloon tip Requires IE5+
; Syntax..........: _ToolTip_SetBaloonStyle()
; Parameter(s)....: None
; Return value(s).: None
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_SetBaloonStyle()
	If $hToolTip = False Then $hToolTip = _ToolTip_Create()
	
	Local $aRet = DllCall("user32.dll", "int", "GetWindowLong", "hwnd", $hToolTip, "int", $GWL_STYLE)
	DllCall("user32.dll", "int", "SetWindowLong", "hwnd", $hToolTip, "int", $GWL_STYLE, "int", BitOR($aRet[0], $TTS_BALLOON))
EndFunc

; #FUNCTION# =============================================================
; Name............: _ToolTip_Create
; Description.....: Create a tooltip window
; Syntax..........: _ToolTip_Create()
; Parameter(s)....: None
; Return value(s).: The handle of tooltip window
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Internal use only
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _ToolTip_Create()
	$hToolTip = DllCall("user32.dll", "hwnd", "CreateWindowEx", "int", $WS_EX_TOPMOST, "str", $TOOLTIPS_CLASSA, _
						"str", 0, "int", BitOR($WS_POPUP, $TTS_ALWAYSTIP), "int", $CW_USEDEFAULT, _
						"int", $CW_USEDEFAULT, "int", $CW_USEDEFAULT, "int", $CW_USEDEFAULT, "hwnd", 0, "hwnd", 0, _
						"hwnd", 0, "ptr", 0)
	
	$TOOLINFO = DllStructCreate("int cbSize;int uFlags;hwnd hWnd;int uId;int rect[4];hwnd hinst;" & _
								"ptr lpszText;int lParam;int lpReserved")

	DllStructSetData($TOOLINFO, "cbSize", DllStructGetSize($TOOLINFO))
	DllStructSetData($TOOLINFO, "uFlags", BitOR($TTF_IDISHWND, $TTF_SUBCLASS))
	DllStructSetData($TOOLINFO, "hinst", 0)
	DllStructSetData($TOOLINFO, "lParam", 0)
	DllStructSetData($TOOLINFO, "lpReserved", 0)
    
	Return $hToolTip[0]
EndFunc

; #FUNCTION# =============================================================
; Name............: _FindControl
; Description.....: Finds the control handle in the array which contains a controls handles
; Syntax..........: _FindControl($hControl)
; Parameter(s)....: $hControl - Handle to the control
; Return value(s).: Last array element number
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Internal use only
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _FindControl($hControl)
	Local $i
	
	If $aControl[0] = 0 Then Return _RedimArray($hControl)
	
	For $i = 1 To $aControl[0]
		If $hControl = $aControl[$i] Then Return $i
	Next
	
	Return _RedimArray($hControl)
EndFunc

; #FUNCTION# =============================================================
; Name............: _RedimArray
; Description.....: Redims arrays with parameters and sets default parameters
; Syntax..........: _RedimArray($hControl)
; Parameter(s)....: $hControl - Handle to the control
; Return value(s).: Last element number from the array contains a controls handles
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Internal use only
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RedimArray($hControl)
	$aControl[0] += 1
	ReDim $aControl[$aControl[0] + 1]
	$aControl[$aControl[0]] = $hControl
	
	$aTitle[0] += 1
	ReDim $aTitle[$aTitle[0] + 1]
	$aTitle[$aTitle[0]] = ""
	
	$aIcon[0] += 1
	ReDim $aIcon[$aIcon[0] + 1]
	$aIcon[$aIcon[0]] = 0
	
	$aTextColor[0] += 1
	ReDim $aTextColor[$aTextColor[0] + 1]
	$aTextColor[$aTextColor[0]] = 0x000000
	
	$aBkColor[0] += 1
	ReDim $aBkColor[$aBkColor[0] + 1]
	$aBkColor[$aBkColor[0]] = _RGB2BGR(0xFFFFE1)
	
	$aFontSize[0] += 1
	ReDim $aFontSize[$aFontSize[0] + 1]
	$aFontSize[$aFontSize[0]] = 10
	
	$aFontWeight[0] += 1
	ReDim $aFontWeight[$aFontWeight[0] + 1]
	$aFontWeight[$aFontWeight[0]] = 400
	
	$aFontAtrrib[0] += 1
	ReDim $aFontAtrrib[$aFontAtrrib[0] + 1]
	$aFontAtrrib[$aFontAtrrib[0]] = 0
	
	$aFont[0] += 1
	ReDim $aFont[$aFont[0] + 1]
	$aFont[$aFont[0]] = "Tahoma"
	
	Return $aControl[0]
EndFunc

; #FUNCTION# =============================================================
; Name............: _CreateFont
; Description.....: Creates a logical font with the specified characteristics
; Syntax..........: _CreateFont($hWnd, $nFontSize, $nFontWeight, $nFontAtrribute, $nFont)
; Parameter(s)....: $hWnd    		- The window handle
;					$sFontSize      - Fontsize (default is 10)
;					$sFontWeight    - Font weight (default 400 = normal)
;					$sFontAtrribute - To define italic:2 underlined:4 strike:8 char formats
;					$sFont          - The name of the font to use
; Return value(s).: None
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Internal use only
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _CreateFont($hWnd, $nFontSize, $nFontWeight, $nFontAtrribute, $nFont)
    Local $hDc = DllCall("user32.dll", "hwnd", "GetDC", "hwnd", $hWnd)
    Local $nPixel = DllCall("gdi32.dll", "int", "GetDeviceCaps", "hwnd", $hDc[0], "int", $LOGPIXELSY)
    Local $nHeight = DllCall("kernel32.dll", "int", "MulDiv", "int", $nFontSize, "int", $nPixel[0], "int", 72)

    Local $hFont = DllCall("gdi32.dll", "hwnd", "CreateFont", "int", $nHeight[0], "int", 0, _
						   "int", 0, "int", 0, "int", $nFontWeight, "dword", BitAND($nFontAtrribute, 2), _
						   "dword", BitAND($nFontAtrribute, 4), "dword", BitAND($nFontAtrribute, 8), "int", $DEFAULT_CHARSET, _
						   "int", $OUT_DEFAULT_PRECIS, "int", $CLIP_DEFAULT_PRECIS, "int", $DEFAULT_QUALITY, "int", 0, _
						   "str", $nFont)

	DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $WM_SETFONT, "int", $hFont[0], "int", 1)
	
	DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $hWnd, "hwnd", $hDc[0])
	DllCall("user32.dll", "int", "DeleteObject", "hwnd", $hFont[0])
EndFunc

; #FUNCTION# =============================================================
; Name............: RGB2BGR
; Description.....: Convert a RGB color mode to a BGR color mode
; Syntax..........: RGB2BGR($sColor)
; Parameter(s)....: $sColor - The color in HEX value
; Return value(s).: Converted color in HEX value
; Requirement(s)..: 
; Note(s).........: 
; Author(s).......: Siao
; ========================================================================
Func _RGB2BGR($iColor)
    Return BitAND(BitShift(String(Binary($iColor)), 8), 0xFFFFFF)
EndFunc   ;==>_RGB2BGR()

Func _TimerProc($hWnd, $Msg, $IdTimer, $dwTime)
	Local $iRet = DllCall("user32.dll", "int", "WindowFromPoint", "int", MouseGetPos(0), "int", MouseGetPos(1))
	$iRet = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $iRet[0])
	
	If ($iRet[0] = 0) Or ($iRet[0] = 350) Then Return False
	
	Local $hControl = $iRet[0]

	If Not IsHWnd($hControl) Then $hControl = GUICtrlGetHandle($hControl)
	
	If $hControl = $LastHwnd Then Return False
	
	For $i = 1 To $aControl[0]
		If $hControl = $aControl[$i] Then
			DllCall("user32.dll", "int", "SendMessage", "hwnd", $hToolTip, "int", $TTM_SETTITLE, "int", $aIcon[$i], "str", $aTitle[$i])
			DllCall("user32.dll", "int", "SendMessage", "hwnd", $hToolTip, "int", $TTM_SETTIPTEXTCOLOR, "int", $aTextColor[$i], "int", 0)
			DllCall("user32.dll", "int", "SendMessage", "hwnd", $hToolTip, "int", $TTM_SETTIPBKCOLOR, "int", $aBkColor[$i], "int", 0)
			_CreateFont($hToolTip, $aFontSize[$i], $aFontWeight[$i], $aFontAtrrib[$i], $aFont[$i])
		EndIf
	Next
	
	$LastHwnd = $hControl
EndFunc

Func OnAutoitExit()
	If IsDeclared("TimerProcHandle") Then
		DllCallbackFree($TimerProcHandle)
		DllCall("user32.dll", "int", "KillTimer", "hwnd", 0, "int", $TimerCall)
		DllCall("User32.dll", "int", "DestroyWindow", "hwnd", $hToolTip)
		$hToolTip = 0
		$TOOLINFO = 0
	EndIf
EndFunc   ;==>OnAutoitExit