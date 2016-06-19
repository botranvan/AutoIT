#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.12.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#Include <WinAPI.au3>

If Not ProcessExists("calc.exe") Then Exit ; exit if calculator is not running
Dim $procHwnd = _WinAPI_OpenProcess(0xE98, False, ProcessExists("calc.exe"))
If Not $procHwnd Then _Exit("Error while getting process handle!")

Dim $pBuffer = DllStructCreate("byte[256]"), $iRead = 0

_WinAPI_ReadProcessMemory($procHwnd, 0x01014dd4, DllStructGetPtr($pBuffer), 256, $iRead)
If Not $iRead Then _Exit("Error while reading data!")
   
; convert the unicode text(as it turned out to be stored as) to normal text and display it
MsgBox(0, "Data Read", BinaryToString(Binary(DllStructGetData($pBuffer, 1)), 2))


Func _Exit($s_Msg)
   
    MsgBox(0, "Error", $s_Msg)
    Exit
   
EndFunc