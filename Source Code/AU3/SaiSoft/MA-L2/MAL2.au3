
;~ Cài đặt lại AutoIT
Opt("GUICloseOnESC",0)
Opt("SendCapslockMode",0)

#include-once
#include "GlobalVariable.au3"	;~ Tất cả biến chương trình
#include "HotKeySet.au3"		;~ Các phím nóng


;~ Thư viện mặc định sẳn có trong AutoIT
#include <IE.au3>			;NoShow
#include <Array.au3>		;NoShow
#Include <GuiComboBox.au3>	;NoShow

;~ Thư viện khác tải từ Internet
#include "UDF\NomadMemory.au3"
#include "UDF\GIFAnimation.au3"

;~ Thư viện tự viết
#include "Functions.au3"
#include "SaiTest.au3"


AutoStart()

While 1
	If $Testing Then DShowTest()
	GameCheck()
	
	If $GameHandle Then
		GameIsTarget()
		SkillUse()
		BuffUse()
		;GameTitleSet($GameHandle,DBCharListGet())
	Else
		LIsTargetSet("No game")
		GameGetList()
	EndIf
	
	
	Sleep(250)
WEnd