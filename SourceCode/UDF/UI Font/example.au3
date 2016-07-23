#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

; Font Icon UDF by Juno_okyo
#include <font-icon.au3>

Opt('GUIOnEventMode', 1)
#Region ### START Koda GUI section ### Form=E:\Program Files\AutoIt3\SciTE\Koda\Templates\Form1.kxf
Global $FormMain = GUICreate('Font Icon for AutoIt by Juno_okyo', 355, 126, -1, -1)
GUISetFont(20, 400, 0, 'Arial')
GUISetOnEvent($GUI_EVENT_CLOSE, 'FormMainClose')
GUIStartGroup()
Global $Label1 = GUICtrlCreateLabel('Juno_okyo', 25, 42, 155, 36)
GUICtrlSetFont(-1, 24, 400, 0, 'Arial')

; See demo.html for Icon name
Global $Label2 = GUICtrlCreateLabel(Font_Icon('icon-heart'), 193, 46, 35, 36)
GUICtrlSetFont(-1, 20, 400, 0, 'juno_okyo') ; Font name
GUICtrlSetColor(-1, 0xa83f39) ; Heart color ;)

Global $Label3 = GUICtrlCreateLabel('AutoIt', 235, 42, 90, 36)
GUICtrlSetFont(-1, 24, 400, 0, 'Arial')
GUIStartGroup()
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
WEnd

Func FormMainClose()
	Exit
EndFunc
