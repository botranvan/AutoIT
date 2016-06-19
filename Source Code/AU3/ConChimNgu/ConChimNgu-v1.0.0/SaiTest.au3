
HotKeySet("^+t","STActive")
Func STActive()
	$Testing = Not $Testing
EndFunc

Func STShow()
	If Not $Testing Then Return
	If TimerDiff($TestTimer) < 100 Then Return
	$TestTimer = TimerInit()

	Local $x,$y
	Global $MyBird

	_GEng_Sprite_PosGet($MyBird, $x, $y)

	Local $Text = ""
	$Text&= @MSEC&@CRLF
	$Text&= "$scr: "&$scrW&';'&$scrH&@CRLF
	$Text&= "$GamePlaying: "&$GamePlaying&@CRLF
	$Text&= "$MyBirdNeedFlyUp: "&$MyBirdNeedFlyUp&@CRLF
	$Text&= "$MyBirdFlyUpCount: "&$MyBirdFlyUpCount&@CRLF
	$Text&= "$MyBirdFlyUpPosY: "&$MyBirdFlyUpPosY&@CRLF
	$Text&= "$MyBird: "&$x&'/'&$y&@CRLF

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