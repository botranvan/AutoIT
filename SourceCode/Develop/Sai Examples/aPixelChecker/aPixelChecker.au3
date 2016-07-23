
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

;~ Thư viện tự viết
#include "Functions.au3"
#include "SaiTest.au3"

Global $Pos[2] = [0,0]
Global $Color

FAutoStart()
While 1
	;DShowTest()
	Sleep(72)
	
	ShowMousePos()
	ShowPixel()
	ShowColor()
	PixelCheck()
WEnd

;Kiểm tra màu
Func PixelCheck()
	Local $Check
	$Check = 0xFF
	
	If $Color == Hex($Check) Then
		LNoticeSet("Tìm thấy màu xanh")
	Else
		LNoticeSet("Kg thấy ")
	EndIf
EndFunc



;Hiện màu chuột đang trỏ
Func ShowColor()
	LColorBackGround("0x"&$Color)
	LColorSet() ;Chết mày nè
EndFunc

;Hiện mã màu chuột đang trỏ
Func ShowPixel()
	$Color = PixelGetColor ($Pos[0],$Pos[1])
	$Color = Hex($Color)
	LPixelSet("0x"&$Color)
EndFunc

;Hiện vị trí chuột lên GUI
Func ShowMousePos()  
	$Pos = MouseGetPos()
	LMousePosSet($Pos[0]&","&$Pos[1])
EndFunc


















