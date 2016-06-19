
HotKeySet("^+t","STActive")
Func STActive()
	$Testing = Not $Testing
EndFunc

Func STShow()
	If Not $Testing Then Return
	Local $Height

	$Height = $Ground[1]-$CharPos[1]

	Local $Text = ""
	$Text&= @MSEC&@CRLF
	$Text&= "$CharOnGround:"&$CharOnGround&@CRLF
	$Text&= "$CharStand:"&$CharStand&@CRLF
	$Text&= "$CharRight:"&$CharRight&@CRLF
	$Text&= "$CharLeft:"&$CharLeft&@CRLF
	$Text&= "Height:"&$Height&@CRLF
	$Text&= STShowCommand()&@CRLF

	ToolTip($Text,0,0)
EndFunc

Func STShowCommand()
	Local $Text = ""
	$Text&= " == Command =========="&@CRLF
	$Text&= STShowArray($CommandList)
	$Text&= STShowArray($CommandCurrent)

	Return $Text
EndFunc

Func STShowArray($Array)
	Local $Text = ""
	For $i = 0 To UBound($Array)-1
		$Text&= $Array[$i]&","
	Next
	$Text&= @CRLF

	Return $Text
EndFunc