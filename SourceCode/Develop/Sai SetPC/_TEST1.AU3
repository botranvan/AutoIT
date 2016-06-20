#include <GUIConstants.au3>

;Initialize variables
Global $GUIWidth
Global $GUIHeight
Global $FuncVar

$GUIWidth = 300
$GUIHeight = 250

;Create window
GUICreate("New GUI", $GUIWidth, $GUIHeight)

;Create an edit box with no text in it
$Edit_1 = GUICtrlCreateEdit("", 10, 10, 280, 190)

;Create an "Assign Text to Variable" button
$Assign_Btn = GUICtrlCreateButton("Assign", 5, 210, 70, 25)
$Execute_Btn = GUICtrlCreateButton("Execute", 75, 210, 70, 25)

;Create a "CANCEL" button
$Cancel_Btn = GUICtrlCreateButton("Cancel", 165, 210, 70, 25)

;Show window/Make the window visible
GUISetState(@SW_SHOW)

;Loop until:
;- user presses Esc
;- user presses Alt+F4
;- user clicks the close button
While 1
;After every loop check if the user clicked something in the GUI window
   $msg = GUIGetMsg()

   Select
   
    ;Check if user clicked on the close button
      Case $msg = $GUI_EVENT_CLOSE
       ;Destroy the GUI including the controls
         GUIDelete()
       ;Exit the script
         Exit
         
    ;Check if user clicked on the "OK" button
      Case $msg = $Assign_Btn
         $FuncVar = GUICtrlRead($Edit_1)
      Case $msg = $Execute_Btn
        Execute($FuncVar)
    ;Check if user clicked on the "CANCEL" button
      Case $msg = $Cancel_Btn
         MsgBox(64, "New GUI", "You clicked on the Cancel button!")
         
   EndSelect

WEnd