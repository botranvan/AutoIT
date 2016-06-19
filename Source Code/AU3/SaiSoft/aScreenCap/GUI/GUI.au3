#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Lap Trinh\AutoIT\Develop\aScreenCap\aScreenCap.kxf
$MainGUI = GUICreate("SaiGUI", 296, 169, 218, 140, -1, BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$BHidden = GUICtrlCreateButton("/\", 260, 136, 27, 25, 0)
GUICtrlSetTip(-1, "Minimize Tool")
GUICtrlSetOnEvent(-1, "BHiddenClick")
$LNotice = GUICtrlCreateLabel("Notice...", 10, 144, 44, 17, BitOR($SS_BLACKRECT,$SS_GRAYFRAME,$SS_LEFTNOWORDWRAP))
$BHomePage = GUICtrlCreateButton("?", 229, 136, 27, 25, 0)
GUICtrlSetOnEvent(-1, "BHomePageClick")
$Label1 = GUICtrlCreateLabel("Save in:", 8, 10, 43, 17)
$ISaveIn = GUICtrlCreateInput("ISaveIn", 56, 8, 201, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY))
$Group1 = GUICtrlCreateGroup("Cap Mode ", 8, 40, 81, 81)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$RCapMod1 = GUICtrlCreateRadio("Desktop", 16, 64, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "RCapMod1Click")
$RCapMod2 = GUICtrlCreateRadio("Window", 16, 88, 65, 17)
GUICtrlSetOnEvent(-1, "RCapMod2Click")
$BSaveIn = GUICtrlCreateButton("...", 264, 6, 27, 25, $WS_GROUP)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
GUICtrlSetOnEvent(-1, "BSaveInClick")
$COCapKey = GUICtrlCreateCombo("", 240, 48, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11")
GUICtrlSetOnEvent(-1, "COCapKeyChange")
$Label2 = GUICtrlCreateLabel("Caputre hot key", 136, 50, 93, 19)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$CHCapCursor = GUICtrlCreateCheckbox("Capture cursor", 136, 80, 97, 17)
GUICtrlSetOnEvent(-1, "CHCapCursorClick")
#EndRegion ### END Koda GUI section ###