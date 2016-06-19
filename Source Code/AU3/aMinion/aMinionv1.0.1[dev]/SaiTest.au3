
HotKeySet("^+t","STActive")
Func STActive()
	$Testing = Not $Testing
EndFunc

Func STShow()
	If Not $Testing Then Return
	If TimerDiff($TestTimer) < 100 Then Return
	$TestTimer = TimerInit()

	Local $x,$y

	Local $Text = ""
	$Text&= @MSEC&@CRLF
	$Text&= "$scr: "&$scrW&';'&$scrH&@CRLF
	$Text&= "$MinionGoUpDelay: "&$MinionGoUpDelay&@CRLF
	$Text&= "$MinionSpawnDelay: "&$MinionSpawnDelay&@CRLF
	$Text&= "$MinionUpCount: "&$MinionUpCount&@CRLF
	$Text&= "$MinionDownCount: "&$MinionDownCount&@CRLF


	$Text&= "== Minion Pos ====="&@CRLF
	For $i = 1 To $Minions1eye[0]
		_GEng_Sprite_PosGet( $Minions1eye[$i], $x, $y)
		$Text&= $i&": "&Round($x)&","&$y&@CRLF
	Next

	$Text&= "== Minion Status ==="&@CRLF
	For $i = 1 To $Minions1eyeStatus[0]
		$Text&= $i&": "&$Minions1eyeStatus[$i]&@CRLF
	Next

	ToolTip($Text,0,0)
EndFunc


Func STShowArray($Array)
	Local $Text = ""
	For $i = 0 To UBound($Array)-1
		$Text&= $Array[$i]&","
	Next
	$Text&= @CRLF

	Return $Text
EndFunc