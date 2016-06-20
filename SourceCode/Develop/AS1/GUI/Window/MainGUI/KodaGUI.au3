#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Lap Trinh\AutoIT\Develop\AS1\GUI\Window\MainGUI\MainGUI.kxf
$MainGUI = GUICreate("MainGUI", 259, 160, 192, 124, BitOR($WS_MINIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 136, 47, 17)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BHidden = GUICtrlCreateButton("/\", 216, 128, 27, 25, $WS_GROUP)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BPause = GUICtrlCreateButton("< >", 184, 128, 27, 25, $WS_GROUP)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Pause")
$BStart = GUICtrlCreateButton("BStart", 176, 8, 75, 25, $WS_GROUP)
$ELog = GUICtrlCreateEdit("", 0, 0, 161, 129)
GUICtrlSetData(-1, "ELog")
#EndRegion ### END Koda GUI section ###
