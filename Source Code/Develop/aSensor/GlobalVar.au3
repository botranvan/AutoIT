
;~ == Auto Var =========================================
Global $GUIVersion = "2.0.5.7"
Global $AutoName = "aSensor"
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

Global $SensorFunc = 'VolumeUp|VolumeDown'
Global $SensorSessionName = 'Sensor'
Global $SensorFuncCreated = False
Global $SensorSocket = False
Global $SensorServerPort = 65532
Global $SensorDataLen = 255
Global $SensorSeparate = ';'


