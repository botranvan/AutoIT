TCPStartup()
 
$hc = TCPConnect("192.168.1.104",9050)                  ; Socks4a Proxy Server
 
$sReq = Chr(0x04) _                                     ; Protocol version  4
      & Chr(0x01) _                                     ; Command Code      1 - establish a tcp/ip stream connection
      & Chr(0x00) & Chr(0x50) _                         ; Port              80
      & Chr(0x00) & Chr(0x00) & Chr(0x00) & Chr(0xFF) _ ; Ip Adress         Invalid - 0.0.0.255
      & "" & Chr(0x00) _                                ; User Id           Empty
      & "www.mamma.com" & Chr(0x00)                     ; Host Name         www.mamma.com

; Send Request to Proxy
ConsoleWrite("! Request: " & Hex(BinaryToString($sReq)) & @CR)
TCPSend($hc,$sReq)

; Wait for the Reply
While 1
    $sBuff = TCPRecv($hc,1)
    If @error Then Exit @ScriptLineNumber
    If StringLen($sBuff) > 0 Then ExitLoop
    Sleep(100)
WEnd

$sBuff &= TCPRecv($hc,8)
ConsoleWrite("!   Reply: " & Hex(BinaryString($sBuff)) & @CR)

; Check for errors
Switch StringMid(Hex(BinaryString($sBuff)),3,2)
    Case "5A"
        ConsoleWrite("> request granted" & @CR)
    Case "5B"
        ConsoleWrite("> request rejected or failed" & @CR)
        Exit @ScriptLineNumber
    Case "5C"
        ConsoleWrite("> request failed because client is not running identd (or not reachable from the server)" & @CR)
        Exit @ScriptLineNumber
    Case "5D"
        ConsoleWrite("> request failed because client's identd could not confirm the user id string in the request" & @CR)
        Exit @ScriptLineNumber
EndSwitch

; Send Http Request to mamma and Search for "AutoIt"
$sReq  = "GET /Mamma?query=AutoIt HTTP/1.0" & @CRLF & @CRLF
ConsoleWrite("! Request:" & @CR & $sReq & "---------------------------------" & @CR)
TCPSend($hc,$sReq)

; Wait for the Reply
ConsoleWrite("Receiving Data ")
$sRepy = ""
While 1
    $sBuff = TCPRecv($hc,1024*5)
    If @error Then ExitLoop
    If StringLen($sBuff) > 0 Then
        $sRepy &= $sBuff
        ConsoleWrite(".")
    EndIf
    Sleep(100)
WEnd

; Parse Reply
$iHeadEnd = StringInStr($sRepy,@CRLF & @CRLF) + 2
$sRepyHead = StringMid($sRepy,1,$iHeadEnd)
$sRepyBody = StringMid($sRepy,$iHeadEnd)

ConsoleWrite(@CR & "! Reply:" & @CR & $sRepyHead & "---------------------------------" & @CR)

; Save Result to disk
$hFile = FileOpen("socks.htm",2)
FileWrite($hFile,$sRepyBody)
FileClose($hFile)

ConsoleWrite("Reply Body stored in .\socks.htm (" & Round(StringLen($sRepyBody)/1024,2) & "Kb)" & @CR)