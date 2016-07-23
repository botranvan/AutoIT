#include-once 
; Both includes are required
#include <Misc.au3>
Func _Shift_Enter($controlInput)
    Dim $PreviousStringLenght
        $ControlRead = GUICtrlRead($controlInput) ;Read data from the control
        
    If StringRight($ControlRead,2) = @CRLF Then ; if the last characters are {ENTER} then do things
        If _IsPressed(10) Then ;Checks if {SHIFT} is pressed so you can still use multiple enters
            $PreviousStringLenght = StringLen($ControlRead) ;Capture the lenght of the string, to see when something has changed 
        ; ElseIf $PreviousStringLenght <> StringLen($ControlRead) Then ;on next occasion, where {SHIFT} is not pressed, check if the String lenght has changed. If so, then do this
        ;     $ControlRead = StringTrimRight($ControlRead,2) ; Delete the {ENTER} from the end
        ;     GUICtrlSetData($InputControl,$ControlRead) ; This is optional data, but I've done this so that the user will not see that the enter is not really captured
        ;     MsgBox(0, "Test data", $ControlRead) ; Do something with the data, in this case display it in the MsgBox
        EndIf
    EndIf
EndFunc