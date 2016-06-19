#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=D:\Dropbox\TL-Fishing\TL-Fishing.kxf
$MainGUI = GUICreate("SaiGUI", 233, 144, 400, 274, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$BHidden = GUICtrlCreateButton("/\", 196, 112, 27, 25, 0)
GUICtrlSetTip(-1, "Minimize Tool")
GUICtrlSetOnEvent(-1, "BHiddenClick")
$LNotice = GUICtrlCreateLabel("Notice...", 10, 120, 44, 17, BitOR($SS_BLACKRECT,$SS_GRAYFRAME,$SS_LEFTNOWORDWRAP))
$BHomePage = GUICtrlCreateButton("?", 165, 112, 27, 25, 0)
GUICtrlSetOnEvent(-1, "BHomePageClick")
$LFishingHole = GUICtrlCreateLabel("9999:9999", 160, 8, 63, 19, $SS_CENTER)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetTip(-1, "Click here")
GUICtrlSetCursor (-1, 0)
GUICtrlSetOnEvent(-1, "LFishingHoleClick")
$LHookButton = GUICtrlCreateLabel("Toa do cua nut hinh moc cau:", 8, 37, 147, 17)
$LHook = GUICtrlCreateLabel("9999:9999", 160, 37, 63, 19, $SS_CENTER)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetTip(-1, "Click here")
GUICtrlSetCursor (-1, 0)
GUICtrlSetOnEvent(-1, "LHookClick")
$BStart = GUICtrlCreateButton("Bat Dau", 144, 64, 75, 33, $WS_GROUP)
GUICtrlSetOnEvent(-1, "BStartClick")
$LIsFishing = GUICtrlCreateLabel("Dang Cau Ca", 40, 64, 68, 17, $SS_CENTER)
$LIsCaught = GUICtrlCreateLabel("Ca chua can cau", 33, 88, 86, 17, $SS_CENTER)
$LFishingButton = GUICtrlCreateLabel("Toa do cua nut [Fishing Hole]", 8, 8, 144, 17)
#EndRegion ### END Koda GUI section ###