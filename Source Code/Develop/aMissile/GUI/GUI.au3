#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Lap Trinh\AutoIT\Develop\SaiGUIv2.02\SaiGUI.kxf
$MainGUI = GUICreate("SaiGUI", 296, 169, 218, 140, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$BHidden = GUICtrlCreateButton("/\", 260, 136, 27, 25, 0)
GUICtrlSetTip(-1, "Minimize Tool")
GUICtrlSetOnEvent(-1, "BHiddenClick")
$LNotice = GUICtrlCreateLabel("Notice...", 10, 144, 44, 17, BitOR($SS_BLACKRECT,$SS_GRAYFRAME,$SS_LEFTNOWORDWRAP))
$BHomePage = GUICtrlCreateButton("?", 229, 136, 27, 25, 0)
GUICtrlSetOnEvent(-1, "BHomePageClick")
#EndRegion ### END Koda GUI section ###