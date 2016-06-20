#include-once

Opt("GUICloseOnESC",0)
HotKeySet("+{esc}","FAutoEnd")

#include "GlobalVar.au3"
#include "FileInstall.au3"
#include "SaiTest.au3"
#include "GUI/GUI.au3"
#include "Functions.au3"

#Include <GuiEdit.au3>

FAutoStart()

While 1
	Sleep(72)
	FAutoPause()
	STShow()
	FSetup()
	LNoticeSet($step&":"&@sec)
WEnd
