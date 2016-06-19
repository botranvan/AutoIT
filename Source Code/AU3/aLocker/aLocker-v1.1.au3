#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:        Sai
 Facebook: 		https://www.facebook.com/tmd18116

 Script Function:
	Lock desktop

#ce ----------------------------------------------------------------------------

#include <Misc.au3>
#include <WindowsConstants.au3>

HotKeySet('+{esc}','_exit')	;No need
; 
Global $Password,$PassLen,$PassIndex,$LockTimer

$Password = 'tranbo9x96'
$Password = StringUpper($Password)
$Password = StringSplit($Password,'')

$PassIndex = 1
$PassWrong = 0
$PassWrongTime = 20

While 1
	Sleep(72)

	If(_IsPressed(_char2key($Password[$PassIndex]))) Then
		$PassIndex+=1
		$PassWrong = 0
	Else
		$PassWrong+=1
	EndIf

	If (_IsPressed('2E')) Or $PassWrong > $PassWrongTime Then
		$PassIndex = 1
		$PassWrong = 0
	EndIf

	If $PassIndex > $Password[0] Then
		MsgBox(0,'','pass right')		;No need
		_exit()
	EndIf

	$msg = "pass: "& $Password[$PassIndex] & "["&Asc($Password[$PassIndex])&"]"&@CRLF
	$msg&= 'index: ' &$PassIndex &'/'&$Password[0]&@CRLF
	$msg&= 'wrong: ' &$PassWrong&@CRLF
;~ 	ToolTip($msg,0,0)	;No need

	_disable_input()
WEnd

Func _exit()
	_enable_input()
	Exit
EndFunc

Func _disable_input()
	If (TimerDiff($LockTimer) < 1000) Then Return
	_MouseTrap(@DesktopWidth/2,@DesktopHeight/2,@DesktopWidth/2,@DesktopHeight/2)
	Send("{ESC}")
	$LockTimer = TimerInit()
EndFunc

Func _enable_input()
	_MouseTrap()
EndFunc

Func _char2key($char)
	If($char =='0') Then Return '30'
	If($char =='1') Then Return '31'
	If($char =='2') Then Return '32'
	If($char =='3') Then Return '33'
	If($char =='4') Then Return '34'
	If($char =='5') Then Return '35'
	If($char =='6') Then Return '36'
	If($char =='7') Then Return '37'
	If($char =='8') Then Return '38'
	If($char =='9') Then Return '39'
	If($char =='A') Then Return '41'
	If($char =='B') Then Return '42'
	If($char =='C') Then Return '43'
	If($char =='D') Then Return '44'
	If($char =='E') Then Return '45'
	If($char =='F') Then Return '46'
	If($char =='G') Then Return '47'
	If($char =='H') Then Return '48'
	If($char =='I') Then Return '49'
	If($char =='J') Then Return '4A'
	If($char =='K') Then Return '4B'
	If($char =='L') Then Return '4C'
	If($char =='M') Then Return '4D'
	If($char =='N') Then Return '4E'
	If($char =='O') Then Return '4F'
	If($char =='P') Then Return '50'
	If($char =='Q') Then Return '51'
	If($char =='R') Then Return '52'
	If($char =='S') Then Return '53'
	If($char =='T') Then Return '54'
	If($char =='U') Then Return '55'
	If($char =='V') Then Return '56'
	If($char =='W') Then Return '57'
	If($char =='X') Then Return '58'
	If($char =='Y') Then Return '59'
	If($char =='Z') Then Return '5A'

	Return '2E' ;Delete
EndFunc
