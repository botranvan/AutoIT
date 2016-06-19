#include "_adlib.au3"
Local $SOCKS_LISTEN_SOCKET
Local $SOCKS_OPEN_SERVER_SOCKETS[1000][10]
Local $SOCKS_OPEN_CLIENT_SOCKETS[1000][10]
Local $SOCKS_RECEIVE_BUFFER
Local $SOCKS_TOTAL_SENT = 0
Local $SOCKS_TOTAL_RECEIVED = 0
Local $SOCKS_TIMEOUT_WAIT = 30000;//30 second timeout

Local Const $SOCKS_LISTEN_IP = "127.0.0.1"
Local Const $SOCKS_LISTEN_PORT = 1080

#cs
   __
 _|  |  ____   _   _   ___  ___
|  _ |/ _   |/  \/  \/  _ || -_|
|____||__/|_||_/\/\_||   / \___/
                     |__|

Dampe http://www.autoitscript.com/forum/index.php?showuser=28723

~~~~~~
~~~~~~ SOCKS Protocol Version 5 Server for AutoIt ~~~~~~
~~~~~~ Version: 0.1. ~~~~~~
~~~~~~ Release notes: Basic functionality working, yay for proof of concept biggrin.gif ~~~~~~
~~~~~~ Contact: duggy_denton@hotmail.com ~~~~~~
~~~~~~

#ce




Func _SOCKS_Init_Server()

    TCPStartup()

   ;//Open listening socket
    $SOCKS_LISTEN_SOCKET = TCPListen ($SOCKS_LISTEN_IP, $SOCKS_LISTEN_PORT)
    If @error Then
        SetError (1)
        Return -1
    EndIf

   ;//Fill server socket array with -1
    For $i = 0 to UBound ($SOCKS_OPEN_SERVER_SOCKETS) -1 step 1
        $SOCKS_OPEN_SERVER_SOCKETS[$i][0] = -1
        $SOCKS_OPEN_SERVER_SOCKETS[$i][1] = 1
        $SOCKS_OPEN_CLIENT_SOCKETS[$i][0] = -1
        $SOCKS_OPEN_CLIENT_SOCKETS[$i][1] = 1
    Next

    _AdlibEnable("_SOCKS_Accept_Client", 50)
    _AdlibEnable("_SOCKS_Receive_Data", 5)
    _AdlibEnable("_SOCKS_ReceiveClient_Data", 5)

    _AdlibEnable("_SOCKS_Empty_OverTimed", 1000)

EndFunc

Func _SOCKS_Close_Server()

    TCPShutdown()
    If @error Then
        Return -1
    EndIf

EndFunc



Func _SOCKS_Accept_Client()

    $dEmptyArrayNum = _SOCKS_GetEmptyServerSocket()
    If $dEmptyArrayNum <> -1 Then
        $SOCKS_OPEN_SERVER_SOCKETS[$dEmptyArrayNum][0] = TCPAccept ($SOCKS_LISTEN_SOCKET)
    EndIf

EndFunc

Func _SOCKS_Receive_Data()

    For $i = 0 To UBound ($SOCKS_OPEN_SERVER_SOCKETS) -1
        If $SOCKS_OPEN_SERVER_SOCKETS[$i][0] <> -1 Then
            $SOCKS_RECEIVE_BUFFER = TCPRecv ($SOCKS_OPEN_SERVER_SOCKETS[$i][0], 9999)
            If @error Then
               ;//Client dcd
               ;//Close socket, set its part of the array back to -1
                TCPCloseSocket ($SOCKS_OPEN_SERVER_SOCKETS[$i][0])
                $SOCKS_OPEN_SERVER_SOCKETS[$i][0] = -1
                $SOCKS_OPEN_SERVER_SOCKETS[$i][1] = 1
            ElseIf $SOCKS_RECEIVE_BUFFER <> "" Then

                _SOCKS_Parse_Data($SOCKS_RECEIVE_BUFFER, $i)

            EndIf
        EndIf
    Next

EndFunc

