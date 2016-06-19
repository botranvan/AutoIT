#include-once

Global $GameName = 'Con Chim Ngu'
Global $GameVersion = '1.0.0'
Global $GameContinue = True
Global $GamePlaying = False
Global $GameMouseTrigger = '01'
Global $GameKeyTrigger = '20'
Global $GameFont[1]
Global $Testing = True
Global $TestTimer = 0

Global $scrW = 500
Global $scrH = 800

Global $GameBackground
Global $GameTextColor = 0xFFFFFFFF
Global $GameNoFlyZone = 50
Global $GameGround = 610


Global $MyBird
Global $MyBirdImage
Global $MyBirdAnima
Global $MyBirdFrameCount = 7
Global $MyBirdPos = [120,300]
Global $MyBirdSize = 60
Global $MyBirdFallSpeed = 400
Global $MyBirdFlyUpSpeed = $MyBirdFallSpeed+300
Global $MyBirdFlyUpPosY = 0
Global $MyBirdFlyUpHeight = 110

Global $MyBirdNeedFlyUp = False
Global $MyBirdFlyUpTimer
Global $MyBirdFlyUpDelay = 500
Global $MyBirdFlyUpCount = 0

Global $SoundShot1
