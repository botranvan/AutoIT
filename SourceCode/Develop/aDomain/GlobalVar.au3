
;~ == Auto Var =========================================
Global $GUIVersion = "2.0.5.5"
Global $AutoName = "aDomain"
Global $AutoVersion = '1.0.2'
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

Global $AutoRuning = ''
Global $ShowIE = True
Global $ComputerIP_URL = 'http://showip.net/'
Global $DomainList_URL = 'https://account.ftech.vn/clientarea.php?action=domains'
Global $DomainIP_URL = 'https://account.ftech.vn/clientarea.php?managedns=hocautoit.com&addonload=1'
Global $DomainTimer = False
Global $DomainTimeCount = 0