Func _SOCKS_ReceiveClient_Data()

    For $i = 0 To UBound ($SOCKS_OPEN_CLIENT_SOCKETS) -1
        If $SOCKS_OPEN_CLIENT_SOCKETS[$i][0] <> -1 Then
            $SOCKS_RECEIVE_BUFFER = TCPRecv ($SOCKS_OPEN_CLIENT_SOCKETS[$i][0], 9999)
            If @error Then
               ;//Client dcd
               ;//Close socket, set its part of the array back to -1
                TCPCloseSocket ($SOCKS_OPEN_CLIENT_SOCKETS[$i][0])
                $SOCKS_OPEN_SERVER_SOCKETS[$i][0] = -1
                $SOCKS_OPEN_SERVER_SOCKETS[$i][1] = 1

            ElseIf $SOCKS_RECEIVE_BUFFER <> "" Then

               ;//Send back the data to the browser / our servers client
                TCPSend ($SOCKS_OPEN_CLIENT_SOCKETS[$i][2], Binary ($SOCKS_RECEIVE_BUFFER))
                $SOCKS_TOTAL_RECEIVED += StringLen ($SOCKS_RECEIVE_BUFFER)

            EndIf
        EndIf
    Next

EndFunc

Func _SOCKS_Parse_Data($sData, $nArrayIndex)

    ConsoleWrite ($sData & " from index " & $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0] & @CRLF)

    $sData = StringReplace ($sData, "0x", "")

    Switch $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1]

       ;//       //
       ;//This is an authenticate session
       ;//       //
        Case 1

           ;//Set string values
            $vVersion = StringLeft ($sData, 2)
            $sData  = StringTrimLeft ($sData, 2)
            $vNmethod = StringLeft ($sData, 2)
            $sData  = StringTrimLeft ($sData, 2)
            $vMethod = $sData

            If $vVersion = "05" and $vNmethod = "01" and $vMethod = "00" Then
               ;//Version is okay
                ConsoleWrite ("Authentication accepted" & @CRLF)
                TCPSend ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0], "0x0500")
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1] += 1
            Else
               ;//Unsupported protcol, notify the user then kill connection
                ConsoleWrite ("Authentication denied, invalid protocol version" & @CRLF)
                TCPSend ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0], "0x05FF")
                TCPCloseSocket ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0])
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0] = -1
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1] = 1
            EndIf


       ;//       //
       ;//  This is a request session
       ;//       //
        Case 2

           ;//Set string values
            $vVersion = StringLeft ($sData, 2)
            $sData  = StringTrimLeft ($sData, 2)
            $vCmd = StringLeft ($sData, 2)
            $sData  = StringTrimLeft ($sData, 4)
            $vAddressType = StringLeft ($sData, 2)
            $sData  = StringTrimLeft ($sData, 2)
            $vDest = StringLeft ($sData, 8)
            $sData  = StringTrimLeft ($sData, 8)
            $vDPort = StringLeft ($sData, 4)

            If $vVersion <> "05" or $vAddressType = "04" or $vCmd <> "01" Then
               ;//Cannot do for now
                ConsoleWrite ("Invalid proxy version or destination address" & @CRLF)
                TCPSend ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0], "0x05070004000000000000")
                TCPCloseSocket ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0])
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0] = -1
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1] = 1

            Else
               ;//Do shit
                $rSockId = _SOCKS_Connect_To_Dest($vDest, $vDPort, $vCmd, $vAddressType, $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0])

                If @error Then
                   ;//Couldn't connect
                    TCPSend ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0], "0x05030001000000000000")
                    ConsoleWrite ("Couldn't connect to host" & @CRLF)
                    TCPCloseSocket ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0])
                    $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0] = -1
                    $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1] = 1
                Else
                   ;//Connected
                    TCPSend ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0], "0x05000001" & $vDest & $vDPort)
                    $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1] += 1
                    $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][2] = $rSockId


                    ConsoleWrite ("Connected to host" & @CRLF)

                EndIf


            EndIf

        Case 3

           ;//Send request to server
            _SOCKS_Send_Request_To_Dest($sData, $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][2])

            If @error Then
                TCPSend ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0], "0x05040001000000000000")
                ConsoleWrite ("Connection to host lost" & @CRLF)
                TCPCloseSocket ($SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0])
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][0] = -1
                $SOCKS_OPEN_SERVER_SOCKETS[$nArrayIndex][1] = 1
            EndIf




    EndSwitch

