#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Dropbox\AutoIT\Develop\MelonUpdate\GUI\Window\MainGUI\MainGUI.kxf
$MainGUI = GUICreate("MainGUI", 125, 101, 250, 184, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$Label1 = GUICtrlCreateLabel("Count:", 16, 8, 35, 17)
$LCount = GUICtrlCreateLabel("0000", 56, 8, 28, 17)
$Label2 = GUICtrlCreateLabel("Update:", 8, 32, 42, 17)
$LDone = GUICtrlCreateLabel("xxxxxxxxxxx", 56, 32, 59, 17)
$BStart = GUICtrlCreateButton("Start", 24, 56, 75, 25)
#EndRegion ### END Koda GUI section ###
