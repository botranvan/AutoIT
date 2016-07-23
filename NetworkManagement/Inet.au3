; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <InetConstants.au3>
#include <File.au3>
#include <WinAPIFiles.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


; Download a file in the background.
; Wait for the download to complete.

Local   $sFilePath =  _WinAPI_GetTempFileName(@ScriptDir) ;_TempFile(@ScriptDir, "pic_", ".png") ; Save the downloaded file to the temporary folder.

; Download the file in the background with the selected option of force a reload from the remote site.
Local   $hDownload = InetGet("http://e1fe3beb26a69ff185ba-1545be6ee72845feb34bb706c1ee1ba5.r45.cf2.rackcdn.com/18155101_0_7d0795c28a98992b47eec9f2eba8b63b.png", $sFilePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True

Do 
	Sleep(200)
Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)

Local   $iByteSize = InetGetInfo($hDownload, $INET_DOWNLOADREAD)
Local   $iFileSize = InetGetSize($sFilePath)

InetClose($hDownload) ; Close the handle returned by InetGet

MsgBox($MB_APPLMODAL, "", "The total download size: " & $iByteSize & @CRLF & _
							"The total filesize: " & $iFileSize)