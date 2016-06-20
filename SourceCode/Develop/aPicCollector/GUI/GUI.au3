#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Lap Trinh\AutoIT\Develop\aPicCollector\aPicCollector.kxf
$MainGUI = GUICreate("SaiGUI", 296, 161, 218, 140, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$BHidden = GUICtrlCreateButton("/\", 260, 128, 27, 25, 0)
GUICtrlSetTip(-1, "Minimize Tool")
GUICtrlSetOnEvent(-1, "BHiddenClick")
$LNotice = GUICtrlCreateLabel("Notice...", 10, 136, 44, 17, BitOR($SS_BLACKRECT,$SS_GRAYFRAME,$SS_LEFTNOWORDWRAP))
$BHomePage = GUICtrlCreateButton("?", 229, 128, 27, 25, 0)
GUICtrlSetOnEvent(-1, "BHomePageClick")
$Label1 = GUICtrlCreateLabel("Key word:", 8, 10, 51, 17)
$IKeyWord = GUICtrlCreateInput("3D Girl", 64, 6, 137, 21)
$RAnySize = GUICtrlCreateRadio("Any size", 8, 104, 80, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "RAnySizeClick")
$RLargerThan = GUICtrlCreateRadio("Larger than...", 8, 40, 80, 17)
GUICtrlSetOnEvent(-1, "RLargerThanClick")
$RExactly = GUICtrlCreateRadio("Exactly...", 8, 72, 80, 17)
GUICtrlSetOnEvent(-1, "RExactlyClick")
$BSearch = GUICtrlCreateButton("Search", 208, 5, 75, 25, $WS_GROUP)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetOnEvent(-1, "BSearchClick")
$COLargerThan = GUICtrlCreateCombo("", 96, 40, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "1024x768|1600x1200|2816x2112|3648x2736|4480x3360")
GUICtrlSetOnEvent(-1, "COLargerThanChange")
$IExaxtlyWidth = GUICtrlCreateInput("1024", 96, 70, 41, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
$Label2 = GUICtrlCreateLabel("X", 144, 72, 11, 17)
$IExaxtlyHeight = GUICtrlCreateInput("768", 160, 70, 41, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
#EndRegion ### END Koda GUI section ###