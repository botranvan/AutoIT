#include-once

Func _GameExit()
	ConsoleWrite('@@ (3) :(' & @MIN & ':' & @SEC & ') _GameExit()' & @CR) ;### Function Trace
	$return = 1
;~ 	$return = MsgBox(1,$GameName,'Bạn muốn thoát game?')
	If ($return == 1) Then $GameContinue = False
EndFunc   ;==>_GameExit

Func _GameMouseHide()
	ConsoleWrite('@@ (10) :(' & @MIN & ':' & @SEC & ') _GameMouseHide()' & @CR) ;### Function Trace
	GUISetCursor(16)
EndFunc   ;==>_GameMouseHide

Func _GameFontLoad()
	ConsoleWrite('@@ (15) :(' & @MIN & ':' & @SEC & ') _GameFontLoad()' & @CR) ;### Function Trace
	$GameFont[0] = _GEng_Font_Create("Arial", 20, 2)
EndFunc   ;==>_GameFontLoad

Func _GameSoundLoad()
	ConsoleWrite('@@ (20) :(' & @MIN & ':' & @SEC & ') _GameSoundLoad()' & @CR) ;### Function Trace
	Global $SoundShot1 = _GEng_Sound_Load("res\sound\shot1.wav")
	Global $SoundGoUp = _GEng_Sound_Load("res\sound\going.wav")
	Global $SoundReload = _GEng_Sound_Load("res\sound\reload.wav")
	$SoundBallExp[0] = _GEng_Sound_Load("res\sound\ball-exp-1.wav")
	$SoundBallExp[1] = _GEng_Sound_Load("res\sound\ball-exp-2.wav")
	$SoundBallExp[2] = _GEng_Sound_Load("res\sound\ball-exp-1.wav")
	$SoundBallExp[3] = _GEng_Sound_Load("res\sound\ball-exp-2.wav")
	$SoundBallExp[4] = _GEng_Sound_Load("res\sound\ball-exp-1.wav")

	_GEng_Sound_AttribSet($SoundShot1, 1)
	_GEng_Sound_AttribSet($SoundGoUp, 0.9)
	_GEng_Sound_AttribSet($SoundReload, 0.2)

EndFunc   ;==>_GameSoundLoad

Func _GameBackgroundCreate()
	ConsoleWrite('@@ (37) :(' & @MIN & ':' & @SEC & ') _GameBackgroundCreate()' & @CR) ;### Function Trace
	Local $img = _GEng_ImageLoad("res\background\game-background.png")
	$GameBackground = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($GameBackground, $img)
EndFunc

Func _GameBackgroundDraw()
	ConsoleWrite('@@ (44) :(' & @MIN & ':' & @SEC & ') _GameBackgroundDraw()' & @CR) ;### Function Trace
	_GEng_Sprite_Draw($GameBackground, 0)
EndFunc

Func _MyBalloonCreate()
	ConsoleWrite('@@ (49) :(' & @MIN & ':' & @SEC & ') _MyBalloonCreate()' & @CR) ;### Function Trace
	Global $GameFont
	Local $img = _GEng_ImageLoad("res\balloon.png")
	Global $MyBalloonImage = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($MyBalloonImage, $img)
	_GEng_Sprite_PosSet($MyBalloonImage, 5, 10)
	Global $MyBalloonText = _GEng_Text_Create($GameFont[0], 'x' & $MyBalloonNumber, $GameTextColor, 25, 10)
EndFunc   ;==>_MyBalloonCreate

Func _MyBalloonDraw()
	ConsoleWrite('@@ (59) :(' & @MIN & ':' & @SEC & ') _MyBalloonDraw()' & @CR) ;### Function Trace
	Global $MyBalloonImage, $MyBalloonNumber
	_GEng_Sprite_Draw($MyBalloonImage)
	_GEng_Text_StringSet($MyBalloonText, 'x' & $MyBalloonNumber)
	_GEng_Text_Draw($MyBalloonText)
EndFunc   ;==>_MyBalloonDraw

Func _MyBalloonIncrease($number = 1)
	ConsoleWrite('@@ (67) :(' & @MIN & ':' & @SEC & ') _MyBalloonIncrease()' & @CR) ;### Function Trace
	$MyBalloonNumber += $number
	If $MyBalloonNumber > $MyBalloonNumberMax Then $MyBalloonNumber = $MyBalloonNumberMax
EndFunc   ;==>_MyBalloonIncrease


