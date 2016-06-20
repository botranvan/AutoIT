#include-once
Global $SaiPixelTestMod = 0

Func _ColorLen($WHandle,$x,$y,$Ctrl = 0,$Step = 2,$Shade=22,$Mod = 0)
	Local $Len,$ColorStart,$Color,$WinPos,$WinCaret,$WinClient,$Tip,$i
	Local $Pos[2],$TipPos[2],$Span[2]
	
	;Set default value to ByPass argument
	If $Step == Default Then $Step = 1
	If $Shade == Default Then $Shade = 100
	If $Mod == Default Then $Mod = 0
	If $Ctrl == Default Then $Ctrl = 0
		
	;Select scan mod
	Opt("PixelCoordMode",$Mod)
	
	$Len = 0
	$Pos = _ColorCoordFix($WHandle,$x,$y)
	$ColorStart = PixelGetColor($Pos[0],$Pos[1],$WHandle)
	;LNoticeSet($ColorStart)
	;LNoticeBackGround($ColorStart)
	
	While (1)
		
		;Return if window need check not active
		If Not WinActive($WHandle) Then 
			SetError(1)
			Return -1
		EndIf
		
		
		
		$Tip = ""
		$Pos = _ColorCoordFix($WHandle,$x+$Len,$y)
		$Color = PixelGetColor($Pos[0],$Pos[1],$WHandle)
		
			
		;Enable Test Mod
		If $SaiPixelTestMod Then
			$TipPos = $Pos
			
			;Reset TipPos with [relative coords to the defined window] mod
			If $Mod == 0 Then
				$WinPos = WinGetPos($WHandle)
				$WinClient = WinGetClientSize($WHandle)
				$WinCaret = WinGetCaretPos()
				$Span[0] = $WinPos[2] - $WinClient[0]
				$Span[1] = $WinPos[3] - $WinClient[1]
				$TipPos[0]+=$WinCaret[0]
				$TipPos[1]+=$WinCaret[1]-$Span[1]+Round($Span[0]/2)
				$Tip&="$Shade: "&$Shade&@CR
				$Tip&="$WinPos: "&$WinPos[0]&" , "&$WinPos[1]&" | "&$WinPos[2]&" , "&$WinPos[3]&@CR
				$Tip&="$WinClient: "&$WinClient[0]&" , "&$WinClient[1]&@CR
				$Tip&="$WinCaret: "&$WinCaret[0]&" , "&$WinCaret[1]&@CR
				$Tip&="$Span: "&$Span[0]&" , "&$Span[1]&@CR
				$Tip&="$Pos: "&$Pos[0]&" , "&$Pos[1]&@CR
				$Tip&="$TipPos: "&$TipPos[0]&" , "&$TipPos[1]&@CR
			EndIf
		
			;Show color in a control
			If $Ctrl Then GUICtrlSetBkColor($Ctrl,$Color)
			LNoticeSet($Color)
				
			$Tip&="$Len: "&$Len&@CR
			$Tip&="$Color: "&$Color&@CR
			ToolTip(@sec&@msec&@CR&$Tip,$TipPos[0],$TipPos[1])
		EndIf
		
		PixelSearch($Pos[0]-1,$Pos[1],$Pos[0]+1,$Pos[1],$ColorStart,$Shade)
		If @error Then Return $Len
		$Len+=$Step

	WEnd
	
	Return $Len
EndFunc


Func _ColorCoordFix($WHandle,$x,$y)
	Local $WinPos,$WinClient
	Local $Pos[2],$Span[2]
	$WinPos = WinGetPos($WHandle)
	$WinClient = WinGetClientSize($WHandle)
	$Span[0] = $WinPos[2] - $WinClient[0]
	$Span[1] = $WinPos[3] - $WinClient[1]
	$Pos[0] = $x
	$Pos[1] = $y+$Span[1]+Round($Span[0]/2)	
	
	Return $Pos
EndFunc
	