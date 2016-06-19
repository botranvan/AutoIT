#include <Sound.au3>

$Sound = _SoundOpen("1.mp3"); Pick a song that is at least 1 minute long

_SoundPlay($Sound)


ConsoleWrite(@CRLF&@CRLF&"First: Volume...")

For $i = 1000 to 0 Step -1
    _SoundVolume($Sound,$i)
    Sleep(1)
Next
For $i = 0 to 1000
    _SoundVolume($Sound,$i)
    Sleep(1)
Next

ConsoleWrite(@CRLF&@CRLF&"Second: Pan...")

for $i = 0 to 1000 Step 5
    _SoundPanLeft($Sound,$i)
    _SoundPanRight($Sound,1000-$i)
    Sleep(1)
Next
for $i = 0 to 1000 step 5
    _SoundPanLeft($Sound,1000-$i)
    _SoundPanRight($Sound,$i)
    Sleep(1)
Next

_SoundPanRight($Sound,1000); normal
_SoundPanLeft($Sound,1000); normal

ConsoleWrite(@CRLF&@CRLF&"Third: Speed...")



_SoundSpeed($Sound,500)
Sleep(3000)
_SoundSpeed($Sound,800)
Sleep(3000)
_SoundSpeed($Sound,1500)
Sleep(3000)
_SoundSpeed($Sound,2200)
Sleep(3000)
_SoundSpeed($Sound,1000); normal


ConsoleWrite(@CRLF&@CRLF&"Fourth: Info,")
    
    $Info = _SoundInfo($Sound, "Speed")
    ConsoleWrite(@CRLF&"Current speed: "& $Info)
    
    $Info = _SoundInfo($Sound, "Volume")
    ConsoleWrite(@CRLF&"Current volume: "& $Info)

ConsoleWrite(@CRLF&@CRLF&"Done! Enjoy the rest of the song."&@CRLF&@CRLF)


While 1
    
WEnd




Func _SoundTimeToMs($Hours, $Minutes, $Seconds)
    
    Return ($Hours*3600000)+($Minutes*60000)+($Seconds*1000)
    
EndFunc





Func _SoundMsToTime($ms)
    
    Local $Return[3]
    
    
    if $ms >= 3600000 Then; 1000*60*60 = 3600000
        $Hours = Floor($ms/3600000)
        $Rest = $ms-($Hours*3600000)
    Else
        $Hours = 0
        $Rest = $ms
    EndIf
    
    If $Rest >= 60000 Then; 1000*60 = 60000
        $Minutes = Floor($Rest/60000)
        $Rest = $Rest-($Minutes*60000)
    Else
        $Minutes = 0
        $Rest = $ms
    EndIf
    
    $Seconds = Round($Rest/1000)
    
    $Return[0] = $Hours
    $Return[1] = $Minutes
    $Return[2] = $Seconds
    
    Return $Return
    
EndFunc



Func _SoundInfo($sSnd_id, $Parameter); look at "http://msdn2.microsoft.com/en-us/library/ms713277(VS.85).aspx" at the table "digitalvideo" for possible parameters
    
    If StringInStr($sSnd_id,'!') Then Return SetError(3, 0, 0); invalid file/alias

;return status
    Return mciSendString("status " & FileGetShortName($sSnd_id) & " " &$Parameter)
EndFunc;==>_SoundInfo





Func _SoundSpeed($sSnd_id, $Speed); $Speed: 0 - 2267,  1000= normal
;Declare variables
    Local $iRet
    
    If StringInStr($sSnd_id,'!') Then Return SetError(3, 0, 0); invalid file/alias
    
    if $Speed < 0 or $Speed > 2267 Then Return SetError(1, 0, 0)
    
    $iRet = mciSendString("set " & FileGetShortName($sSnd_id) & " speed "&$Speed)
;return
    If $iRet = 0 Then
        Return 1
    Else
        Return SetError(1, 0, 0)
    EndIf
EndFunc;==>_SoundSpeed





Func _SoundPanLeft($sSnd_id, $Pan); $Pan: 0 - 1000,  1000= normal
;Declare variables
    Local $iRet
    
    If StringInStr($sSnd_id,'!') Then Return SetError(3, 0, 0); invalid file/alias
    
    if $Pan < 0 or $Pan > 1000 Then Return SetError(1, 0, 0)
    
    $iRet = mciSendString("setaudio " & FileGetShortName($sSnd_id) & " left volume to "&$Pan)
;return
    If $iRet = 0 Then
        Return 1
    Else
        Return SetError(1, 0, 0)
    EndIf
EndFunc;==>_SoundPanLeft





Func _SoundPanRight($sSnd_id, $Pan); $Pan: 0 - 1000,  1000= normal
;Declare variables
    Local $iRet
    
    If StringInStr($sSnd_id,'!') Then Return SetError(3, 0, 0); invalid file/alias
    
    if $Pan < 0 or $Pan > 1000 Then Return SetError(1, 0, 0)
    
    $iRet = mciSendString("setaudio " & FileGetShortName($sSnd_id) & " right volume to "&$Pan)
;return
    If $iRet = 0 Then
        Return 1
    Else
        Return SetError(1, 0, 0)
    EndIf
EndFunc;==>_SoundPanRight





Func _SoundVolume($sSnd_id, $Volume); $Volume: 0 - 1000,  1000= normal
;Declare variables
    Local $iRet
    
    If StringInStr($sSnd_id,'!') Then Return SetError(3, 0, 0); invalid file/alias
    
    if $Volume < 0 or $Volume > 1000 Then Return SetError(1, 0, 0)
    
    $iRet = mciSendString("setaudio " & FileGetShortName($sSnd_id) & " volume to "&$Volume)
;return
    If $iRet = 0 Then
        Return 1
    Else
        Return SetError(1, 0, 0)
    EndIf
EndFunc;==>_SoundVolume