Func _MyBulletCreate()
	ConsoleWrite('@@ (74) :(' & @MIN & ':' & @SEC & ') _MyBulletCreate()' & @CR) ;### Function Trace
	Global $GameFont
	Local $img = _GEng_ImageLoad("res\my-bullet.png")
	Global $MyBulletImage = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($MyBulletImage, $img)
	_GEng_Sprite_PosSet($MyBulletImage, $scrW - 100, 14)
	Global $MyBulletText = _GEng_Text_Create($GameFont[0], 'x' & $MyBulletNumber, $GameTextColor, $scrW - 55, 10)
EndFunc   ;==>_MyBulletCreate

Func _MyBulletDraw()
	ConsoleWrite('@@ (84) :(' & @MIN & ':' & @SEC & ') _MyBulletDraw()' & @CR) ;### Function Trace
	Global $MyBulletImage, $MyBulletNumber
	_GEng_Sprite_Draw($MyBulletImage)
	_GEng_Text_StringSet($MyBulletText, 'x' & $MyBulletNumber)
	_GEng_Text_Draw($MyBulletText)
EndFunc   ;==>_MyBulletDraw

Func _MyBulletIncrease($number = 1)
	ConsoleWrite('@@ (92) :(' & @MIN & ':' & @SEC & ') _MyBulletIncrease()' & @CR) ;### Function Trace
	$MyBulletNumber += $number
	If $MyBulletNumber > $MyBulletNumberMax Then $MyBulletNumber = $MyBulletNumberMax
EndFunc   ;==>_MyBulletIncrease

Func _MyBulletDecrease($number = 1)
	ConsoleWrite('@@ (98) :(' & @MIN & ':' & @SEC & ') _MyBulletDecrease()' & @CR) ;### Function Trace
	$MyBulletNumber -= $number
	If $MyBulletNumber < 0 Then $MyBulletNumber = 0
EndFunc   ;==>_MyBulletDecrease

Func _MyMinionBulletImageLoad()
	ConsoleWrite('@@ (104) :(' & @MIN & ':' & @SEC & ') _MyMinionBulletImageLoad()' & @CR) ;### Function Trace
	Global $MyMinionBulletImage = _GEng_ImageLoad("res\bullet.png")
EndFunc   ;==>_MyMinionBulletImageLoad

Func _MyMinionCreate()
	ConsoleWrite('@@ (109) :(' & @MIN & ':' & @SEC & ') _MyMinionCreate()' & @CR) ;### Function Trace
	Global $MyMinionImage = _GEng_ImageLoad("res\minion\shooter.png")
	Global $MyMinion = _GEng_Sprite_Create(); Minion
	_GEng_Sprite_ImageSet($MyMinion, $MyMinionImage, 0, 0, $MyMinionSize, $MyMinionSize)
	_GEng_Sprite_OriginSetEx($MyMinion, $GEng_Origin_Mid)
	_GEng_Sprite_PosSet($MyMinion, $MyMinionPos[0], $MyMinionPos[1])

	_GEng_Sprite_SpeedSet($MyMinion, 0, 0, $MyMinionSpeed) ;move speed
	_GEng_Sprite_AngleSpeedSet($MyMinion, 0, 100) ;rotation  speed
	_GEng_Sprite_InnertieSet($MyMinion, 300)
	_GEng_Sprite_AngleInnertieSet($MyMinion, 60)

	$LeftShooterTimer = TimerInit()
EndFunc   ;==>_MyMinionCreate

Func _GameWallRightCreate()
	ConsoleWrite('@@ (125) :(' & @MIN & ':' & @SEC & ') _GameWallRightCreate()' & @CR) ;### Function Trace
	Local $Image = _GEng_ImageLoad("res\background\wall-right.png")
	Global $GameWallRight = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($GameWallRight, $Image, 0, 0, 58, 807)
	_GEng_Sprite_PosSet($GameWallRight, $scrW - 15, 0)

EndFunc   ;==>_GameWallRightCreate

Func _MyMinionDraw()
	ConsoleWrite('@@ (134) :(' & @MIN & ':' & @SEC & ') _MyMinionDraw()' & @CR) ;### Function Trace
	Global $MyMinion
	_GEng_Sprite_Draw($MyMinion)
EndFunc   ;==>_MyMinionDraw

Func _WallRightDraw()
	ConsoleWrite('@@ (140) :(' & @MIN & ':' & @SEC & ') _WallRightDraw()' & @CR) ;### Function Trace
	Global $GameWallRight
	_GEng_Sprite_Draw($GameWallRight)
EndFunc   ;==>_WallRightDraw

