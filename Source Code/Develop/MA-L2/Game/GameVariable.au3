Global $GameTitle = "[CLASS:l2UnrealWWindowsViewportWindow]"
Global $GameProcess = "l2.exe"
Global $GameHandle = ""
Global $GamePid = ""
Global $GameMem = "?"
Global $GameList = ""
Global $IsPet = 0

Global $TargetKey = "F12"
Global $FishingKey = "F12"
Global $PumpKey = "F12"
Global $ReelKey = "F12"

Global $IsTarget = ""
Global $AIsTargetIndex = 0
Global $AIsTarget[1]
$AIsTarget[0] = 0x0BBEF108	

Global $MobHPCur = ""
Global $AModHPCurIndex = 0
Global $AModHPCur[1]
$AModHPCur[0] = 0x0DDE4580	

Global $IsFishing = 0
Global $AIsFishingIndex = 0
Global $AIsFishing[1]
$AIsFishing[0] = 0x10F7A734

Global $IsFishing = 0
Global $FishingBarColor = 100
Global $FishingBar[2] = [190,400]
;l2vn.exe 0x10900000
;l2vn.dll 0x00E10000