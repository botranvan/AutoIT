#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.12.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Include <WinAPI.au3>

If Not ProcessExists("calc.exe") Then Exit ; exit if calculator is not running

Dim $procHwnd = _WinAPI_OpenProcess(0xE98, False, ProcessExists("calc.exe")); get access to read/write/anything the process memory
If Not $procHwnd Then _Exit("Error while getting process handle!") ; if we didn't get a valid 'access' handle then exit

Dim $pBuffer = DllStructCreate("byte[256]"), $iRead = 0; create our structure(I assume we won't need to read more than 256 bytes), and iRead which specifies how many bytes where really read.

_WinAPI_ReadProcessMemory($procHwnd, 0x01014dd4, DllStructGetPtr($pBuffer), 256, $iRead) ; here we read the memory
If Not $iRead Then _Exit("Error while reading data!"); exit if no data was read

MsgBox(0, "Data Read:", _UnicodeToStr(DllStructGetData($pBuffer, 1))) ; convert the unicode text(as it turned out to be stored as) to normal text and display it



Func _UnicodeToStr($b_Unicode)
   
    Local $a_Tmp = StringSplit(StringTrimLeft($b_Unicode, 2), "00", 1), $s_Str
   
    For $i = 1 To $a_Tmp[0]
       
        $s_Str &= Chr(Dec($a_Tmp[$i]))
       
    Next
   
    Return $s_Str
   
EndFunc

Func _Exit($s_Msg)
   
    MsgBox(0, "Error", $s_Msg)
    Exit
   
EndFunc