Func _MyMinionCheckMove()
	ConsoleWrite('@@ (146) :(' & @MIN & ':' & @SEC & ') _MyMinionCheckMove()' & @CR) ;### Function Trace
	Local $x, $y
	Global $MyMinion

	$tmp = _GEng_Sprite_AngleGet($MyMinion)
	$tmp = _GEng_AngleToVector($tmp, 1)
	_GEng_Sprite_PosGet($MyMinion, $x, $y)

	If _IsPressed('57') Or _IsPressed('26') Then ;up
		If (Not _GEng_Sound_IsPlaying($SoundGoUp)) Then _GEng_Sound_Play($SoundGoUp)
		_GEng_Sprite_AccelSet($MyMinion, $tmp[1] * -1000, $tmp[0] * -1000)
		If ($y < 100) Then _GEng_Sprite_AccelSet($MyMinion, $tmp[1] * 1000, $tmp[0] * 1000)

	ElseIf _IsPressed('53') Or _IsPressed('28') Then ;down
		If (Not _GEng_Sound_IsPlaying($SoundGoUp)) Then _GEng_Sound_Play($SoundGoUp)
		_GEng_Sprite_AccelSet($MyMinion, $tmp[1] * 1000, $tmp[0] * 1000)
		If ($y > $scrH - 160) Then _GEng_Sprite_AccelSet($MyMinion, $tmp[1] * -1000, $tmp[0] * -1000)

	Else
		_GEng_Sound_Stop($SoundGoUp)
		_GEng_Sprite_AccelSet($MyMinion, 0, 0)
	EndIf

	_GEng_Sprite_PosGet($MyMinion, $x, $y)
	_GEng_Sprite_PosSet($MyShotBar, $x - 70, $y - 35)
EndFunc   ;==>_MyMinionCheckMove

Func _MyMinionShoot()
	ConsoleWrite('@@ (174) :(' & @MIN & ':' & @SEC & ') _MyMinionShoot()' & @CR) ;### Function Trace
	Local $x, $y
	Global $MyMinion

	$tmp = _GEng_Sprite_AngleGet($MyMinion)
	$tmp = _GEng_AngleToVector($tmp, 1)

	If (_IsPressed('01') Or _IsPressed('25') Or _IsPressed('4A')) Then
		_MinionShot()
	ElseIf (_IsPressed('02') Or _IsPressed('20')) Then
		If ($MyBulletNumber > 0) Then _MinionShot(True)
	EndIf
EndFunc   ;==>_MyMinionShoot

Func _MyMinionShotRestore()
	ConsoleWrite('@@ (189) :(' & @MIN & ':' & @SEC & ') _MyMinionShotRestore()' & @CR) ;### Function Trace
	Local $x, $y
	Global $MyMinion, $MyMinionPos
	_GEng_Sprite_PosGet($MyMinion, $x, $y)
	If ($x == $MyMinionPos[0]) Then Return
	_GEng_Sprite_PosSet($MyMinion, $MyMinionPos[0], $y)
EndFunc   ;==>_MyMinionShotRestore


Func _MinionShot($Rapid = False)
	ConsoleWrite('@@ (199) :(' & @MIN & ':' & @SEC & ') _MinionShot()' & @CR) ;### Function Trace

	$Delay = $LeftShooterDelay
	If $Rapid Then $Delay = $LeftShooterRapidDelay
	If TimerDiff($LeftShooterTimer) < $Delay Then Return
	If Not $MyMinionCanShot Then Return
	$MyMinionCanShot = False

	_MyShotBarSpeed($Delay)

	If $Rapid Then _MyBulletDecrease()

	Local $bullet, $smoke, $x, $y, $tmp
	Global $MyMinionGunPos, $MyMinionBulletImage, $MyBullets, $_Smokes, $SoundShot1

	_GEng_Sound_Play($SoundShot1)
	_GEng_Sprite_PosGet($MyMinion, $x, $y)
	_GEng_Sprite_PosSet($MyMinion, $MyMinionPos[0] + 3, $y)

	;Create a bullet
	$bullet = _GEng_Sprite_Create($MyMinionBulletImage)
	_GEng_Sprite_CollisionSet($bullet, 0, 1, 3)
	_GEng_Sprite_MasseSet($bullet, 50)
	_GEng_Sprite_PointGet($MyMinion, $MyMinionGunPos[0], $MyMinionGunPos[1], $x, $y)
	_GEng_Sprite_PosSet($bullet, $x, $y)

	;Set the way bullet fly away
	$tmp = _GEng_Sprite_AngleGet($MyMinion)
	_GEng_Sprite_AngleSet($bullet, $tmp)
	$tmp = _GEng_AngleToVector($tmp, -1000) ; vitesse obus
	_GEng_Sprite_SpeedSet($bullet, $tmp[0], $tmp[1], $MyMinionBulletSpeed)


	_ArrayAdd($MyBullets, $bullet)
	$MyBullets[0] += 1

	;Create smoke
	$smoke = 0
	$smoke = _GEng_Sprite_Create()
	_GEng_Sprite_ColorMatrixTranslate($smoke, 0, 0, 0, -0.4)
	_GEng_Sprite_OriginSet($smoke, 12, 12)
	_GEng_Sprite_PosSet($smoke, $x, $y)
	_GEng_Sprite_AngleSet($smoke, Random(0, 359, 1))
	_ArrayAdd($_Smokes, $smoke)
	$_Smokes[0] += 1
	$smoke = 0

	$LeftShooterTimer = TimerInit()
