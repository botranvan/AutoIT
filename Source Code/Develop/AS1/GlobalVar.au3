
;~ == Auto Var =========================================
Global $GUIVersion = "2.04 building"
Global $AutoName = "AutoSetup #1"
Global $AutoVersion = "1.01c"
Global $AutoShow = 1
Global $AutoPos[2] = [0,0]
Global $AutoPause = 0
Global $Testing = 0
Global $DataFolder = "data"
Global $DataFile = $DataFolder&"\data.ini"
Global $SaveLog = 1
Global $LogFile = 0
Global $LogDate = @YEAR &"-"& @MON &"-"& @MDAY &" "& @HOUR
Global $LogFileName = "log\"&$LogDate&".ini"
Global $Start = 0
Global $Step = 0
Global $LastLog = ""

;~ == File Var =========================================
Global $dotNet = "dotNetFx4.exe"
Global $dNTitle1 = "[TITLE:Extracting files; CLASS:#32770]"
Global $dNTitle2 = "[TITLE:Microsoft .NET Framework 4; CLASS:#32770]"
Global $dNText2 = "동의함"
Global $dNText3 = "마침"
Global $dNText4 = "원래 상태로 .NET Framework 4 복구"
Global $dNText5 = "예"

Global $VisualFile = "vcredist_x86.exe"
Global $VisualTitle1 = "[TITLE:Extracting Files; CLASS:#32770]"
Global $VisualTitle2 = "[TITLE:Microsoft Visual C++ 2010; CLASS:#32770]"
Global $VisualText2 = "동의함"
Global $VisualText3 = "마침"
Global $VisualText4 = "Microsoft Visual C++ 2010 x86 재배포 가능 패키지를 원래 상태로 복구합니다"
Global $VisualText5 = "예"

Global $CloneSource = "C:\Program Files\Diablo III\Data_D3\PC\MPQs\"
Global $CloneDest = "C:\D3MPQ\MPQs\"

