; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>
#include <FileConstants.au3>
#include "PressedShiftEnterToGoUnderLine.au3"
; #RequireAdmin

OPt
Local  $guiHandle = GUICreate("", 320, 640, 1030, 0, $WS_OVERLAPPEDWINDOW)
GUISetIcon("..\icons\ico500.ico", $guiHandle)

;	Creates Menu File
;   Only have MenuItem in Menu

Local  $idFileMenu = GUICtrlCreateMenu("File")
Local  $idFileMenuItem_NewFile = GUICtrlCreateMenuItem("New File"  & @TAB & @TAB & @TAB & "Ctrl + N", $idFileMenu) ; Creates a Menu control for the GUI
Local  $idFileMenuItem_OpenFile = GUICtrlCreateMenuItem("Open File...", $idFileMenu) ; Creates a MenuItem control for the GUI
Local  $idFileMenuItem_OpenFolder = GUICtrlCreateMenuItem("Open Folder...", $idFileMenu)
Local  $idFileMenuItem_OpenRecent = GUICtrlCreateMenu("Open Recent...", $idFileMenu)
	Local  $idFileMenuItem_OpenRecentItem_Reopen_Closed_File = GUICtrlCreateMenuItem("Reopen Closed File", $idFileMenuItem_OpenRecent)
	Local  $idFileMenuItem_OpenRecentItem_Clear_Items = GUICtrlCreateMenuItem("Clear Items", $idFileMenuItem_OpenRecent)
Local  $idFileMenuItem_ReopenwithEncoding = GUICtrlCreateMenu("Reopen with Encoding", $idFileMenu)
Local  $idFileMenuItem_NewViewintoFile = GUICtrlCreateMenuItem("New View into File", $idFileMenu)
Local  $idFileMenuItem_Save = GUICtrlCreateMenuItem("Save", $idFileMenu)
Local  $idFileMenuItem_SavewithEncoding = GUICtrlCreateMenu("Save with Encoding", $idFileMenu)
Local  $idFileMenuItem_SaveAs = GUICtrlCreateMenuItem("Save As...", $idFileMenu)
Local  $idFileMenuItem_SaveAll = GUICtrlCreateMenuItem("Save All", $idFileMenu)
GUICtrlCreateMenuItem("", $idFileMenu, 10) ; Create a separator line
Local  $idFileMenuItem_NewWindow = GUICtrlCreateMenuItem("New Window", $idFileMenu)
Local  $idFileMenuItem_CloseWindow = GUICtrlCreateMenuItem("Close Window", $idFileMenu)
GUICtrlCreateMenuItem("", $idFileMenu, 13) ; Create a separator line
Local  $idFileMenuItem_CloseFile = GUICtrlCreateMenuItem("Close File", $idFileMenu)
Local  $idFileMenuItem_RevertFile = GUICtrlCreateMenuItem("Revert File", $idFileMenu)
Local  $idFileMenuItem_CloseAllFiles = GUICtrlCreateMenuItem("Close All Files", $idFileMenu)
GUICtrlCreateMenuItem("", $idFileMenu, 17) ; Create a separator line
Local  $idFileMenuItem_Exit = GUICtrlCreateMenuItem("Exit", $idFileMenu)
;   Ended

;   Creates Menu Edit
Local  $idEditMenu = GUICtrlCreateMenu("Edit")
;   Ended

;   Creates Menu Selection
Local  $idSelectionMenu = GUICtrlCreateMenu("Selection")
;   Ended

;   Creates Menu Find
Local  $idFindMenu = GUICtrlCreateMenu("Find")
;   Ended

;   Creates Menu View
Local  $idViewMenu = GUICtrlCreateMenu("View")
;   Ended

;   Creates Menu Goto
Local  $idGotoMenu = GUICtrlCreateMenu("Goto")
;   Ended

;   Creates Menu Tools
Local  $idToolMenu = GUICtrlCreateMenu("Tools")
;   Ended

;   Creates Menu Project
Local  $idProjectMenu = GUICtrlCreateMenu("Project")
;   Ended

;   Creates Menu Preferences
Local  $idPreferenceMenu = GUICtrlCreateMenu("Preferences")
;   Ended
;   Creates Menu Help
Local  $idHelpMenu = GUICtrlCreateMenu("Help")
Local  $idHelpMenuItem_Documentation = GUICtrlCreateMenuItem("Documentation", $idHelpMenu)
Local  $idHelpMenuItem_Twiter = GUICtrlCreateMenuItem("Twiter", $idHelpMenu)
GUICtrlCreateMenuItem("", $idHelpMenu, 3)
Local  $idHelpMenuItem_RemoveLicense = GUICtrlCreateMenuItem("RemoveLicense", $idHelpMenu)
GUICtrlCreateMenuItem("", $idHelpMenu, 4)
Local  $idHelpMenuItem_Update = GUICtrlCreateMenuItem("Check for Update...", $idHelpMenu)
Local  $idHelpMenuItem_Changelog = GUICtrlCreateMenuItem("Changelog...", $idHelpMenu)
Local  $idHelpMenuItem_About = GUICtrlCreateMenuItem("About Software", $idHelpMenu)
;   Ended
#comments-start
# Sets the accelerator table to be used in a GUI window (Short Key)
#comments-end

