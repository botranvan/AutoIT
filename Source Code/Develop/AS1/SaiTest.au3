
HotKeySet("^t","STActive")
Func STActive()
	$Testing = Not $Testing
EndFunc

Func STShow()
	If Not $Testing Then Return
		
	Local $Test = ""
	$Test&= @MSEC&@CRLF
	
	ToolTip($Test,0,0)
EndFunc

Func STShowArray($Array)
	Local $Text = ""
	For $i = 0 To UBound($Array)-1
		$Text&= $Array[$i]&","
	Next
	$Text&= @CRLF
	
	Return $Text
EndFunc