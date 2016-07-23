#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=C:\xampp\htdocs\aTester\GUI\Window\MainGUI\MainGUI.kxf
$MainGUI = GUICreate("MainGUI", 450, 323, 192, 124, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FAutoEnd")
$LNotice = GUICtrlCreateLabel("Notice....", 8, 296, 47, 17, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BHidden = GUICtrlCreateButton("/\", 416, 288, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$BPause = GUICtrlCreateButton("< >", 384, 288, 27, 25, $BS_NOTIFY)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Pause")
$Label1 = GUICtrlCreateLabel("File upload", 256, 8, 55, 17)
$EFilesUpload = GUICtrlCreateEdit("", 256, 32, 185, 129)
GUICtrlSetData(-1, "EFilesUpload")
$FTPServer = GUICtrlCreateGroup(" FTP Server ", 8, 8, 233, 153)
$Label2 = GUICtrlCreateLabel("Host: ", 16, 32, 32, 17)
$IHostAddress = GUICtrlCreateInput("IHostAddress", 56, 30, 177, 21)
$Label3 = GUICtrlCreateLabel("User: ", 16, 64, 32, 17)
$IUsername = GUICtrlCreateInput("IUsername", 56, 64, 177, 21)
$Pass = GUICtrlCreateLabel("Pass:", 16, 96, 30, 17)
$IPassword = GUICtrlCreateInput("IPassword", 56, 96, 177, 21)
$Label4 = GUICtrlCreateLabel("Folder:", 16, 130, 36, 17)
$IFolder = GUICtrlCreateInput("IFolder", 56, 128, 177, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group1 = GUICtrlCreateGroup(" Option ", 8, 176, 233, 105)
$CReplacePattern = GUICtrlCreateCheckbox("Replace Pattern", 16, 200, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$BStart = GUICtrlCreateButton("Start", 288, 216, 99, 41)
$BHelp = GUICtrlCreateButton("?", 352, 288, 27, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
