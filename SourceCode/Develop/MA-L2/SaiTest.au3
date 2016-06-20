
Func TestingSet()
	$Testing = Not $Testing
	ToolTip("")
EndFunc


Func DShowTest()
	Local $Text = ""
	$Text&= @CRLF
	$Text&= "$Training: "&$Training&@CRLF
	$Text&= "$UsingBuff: "&$UsingBuff&@CRLF
	$Text&= "$GameTitle: "&$GameTitle&@CRLF
	$Text&= "$GameHandle: ["&$GameHandle&"]"&@CRLF
	$Text&= "$Old: "&$Old&@CRLF
	$Text&= "$Len: "&$Len&@CRLF
	$Text&= "$GamePid: "&$GamePid&@CRLF
	$Text&= "$IsTarget: "&Hex($AIsTarget[$AIsTargetIndex])&" | "&$AIsTargetIndex&" | "&$IsTarget&@CRLF
	$Text&= "$MobHPCur: "&Hex($AModHPCur[$AModHPCurIndex])&" | "&$AModHPCurIndex&" | "&$MobHPCur&@CRLF
	$Text&= "$AIsFishing: "&Hex($AIsFishing[$AIsFishingIndex])&" | "&$AIsFishingIndex&" | "&$IsFishing&@CRLF
	
	#cs
	$Text&= "$TargetKey: "&$TargetKey&@CRLF
	$Text&= "$FishingKey: "&$FishingKey&@CRLF
	$Text&= "$PumpKey: "&$PumpKey&@CRLF
	$Text&= "$ReelKey: "&$ReelKey&@CRLF

	For $i = 1 To $SkillInUse
		$Text&= "Skill "&$i&": "&$Skill[$i][0]&" | "&$Skill[$i][1]&" | "&$Skill[$i][2]&" | "&$Skill[$i][3]&" | "&@CRLF
	Next

	For $i = 101 To $SkillInUse+100
		$Text&= "Skill "&$i&": "&$Skill[$i][0]&" | "&$Skill[$i][1]&" | "&$Skill[$i][2]&" | "&$Skill[$i][3]&" | "&@CRLF
	Next

	For $i = 1 To $GameList[0][0]
		$Text&= "Game "&$i&": "&$GameList[$i][0]&" | "&$GameList[$i][1]&@CRLF
	Next
	#ce
	
	tooltip(@sec&@msec&" "&$Text,0,0)
	
EndFunc


Func DShowArray($array)
	Local $Text = ""
	
	For $i=0 To UBound($array)-1
		$Text&=$array[$i]&" "
	Next
	
	Return $Text
EndFunc

;~ Get Coord position in game
Func GameGetPost($Pos)
    Local $GamePos = WinGetPos($GameHandle)
    Local $GameGreen = WinGetClientSize ($GameHandle)
    Local $Span[2] = [$GameGreen[0] - $GamePos[2],$GameGreen[1] - $GamePos[3]]
   
    $Pos[0]+= $GamePos[0] - $Span[0]
    $Pos[1]+= $GamePos[1] - $Span[1]
   
    Return $Pos
EndFunc
 
;~ Kiểm tra tọa Coords của Game
Func ShowTextTest()
    If Not $GameHandle Then
        tooltip(@sec&@msec&" Chưa mở game",0,0)
;~         $GameHandle = WinGetHandle($GameTitle)
        Return
    EndIf
       
    Local $Text = ""
    Local $Mouse = MouseGetPos()
    Local $GamePos = WinGetPos($GameHandle)
    Local $GameGreen = WinGetClientSize ($GameHandle)
    Local $ControlPos[2]
    $ControlPos[0] = $Mouse[0] - $GamePos[0] + ($GameGreen[0] - $GamePos[2]) +4
    $ControlPos[1] = $Mouse[1] - $GamePos[1] + ($GameGreen[1] - $GamePos[3]) +4
   
    $Text&= @CRLF
    $Text&= "MousePos: "&$Mouse[0]&"/"&$Mouse[1]&@CRLF
    $Text&= "GamePos: "&$GamePos[0]&"/"&$GamePos[1]&@CRLF
    $Text&= "GameSize: "&$GamePos[2]&"/"&$GamePos[3]&@CRLF
    $Text&= "GameGreen: "&$GameGreen[0]&"/"&$GameGreen[1]&@CRLF
    $Text&= "Coords: "&$ControlPos[0]&"/"&$ControlPos[1]&@CRLF
   
	Return $Text
EndFunc