;~ Chương trình dùng kỹ thuật quest Pixel

#include <GUiconstantsEx.au3>
#include <WindowsConstants.au3>

HotKeySet("{ESC}","thoat")

Global $n =400
Opt("GUIOnEventMode",1)

$gui = GUICreate("Auto Heal",400,100,Default,Default,$WS_POPUPWINDOW,$WS_EX_TOOLWINDOW+$WS_EX_TOPMOST)
$G = GUICtrlCreateLabel("Bấm vào đây hoặc bấm ESC để thoát",7,10)
GUIctrlSetOnEvent($G,"thoat")
$a = GUICtrlCreateLabel("",2,50,$n,20)
GUICtrlSetBkColor($a,0xF30F30)
GUISetState()
$xy = WinGetPos($gui,"")
$x = $xy[0] + 30
$y = $xy[1] + 40
$test = PixelChecksum($x,$y,$x+25,$y+25)

MouseMove($x,$y,7)
MouseMove($x+25,$y+25,7)

While 1
	$n -= 25
	GUICtrlSetPos( $a, 2, 50, $n)
;~ 	GUICtrlSetData( $a, $n)
	Sleep(100)
	
	$test2 = PixelChecksum($x,$y,$x+25,$y+25)
	if $test <> $test2 Then
		$n = $n + 340
	EndIf
Wend

func thoat()
	Exit
EndFunc