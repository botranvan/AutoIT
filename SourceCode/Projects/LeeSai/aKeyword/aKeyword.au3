#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Custom-Icon-Design-Pretty-Office-7-Increase.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=LeeSai
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once

Opt("GUICloseOnESC",0)

#include <Array.au3>
#include <IE.au3>
#include <String.au3>
#include <GuiEdit.au3>

#include "GlobalVar.au3"
#include "FileInstall.au3"
#include "SaiTest.au3"
#include "GUI/GUI.au3"
#include "Functions.au3"

HotKeySet("^+{del}","FToolTipDel")
HotKeySet("+{esc}","FAutoEnd")

FAutoStart()

While 1
	Sleep(72)
	FAutoPause()
;~ 	STShow()

;~ 	FCommandCheck()
WEnd
