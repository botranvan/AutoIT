#include <MouseSetOnEvent_UDF.au3>

_BlockMouseClicksInput(0)

ToolTip('MouseClicks is disabled')
Sleep(3000)

_BlockMouseClicksInput(1)

ToolTip('MouseClicks is enabled')
Sleep(3000)

Func _BlockMouseClicksInput($iOpt=0)
	If $iOpt = 0 Then
		_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "__Dummy")
		_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "__Dummy")
		_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT, "__Dummy")
		_MouseSetOnEvent($MOUSE_SECONDARYDOWN_EVENT, "__Dummy")
	Else
		_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT)
		_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT)
		_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT)
		_MouseSetOnEvent($MOUSE_SECONDARYDOWN_EVENT)
	EndIf
EndFunc   ;==>_BlockMouseClicksInput
