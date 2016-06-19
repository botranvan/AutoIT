#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=F:\Lap Trinh\AutoIT\Develop\aFlashGame\aFlashGame.kxf
$MainGUI = GUICreate("Sai GUI v1.0 | 72ls.NET", 601, 451, 194, 139, BitOR($WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS), 0)
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$Hidden_B = GUICtrlCreateButton("/\", 572, 429, 27, 20, 0)
GUICtrlSetOnEvent(-1, "Hidden_BClick")
$Waring_L = GUICtrlCreateLabel("72ls.NET is a LeeSai's Web ....", 2, 432, 151, 17)
$HomePage_B = GUICtrlCreateButton("?", 541, 429, 27, 20, 0)
GUICtrlSetOnEvent(-1, "HomePage_BClick")
#EndRegion ### END Koda GUI section ###
