#include <ButtonConstants.au3>
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
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

