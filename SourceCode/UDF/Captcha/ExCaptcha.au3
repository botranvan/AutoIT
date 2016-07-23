#include <EditConstants.au3>
#include "Captcha.au3"

$GUI = GUICreate("Register Form", 210, 110)
GUICtrlCreateLabel("Userame:", 10, 10)
GUICtrlCreateLabel("Email:", 10, 30)
GUICtrlCreateLabel("Password:", 10, 50)
$Username = GUICtrlCreateInput("", 100, 7, 100)
$Email = GUICtrlCreateInput("", 100, 27, 100)
$Password = GUICtrlCreateInput("", 100, 47, 100, 20, $ES_PASSWORD)
$Register = GUICtrlCreateButton("Register", 10, 75, 90)
$Clear = GUICtrlCreateButton("Clear", 110, 75, 90)

GUISetState()
While 1
    Switch GUIGetMsg()
    Case -3
        Exit

    Case $Register
        If GUICtrlRead($Username) <> "" And GUICtrlRead($Email) <> "" And GUICtrlRead($Password) <> "" Then
            If _CaptchaCode(1) Then
                MsgBox(64, Default, "Registration done!")
                $Data = ""
                $Data &= "Username  : " & GUICtrlRead($Username) & @CRLF
                $Data &= "Email     : " & GUICtrlRead($Email) & @CRLF
                $Data &= "Password  : " & GUICtrlRead($Password) & @CRLF
                FileWrite(@DesktopDir & "\register_form.txt", $Data)
            Else
                MsgBox(16, Default, "Tries maxed out, exiting program.")
                Exit
            EndIf
        Else
            MsgBox(16, Default, "Please fill in every information.")
        EndIf

    Case $Clear
        GUICtrlSetData($Username, "")
        GUICtrlSetData($Email, "")
        GUICtrlSetData($Password, "")

    EndSwitch
WEnd