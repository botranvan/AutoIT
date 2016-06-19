#include-once

Func _GameExit()
	$return = 1
	If ($return == 1) Then $GameContinue = False
EndFunc   ;==>_GameExit

Func _GameMouseHide()
	GUISetCursor(16)
EndFunc   ;==>_GameMouseHide

Func _GameFontLoad()
	$GameFont[0] = _GEng_Font_Create("Arial", 20, 2)
EndFunc   ;==>_GameFontLoad

Func _GameSoundLoad()
	Global $SoundShot1 = _GEng_Sound_Load("res\sound\shot1.wav")

	_GEng_Sound_AttribSet($SoundShot1, 1)

EndFunc   ;==>_GameSoundLoad

Func _GameOver()
	MsgBox(0,'_GameOver','_GameOver')
	_GameExit()
EndFunc

Func _AnimationLoad()

	$MyBirdImage = _GEng_ImageLoad("res\bird-anima.png")
	$MyBirdAnima = _GEng_Anim_Create()
	For $i = 0 To $MyBirdFrameCount
		_GEng_Anim_FrameAdd($MyBirdAnima, $MyBirdImage, 100, $MyBirdSize * $i, 0, $MyBirdSize, $MyBirdSize)
	Next

EndFunc   ;==>_AnimationLoad


Func _GameBackgroundCreate()
	Local $img = _GEng_ImageLoad("res\game-background.png")
	$GameBackground = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($GameBackground, $img)
EndFunc

Func _GameBackgroundDraw()
	_GEng_Sprite_Draw($GameBackground, 0)
EndFunc


Func _MyBirdCreate()
	Global $MyBird = _GEng_Sprite_Create()


;~ 	_GEng_Sprite_ImageSet($MyBird, $MyBirdImage, 0, 0, $MyBirdSize, $MyBirdSize)

	_GEng_Sprite_OriginSetEx($MyBird, $GEng_Origin_Mid)
	_GEng_Sprite_PosSet($MyBird, $MyBirdPos[0], $MyBirdPos[1])

	_GEng_Sprite_SpeedSet($MyBird, 0, 0, $MyBirdFallSpeed)
	_GEng_Sprite_AngleSpeedSet($MyBird, 0, 100) ;rotation  speed
	_GEng_Sprite_InnertieSet($MyBird, 300)
	_GEng_Sprite_AngleInnertieSet($MyBird, 60)

	$MyBirdFlyUpTimer = TimerInit()
EndFunc   ;==>_MyBirdCreate

Func _MyBirdDraw()
	Global $MyBird
	_GEng_Sprite_Draw($MyBird)
	_GEng_Sprite_Animate($MyBird, $MyBirdAnima)

EndFunc   ;==>_MyBirdDraw


Func _MyBirdCheckMove()

	Local $x, $y

	If _IsPressed($GameMouseTrigger) Or _IsPressed($GameKeyTrigger) Then ;up
		_MyBirdFlyUp()
	EndIf

	_GEng_Sprite_PosGet($MyBird, $x, $y)

	If ($MyBirdNeedFlyUp == True) And ($y <= $MyBirdFlyUpPosY) Then
		$MyBirdNeedFlyUp = False
		_GEng_Sprite_SpeedSet($MyBird, 0, 0, $MyBirdFallSpeed)
	EndIf

EndFunc   ;==>_MyBirdCheckMove



;~ Game start by mouse click or key
Func _MyBirdFlying()
	If _IsPressed($GameKeyTrigger) Or _IsPressed($GameMouseTrigger) Then $GamePlaying = True
	If Not $GamePlaying Then Return

	Local $tmp,$x, $y
	$tmp = _GEng_Sprite_AngleGet($MyBird)
	$tmp = _GEng_AngleToVector($tmp, 1)

	If $MyBirdNeedFlyUp Then	;Up
		_GEng_Sprite_AccelSet($MyBird, $tmp[1] * -1000, $tmp[0] * -1000)

	Else	;Down
		_GEng_Sprite_AccelSet($MyBird, $tmp[1] * 1000, $tmp[0] * 1000)
	EndIf

	_GEng_Sprite_PosGet($MyBird, $x, $y)
	If ($y > $GameGround) Then _GameOver()

EndFunc

;~ Make bird fly up
Func _MyBirdFlyUp()
	If TimerDiff($MyBirdFlyUpTimer) < $MyBirdFlyUpDelay Then Return

	Local $x, $y
	_GEng_Sprite_PosGet($MyBird, $x, $y)

	$MyBirdNeedFlyUp = True
	$MyBirdFlyUpPosY = $y-$MyBirdFlyUpHeight
	_GEng_Sprite_SpeedSet($MyBird, 0, 0, $MyBirdFlyUpSpeed)

	$MyBirdFlyUpCount+=1
	$MyBirdFlyUpTimer = TimerInit();
EndFunc



