#include <GUIConstants.au3>
Global $Msg
GUICreate("Test")
$ButtonStart = GUICtrlCreateButton("Start", 10, 10, 40)
$ButtonStop = GUICtrlCreateButton("Stop", 10, 40, 40)
GUISetState()

Do
    $Msg = GUIGetMsg()
    If $Msg = $ButtonStart Then
        Start()
    EndIf
    Sleep(10)
Until $Msg = $GUI_Event_Close
 
Func Start()
	$i=1
    While $i < 10000
        $Msg = GUIGetMsg()
        ToolTip($i, 10, 10)
        If $Msg = $ButtonStop Then
            ToolTip("")
            ExitLoop
        EndIf
		$i+=1
    WEnd
EndFunc