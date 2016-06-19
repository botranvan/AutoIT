#include <GUIConstants.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>
Global $Msg
$GUI = GUICreate("Calculator for amateur", 230, 230)
$GUI_Input_1 = GUICtrlCreateInput("", 10, 10, 100, -1, $ES_NUMBER + $ES_RIGHT)
$GUI_Input_2 = GUICtrlCreateInput("", 120, 10, 100, -1, $ES_NUMBER + $ES_RIGHT)
$GUI_Input_3 = GUICtrlCreateInput("", 10, 40, 210, -1, $ES_RIGHT + $ES_READONLY)
 
 
GUICtrlCreateGroup("Máy tính", 10, 70, 210, 110)
    $GUI_Radio_Plus = GUICtrlCreateRadio("Phép cộng    ", 20, 90)
    GUICtrlSetState(-1, $GUI_CHECKED)
    $GUI_Radio_Minus = GUICtrlCreateRadio("Phép trừ   ", 20, 110)
    $GUI_Radio_Of = GUICtrlCreateRadio("Phép nhân   ", 20, 130)
    $GUI_Radio_Divided = GUICtrlCreateRadio("Phép chia   ", 20, 150)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
 
$GUI_Button_1 = GUICtrlCreateButton("Tính", 10, 190, 100, -1, $BS_DEFPUSHBUTTON)
$GUI_Button_2 = GUICtrlCreateButton("Xóa dữ liệu", 120, 190, 100)
   
GUISetState()
GUICtrlSetState($GUI_Input_1, $GUI_FOCUS)
 
While 1
    $Msg = GUIGetMsg()
    Switch $Msg
    Case $GUI_EVENT_CLOSE
        Exit
    Case $GUI_Button_1
        Select
        Case BitAND(GUICtrlRead($GUI_Radio_Plus), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($GUI_Input_3, GUICtrlRead($GUI_Input_1) + GUICtrlRead($GUI_Input_2))
        Case BitAND(GUICtrlRead($GUI_Radio_Minus), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($GUI_Input_3, GUICtrlRead($GUI_Input_1) - GUICtrlRead($GUI_Input_2))
        Case BitAND(GUICtrlRead($GUI_Radio_Of), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($GUI_Input_3, GUICtrlRead($GUI_Input_1) * GUICtrlRead($GUI_Input_2))
        Case BitAND(GUICtrlRead($GUI_Radio_Divided), $GUI_CHECKED) = $GUI_CHECKED
            If GUICtrlRead($GUI_Input_2)=0 Then
                GUICtrlSetData($GUI_Input_3, "ERROR")
            Else
                GUICtrlSetData($GUI_Input_3, GUICtrlRead($GUI_Input_1) / GUICtrlRead($GUI_Input_2))
            EndIf
        EndSelect
        GUICtrlSetState($GUI_Input_1, $GUI_FOCUS)
    Case $GUI_Button_2
        GUICtrlSetData($GUI_Input_1, "")
        GUICtrlSetData($GUI_Input_2, "")
        GUICtrlSetData($GUI_Input_3, "")
        GUICtrlSetState($GUI_Input_1, $GUI_FOCUS)
    EndSwitch
WEnd