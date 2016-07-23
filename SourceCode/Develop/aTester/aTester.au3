#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Zerode-Plump-Shell-run.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Opt("GUICloseOnESC",0)


#include "Array.au3"
#include <Date.au3>

#include "GlobalVar.au3"
#include "FileInstall.au3"
#include "SaiTest.au3"
#include "GUI/GUI.au3"
#include "Functions.au3"

#include "TestFunction.au3"
#include "TestVar.au3"

HotKeySet("^+{del}","FToolTipDel")
HotKeySet("+{esc}","FAutoEnd")

FAutoStart()

While 1
	Sleep(72)
	FAutoPause()
	STShow()

	FCommandCheck()
WEnd