EndFunc   ;==>_MinionShot

Func _AnimShots()
	ConsoleWrite('@@ (250) :(' & @MIN & ':' & @SEC & ') _AnimShots()' & @CR) ;### Function Trace
	Local $x, $y, $tmp
	Global $scrW, $scrH, $animSmoke1, $SoundShot1

	; Bullet
	For $i = $MyBullets[0] To 1 Step -1
		_GEng_Sprite_Draw($MyBullets[$i])
		_GEng_Sprite_PosGet($MyBullets[$i], $x, $y)
		If $x < 0 Or $x > $scrW Or $y < 0 Or $y > $scrH Then
			_GEng_Sprite_Delete($MyBullets[$i])
			_ArrayDelete($MyBullets, $i)
			$MyBullets[0] -= 1
;~ 		ElseIf _GEng_Sprite_Collision($MyBullets[$i], $MinionUp1) Then
;~ 			_GEng_Sound_Play($SoundShot1)
;~ 			_GEng_Sprite_Delete($MyBullets[$i])
;~ 			_ArrayDelete($MyBullets, $i)
;~ 			$MyBullets[0] -= 1
;~ 			_MyBalloonIncrease()
;~ 			_MyBulletIncrease()
		EndIf
	Next

	; smokes
	For $i = $_Smokes[0] To 1 Step -1
		_GEng_Sprite_Draw($_Smokes[$i])
;~ 		ConsoleWrite("_GEng_Sprite_Animate($_Smokes[$i], $animSmoke1, 1)"&@LF)
		If _GEng_Sprite_Animate($_Smokes[$i], $animSmoke1, 1) = -1 Then
			_GEng_Sprite_Delete($_Smokes[$i])
			_ArrayDelete($_Smokes, $i)
			$_Smokes[0] -= 1
		EndIf
	Next

EndFunc   ;==>_AnimShots

Func _AnimationLoad()
	ConsoleWrite('@@ (286) :(' & @MIN & ':' & @SEC & ') _AnimationLoad()' & @CR) ;### Function Trace
	Local $img

	$img = _GEng_ImageLoad("res\smoke\smoke.png", 576 / 2, 24)
	Global $animSmoke1 = _GEng_Anim_Create()
	For $i = 0 To 11
		_GEng_Anim_FrameAdd($animSmoke1, $img, 75, 24 * $i, 0, 24, 24)
	Next

	$img = _GEng_ImageLoad("res\minion\1eye\stand0.png")
	Global $animMinison1eyeStand0 = _GEng_Anim_Create()
	For $i = 0 To $animMinison1eyeFrameCount
		_GEng_Anim_FrameAdd($animMinison1eyeStand0, $img, 100, $MinisonFrameSize[0] * $i, 0, $MinisonFrameSize[0], $MinisonFrameSize[1])
	Next

	$img = _GEng_ImageLoad("res\minion\1eye\go-left-1.png")
	Global $animMinison1eyeGoLeft1 = _GEng_Anim_Create()
	For $i = 0 To $animMinison1eyeFrameCount
		_GEng_Anim_FrameAdd($animMinison1eyeGoLeft1, $img, 50, $MinisonFrameSize[0] * $i, 0, $MinisonFrameSize[0], $MinisonFrameSize[1])
	Next

	$img = _GEng_ImageLoad("res\minion\1eye\go-right-2.png")
	Global $animMinison1eyeGoRight2 = _GEng_Anim_Create()
	For $i = 0 To $animMinison1eyeFrameCount
		_GEng_Anim_FrameAdd($animMinison1eyeGoRight2, $img, 50, $MinisonFrameSize[0] * $i, 0, $MinisonFrameSize[0], $MinisonFrameSize[1])
	Next

	$img = _GEng_ImageLoad("res\minion\1eye\stand3.png")
	Global $animMinison1eyeStand3 = _GEng_Anim_Create()
	For $i = 0 To $animMinison1eyeFrameCount
		_GEng_Anim_FrameAdd($animMinison1eyeStand3, $img, 150, $MinisonFrameSize[0] * $i, 0, $MinisonFrameSize[0], $MinisonFrameSize[1])
	Next