Local   $shortKeyFunctions = [ _
                                ["^n", $idFileMenuItem_OpenFile], _ 
                                ["^+n", $idFileMenuItem_OpenFolder] _
                             ]
                                ; ["shortKey", controlID]
GUISetAccelerators($shortKeyFunctions)
#comments-start
# Creates a ContextMenu for the GUI
#comments-end
Local   $controlContextMenu = GUICtrlCreateContextMenu()
Local   $controlContextMenu_Menu = GUICtrlCreateMenu("File", $controlContextMenu)
Local   $controlContextMenu_Menu = GUICtrlCreateMenuItem("Edit", $controlContextMenu)
Local   $controlContextMenu_Menu = GUICtrlCreateMenu("Selection", $controlContextMenu)
Local   $controlContextMenu_Menu = GUICtrlCreateMenu("Find", $controlContextMenu)
Local   $controlContextMenu_Menu = GUICtrlCreateMenu("View", $controlContextMenu)
Local   $controlContextMenu_Menu = GUICtrlCreateMenu("Goto", $controlContextMenu)
;   Creates a Tab control for the GUI
Local  $controlTab = GUICtrlCreateTab(-1, -1, $TCS_RAGGEDRIGHT + $TCS_HOTTRACK)
GUISetBkColor(0x00E0FFFF)   ; Sets the background color of a GUI
; GUICtrlSetColor(controlID, textcolor)   ; Sets the background color of a control
GUISetFont(9, 300)

GUICtrlCreateTab(10, 10, 200, 100)
Local   $fileStudentHandle = FileOpen("File_Student.txt"), _
        $fileObjectHandle = FileOpen("File_Object.txt"), _
        $fileResultHandle = FileOpen("File_Result.txt"), _
        $i = 1

Local  $controlTabItem_Student = GUICtrlCreateTabItem("Student")
Local  $controlTabItem_Student_ListView = GUICtrlCreateListView("Student_ID| Student_Name| Date of birth| Sex| Class| Adress", 0, 20, 320, 640)
; GUICtrlSetTip($controlTabItem_Student_ListView, "Included informations of the students", "Tip")
GUICtrlSetFont($controlTabItem_Student_ListView, Default, $FW_BOLD)

While True
    FileReadLine($fileStudentHandle, $i)
    If Not @error Then
        GUICtrlCreateListViewItem($i & "|" & FileReadLine($fileStudentHandle, $i), $controlTabItem_Student_ListView)
        $i += 1
    Else
        $i = 1
        ExitLoop
    EndIf
WEnd

Local  $controlTabItem_Object = GUICtrlCreateTabItem("Object")
Local  $controlTabItem_Object_ListView = GUICtrlCreateListView("Object_ID| Object_Name", 0, 20, 320, 640)
GUICtrlSetFont($controlTabItem_Object_ListView, Default, $FW_BOLD)
While True
    FileReadLine($fileObjectHandle, $i)
    If Not @error Then
        GUICtrlCreateListViewItem(FileReadLine($fileObjectHandle, $i), $controlTabItem_Object_ListView)
        $i += 1
    Else
        $i = 1
        ExitLoop
    EndIf
WEnd

Local  $controlTabItem_Result = GUICtrlCreateTabItem("Result")
Local  $controlTabItem_Result_ListView = GUICtrlCreateListView("Object_ID| Student_ID| Result", 0, 20, 320, 640)
GUICtrlSetFont($controlTabItem_Result_ListView, Default, $FW_BOLD)
While True
    FileReadLine($fileResultHandle, $i)
    If Not @error Then
        GUICtrlCreateListViewItem(FileReadLine($fileResultHandle, $i), $controlTabItem_Result_ListView)
        $i += 1
    Else
        $i = 1
        ExitLoop
    EndIf
WEnd

GUICtrlSetState(-1, $GUI_SHOW) ; will be display first

Local  $controlTabItem_Query = GUICtrlCreateTabItem("Query")
Local  $controlTabItem_Query_Input = GUICtrlCreateInput("", -1, -1, 320, 21*6, $ES_WANTRETURN + $WS_VSCROLL + $ES_AUTOVSCROLL + $ES_MULTILINE)
GUICtrlCreateLabel("Result", 5, 21*8)
GUICtrlCreateTabItem("") ; end tabitem definition
;   Ended
GUISetState(@SW_SHOW, $guiHandle)
While True
    _Shift_Enter($controlTabItem_Query_Input)
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $idFileMenuItem_Exit
            Exit
        Case $idFileMenuItem_OpenFile
        	Global $filePath = FileOpenDialog("Open", "", "All File (*.*)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)
        Case $idFileMenuItem_OpenFolder
            Global  $folderOpen = FileSelectFolder("Select Folder", "")
    EndSwitch
WEnd