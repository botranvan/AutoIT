#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Lap Trinh\AutoIT\Develop\aPixelChecker\aPixelChecker.kxf
$MainGUI = GUICreate("SaiGUI", 296, 169, 218, 140, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$BHidden = GUICtrlCreateButton("/\", 260, 136, 27, 25, 0)
GUICtrlSetTip(-1, "Minimize Tool")
GUICtrlSetOnEvent(-1, "BHiddenClick")
$LNotice = GUICtrlCreateLabel("Notice...", 10, 144, 44, 17, BitOR($SS_BLACKRECT,$SS_GRAYFRAME,$SS_LEFTNOWORDWRAP))
$BHomePage = GUICtrlCreateButton("?", 229, 136, 27, 25, 0)
GUICtrlSetOnEvent(-1, "BHomePageClick")
$Label1 = GUICtrlCreateLabel("Pixel:", 8, 8, 41, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
$Label2 = GUICtrlCreateLabel("Mouse:", 8, 40, 49, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
$LPixel = GUICtrlCreateLabel("0x00000000", 72, 8, 75, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
GUICtrlSetOnEvent(-1, "LPixelClick")
$LMousePos = GUICtrlCreateLabel("99999,99999", 72, 40, 78, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
GUICtrlSetOnEvent(-1, "LMousePosClick")
$LColor = GUICtrlCreateLabel("LColor", 184, 8, 46, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
GUICtrlSetOnEvent(-1, "LColorClick")
#EndRegion ### END Koda GUI section ###