EndFunc   ;==>_AnimationLoad

Func _MyShotBarCreate()
	ConsoleWrite('@@ (322) :(' & @MIN & ':' & @SEC & ') _MyShotBarCreate()' & @CR) ;### Function Trace
	Local $img
	Global $MyShotBarAni = _GEng_Anim_Create()
	Global $MyShotBar = _GEng_Sprite_Create()

	Global $MyShotBarImg = _GEng_ImageLoad("res\shotbar.png")

	For $i = 0 To $MyShotBarFrame - 1
		_GEng_Anim_FrameAdd($MyShotBarAni, $MyShotBarImg, ($LeftShooterDelay - 150) / $MyShotBarFrame, 0, $MyShotBarSize[1] * $i, $MyShotBarSize[0], $MyShotBarSize[1])
	Next
EndFunc   ;==>_MyShotBarCreate

Func _MyShotBarSpeed($Delay)
	ConsoleWrite('@@ (335) :(' & @MIN & ':' & @SEC & ') _MyShotBarSpeed()' & @CR) ;### Function Trace
	Global $MyShotBarImg, $MyShotBarAni, $MyShotBarFrame
	For $i = 1 To $MyShotBarFrame - 1
		_GEng_Anim_FrameMod($MyShotBarAni, $i, $MyShotBarImg, ($Delay - 150) / $MyShotBarFrame, 0, $MyShotBarSize[1] * $i, $MyShotBarSize[0], $MyShotBarSize[1])
	Next
EndFunc   ;==>_MyShotBarSpeed

Func _MyShotBarDraw()
	ConsoleWrite('@@ (343) :(' & @MIN & ':' & @SEC & ') _MyShotBarDraw()' & @CR) ;### Function Trace
	Global $MyShotBar, $MyShotBarAni
	_GEng_Sprite_Draw($MyShotBar)

	If Not $MyMinionCanShot Then
;~ 		ConsoleWrite("_GEng_Sprite_Animate($MyShotBar, $MyShotBarAni, 16)"&@LF)
		If _GEng_Sprite_Animate($MyShotBar, $MyShotBarAni, 16) == -1 Then
			_GEng_Sound_Play($SoundReload)
			$MyMinionCanShot = True
		EndIf
	EndIf
EndFunc   ;==>_MyShotBarDraw

Func _MinionSpawn()
	ConsoleWrite('@@ (357) :(' & @MIN & ':' & @SEC & ') _MinionSpawn()' & @CR) ;### Function Trace

	$MinionGoUpDelay = $MinionGoUpStartDelay-($MyBalloonNumber*10)
	If $MinionGoUpDelay < 1000 Then $MinionGoUpDelay = 1000;

	If TimerDiff($MinionSpawnTimer) < $MinionGoUpDelay Then Return

	_Minion1eyeSpawn()

	$MinionSpawnTimer = TimerInit()
EndFunc

Func _Minion1eyeSpawn()
	ConsoleWrite('@@ (370) :(' & @MIN & ':' & @SEC & ') _Minion1eyeSpawn()' & @CR) ;### Function Trace
	If $Minions1eye[0] >= $Minions1eyeMax Then Return
	Local $Minion

	;Create a minion
	$Minion = _GEng_Sprite_Create()
	_GEng_Sprite_MasseSet($Minion, 50)
	_GEng_Sprite_PosSet($Minion, Random(10,$scrW-70,1), $GameGround)	;

	;Minion go out from left to right
;~ 	$tmp = _GEng_Sprite_AngleGet($Minion)
;~ 	_GEng_Sprite_AngleSet($Minion, $tmp)
;~ 	$tmp = _GEng_AngleToVector($tmp, 1000) ; vitesse obus
;~ 	_GEng_Sprite_SpeedSet($Minion, $tmp[0], $tmp[1], $MinionRunSpeed)


	_ArrayAdd($Minions1eye, $Minion)
	_ArrayAdd($Minions1eyeStatus, 0)
	_ArrayAdd($Minions1eyeTimer, 0)
	$Minions1eye[0] += 1
	$Minions1eyeStatus[0] += 1
	$Minions1eyeTimer[0] += 1

	$MinionSpawnDelay += $Minions1eye[0] * 100
