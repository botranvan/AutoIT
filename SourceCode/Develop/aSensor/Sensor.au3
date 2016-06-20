#include-once

;~ SensorStart
Func SensorServerStart()
	Global $SensorServerPort,$SensorSocket

	UDPStartup()

	IIPAddressSet(@IPAddress1)

	$SensorSocket = UDPBind(@IPAddress1, $SensorServerPort)

	; If an error occurred display the error code and return False.
	If @error Then
		; Someone is probably already binded on this IP Address and Port (script already running?).
		Local $iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Server:" & @CRLF & "Could not bind, Error code: " & $iError)
		FAutoEnd()
	EndIf

	LNoticeSet('Server started')
EndFunc

;~ SensorServerStop
Func SensorServerStop()
	Global $SensorSocket

	UDPCloseSocket($SensorSocket)
EndFunc

;~ SensorServerRecv
Func SensorServerRecv()
	Global $SensorDataLen,$SensorSocket
	Local $sReceived

	$sReceived = UDPRecv($SensorSocket, $SensorDataLen)
;~ 	If(Not Random(0,1,1)) Then $sReceived = '11000;up;VolumeUp'

	If (Not $sReceived) Then Return

	SensorServerAddLog($sReceived)
	SensorProcess($sReceived)
EndFunc

;~ SensorServerAddLog
Func SensorServerAddLog($sReceived)
	Local $Data

	$Data = ECommandListGet()
	$Data = $sReceived&@CRLF&$Data

	ECommandListSet($Data)
EndFunc

;~ SensorFuncCreatedLoad
Func SensorFuncCreatedLoad()
	Global $SensorFuncCreated = FRead($SensorSessionName)
	Local $Data

	LISensorFuncListClear()

	If (Not IsArray($SensorFuncCreated)) Then Return

	For $i = 1 To $SensorFuncCreated[0][0]
		If ($i > 1) Then $Data&='|'
		$Data&= $SensorFuncCreated[$i][1]
	Next

	LISensorFuncListSet($Data)
EndFunc

;~ SensorFuncCreatedKey
Func SensorFuncCreatedKey($SensorFunc)
	Global $SensorFuncCreated
	For $i = 1 To $SensorFuncCreated[0][0]
		If ($SensorFunc == $SensorFuncCreated[$i][1]) Then Return $SensorFuncCreated[$i][0]
	Next

	Return False
EndFunc

;~ SensorFuncList
Func SensorFuncListLoad()
	Global $SensorFunc
	COFuncListSet($SensorFunc)
EndFunc


;~ SensorFuncList
Func SensorFuncList()
	Global $SensorFunc
	Local $List = StringSplit($SensorFunc,'|')
	Return $List
EndFunc


;~ SensorAdd
Func SensorAdd()
	Local $Fingers

	$Fingers = SensorFingerGet()
	$Motion = SensorMotionGet()
	$Funs = COFuncListGet()

	If($Fingers == '00000') Then
		MsgBox(0,$AutoName,'You need choose a finger')
		Return
	EndIf

	If (StringInStr($Funs,'Choose One')) Then
		MsgBox(0,$AutoName,'You need choose a function')
		Return
	EndIf

	$SensorFunc = $Fingers&$SensorSeparate&$Motion&$SensorSeparate&$Funs
	If (Not SensorFuncSave($SensorFunc)) Then LNoticeSet('Sensor func create fault')
EndFunc

;~ SensorDel
Func SensorDel()
	Local $Selected

	$Selected = LISensorFuncListGet()
	If ($Selected == '') Then Return

	$key = SensorFuncCreatedKey($Selected)

	If MsgBox(4,$AutoName,'Delete sensor func: '&$Selected&@CRLF&'Are you sure?') == 7 Then Return


	FDelete($SensorSessionName,$key)

	SensorFuncCreatedLoad()
	LNoticeSet('Sensor func deleted: '&$key)
EndFunc

;~ SensorFingerGet
Func SensorFingerGet()
	Local $f, $Fingers[5]
	$Fingers[0] = CHThumbIsCheck()*1
	$Fingers[1] = CHIndexIsCheck()*1
	$Fingers[2] = CHMiddleIsCheck()*1
	$Fingers[3] = CHRingIsCheck()*1
	$Fingers[4] = CHPinkyIsCheck()*1

	For $i = 0 To 4
		$f&= $Fingers[$i]
	Next

	Return $f
EndFunc

;~ SensorMotionGet
Func SensorMotionGet()
	If (RHandUpIsCheck()) 	Then Return 'up'
	If (RHandDownIsCheck()) Then Return 'down'
	If (RHandLeftIsCheck()) Then Return 'left'
	If (RHandRightIsCheck()) 	Then Return 'right'
	If (RHandShakeIsCheck()) 	Then Return 'shake'
	Return '.'
EndFunc

;~ SensorFuncSave
Func SensorFuncSave($SensorFunc)
	If SensorFuncExist($SensorFunc) Then
		MsgBox(0,$AutoName,'Sensor func exist'&@CRLF&$SensorFunc)
		Return False
	EndIf

	Local $key = Random(100000,999999,1)

	If Not FWrite($SensorSessionName,$key,$SensorFunc) Then Return False

	SensorFuncCreatedLoad()
	LNoticeSet('Sensor func created: '&$key)
	Return True
EndFunc

;~ SensorFuncExist
Func SensorFuncExist($SensorFunc)
	Global $SensorFuncCreated
	If (Not IsArray($SensorFuncCreated)) Then Return False

	For $i = 1 To $SensorFuncCreated[0][0]
		If ($SensorFunc == $SensorFuncCreated[$i][1]) Then Return True
	Next
	Return False
EndFunc

;~ SensorProcess
Func SensorProcess($SensorFunc)
	Local $Data,$Func

	If (Not SensorFuncExist($SensorFunc)) Then Return

	$Data = StringSplit($SensorFunc,$SensorSeparate)
	$Func = '_Sensor'&$Data[3]

	Call($Func)
EndFunc

;~ _SensorVolumeUp
Func _SensorVolumeUp()
	Local $CurrentVol

	$CurrentVol = _SoundGetPhoneVolume()

	LNoticeSet(@MSEC&': '&$CurrentVol)

EndFunc