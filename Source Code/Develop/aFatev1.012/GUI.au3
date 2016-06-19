#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=D:\Downloads\aFate\aFate.kxf
$MainGUI = GUICreate("Sai GUI v1.0 | 72ls.NET", 218, 152, 398, 154, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$Hidden_B = GUICtrlCreateButton("/\", 188, 128, 27, 20, $BS_NOTIFY)
GUICtrlSetOnEvent(-1, "Hidden_BClick")
$Waring_L = GUICtrlCreateLabel("72ls.NET is a LeeSai's Web ....", 2, 133, 151, 17, 0)
$HomePage_B = GUICtrlCreateButton("?", 157, 128, 27, 20, $BS_NOTIFY)
GUICtrlSetOnEvent(-1, "HomePage_BClick")
$Label1 = GUICtrlCreateLabel("Gold:", 8, 8, 29, 17)
$LGold = GUICtrlCreateLabel("00000000", 40, 8, 52, 17)
$Label2 = GUICtrlCreateLabel("HP:", 8, 24, 22, 17)
$CurHPL = GUICtrlCreateLabel("0000", 35, 24, 28, 17, $SS_RIGHT)
$Label3 = GUICtrlCreateLabel("/", 66, 24, 9, 17)
$MaxHPL = GUICtrlCreateLabel("0000", 72, 24, 28, 17)
#EndRegion ### END Koda GUI section ###
