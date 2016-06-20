#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Dropbox\AutoIT\Develop\aMegaman\GUI\Window\MainGUI\MainGUI.kxf
$MainGUI = GUICreate("MainGUI", 359, 157, 192, 124, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 136, 47, 17, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BHidden = GUICtrlCreateButton("/\", 328, 128, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BPause = GUICtrlCreateButton("< >", 296, 128, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Pause")
$Label1 = GUICtrlCreateLabel("Char Position:", 8, 8, 69, 17)
$LCharPos = GUICtrlCreateLabel("9999x9999", 76, 8, 67, 19)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor (-1, 0)
$Label2 = GUICtrlCreateLabel("Ground Pos:", 8, 32, 63, 17)
$LGroundPos = GUICtrlCreateLabel("9999x9999", 76, 31, 67, 19)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor (-1, 0)
$LGroundSize = GUICtrlCreateLabel("9999x9999", 76, 49, 67, 19)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor (-1, 0)
$Label3 = GUICtrlCreateLabel("Ground Size", 8, 50, 62, 17)
#EndRegion ### END Koda GUI section ###
