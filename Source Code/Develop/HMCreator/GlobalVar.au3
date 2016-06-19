
;~ == Auto Var =========================================
Global $GUIVersion = "2.0.5.4"
Global $AutoName = "HMCreator"
Global $AutoVersion = "1.1"
Global $AutoShow = 1
Global $AutoPos[2] = [0,0]
Global $AutoPause = 0
Global $Testing = 0
Global $DataFolder = "data"
Global $DataFile = $DataFolder&"\data.ini"
Global $LangFile = $DataFolder&"\lang.txt"
Global $CommandList[1] = [-1]
Global $CommandCurrent[2] = [0,0]

Global $SaveLog = 1
Global $LogFile = 0
Global $LogDate = @YEAR &"-"& @MON &"-"& @MDAY &" "& @HOUR
Global $LogFileName = "log\"&$LogDate&".ini"

;~ ===================================================
Global $Start = 0
Global $FileAccount = "account.txt"
Global $AccCount = 0
Global $oIE
