
HotKeySet("^+t","STActive")
Func STActive()
	$Testing = Not $Testing
EndFunc

Func STShow()
	If Not $Testing Then Return

	Local $Text = ""
	$Text&= @MSEC&@CRLF
	$Text&= STShowFilesUpload()&@CRLF
	$Text&= STShowFilesUploadTemp()&@CRLF
	$Text&= STShowCommand()&@CRLF

	ToolTip($Text,0,0)
EndFunc

Func STShowFilesUpload()
	Global $FilesUpload
	Local $Text = ""
	$Text&= " == Files Upload =========="&@CRLF
	$Text&= STShowArray($FilesUpload)

	Return $Text
EndFunc

Func STShowFilesUploadTemp()
	Global $FilesUploadTemp
	Local $Text = ""
	$Text&= " == Files Temp =========="&@CRLF
	$Text&= STShowArray($FilesUploadTemp)

	Return $Text
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