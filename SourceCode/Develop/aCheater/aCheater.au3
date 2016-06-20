
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
AdlibRegister('CHStep6Freeze',72)
AdlibRegister('CHStep8Freeze',72)

While 1
	Sleep(72)
	FAutoPause()
	STShow()

	FCTConnect()
	FCTStep1LoadAddress()
	FCTStep2LoadAddress()
	FCTStep6LoadAddress()
	FCTStep7LoadAddress()
	FCTStep8LoadAddress()

WEnd
