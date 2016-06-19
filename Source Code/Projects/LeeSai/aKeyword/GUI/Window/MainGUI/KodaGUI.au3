#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Dropbox\AutoIT\Project\LeeSai\aKeyword\GUI\Window\MainGUI\MainGUI.kxf
$MainGUI = GUICreate("MainGUI", 275, 423, 274, 314, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 400, 47, 17, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$IWebsite = GUICtrlCreateInput("IWebsite", 56, 8, 121, 21)
$BCheck = GUICtrlCreateButton("Check", 192, 16, 75, 41)
$Label1 = GUICtrlCreateLabel("Website", 7, 10, 43, 17)
$IKeyword = GUICtrlCreateInput("IKeyword", 56, 40, 121, 21)
$Label2 = GUICtrlCreateLabel("Keyword", 8, 42, 45, 17)
$EResult = GUICtrlCreateEdit("", 8, 72, 257, 321)
GUICtrlSetData(-1, "EResult")
#EndRegion ### END Koda GUI section ###
