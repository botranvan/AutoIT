
Opt("GUICloseOnESC",0)


#include "Array.au3"
#include "NomadMemory.au3"

#include "GlobalVar.au3"
#include "FileInstall.au3"
#include "SaiTest.au3"
#include "GUI/GUI.au3"
#include "Functions.au3"


HotKeySet("^+{del}","FToolTipDel")
HotKeySet("+{esc}","FAutoEnd")

FAutoStart()

While 1


	Sleep(1)
	FAutoPause()
;~ 	STShow()

	FCTConnect()
	If(CHStep6FreezeIsCheck() And $Step6FreezeAdd>0) Then
		FCTWrite($Step6FreezeAdd,IStep6ChangeToGet())
	Else
		FCTStep1LoadAddress()
		FCTStep2LoadAddress()
		FCTStep6LoadAddress()
	EndIf
WEnd
