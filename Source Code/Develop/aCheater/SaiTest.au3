
HotKeySet("^+t","STActive")
Func STActive()
	$Testing = Not $Testing
EndFunc

Func STShow()
	If Not $Testing Then Return

	Local $Text = ""
	$Text&= @MSEC&@CRLF
	$Text&= "$CETutorialPID: "&$CETutorialPID&@CRLF
	$Text&= "$Step6ValueIsHex: "&$Step6ValueIsHex&@CRLF
	$Text&= "$Step7ValueIsHex: "&$Step7ValueIsHex&@CRLF

	Local $iv_Address = IStep7AddressGet()
	Local $iv_AddressDec = Dec(StringReplace($iv_Address,'0x',''))
	$Text&= "$iv_Address: "&$iv_Address&@CRLF
	$Text&= "$iv_AddressDec: "&$iv_AddressDec&@CRLF


	$iv_Address2= $iv_AddressDec+5
	$Text&= "$iv_Address2: "&$iv_Address2&@CRLF
	$Text&= "$iv_Address2a: "&'0x'&Hex($iv_Address2,8)&@CRLF

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