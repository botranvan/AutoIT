#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Lap Trinh\AutoIT\Develop\Pinball\Pinball.kxf
$MainGUI = GUICreate("Sai GUI v1.0 | 72ls.NET", 218, 152, 398, 154, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$Hidden_B = GUICtrlCreateButton("/\", 188, 128, 27, 20, 0)
GUICtrlSetOnEvent(-1, "Hidden_BClick")
$Waring_L = GUICtrlCreateLabel("72ls.NET is a LeeSai's Web ....", 2, 133, 151, 17)
$HomePage_B = GUICtrlCreateButton("?", 157, 128, 27, 20, 0)
GUICtrlSetOnEvent(-1, "HomePage_BClick")
$Label1 = GUICtrlCreateLabel("Scores:", 8, 8, 40, 17, $WS_GROUP)
$LGold = GUICtrlCreateLabel("00000000", 48, 8, 52, 17, $WS_GROUP)
#EndRegion ### END Koda GUI section ###