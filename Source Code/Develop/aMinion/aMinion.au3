#include <Misc.au3>
#include <GDIPlus.au3>

#include "GEnginFixed\GEngin.au3"
#include "var.au3"
#include "function.au3"
#include "SaiTest.au3"


Opt("MouseCoordMode", 2)
Opt("GuiOnEventMode", 1)

ProcessSetPriority(@AutoItPID,3)

_GEng_SetDebug(1)
_GEng_Start($GameName&" v"&$GameVersion, $scrW, $scrH)
_GEng_Sound_Init()

GuiSetOnEvent(-3, "_GameExit")

_GameMouseHide()
_GameSoundLoad()
_GameFontLoad()
;~ _GameWallRightCreate()

_AnimationLoad()

_GameBackgroundCreate()
_MyMinionCreate()
_MyMinionBulletImageLoad()
_MyBalloonCreate()
_MyBulletCreate()
_MyShotBarCreate()
_MyBananaCreate()

AdlibRegister('_MyMinionShotRestore',100)
AdlibRegister('_MyMinionShot1eyeCheck',10)
$MinionGoUpTimer = TimerInit()

While 1
	STShow()

	_GEng_ScrFlush(0xFFFFFFFF)
	_GameBackgroundDraw()

	_MyBalloonDraw()
	_MyBulletDraw()

	_MyMinionDraw()
	_MyMinionCheckMove()
	_MyMinionShoot()
	_MyShotBarDraw()

;~ 	_WallRightDraw()

	_MinionSpawn()
	_Minion1eyeMovement()

	_MinionGoUp()
	_MinionGoDown()
	_MinionGoStandUp()
	_MinionGo4Banana()

	_AnimShots()

	_GEng_ScrUpdate()

	If Not $GameContinue Then ExitLoop
Wend

_GEng_Font_Delete($GameFont[0])
_GEng_Text_Delete($MyBalloonText)
_GEng_Sound_Free($SoundShot1)
_GEng_Shutdown()

Exit
