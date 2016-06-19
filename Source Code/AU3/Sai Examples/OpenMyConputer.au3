	#include <GUIConstantsEx.au3>

	Local $msg

    GUICreate("My GUI")
    $Button = GUICtrlCreateButton("My Conputer",100,100)
	GUISetState(@SW_SHOW)

    While 1
        $msg = GUIGetMsg()

        If $msg = $GUI_EVENT_CLOSE Then ExitLoop
        If $msg = $Button Then Run('explorer.exe /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}')
    WEnd
    GUIDelete()
