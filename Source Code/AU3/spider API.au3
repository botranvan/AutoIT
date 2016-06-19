#include <Misc.au3>
#Include <WinAPI.au3>
#Include <process.au3>
#include<Constants.au3>
While 1
	If _IsPressed("77") then
		dim $pid = WinGetProcess("Spider")
		Dim $procHwnd = _WinAPI_OpenProcess($PROCESS_ALL_ACCESS, False, $pid)
		Dim $pBuffer = DllStructCreate("byte[2]"), $iRead = 0
		$iWritten = DllStructSetData($pBuffer,1,0xFFF)
		_WinAPI_WriteProcessMemory($procHwnd, 0x01012f60, DllStructGetPtr($pBuffer), 2,$iWritten)
		_WinAPI_ReadProcessMemory($procHwnd, 0x01012f60, DllStructGetPtr($pBuffer), 2, $iRead)
		MsgBox(0, "Data Read:", int(DllStructGetData($pBuffer, 1)))
	EndIf
WEnd