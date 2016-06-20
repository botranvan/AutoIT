#include-once

Func _GameExit()
	$return = 1
;~ 	$return = MsgBox(1,$GameName,'Bạn muốn thoát game?')
	If($return==1) Then $GameContinue = False
EndFunc

Func _GameMouseHide()
	GUISetCursor(16)
EndFunc

Func _GameFontLoad()
	$GameFont[0] = _GEng_Font_Create("Arial", 20, 2)
EndFunc

Func _GameSoundLoad()
	Global $SoundShot1 = _GEng_Sound_Load("res\sound\shot1.wav")
	Global $SoundGoUp = _GEng_Sound_Load("res\sound\going.wav")
	Global $SoundReload = _GEng_Sound_Load("res\sound\reload.wav")

	_GEng_Sound_AttribSet($SoundShot1,1)
	_GEng_Sound_AttribSet($SoundGoUp,0.1)
	_GEng_Sound_AttribSet($SoundReload,0.1)

EndFunc

Func _MyBalloonCreate()
	Global $GameFont
	Local $img = _GEng_ImageLoad("res\balloon.png")
	Global $MyBalloonImage = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($MyBalloonImage, $img)
	_GEng_Sprite_PosSet($MyBalloonImage, 5, 10)
	Global $MyBalloonText = _GEng_Text_Create($GameFont[0], 'x'&$MyBalloonNumber, 0xFF000000, 25, 10)
EndFunc

Func _MyBalloonDraw()
	Global $MyBalloonImage,$MyBalloonNumber
	_GEng_Sprite_Draw($MyBalloonImage)
	_GEng_Text_StringSet($MyBalloonText, 'x'&$MyBalloonNumber)
	_GEng_Text_Draw($MyBalloonText)
EndFunc

Func _MyBalloonIncrease($number = 1)
	$MyBalloonNumber+=$number
	If $MyBalloonNumber>$MyBalloonNumberMax Then $MyBalloonNumber = $MyBalloonNumberMax
EndFunc


Func _MyBulletCreate()
	Global $GameFont
	Local $img = _GEng_ImageLoad("res\my-bullet.png")
	Global $MyBulletImage = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($MyBulletImage, $img)
	_GEng_Sprite_PosSet($MyBulletImage, $scrW-100, 10)
	Global $MyBulletText = _GEng_Text_Create($GameFont[0], 'x'&$MyBulletNumber, 0xFF000000, $scrW-55, 10)
EndFunc

Func _MyBulletDraw()
	Global $MyBulletImage,$MyBulletNumber
	_GEng_Sprite_Draw($MyBulletImage)
	_GEng_Text_StringSet($MyBulletText, 'x'&$MyBulletNumber)
	_GEng_Text_Draw($MyBulletText)
EndFunc

Func _MyBulletIncrease($number = 1)
	$MyBulletNumber+=$number
	If $MyBulletNumber>$MyBulletNumberMax Then $MyBulletNumber = $MyBulletNumberMax
EndFunc

Func _MyBulletDecrease($number = 1)
	$MyBulletNumber-=$number
	If $MyBulletNumber<0 Then $MyBulletNumber = 0
EndFunc

Func _MyMinionBulletImageLoad()
	Global $MyMinionBulletImage = _GEng_ImageLoad("res\bullet.png")
EndFunc

Func _MinionUpCreate()
	Global $MinionUp1Image
	Global $MinionUp1 = _GEng_Sprite_Create(); Minion
	_GEng_Sprite_ImageSet($MinionUp1, $MinionUp1Image, 0, 0, $MinionUp1Size[0], $MinionUp1Size[1])
	_GEng_Sprite_PosSet($MinionUp1, 311, 361)
	_GEng_Sprite_CollisionSet($MinionUp1, 2, 15, 15, 20)
	_GEng_Sprite_OriginSetEx($MinionUp1, $GEng_Origin_Mid)
EndFunc


Func _MinionUpDraw()
	Global $MinionUp1
	_GEng_Sprite_Draw($MinionUp1)
EndFunc

