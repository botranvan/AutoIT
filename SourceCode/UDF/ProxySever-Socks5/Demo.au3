
#include "Socks5.au3"
#include <GuiConstants.au3>

Opt ("GUIOnEventMode", 1)

_SOCKS_Init_Server()

$GUI = GUICreate ("Socks Server: Running", 300, 75)
GUISetOnEvent ($GUI_EVENT_CLOSE, "_Quit")

$GUILblSent = GUICtrlCreateLabel ("0", 5, 5, 280, 15)
$GUILblReceived = GUICtrlCreateLabel ("0", 5, 20, 280, 15)
GUISetState (@SW_SHOW)

_AdlibEnable("_UpdateGui", 1000)

While 1

    Sleep (1000)


WEnd
Func _Quit()

    Exit 0

EndFunc

Func _UpdateGui()

    GUICtrlSetData ($GUILblSent,  "Total data sent: " & Round(_SOCKS_Get_Total_Sent() / 1024, 1) & " kbs")
    GUICtrlSetData ($GUILblReceived,"Total data received: " &  Round(_SOCKS_Get_Total_Received() / 1024, 1) & " kbs")

EndFunc