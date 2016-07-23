#include-once

Global $GameName = 'aMinion'
Global $GameVersion = '1.0.0'
Global $GameContinue = True
Global $GameFont[1]
Global $Testing = True
Global $TestTimer = 0

Global $scrW = 800
Global $scrH = 700

Global $GameBackground
Global $GameTextColor = 0xFFFFFFFF

Global $MyBalloonImage
Global $MyBalloonNumber = 0
Global $MyBalloonNumberMax = 999999
Global $MyBalloonText

Global $MyBulletImage
Global $MyBulletNumber = 0
Global $MyBulletNumberMax = 10
Global $MyBulletText

Global $MyMinion
Global $MyMinionCanShot = False
Global $MyMinionPos = [$scrW-70,$scrH / 2]
Global $MyMinionSize = 150
Global $MyMinionImage
Global $MyMinionSpeed = 150
Global $MyMinionBulletImage
Global $LeftShooterTimer = 0
Global $LeftShooterDelay = 1500
Global $LeftShooterRapidDelay = 300
Global $MyMinionGunPos = [-5,78]
Global $MyMinionBulletSpeed = 600
Global $GameWallRight = 0
Global $imgSmoke1
Global $animSmoke1
Global $_Smokes[1] = [0]
Global $MyBullets[1] = [0]

Global $SoundShot1
Global $SoundGoUp
Global $SoundReload
Global $SoundBallExpCount = 5
Global $SoundBallExp[$SoundBallExpCount]
Global $SoundBallExp1
Global $SoundBallExp2

Global $MyShotBar
Global $MyShotBarImg
Global $MyShotBarAni
Global $MyShotBarSize = [80,8]
Global $MyShotBarFrame = 16


Global $animMinisonGoUp


Global $GameGround = $scrH-75
Global $MinisonFrameSize = [80,120]
Global $MinionSpawnDelay = 1000
Global $MinionSpawnTimer = 0
Global $MinionUpSpeedMin = 40
Global $MinionUpSpeedMax = 50
Global $MinionDownSpeed = 250
Global $MinionRunSpeed = 100
Global $MinionGoUpTimer = 0
Global $MinionGoUpStartDelay = 2000
Global $MinionGoUpDelay = $MinionGoUpStartDelay
Global $MinionGoUpDelayMin = 100
Global $MinionNaughty = 13

Global $MinionUpNeed = 1
Global $MinionUpCount = 0
Global $MinionDownCount = 0

Global $Minions1eyeMax = 20
Global $animMinison1eyeFrameCount = 15
Global $animMinison1eyeStand0
Global $animMinison1eyeGoLeft1
Global $animMinison1eyeGoRight2
Global $animMinison1eyeStand3
Global $Minions1eye[1] = [0]
Global $Minions1eyeTimer[1] = [0]
Global $Minions1eyeStatus[1] = [0]

;Minion Status
;-4 - go for banana
;-3 - stand up
;-2 - go down
;-1 - go up
; 0 - stand
; 1 - go left
; 2 - go right;
; 3 - stand
; 4- go left
; 5 - go right;

