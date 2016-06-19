
;~ == Auto Var =========================================
Global $GUIVersion = "2.0.5.4"
Global $AutoName = "aMegaman"
Global $AutoVersion = '1.0'
Global $AutoShow = 1
Global $AutoPos[2] = [0,0]
Global $AutoPause = 0
Global $Testing = 0
Global $DataFolder = "data"
Global $DataFile = $DataFolder&"\data.ini"
Global $LangFile = $DataFolder&"\lang.txt"
Global $CommandList[1] = [-1]
Global $CommandCurrent[2] = [0,0]

Global $SaveLog = 0
Global $LogFile = 0
Global $LogDate = @YEAR &"-"& @MON &"-"& @MDAY &" "& @HOUR
Global $LogFileName = "log\"&$LogDate&".ini"

Global $CharWidth = 70
Global $CharHeight = 70
Global $CharHeightDif = 10
Global $mm1l = "data\mm1.png"
Global $mm1width = 2870
Global $mm1height = 140
Global $mm1obj
Global $mm1showup
Global $mm1standleft
Global $mm1standright
Global $mm1moveleft
Global $mm1moveright

Global $CharBornPos[2] = [50,-100]
Global $CharPos[4]
Global $CharOnGround = False
Global $CharStand = True
Global $CharRight = True
Global $CharLeft = False
Global $CharDropSpeed = 4
Global $CharMoveSpeed = 7
Global $CharStandBy = 50
Global $CharStepShowUp[3] = [0,21,22]
Global $CharStandRight[3] = [21,24,4]
Global $CharStandLeft[3] = [21,24,4]
Global $CharMoveRight[3] = [27,40,13]
Global $CharMoveLeft[3] = [27,40,13]

Global $StartBarTitle = '[CLASS:Shell_TrayWnd]'
Global $Ground = WinGetPos($StartBarTitle)

