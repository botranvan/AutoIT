Global $GameTitle = "[CLASS:l2UnrealWWindowsViewportWindow]"
Global $GameProcess = "l2.exe"
Global $GameHandle = ""
Global $GamePid = ""
Global $GameMem = "?"
Global $GameList = ""
Global $TargetKey = "F12"
Global $IsTarget = ""
Global $MobHPCur = ""

Global $AIsTargetIndex = 0
Global $AIsTarget[1]
$AIsTarget[0] = 0x0BBEF108	

Global $AModHPCurIndex = 0
Global $AModHPCur[1]
$AModHPCur[0] = 0x0DDE4580	

;l2vn.exe 0x10900000
;l2vn.dll 0x00E10000