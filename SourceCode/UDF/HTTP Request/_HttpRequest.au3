#include-once
#include <WinHTTP.au3> ;Trancexx autoitscript.com
#include <ZLIB.au3> ;Ward autoitscript.com
#include <Misc.au3>
#include <Array.au3>

Func _HttpRequest($iReturn, $URL, $sDataToSend = '', $sCookie = '', $sReferrer = '', $sAddition = '', $sOVerb = '', $iUpload = False, $sBoundary = '', $sHexKeyCancelUpload = '')
	Local $iError = 0, $rData
	Local $sVerb = (Not $sDataToSend ? "GET" : "POST")
	Local $PortFlag[2][2] = [[80, 443], ['', '8388608']]
	Local $aURL = StringRegExp($URL, '^http(s?)://(.*?)\/(.*?)$', 3)
	If @error Then Return SetError(1)
	Local $SSL = ($aURL[0] ? 1 : 0)
	Local $hOpen = _WinHttpOpen('Mozilla/5.0 (Windows NT 5.1; rv:45.0) Gecko/20100101 Firefox/45.0')
	Local $hConnect = _WinHttpConnect($hOpen, $aURL[1], $PortFlag[0][$SSL])
	Local $hRequest = _WinHttpOpenRequest($hConnect, $sOVerb ? $sOVerb : $sVerb, $aURL[2], "HTTP/1.1", $sReferrer, Default, $PortFlag[1][$SSL])
	If $iReturn = 1 Then _WinHttpSetOption($hRequest, 63, 2)
	_WinHttpAddRequestHeaders($hRequest, "Accept-Encoding: gzip, deflate, sdch, br")
	_WinHttpAddRequestHeaders($hRequest, 'Accept: ' & _
			'application/x-ms-application,application/xhtml+xml,application/xml,application/x-silverlight,' & _
			'image/jpeg, image/gif, image/pjpeg, image/webp, text/html;q=0.9,*/*;q=0.8')
	If $sAddition Then
		Local $aAddition = StringSplit($sAddition, '|')
		For $i = 1 To $aAddition[0]
			_WinHttpAddRequestHeaders($hRequest, $aAddition[$i])
		Next
	EndIf
	If $sCookie Then _WinHttpAddRequestHeaders($hRequest, "Cookie: " & $sCookie)
	If Not $iUpload Then
		If $sDataToSend Then _WinHttpAddRequestHeaders($hRequest, "Content-Type: application/x-www-form-urlencoded")
		_WinHttpSendRequest($hRequest, "", $sDataToSend)
	Else
		Local $sContentType = 'Content-Type: multipart/form-data; boundary=' & StringTrimLeft($sBoundary, 2)
		Local $lenData = StringLen($sDataToSend)
		_WinHttpSendRequest($hRequest, $sContentType, '', $lenData)
		Local $sData = StringToBinary($sDataToSend), $iBytes2Send = 2048, $iBin, $iStart = 1, $iExtended = 0
		While 1
			If $sHexKeyCancelUpload And _IsPressed($sHexKeyCancelUpload) Then
				$iError = -1
				ExitLoop
			EndIf
			$iBin = BinaryMid($sData, $iStart, $iBytes2Send)
			If BinaryLen($iBin) = 0 Then ExitLoop
			_WinHttpWriteData($hRequest, $iBin, 1)
			If Not @error Then
				$iStart += $iBytes2Send
			Else
				$iBin = 0
				$iError = 2
				ExitLoop
			EndIf
		WEnd
	EndIf

	If $iError = 0 Then
		_WinHttpReceiveResponse($hRequest)
		If Not @error Then
			If $iUpload And $iReturn > 1 And StringInStr(_WinHttpQueryHeaders($hRequest), 'Encoding: gzip', 0, 1) Then $iReturn = 2
			Switch $iReturn
				Case 1
					$rData = _WinHttpQueryHeaders($hRequest)
				Case 2
					$rData = Binary("")
					Do
						$rData &= _WinHttpReadData($hRequest, 2)
					Until @error
					$rData = BinaryToString(_ZLIB_GZUncompress($rData), 4)
				Case 3
					Do
						$rData &= _WinHttpReadData($hRequest)
					Until @error
				Case 4
					Local $rData[2]
					$rData[0] = _WinHttpQueryHeaders($hRequest)
					$rData[1] = Binary("")
					Do
						$rData[1] &= _WinHttpReadData($hRequest, 2)
					Until @error
					$rData[1] = BinaryToString(_ZLIB_GZUncompress($rData[1]), 4)
				Case 5
					$rData = Binary("")
					Do
						$rData &= _WinHttpReadData($hRequest, 2)
					Until @error
					$rData = _ZLIB_GZUncompress($rData)
			EndSwitch
		EndIf
	EndIf

	_WinHttpCloseHandle($hRequest)
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Return SetError($iError, 0, $rData)
EndFunc

Func _WinHttpBoundaryGenerator($iLength = 30)
	Local $sData = "", $sRandom
	For $a = 1 To $iLength
		$sRandom = Random(55, 116, 1)
		$sData &= Chr($sRandom + 6 * ($sRandom > 90) - 7 * ($sRandom < 65))
	Next
	Return ('--' & $sData)
EndFunc

Func _URIEncode($sData) ; Prog@ndy autoitscript.com
	Local $aData = StringSplit(BinaryToString(StringToBinary($sData, 4), 1), "")
	Local $nChar
	$sData = ""
	For $i = 1 To $aData[0]
		$nChar = Asc($aData[$i])
		Switch $nChar
			Case 45, 46, 48 To 57, 65 To 90, 95, 97 To 122, 126
				$sData &= $aData[$i]
			Case 32
				$sData &= "+"
			Case Else
				$sData &= "%" & Hex($nChar, 2)
		EndSwitch
	Next
	Return $sData
EndFunc

Func _URIDecode($sData) ; Prog@ndy
	Local $aData = StringSplit(StringReplace($sData, "+", " ", 0, 1), "%")
	$sData = ""
	For $i = 2 To $aData[0]
		$aData[1] &= Chr(Dec(StringLeft($aData[$i], 2))) & StringTrimLeft($aData[$i], 2)
	Next
	Return BinaryToString(StringToBinary($aData[1], 1), 4)
EndFunc

Func _URLDecode($sData)
	Local $aSRE = StringRegExp($sData, "\\(?:u|x)([[:xdigit:]]{2,4})", 3)
	For $i = 0 To UBound($aSRE) - 1
		$sData = StringRegExpReplace($sData, "\\(?:u|x)" & $aSRE[$i], ChrW(Int('0x' & $aSRE[$i])))
	Next
	Return $sData
EndFunc

Func _GetCookie($sResponseHeader, $arrBeginGetCookie = 0)
	Local $aRet = StringRegExp($sResponseHeader, '(?m)^Set\-Cookie\:(.*?)$', 3), $sRet = ''
	If @error Then Return SetError(1, 0, False)
	Local $__qRet = UBound($aRet)
	If $arrBeginGetCookie + $__qRet < 0 Then $arrBeginGetCookie = 0
	If $arrBeginGetCookie < 0 Then $arrBeginGetCookie = $__qRet + $arrBeginGetCookie
	For $i = $arrBeginGetCookie To $__qRet - 1
		$sRet &= $aRet[$i] & ';'
	Next
	Return $sRet
EndFunc

Func _FileWrite_Test($sData)
	$FilePath = @TempDir & '\Test.html'
	$hOpen = FileOpen($FilePath, 2 + 32)
	FileWrite($hOpen, $sData)
	FileClose($hOpen)
	ShellExecute($FilePath)
EndFunc