Func _MyMinionCreate()
	Global $MyMinionImage = _GEng_ImageLoad("res\minion\shooter.png")
	Global $MyMinion = _GEng_Sprite_Create(); Minion
	_GEng_Sprite_ImageSet($MyMinion, $MyMinionImage, 0, 0, $MyMinionSize, $MyMinionSize)
	_GEng_Sprite_OriginSetEx($MyMinion, $GEng_Origin_Mid)
	_GEng_Sprite_PosSet($MyMinion, $MyMinionPos[0], $MyMinionPos[1])

	_GEng_Sprite_SpeedSet($MyMinion, 0, 0, $MyMinionSpeed)	;move speed
	_GEng_Sprite_AngleSpeedSet($MyMinion, 0, 100)   ;rotation  speed
	_GEng_Sprite_InnertieSet($MyMinion, 300)
	_GEng_Sprite_AngleInnertieSet($MyMinion, 60)

	$LeftShooterTimer = TimerInit()
EndFunc

Func _GameWallRightCreate()
	Local $Image = _GEng_ImageLoad("res\background\wall-right.png")
	Global $GameWallRight = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($GameWallRight, $Image, 0, 0,58,807)
	_GEng_Sprite_PosSet($GameWallRight, $scrW-15, 0)

EndFunc

Func _MyMinionDraw()
	Global $MyMinion
	_GEng_Sprite_Draw($MyMinion)
EndFunc

Func _WallRightDraw()
	Global $GameWallRight
	_GEng_Sprite_Draw($GameWallRight)
EndFunc

Func _MyMinionCheckMove()
	Local $x, $y
	Global $MyMinion

	$tmp = _GEng_Sprite_AngleGet($MyMinion)
	$tmp = _GEng_AngleToVector($tmp, 1)
	_GEng_Sprite_PosGet($MyMinion, $x, $y)

	If _IsPressed('57') Or _IsPressed('26')  Then ;up
		If(Not _GEng_Sound_IsPlaying($SoundGoUp)) Then _GEng_Sound_Play($SoundGoUp)
		_GEng_Sprite_AccelSet($MyMinion, $tmp[1] * -1000, $tmp[0] * -1000)
		If($y<100) Then _GEng_Sprite_AccelSet($MyMinion, $tmp[1] * 1000, $tmp[0] * 1000)

	ElseIf _IsPressed('53') Or  _IsPressed('28') Then ;down
		If(Not _GEng_Sound_IsPlaying($SoundGoUp)) Then _GEng_Sound_Play($SoundGoUp)
		_GEng_Sprite_AccelSet($MyMinion, $tmp[1] * 1000, $tmp[0] * 1000)
		If($y>$scrH-150) Then _GEng_Sprite_AccelSet($MyMinion, $tmp[1] * -1000, $tmp[0] * -1000)

	Else
		_GEng_Sound_Stop($SoundGoUp)
		_GEng_Sprite_AccelSet($MyMinion, 0, 0)
	EndIf

	_GEng_Sprite_PosGet($MyMinion, $x, $y)
	_GEng_Sprite_PosSet($MyShotBar, $x-70, $y-35)
EndFunc

Func _MyMinionShoot()
	Local $x, $y
	Global $MyMinion

	$tmp = _GEng_Sprite_AngleGet($MyMinion)
	$tmp = _GEng_AngleToVector($tmp, 1)

	If (_IsPressed('01') Or _IsPressed('25') Or _IsPressed('4A')) Then
		_MinionShot()
	ElseIf (_IsPressed('02') Or _IsPressed('20')) Then
		If($MyBulletNumber>0) Then _MinionShot(True)
	EndIf
EndFunc

Func _MyMinionShotRestore()
	Local $x, $y
	Global $MyMinion,$MyMinionPos
	_GEng_Sprite_PosGet($MyMinion, $x, $y)
	If($x == $MyMinionPos[0]) Then Return
	_GEng_Sprite_PosSet($MyMinion, $MyMinionPos[0], $y)
EndFunc


