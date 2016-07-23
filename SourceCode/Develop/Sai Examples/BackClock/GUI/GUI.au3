#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Sai\Lap Trinh\AutoIT\Develop\BackClock\BackClock.kxf
$MainGUI = GUICreate("SaiGUI", 296, 169, 218, 140, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$BHidden = GUICtrlCreateButton("/\", 260, 136, 27, 25, 0)
GUICtrlSetTip(-1, "Minimize Tool")
GUICtrlSetOnEvent(-1, "BHiddenClick")
$LNotice = GUICtrlCreateLabel("Notice...", 10, 144, 44, 17)
$BHomePage = GUICtrlCreateButton("?", 229, 136, 27, 25, 0)
GUICtrlSetOnEvent(-1, "BHomePageClick")
$Clock = GUICtrlCreateLabel("00:00 00", 96, 48, 102, 33)
GUICtrlSetFont(-1, 18, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
#EndRegion ### END Koda GUI section ###
