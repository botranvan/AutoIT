#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=D:\EritProject\AutoIT\aCollector\aCollector.kxf
$MainGUI = GUICreate("Sai GUI v1.0 | 72ls.NET", 218, 153, 398, 154, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$Hidden_B = GUICtrlCreateButton("/\", 188, 128, 27, 20, $BS_NOTIFY)
GUICtrlSetOnEvent(-1, "Hidden_BClick")
$Waring_L = GUICtrlCreateLabel("72ls.NET is a LeeSai's Web ....", 2, 133, 151, 17, 0)
$HomePage_B = GUICtrlCreateButton("?", 157, 128, 27, 20, $BS_NOTIFY)
GUICtrlSetOnEvent(-1, "HomePage_BClick")
$bStart = GUICtrlCreateButton("Start", 8, 8, 75, 25)
GUICtrlSetOnEvent(-1, "bStartClick")
$inKey = GUICtrlCreateInput("Ring", 40, 40, 169, 21)
$ipPage = GUICtrlCreateInput("0", 128, 9, 33, 21)
$Page = GUICtrlCreateLabel("Page:", 96, 12, 32, 17)
$Label1 = GUICtrlCreateLabel("Size:", 40, 77, 27, 17)
$ipWidth = GUICtrlCreateInput("0", 72, 72, 57, 21)
$ipHeight = GUICtrlCreateInput("0", 151, 72, 57, 21)
$Label2 = GUICtrlCreateLabel("X", 135, 77, 11, 17)
$ipPageItem = GUICtrlCreateInput("18", 175, 9, 33, 21)
$Label3 = GUICtrlCreateLabel("/", 166, 12, 9, 17)
$Label4 = GUICtrlCreateLabel("Key:", 11, 43, 25, 17)
#EndRegion ### END Koda GUI section ###