Func _MinionShot($Rapid = False)

	$Delay = $LeftShooterDelay
	If $Rapid Then $Delay = $LeftShooterRapidDelay
	If TimerDiff($LeftShooterTimer) < $Delay Then Return
	If Not $MyMinionCanShot Then Return
	$MyMinionCanShot = False

	_MyShotBarSpeed($Delay)

	If $Rapid Then _MyBulletDecrease()

	Local $bullet,$smoke, $x, $y, $tmp
	Global $MyMinionGunPos,$MyMinionBulletImage,$_Bullets,$_Smokes,$SoundShot1

	_GEng_Sound_Play($SoundShot1)
	_GEng_Sprite_PosGet($MyMinion, $x, $y)
	_GEng_Sprite_PosSet($MyMinion, $MyMinionPos[0]+3, $y)

	;Create a bullet
	$bullet = _GEng_Sprite_Create($MyMinionBulletImage)
	_GEng_Sprite_CollisionSet($bullet, 0, 4, 2)
	_GEng_Sprite_MasseSet($bullet, 50)
	_GEng_Sprite_PointGet($MyMinion, $MyMinionGunPos[0], $MyMinionGunPos[1], $x, $y)
	_GEng_Sprite_PosSet($bullet, $x, $y)

	;Set the way bullet fly away
	$tmp = _GEng_Sprite_AngleGet($MyMinion)
	_GEng_Sprite_AngleSet($bullet, $tmp)
	$tmp = _GEng_AngleToVector($tmp, -1000) ; vitesse obus
	_GEng_Sprite_SpeedSet($bullet, $tmp[0], $tmp[1],$MyMinionBulletSpeed)


	_ArrayAdd($_Bullets, $bullet)
	$_Bullets[0] += 1

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
EndFunc

Func _AnimShots()
	Local $x, $y, $tmp
	Global $scrW, $scrH,$animSmoke1,$SoundShot1

	; Bullet
	For $i = $_Bullets[0] To 1 Step -1
		_GEng_Sprite_Draw($_Bullets[$i])
		_GEng_Sprite_PosGet($_Bullets[$i], $x, $y)
		If $x < 0 Or $x > $scrW Or $y < 0 Or $y > $scrH Then
			_GEng_Sprite_Delete($_Bullets[$i])
			_ArrayDelete($_Bullets, $i)
			$_Bullets[0] -= 1
		ElseIf _GEng_Sprite_Collision($_Bullets[$i], $MinionUp1) Then
;~ 			_GEng_Sound_Play($SoundShot1)
			_GEng_Sprite_Delete($_Bullets[$i])
			_ArrayDelete($_Bullets, $i)
			$_Bullets[0] -= 1
			_MyBalloonIncrease()
			_MyBulletIncrease()
		EndIf
	Next

	; smokes
	For $i = $_Smokes[0] To 1 Step -1
		_GEng_Sprite_Draw($_Smokes[$i])
		; ---
		If _GEng_Sprite_Animate($_Smokes[$i], $animSmoke1, 1) = -1 Then
			_GEng_Sprite_Delete($_Smokes[$i])
			_ArrayDelete($_Smokes, $i)
			$_Smokes[0] -= 1
		EndIf
	Next

EndFunc

Func _AnimationLoad()
	Local $img

	Global $MinionUp1Image = _GEng_ImageLoad("res\minion\minion-up-1.png", $MinionUp1Size[0], $MinionUp1Size[1])


	$img = _GEng_ImageLoad("res\minion\minion-stand.png")
	Global $animMinisonStand = _GEng_Anim_Create()
	For $i = 0 To 15
		_GEng_Anim_FrameAdd($animMinisonStand, $img, 100, $MinisonStandSize * $i, 0, $MinisonStandSize, $MinisonStandSize)
	Next

	$img = _GEng_ImageLoad("res\minion\minione-walking-left.png")
	Global $animMinisonWalkLeft = _GEng_Anim_Create()
	For $i = 0 To 8
		_GEng_Anim_FrameAdd($animMinisonWalkLeft, $img, 50, $MinisonFrameSize * $i, 0, $MinisonFrameSize, $MinisonFrameSize)
	Next

	$img = _GEng_ImageLoad("res\minion\minione-walking-right.png")
	Global $animMinisonWalkRight = _GEng_Anim_Create()
	For $i = 0 To 8
		_GEng_Anim_FrameAdd($animMinisonWalkRight, $img, 50, $MinisonFrameSize * $i, 0, $MinisonFrameSize, $MinisonFrameSize)
	Next

	$img = _GEng_ImageLoad("res\smoke\smoke.png", 576/2, 24)
	Global $animSmoke1 = _GEng_Anim_Create()
	For $i = 0 To 11
		_GEng_Anim_FrameAdd($animSmoke1, $img, 75, 24 * $i, 0, 24, 24)
	Next
EndFunc

Func _MyShotBarCreate()
	Local $img
	Global $MyShotBarAni = _GEng_Anim_Create()
	Global $MyShotBar = _GEng_Sprite_Create()

	Global $MyShotBarImg = _GEng_ImageLoad("res\shotbar.png")

	For $i = 0 To $MyShotBarFrame-1
		_GEng_Anim_FrameAdd($MyShotBarAni, $MyShotBarImg, ($LeftShooterDelay-150)/$MyShotBarFrame, 0, $MyShotBarSize[1] * $i, $MyShotBarSize[0], $MyShotBarSize[1])
	Next