EndFunc   ;==>_Minion1eyeSpawn

Func _Minion1eyeMovement()
	ConsoleWrite('@@ (397) :(' & @MIN & ':' & @SEC & ') _Minion1eyeMovement()' & @CR) ;### Function Trace
	Local $x, $y, $i, $ani

	For $i = 1 To $Minions1eye[0]
		_GEng_Sprite_Draw($Minions1eye[$i])

		If $Minions1eyeStatus[$i] < 0 Then ContinueLoop

		_GEng_Sprite_PosGet($Minions1eye[$i], $x, $y)

		$NewStatus = $Minions1eyeStatus[$i]

		If _GEng_Sprite_Collision($Minions1eye[$i], $GEng_ScrBorder_Left) Then
			$NewStatus = 2
		ElseIf _GEng_Sprite_Collision($Minions1eye[$i], $GEng_ScrBorder_Right) Then
			$NewStatus = 1
		Else
			$rand = Random(2, $MinionNaughty, 1)
			If TimerDiff($Minions1eyeTimer[$i]) > $rand * 1000 Then
				$NewStatus = Random(0,3, 1)
				$Minions1eyeTimer[$i] = TimerInit()
			EndIf
		EndIf

		If $NewStatus == 0 And $Minions1eyeStatus[$i] == 3 Then ContinueLoop
		If $NewStatus == 3 And $Minions1eyeStatus[$i] == 0 Then ContinueLoop

		If $NewStatus <> $Minions1eyeStatus[$i] Then
			_GEng_Sprite_AnimRewind($Minions1eye[$i])
			$Minions1eyeStatus[$i] = $NewStatus
			_Minion1eyeChangeStatus($i)
			_GEng_Sprite_AnimRewind($Minions1eye[$i])
		EndIf


		;Error need fix
;~ 		ConsoleWrite("_GEng_Sprite_Animate($Minions1eye[$i], $ani)"&@LF)
		$ani = _Minion1eyeGetAni($i)
		_GEng_Sprite_Animate($Minions1eye[$i], $ani)
	Next
EndFunc   ;==>_Minion1eyeMovement

Func _Minion1eyeChangeStatus($index)
	ConsoleWrite('@@ (440) :(' & @MIN & ':' & @SEC & ') _Minion1eyeChangeStatus()' & @CR) ;### Function Trace
	Local $x, $y
	$tmp = _GEng_Sprite_AngleGet($Minions1eye[$index])
	_GEng_Sprite_AngleSet($Minions1eye[$index], $tmp)

	_GEng_Sprite_PosGet($Minions1eye[$index], $x, $y)

	Switch $Minions1eyeStatus[$index]
		Case 0
			ContinueCase
		Case 3
			$tmp = _GEng_AngleToVector($tmp, 0)
			_GEng_Sprite_SpeedSet($Minions1eye[$index], 0, 0)
			_GEng_Sprite_CollisionSet($Minions1eye[$index], 1, $MinisonFrameSize[0]/4, $MinisonFrameSize[0]/4, $MinisonFrameSize[0]/2, $MinisonFrameSize[0]/2)
		Case 1
			$tmp = _GEng_AngleToVector($tmp, -1000)
			_GEng_Sprite_SpeedSet($Minions1eye[$index], $tmp[0], $tmp[1], $MinionRunSpeed)
			_GEng_Sprite_CollisionSet($Minions1eye[$index], 1, $MinisonFrameSize[0]/4, $MinisonFrameSize[0]/4, $MinisonFrameSize[0]/2, $MinisonFrameSize[0]/2)
		Case 2
			$tmp = _GEng_AngleToVector($tmp, 1000)
			_GEng_Sprite_SpeedSet($Minions1eye[$index], $tmp[0], $tmp[1], $MinionRunSpeed)
			_GEng_Sprite_CollisionSet($Minions1eye[$index], 1, $MinisonFrameSize[0]/4, $MinisonFrameSize[0]/4, $MinisonFrameSize[0]/2, $MinisonFrameSize[0]/2)
	EndSwitch
EndFunc   ;==>_MinionChangeStatus

Func _Minion1eyeGetAni($index)
	ConsoleWrite('@@ (466) :(' & @MIN & ':' & @SEC & ') _Minion1eyeGetAni()' & @CR) ;### Function Trace
	Switch $Minions1eyeStatus[$index]
		Case 0
			Return $animMinison1eyeStand0
		Case 1
			Return $animMinison1eyeGoLeft1
		Case 2
			Return $animMinison1eyeGoRight2
		Case 3
			Return $animMinison1eyeStand3
	EndSwitch

