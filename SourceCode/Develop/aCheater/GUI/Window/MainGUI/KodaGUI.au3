#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=e:\programming\autoit\develop\acheater\gui\window\maingui\maingui.kxf
$MainGUI = GUICreate("MainGUI", 309, 218, 192, 124, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 192, 47, 17, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BHidden = GUICtrlCreateButton("/\", 264, 184, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BPause = GUICtrlCreateButton("< >", 232, 184, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Pause")
$MainTab = GUICtrlCreateTab(0, 32, 305, 145)
$Step123 = GUICtrlCreateTabItem("Step2&3")
$Label1 = GUICtrlCreateLabel("Heath:", 8, 88, 36, 17)
$LStep1Heath = GUICtrlCreateLabel("99999999999999999999", 72, 88, 124, 17)
$Label2 = GUICtrlCreateLabel("Change to:", 8, 112, 56, 17)
$IStep1ChangeTo = GUICtrlCreateInput("1000", 72, 112, 121, 21)
$BStep1ChangeTo = GUICtrlCreateButton("Change", 72, 144, 75, 25)
$Label3 = GUICtrlCreateLabel("Address:", 8, 64, 45, 17)
$IStep1Address = GUICtrlCreateInput("IStep1Address", 72, 62, 121, 21)
$StepX = GUICtrlCreateTabItem("Step 4")
$Label5 = GUICtrlCreateLabel("Address:", 9, 64, 45, 17)
$Label6 = GUICtrlCreateLabel("Heath/Ammo:", 9, 88, 70, 17)
$Label7 = GUICtrlCreateLabel("Change to:", 9, 112, 56, 17)
$IStep2ChangeTo = GUICtrlCreateInput("5000", 73, 112, 49, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$LStep2Heath = GUICtrlCreateLabel("99999999999999999", 79, 88, 106, 17)
$IStep2Address = GUICtrlCreateInput("IStep2Address", 73, 62, 129, 21)
$BStep2ChangeTo = GUICtrlCreateButton("Change", 65, 144, 75, 25)
$COStep2DataType = GUICtrlCreateCombo("", 136, 112, 73, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "DWORD|float|double", "DWORD")
$TabSheet1 = GUICtrlCreateTabItem("Step 5")
$Label8 = GUICtrlCreateLabel("Code address:", 8, 64, 72, 17)
$IStep5CodeAddress = GUICtrlCreateInput("IStep5CodeAddress", 88, 62, 121, 21)
$Label9 = GUICtrlCreateLabel("New add value:", 8, 94, 79, 17)
$IStep5NewAddValue = GUICtrlCreateInput("IStep5NewAddValue", 88, 92, 121, 21)
$BStep5ChangeValue = GUICtrlCreateButton("Change Value", 64, 128, 75, 33)
$TabSheet2 = GUICtrlCreateTabItem("Step 6")
$Label10 = GUICtrlCreateLabel("Pointer:", 8, 66, 40, 17)
$IStep6Pointer = GUICtrlCreateInput("IStep6Pointer", 56, 64, 121, 21)
$IStep6ChangeTo = GUICtrlCreateInput("IStep6ChangeTo", 56, 116, 121, 21)
$Label11 = GUICtrlCreateLabel("Change:", 8, 118, 44, 17)
$Label12 = GUICtrlCreateLabel("Value:", 8, 91, 34, 17)
$LStep6Value = GUICtrlCreateLabel("99999999999999999999", 56, 91, 144, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor (-1, 0)
$BStep6ChangeTo = GUICtrlCreateButton("Change to", 24, 144, 75, 25)
$CHStep6Freeze = GUICtrlCreateCheckbox("Freeze", 112, 148, 97, 17)
$TabSheet3 = GUICtrlCreateTabItem("Step 7")
$Label13 = GUICtrlCreateLabel("Inject Address:", 8, 66, 74, 17)
$IStep7Address = GUICtrlCreateInput("IStep7Address", 96, 64, 121, 21)
$BStep7Inject = GUICtrlCreateButton("Inject", 24, 120, 83, 41)
$BStep7Restore = GUICtrlCreateButton("Restore", 144, 120, 83, 41)
$Label14 = GUICtrlCreateLabel("Value of add:", 8, 93, 67, 17)
$LStep7AddValue = GUICtrlCreateLabel("0x99999999999999", 96, 93, 115, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor (-1, 0)
$TabSheet4 = GUICtrlCreateTabItem("Step8")
GUICtrlSetState(-1,$GUI_SHOW)
$Label15 = GUICtrlCreateLabel("Pointer:", 7, 64, 40, 17)
$IStep8Pointer = GUICtrlCreateInput("IStep8Pointer", 55, 62, 209, 21)
$LStep8Value = GUICtrlCreateLabel("99999999999999999999", 55, 89, 144, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor (-1, 0)
$Label17 = GUICtrlCreateLabel("Value:", 7, 89, 34, 17)
$Label18 = GUICtrlCreateLabel("Change:", 7, 116, 44, 17)
$IStep8ChangeTo = GUICtrlCreateInput("IStep8ChangeTo", 55, 114, 121, 21)
$BStep8ChangeTo = GUICtrlCreateButton("Change to", 23, 142, 75, 25)
$CHStep8Freeze = GUICtrlCreateCheckbox("Freeze", 111, 146, 97, 17)
GUICtrlCreateTabItem("")
$Label4 = GUICtrlCreateLabel("Process Name:", 8, 8, 76, 17)
$IProcessName = GUICtrlCreateInput("IProcessName", 88, 6, 121, 21)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
