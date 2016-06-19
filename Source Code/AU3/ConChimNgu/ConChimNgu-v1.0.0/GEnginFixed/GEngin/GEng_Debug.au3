#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Debug_DrawVector($iDbgPen, $x0, $y0, $x1, $y1, $hBuffer = Default)
	_GEng_Debug_DrawVectAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur, $hBuffer = Default)
	_GEng_Debug_DrawLine($iDbgPen, $x0, $y0, $x1, $y1, $hBuffer = Default)
	_GEng_Debug_DrawLineAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur, $hBuffer = Default)
	_GEng_Debug_DrawRect($iDbgPen, $x, $y, $w, $h, $hBuffer = Default)
	_GEng_Debug_DrawCircle($iDbgPen, $x, $y, $r, $hBuffer = Default)
	__GEng_Debug_CreatePens()
	__GEng_Debug_DiscardPens()
#ce
#EndRegion ###


Func _GEng_Debug_DrawVector($iDbgPen, $x0, $y0, $x1, $y1, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Arrow" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Arrow" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawVectAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur, $hBuffer = Default)
	Local $tmp = _GEng_AngleToVector($iAngle, $iGrandeur)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Arrow" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Arrow" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawLine($iDbgPen, $x0, $y0, $x1, $y1, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawLineAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur, $hBuffer = Default)
	Local $tmp = _GEng_AngleToVector($iAngle, $iGrandeur)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawRect($iDbgPen, $x, $y, $w, $h, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawRect($__GEng_hBuffer, $x, $y, $w, $h, Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawRect($hBuffer, $x, $y, $w, $h, Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawCircle($iDbgPen, $x, $y, $r, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawEllipse($__GEng_hBuffer, $x - $r, $y - $r, $r * 2, $r * 2, Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawEllipse($hBuffer, $x - $r, $y - $r, $r * 2, $r * 2, Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc


; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Debug_CreatePens()
	$_Arrow = _GDIPlus_ArrowCapCreate(5, 3, 1)
	$_dbg_Arrow1 = _GDIPlus_PenCreate(0xFFFF0000, 2)
	$_dbg_Arrow2 = _GDIPlus_PenCreate(0xFF00FF00, 2)
	$_dbg_Arrow3 = _GDIPlus_PenCreate(0xFF0000FF, 2)
	$_dbg_Arrow4 = _GDIPlus_PenCreate(0xFFb9ba4e, 1)
		_GDIPlus_PenSetCustomEndCap($_dbg_Arrow1, $_Arrow)
		_GDIPlus_PenSetCustomEndCap($_dbg_Arrow2, $_Arrow)
		_GDIPlus_PenSetCustomEndCap($_dbg_Arrow3, $_Arrow)
		_GDIPlus_PenSetCustomEndCap($_dbg_Arrow4, $_Arrow)
	; ---
	$_dbg_pen1 = _GDIPlus_PenCreate(0xFFFF0000, 2)
	$_dbg_pen2 = _GDIPlus_PenCreate(0xFF00FF00, 2)
	$_dbg_pen3 = _GDIPlus_PenCreate(0xFF0000FF, 2)
	$_dbg_pen4 = _GDIPlus_PenCreate(0xFFb9ba4e, 1)
EndFunc

Func __GEng_Debug_DiscardPens()
	_GDIPlus_PenDispose($_dbg_Arrow1)
	_GDIPlus_PenDispose($_dbg_Arrow2)
	_GDIPlus_PenDispose($_dbg_Arrow3)
	_GDIPlus_PenDispose($_dbg_Arrow4)
	_GDIPlus_ArrowCapDispose($_Arrow)
	; ---
	_GDIPlus_PenDispose($_dbg_pen1)
	_GDIPlus_PenDispose($_dbg_pen2)
	_GDIPlus_PenDispose($_dbg_pen3)
	_GDIPlus_PenDispose($_dbg_pen4)
EndFunc

