#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=e:\programming\autoit\develop\asensor\gui\window\maingui\maingui.kxf
$MainGUI = GUICreate("MainGUI", 260, 420, 192, 124, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 400, 47, 17, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BHidden = GUICtrlCreateButton("/\", 224, 392, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BPause = GUICtrlCreateButton("< >", 192, 392, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Pause")
$TMain = GUICtrlCreateTab(-2, 0, 257, 385)
GUICtrlSetResizing(-1, $GUI_DOCKVCENTER)
$TabSheet1 = GUICtrlCreateTabItem("Command")
$Password = GUICtrlCreateLabel("Password:", 8, 34, 53, 17)
$IPassword = GUICtrlCreateInput("123qwe", 72, 32, 169, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$ECommandList = GUICtrlCreateEdit("", 8, 82, 241, 297)
GUICtrlSetData(-1, "ECommandList")
$IPAddress = GUICtrlCreateLabel("IP Address:", 8, 58, 58, 17)
$IIPAddress = GUICtrlCreateInput("IIPAddress", 72, 56, 169, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_READONLY))
$TabSheet2 = GUICtrlCreateTabItem("Sensor")
$CHThumb = GUICtrlCreateCheckbox("Thumb", 10, 54, 97, 17)
$Label1 = GUICtrlCreateLabel("Fingers", 18, 30, 56, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$CHIndex = GUICtrlCreateCheckbox("Index Finger", 10, 78, 97, 17)
$CHMiddle = GUICtrlCreateCheckbox("Middle Finger", 10, 102, 97, 17)
$CHRing = GUICtrlCreateCheckbox("Ring Finger", 10, 126, 97, 17)
$CHPinky = GUICtrlCreateCheckbox("Pinky", 10, 150, 97, 17)
$Label2 = GUICtrlCreateLabel("Hand Motion", 134, 32, 91, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$RHandUp = GUICtrlCreateRadio("Hand Up", 126, 56, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RHandDown = GUICtrlCreateRadio("Hand Down", 126, 80, 113, 17)
$RHandLeft = GUICtrlCreateRadio("Hand Left", 126, 104, 113, 17)
$RHandRight = GUICtrlCreateRadio("Hand Right", 126, 128, 113, 17)
$RHandShake = GUICtrlCreateRadio("Hand Shake", 126, 152, 113, 17)
$BSensorAdd = GUICtrlCreateButton("Add", 142, 182, 51, 25)
$COFuncList = GUICtrlCreateCombo("", 6, 184, 121, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, " - Choose One -", " - Choose One -")
$BSensorDel = GUICtrlCreateButton("Delete", 198, 182, 51, 25)
$LISensorFuncList = GUICtrlCreateList("", 4, 211, 250, 162)
GUICtrlCreateTabItem("")
#EndRegion ### END Koda GUI section ###
