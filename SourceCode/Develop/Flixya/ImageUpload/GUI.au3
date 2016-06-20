#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=F:\Lap Trinh\AutoIT\Develop\Flixya\ImageUpload\FYImage.kxf
$MainGUI = GUICreate("Sai GUI v1.0 | 72ls.NET", 218, 152, 398, 154, BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS), $WS_EX_TOPMOST)
GUISetOnEvent($GUI_EVENT_CLOSE, "MainGUIClose")
$Hidden_B = GUICtrlCreateButton("/\", 188, 128, 27, 20, 0)
GUICtrlSetOnEvent(-1, "Hidden_BClick")
$Waring_L = GUICtrlCreateLabel("72ls.NET is a LeeSai's Web ....", 2, 133, 151, 17)
$HomePage_B = GUICtrlCreateButton("?", 157, 128, 27, 20, 0)
GUICtrlSetOnEvent(-1, "HomePage_BClick")
$Label1 = GUICtrlCreateLabel("Folder", 8, 9, 39, 17)
GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
$ImagesPathI = GUICtrlCreateInput("D:\image", 48, 5, 161, 21)
$ImageGetB = GUICtrlCreateButton("Get Images", 8, 32, 75, 25, $WS_GROUP)
GUICtrlSetOnEvent(-1, "ImageGetBClick")
$ImageGetL = GUICtrlCreateLabel("Found ????? Images", 96, 40, 104, 17)
$ImageUpL = GUICtrlCreateLabel("Uploaded ????? / ????? Images", 32, 64, 161, 17)
#EndRegion ### END Koda GUI section ###
