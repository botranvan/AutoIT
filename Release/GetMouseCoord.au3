#pragma compile(Compatibility, win81)
#pragma compile(Compression, 9)
#pragma compile(ExecLevel,highestAvailable)
#pragma compile(FileVersion, 1.0.0)
#pragma compile(FileDescription, "No Virus")
#pragma compile(Icon, "source/icons/firefox.ico")
#pragma compile(LegalCopyright, Researcher)
#pragma compile(OriginalFilename, show_love.exe)
#pragma compile(ProductName, Virus I Love You)
#pragma compile(ProductVersion, 1.0)
#pragma compile(UPX, true)


; #NoTrayIcon


HotKeySet("{ESC}", "_Terminate")
HotKeySet("{F1}", "_ClipPutData")

Local $aMgp = Default

While True
	$aMgp = MouseGetPos()
	$iColor = PixelGetColor($aMgp[0], $aMgp[1])
	ToolTip("Left: " & $aMgp[0] & "pixel" & @CRLF & _
			"Top: " & $aMgp[1] & "pixel" & @CRLF & _
			"Decimal color is: " & $iColor & @CRLF & _
			"Hexa color is: " & Hex($iColor, 6), $aMgp[0] + 10, $aMgp[1] + 10)
	Sleep(50)
WEnd

Func _ClipPutData()
	;code
	ClipPut("Left: " & $aMgp[0] & "pixel" & @CRLF & _
			"Top: " & $aMgp[1] & "pixel" & @CRLF & _
			"Decimal color is: " & $iColor & @CRLF & _
			"Hexa color is: " & Hex($iColor, 6))
	ToolTip("Copied", 0, 0, "Note", 1, 1)
	Sleep(567)
EndFunc   ;==>_ClipPutData

Func _Terminate()
	Exit
EndFunc   ;==>_Terminate
