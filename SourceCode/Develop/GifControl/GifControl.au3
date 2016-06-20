
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
#include "UDF\GIFAnimation.au3"

;~ Thư viện tự viết
#include "Functions.au3"
#include "SaiTest.au3"

FAutoStart()
	$AttGif = _GUICtrlCreateGIF($AttGifFile, 150, 2,$aGIFArrayOfIconHandles,$hGIFThread,$iTransparent,$tCurrentFrame)
	
While 1
	DShowTest()
	$Current += 1
	Sleep(222)
WEnd
