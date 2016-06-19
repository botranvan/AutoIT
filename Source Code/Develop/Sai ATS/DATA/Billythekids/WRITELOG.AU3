#include <file.au3>
#include <NomadMemory.au3>


Global $pointer =  0x00EB7EE0; Enter the base address
Global $baseOffset = 0x10c ; Enter the first base offset
Global $Programe = "Programe" ; Enter the programm name
Global $file = "logs.log" ; Enter the log file name
Global $Process = WinGetProcess($Programe)
Global $game = _MemoryOpen($Process)

Func createLogs()
	If Not _FileCreate($file) Then
   MsgBox(4096,"Error", " Error Creating/Resetting log.      error:" & @error)
	EndIf
EndFunc

Func _FindNewAddress($ointer, $Oset)
Return '0x' & Hex(_MemoryRead($ointer,$game) + $Oset, 8)
EndFunc

Func get_data($ofset,$type=0)
	$readpointer = '0x' & Hex(_MemoryRead($Pointer, $game) + $baseOffset,8)
	$readinfo = _FindNewAddress($readpointer, $ofset)
	If $type == "float" Then
	Return Floor(_MemoryRead($readinfo, $game, $type))
	Elseif $type == "char" Then
	Return _MemoryRead($readinfo, $game, "wchar[64]")
	Else
	Return _MemoryRead($readinfo, $game)
	EndIf
EndFunc

Func writeLogs($text)
	_FileWriteLog(@ScriptDir & "\" & $file,$text)
EndFunc

Func readinfo()
	for $i= 1 to 5000
		$i = '0x' &  Hex($i)
		$text = "Offset: " & $i & " value: " & get_data($i,"char")		
		writeLogs($text)	
	Next
EndFunc

createLogs()
readinfo()