EndFunc

Func _MyShotBarSpeed($Delay)
	Global $MyShotBarImg,$MyShotBarAni,$MyShotBarFrame
	For $i = 1 To $MyShotBarFrame-1
		_GEng_Anim_FrameMod($MyShotBarAni, $i,$MyShotBarImg, ($Delay-150)/$MyShotBarFrame, 0, $MyShotBarSize[1] * $i, $MyShotBarSize[0], $MyShotBarSize[1])
	Next
EndFunc

Func _MyShotBarDraw()
	Global $MyShotBar,$MyShotBarAni
	_GEng_Sprite_Draw($MyShotBar)

	If Not $MyMinionCanShot Then
		If _GEng_Sprite_Animate($MyShotBar, $MyShotBarAni, 16) == -1 Then
			_GEng_Sound_Play($SoundReload)
			$MyMinionCanShot = True
		EndIf
	EndIf
EndFunc

Func _MinionSpawn()
	If TimerDiff($MinionSpawnTimer) < $MinionSpawnDelay Then Return

	Local $Minion

	;Create a minion
	$Minion = _GEng_Sprite_Create()
	_GEng_Sprite_CollisionSet($Minion, 1, 0, 0, $MinisonFrameSize, $MinisonFrameSize)
	_GEng_Sprite_MasseSet($Minion, 50)
	_GEng_Sprite_PosSet($Minion, 0, $GameGround)

	;Minion go out from left to right
	$tmp = _GEng_Sprite_AngleGet($Minion)
	_GEng_Sprite_AngleSet($Minion, $tmp)
	$tmp = _GEng_AngleToVector($tmp, 1000) ; vitesse obus
	_GEng_Sprite_SpeedSet($Minion, $tmp[0], $tmp[1],$MinionRunSpeed)


	_ArrayAdd($Minions,$Minion)
	_ArrayAdd($MinionStatus,0)
	_ArrayAdd($MinionTimer,0)
	$Minions[0]+=1
	$MinionStatus[0]+=1
	$MinionTimer[0]+=1

	$MinionSpawnDelay+= $Minions[0]*100
	$MinionSpawnTimer = TimerInit()
EndFunc

Func _MinionMovement()
	Local  $x, $y,$i,$ani

	For $i = 1 To $Minions[0]
		_GEng_Sprite_Draw($Minions[$i])

		$ani = _MinionGetAni($i)
		_GEng_Sprite_Animate($Minions[$i], $ani)

		$NewStatus = $MinionStatus[$i]

		If _GEng_Sprite_Collision($Minions[$i], $GEng_ScrBorder_Left) Then
			$NewStatus = 2
		ElseIf _GEng_Sprite_Collision($Minions[$i], $GEng_ScrBorder_Right) Then
			$NewStatus = 1
		Else
			$rand = Random(2,$MinionNaughty,1)
			If TimerDiff($MinionTimer[$i]) > $rand*1000 Then
				$NewStatus = Random(0,2,1)
				$MinionTimer[$i] = TimerInit()
			EndIf
		EndIf

		If $NewStatus <> $MinionStatus[$i] Then
			_GEng_Sprite_AnimRewind($Minions[$index])
			$MinionStatus[$i] = $NewStatus
			_MinionChangeStatus($i)
		EndIf
	Next
EndFunc

Func _MinionChangeStatus($index)
	Local $x, $y
	$tmp = _GEng_Sprite_AngleGet($Minions[$index])
	_GEng_Sprite_AngleSet($Minions[$index], $tmp)

	_GEng_Sprite_PosGet( $Minions[$index], $x, $y)

	Switch $MinionStatus[$index]
	Case 0
       $tmp = _GEng_AngleToVector($tmp, 0)
    Case 1
		$tmp = _GEng_AngleToVector($tmp, -1000)
    Case 2
		$tmp = _GEng_AngleToVector($tmp, 1000)
	EndSwitch

	_GEng_Sprite_SpeedSet($Minions[$index], $tmp[0], $tmp[1],$MinionRunSpeed)
EndFunc

Func _MinionGetAni($index)

	Switch $MinionStatus[$index]
	Case 0
       Return $animMinisonStand
	Case 1
       Return $animMinisonWalkLeft
	Case 2
       Return $animMinisonWalkRight
	EndSwitch

EndFunc