EndFunc

Func _SOCKS_Receive_Client_Data($sId)

    $tRecv = TCPRecv ($SOCKS_OPEN_CLIENT_SOCKETS[$sId][0], 9999)
    If @error Then
       ;//User dropped
        SetError (1)
        Return -1
    EndIf
    If $tRecv <> "" Then
        Return $tRecv
    EndIf

EndFunc

Func _SOCKS_Send_Request_To_Dest($sReg, $sID)

    TCPSend ($SOCKS_OPEN_CLIENT_SOCKETS[$sID][0], Binary ($sReg))
    If @error Then
        SetError (1)
        Return -1
    EndIf
    $SOCKS_TOTAL_SENT += StringLen (Binary($sReg))

EndFunc

Func _SOCKS_Empty_OverTimed()

    For $i = 0 to UBound ($SOCKS_OPEN_CLIENT_SOCKETS) -1 step 1
        If $SOCKS_OPEN_CLIENT_SOCKETS[$i][0] <> -1 Then
            If TimerDiff ($SOCKS_OPEN_CLIENT_SOCKETS[$i][4]) >= $SOCKS_TIMEOUT_WAIT Then
                ConsoleWrite ("Closed connection due to timeout" & @CRLF)
                TCPCloseSocket ($SOCKS_OPEN_CLIENT_SOCKETS[$i][0])
                $SOCKS_OPEN_CLIENT_SOCKETS[$i][0] = -1
                $SOCKS_OPEN_CLIENT_SOCKETS[$i][1] = 1
            EndIf
        EndIf

    Next

EndFunc

Func _SOCKS_Connect_To_Dest($sDest, $sPort, $sType, $sAtype, $sFromID)



    Local $tSDestination, $tSPort

    If $sAtype = "01" Then
        $tSDestination = _SOCKS_Convert_To_Ip($sDest)
    Else
        $tDestination = $sDest
    EndIf

    $tSPort = Dec ($sPort)


    $nTempConSocket = _SOCKS_GetEmptyClientSocket()
    If $nTempConSocket <> -1 Then
       ;//Connect to $SOCKS_OPEN_CLIENT_SOCKETS[$nTempConSocket][0]
        $SOCKS_OPEN_CLIENT_SOCKETS[$nTempConSocket][2] = $sFromID
        $SOCKS_OPEN_CLIENT_SOCKETS[$nTempConSocket][0] = TCPConnect ($tSDestination, $tSPort)
        $SOCKS_OPEN_CLIENT_SOCKETS[$nTempConSocket][4] = TimerInit()
        If $SOCKS_OPEN_CLIENT_SOCKETS[$nTempConSocket][0] = -1 Then
            SetError (1)
            Return -1
        Else
            Return $nTempConSocket
        EndIf
    EndIf

EndFunc

Func _SOCKS_Get_Total_Sent()

    Return $SOCKS_TOTAL_SENT

EndFunc

Func _SOCKS_Get_Total_Received()

    Return $SOCKS_TOTAL_RECEIVED

EndFunc

Func _SOCKS_Convert_To_Ip($sAddr)

    Local $sBuf

    For $i = 1 to 4 step 1
        $sBuf &= Dec (StringLeft ($sAddr, 2)) & "."
        $sAddr = StringTrimLeft ($sAddr, 2)
    Next

    Return StringTrimRight ($sBuf, 1)

EndFunc

Func _SOCKS_GetEmptyClientSocket()

    For $i = 0 To UBound ($SOCKS_OPEN_CLIENT_SOCKETS) -1
        If $SOCKS_OPEN_SERVER_SOCKETS[$i][0] = -1 Then
            Return $i
        EndIf
    Next

    Return -1

EndFunc

Func _SOCKS_GetEmptyServerSocket()

    For $i = 0 To UBound ($SOCKS_OPEN_SERVER_SOCKETS) -1
        If $SOCKS_OPEN_SERVER_SOCKETS[$i][0] = -1 Then
            Return $i
        EndIf
    Next

    Return -1

EndFunc