EndFunc   ;==>_MinionGetAni

Func _MinionGoUp()
	ConsoleWrite('@@ (481) :(' & @MIN & ':' & @SEC & ') _MinionGoUp()' & @CR) ;### Function Trace
	If TimerDiff($MinionGoUpTimer) < $MinionGoUpDelay Then Return
	$Up = False

	$UpNeed = StringLeft(@SEC,1)
	If $Minions1eye[0] < 5 Then $UpNeed = 1
	$Up = _Minion1eyeGoUp()

	If $Up Then
		$MinionGoUpTimer = TimerInit()
;~ 		$MinionGoUpDelay-=$MyBalloonNumber
		If $MinionGoUpDelay < $MinionGoUpDelayMin Then $MinionGoUpDelay = $MinionGoUpDelayMin
	EndIf
EndFunc


Func _MinionGoDown()
	ConsoleWrite('@@ (498) :(' & @MIN & ':' & @SEC & ') _MinionGoDown()' & @CR) ;### Function Trace
	If Not $MinionDownCount Then Return

	_Minion1eyeGoDown()
EndFunc

Func _MinionGoStandUp()
	ConsoleWrite('@@ (505) :(' & @MIN & ':' & @SEC & ') _MinionGoStandUp()' & @CR) ;### Function Trace
	If Not $MinionDownCount Then Return

	_Minion1eyeStandUp()
EndFunc

Func _MinionGo4Banana()
	ConsoleWrite('@@ (512) :(' & @MIN & ':' & @SEC & ') _MinionGo4Banana()' & @CR) ;### Function Trace
	If Not $MinionUpCount Then Return

	_Minion1eyeGo4Banana()
EndFunc

Func _Minion1eyeGo4Banana()
	ConsoleWrite('@@ (519) :(' & @MIN & ':' & @SEC & ') _Minion1eyeGo4Banana()' & @CR) ;### Function Trace
	Local $img,$x,$y

	For $index = 1 To $Minions1eye[0]
		If Not _GEng_Sprite_Collision($Minions1eye[$index],$GEng_ScrBorder_Top) Then ContinueLoop

		If $Minions1eyeStatus[$index] == -1 Then
			_GEng_Sprite_SpeedSet($Minions1eye[$index], 0, 0, $MinionUpSpeedMin)
			$Minions1eyeStatus[$index] = -4
		EndIf

		If $Minions1eyeStatus[$index] <> -4 Then ContinueLoop

		_GEng_Sprite_PosGet($Minions1eye[$index],$x,$y)
		$tmp = _GEng_Sprite_AngleGet($Minions1eye[$index])
		$tmp = _GEng_AngleToVector($tmp, 1)

		If _GEng_Sprite_Collision($Minions1eye[$index],$GEng_ScrBorder_Left) Then
			_GEng_Sprite_AccelSet($Minions1eye[$index], $tmp[0] * 1000, $tmp[1] * 1000)

		ElseIf _GEng_Sprite_Collision($Minions1eye[$index],$GEng_ScrBorder_Right) Then
			_GEng_Sprite_AccelSet($Minions1eye[$index], $tmp[0] * -1000, $tmp[1] * -1000)

		Else
			$rand = Random(2, $MinionNaughty, 1)
			If TimerDiff($Minions1eyeTimer[$index]) > $rand * 1000 Then
				Do
					$rand = Random(-1,1,1)
				Until $rand<>0
				_GEng_Sprite_AccelSet($Minions1eye[$index], $tmp[0] * -1000 *$rand, $tmp[1] * -1000 *$rand)
				$Minions1eyeTimer[$index] = TimerInit()
			EndIf
		EndIf
	Next
EndFunc

