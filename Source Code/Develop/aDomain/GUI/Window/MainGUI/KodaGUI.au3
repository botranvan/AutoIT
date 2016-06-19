#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=e:\programming\autoit\develop\adomain\gui\window\maingui\maingui.kxf
$MainGUI = GUICreate("MainGUI", 258, 139, 192, 124, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 120, 47, 17, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BHidden = GUICtrlCreateButton("/\", 224, 112, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BPause = GUICtrlCreateButton("< >", 192, 112, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Pause")
$Label1 = GUICtrlCreateLabel("Computer IP:", 8, 8, 65, 17)
$Label2 = GUICtrlCreateLabel("Domain IP:", 8, 32, 56, 17)
$LComputerIP = GUICtrlCreateLabel("000.000.000.000", 80, 8, 85, 17)
$LDomainIP = GUICtrlCreateLabel("000.000.000.000", 80, 32, 85, 17)
$Label3 = GUICtrlCreateLabel("Repeat Time:", 8, 58, 68, 17)
$IRepeatTime = GUICtrlCreateInput("IRepeatTime", 80, 56, 81, 21)
$BStart = GUICtrlCreateButton("Start", 176, 16, 75, 49)
$CHShowIE = GUICtrlCreateCheckbox("Show Internet Explorer", 8, 88, 185, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
