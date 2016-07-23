
#cs >> Danh sách hàm ===============================================================================================

Tất cả hàm được gọi trong file này nằm trong file Function.au3

#ce << Danh sách hàm ===============================================================================================


;~ Cài đặt lại AutoIT
Opt("GUICloseOnESC",0)
Opt("SendCapslockMode",0)

#include-once
#include "GlobalVariable.au3"	;~ Tất cả biến chương trình
#include "HotKeySet.au3"		;~ Các phím nóng


;~ Thư viện mặc định sẳn có trong AutoIT
#include <IE.au3>		;NoShow
#include <Array.au3>	;NoShow

;~ Thư viện khác tải từ Internet
;~ #include "UDF\NomadMemory.au3"
#include "UDF\UnixTime.au3"

;~ Thư viện tự viết
#include "Functions.au3"
#include "SaiTest.au3"

AutoStart()

Global $TimeS = _TimeGetStamp()


While 1
;	DShowTest()
	BackClock()
	Sleep(1000)
WEnd

Func BackClock()
	$TimeS-=1
	Local $Time = _StringFormatTime("%I:%M %S",$TimeS)
	ClockSet($Time)
EndFunc