Func _Minion1eyeGoUp()
	ConsoleWrite('@@ (556) :(' & @MIN & ':' & @SEC & ') _Minion1eyeGoUp()' & @CR) ;### Function Trace
	Local $img,$x,$y,$randImg,$randMinion
	Global $UpNeed

	$randMinion = Random(1,$Minions1eye[0],1)
	For $index = $randMinion To $Minions1eye[0]
		If $Minions1eyeStatus[$index] < 0 Then ContinueLoop

		_GEng_Sprite_PosGet($Minions1eye[$index], $x, $y)
		If($x < 50) Then ContinueLoop
		If($x > $scrW-250) Then ContinueLoop

		$randImg = Random(0,$animMinison1eyeFrameCount,1)
		$img = _GEng_ImageLoad("res\minion\1eye\up.png", $MinisonFrameSize[0], $MinisonFrameSize[1],$MinisonFrameSize[0]*$randImg,0,$MinisonFrameSize[0], $MinisonFrameSize[1])
		_GEng_Sprite_ImageSet($Minions1eye[$index], $img)

		$tmp = _GEng_Sprite_AngleGet($Minions1eye[$index])
		_GEng_Sprite_AngleSet($Minions1eye[$index], $tmp)
		$tmp = _GEng_AngleToVector($tmp, -1000)

		$MinionUpSpeed = Random($MinionUpSpeedMin,$MinionUpSpeedMax,1)
		_GEng_Sprite_SpeedSet($Minions1eye[$index], $tmp[1], $tmp[0], $MinionUpSpeed)
		_GEng_Sprite_PosSet($Minions1eye[$index], $x, $GameGround-20)
		_GEng_Sprite_CollisionSet($Minions1eye[$index], 1, 20, 9, 43, 50)

		$Minions1eyeStatus[$index] = -1

		$MinionUpCount+=1
		If $MinionUpCount >= $UpNeed Then Return True
	Next

	Return False
EndFunc

Func _Minion1eyeGoDown()
	ConsoleWrite('@@ (591) :(' & @MIN & ':' & @SEC & ') _Minion1eyeGoDown()' & @CR) ;### Function Trace
	Local $img,$x,$y

	For $index = 1 To $Minions1eye[0]
		If $Minions1eyeStatus[$index] <> -2 Then ContinueLoop

		_GEng_Sprite_PosGet($Minions1eye[$index], $x, $y)
		If($y < $GameGround) Then ContinueLoop

		$tmp = _GEng_Sprite_AngleGet($Minions1eye[$index])
		_GEng_Sprite_AngleSet($Minions1eye[$index], $tmp)
		$tmp = _GEng_AngleToVector($tmp, 0)
		_GEng_Sprite_SpeedSet($Minions1eye[$index], 0, 0)

		$Minions1eyeStatus[$index] = -3
	Next

EndFunc

Func _Minion1eyeStandUp()
	ConsoleWrite('@@ (611) :(' & @MIN & ':' & @SEC & ') _Minion1eyeStandUp()' & @CR) ;### Function Trace
	Local $img,$x,$y

	For $index = 1 To $Minions1eye[0]
		If $Minions1eyeStatus[$index] <> -3 Then ContinueLoop

		$Minions1eyeStatus[$index] = 3
		$MinionDownCount-=1
	Next
EndFunc

Func _MyMinionShot1eyeCheck()
	ConsoleWrite('@@ (623) :(' & @MIN & ':' & @SEC & ') _MyMinionShot1eyeCheck()' & @CR) ;### Function Trace
	For $BulletIndex = 1 To $MyBullets[0]
		For $MinionIndex = 1 To $Minions1eye[0]
			If _GEng_Sprite_Collision($MyBullets[$BulletIndex], $Minions1eye[$MinionIndex]) Then
				$MinionUpCount-=1

				_MyBalloonIncrease()
				_MyBulletIncrease()

				_BalloonExplorerSound()

				$img = _GEng_ImageLoad("res\minion\1eye\down.png", $MinisonFrameSize[0], $MinisonFrameSize[1])
				_GEng_Sprite_ImageSet($Minions1eye[$MinionIndex], $img)

				$tmp = _GEng_Sprite_AngleGet($Minions1eye[$MinionIndex])
				_GEng_Sprite_AngleSet($Minions1eye[$MinionIndex], $tmp)
				$tmp = _GEng_AngleToVector($tmp, 1000)
				_GEng_Sprite_SpeedSet($Minions1eye[$MinionIndex], $tmp[1], $tmp[0], $MinionDownSpeed)

				_GEng_Sprite_CollisionSet($Minions1eye[$MinionIndex], 0, $MinisonFrameSize[0]/2, $MinisonFrameSize[1]-10)

				$Minions1eyeStatus[$MinionIndex] = -2
				$MinionDownCount+=1
			EndIf
		Next
	Next
EndFunc

Func _BalloonExplorerSound()
	ConsoleWrite('@@ (652) :(' & @MIN & ':' & @SEC & ') _BalloonExplorerSound()' & @CR) ;### Function Trace
	_GEng_Sound_Play($SoundBallExp[Random(0,$SoundBallExpCount-1,1)])
EndFunc

Func _MyBananaCreate()
	ConsoleWrite('@@ (657) :(' & @MIN & ':' & @SEC & ') _MyBananaCreate()' & @CR) ;### Function Trace

EndFunc